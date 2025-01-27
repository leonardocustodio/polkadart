import 'dart:typed_data';
import 'package:polkadart/polkadart.dart';
import 'package:polkadart/scale_codec.dart';
import 'package:polkadart/scale_codec.dart' as scale_codec;
import 'package:polkadart/substrate/era.dart';
import 'package:polkadart_keyring/polkadart_keyring.dart';
import 'package:ss58/ss58.dart';

class ContractMeta {
  final int blockNumber;
  final Uint8List blockHash;
  final Uint8List genesisHash;
  final int specVersion;
  final int transactionVersion;
  final RuntimeMetadata runtimeMetadata;

  const ContractMeta({
    required this.blockNumber,
    required this.blockHash,
    required this.genesisHash,
    required this.specVersion,
    required this.transactionVersion,
    required this.runtimeMetadata,
  });

  static Future<ContractMeta> fromProvider({required Provider provider}) async {
    final ChainApi chainApi = ChainApi(provider);

    // Get the latest block number from the chain
    final int blockNumber = await chainApi.getChainHeader();

    // Get the blockhash of the latest block
    final Uint8List blockHash =
        await chainApi.getBlockHash(blockNumber: blockNumber);

    // Get the genesis hash of the chain from block number: 0
    final Uint8List genesisHash = await chainApi.getBlockHash(blockNumber: 0);

    final StateApi stateApi = StateApi(provider);
    final RuntimeMetadata runtimeMetadata = await stateApi.getMetadata();
    final RuntimeVersion stateRuntimeVersion =
        await stateApi.getRuntimeVersion();

    return ContractMeta(
      blockNumber: blockNumber,
      blockHash: blockHash,
      genesisHash: genesisHash,
      runtimeMetadata: runtimeMetadata,
      specVersion: stateRuntimeVersion.specVersion,
      transactionVersion: stateRuntimeVersion.transactionVersion,
    );
  }
}

class ContractExtrinsicPayload {
  static Uint8List encode({
    required final ContractMeta meta,
    required final Uint8List method,
    required final Uint8List signer,
    required final Uint8List signature,
    required final dynamic tip,
    required final int version,
    required final int nonce,
    // making it required intentionally so that the end-developer knows that this is supported
    // and has to pass null explicitly.
    required final bool? checkMetadataHash,
    required final SignatureType signatureType,
    final int eraPeriod = 0,
  }) {
    final output = ByteOutput();

    // version
    output.pushByte(version);
    // MultiAddress -> Id  {is at index 0}
    output.pushByte(0);
    // now push the signer bytes
    output.write(signer);
    // Signature type byte
    output.pushByte(signatureType.type);

    // Write Signature
    output.write(signature);

    // era
    if (eraPeriod == 0) {
      output.pushByte(0);
    } else {
      Era.codec.encodeMortal(meta.blockNumber, eraPeriod);
    }

    // nonce
    CompactCodec.codec.encode(nonce);

    // tip
    if (tip is int) {
      CompactCodec.codec.encodeTo(tip, output);
    } else if (tip is BigInt) {
      CompactBigIntCodec.codec.encodeTo(tip, output);
    } else {
      throw Exception('tip can either be int or BigInt.');
    }

    // CheckMetadata Hash
    if (checkMetadataHash != null) {
      BoolCodec.codec.encodeTo(checkMetadataHash, output);
    }

    // Add the method call -> transfer.....
    output.write(method);

    return U8SequenceCodec.codec.encode(output.toBytes());
  }
}

class ContractSigningPayload {
  static Uint8List encode({
    required final ContractMeta meta,
    required final Uint8List method,
    required final dynamic tip,
    required final int nonce,
    // making it required intentionally so that the end-developer knows that this is supported
    // and has to pass null explicitly.
    required final bool? checkMetadataHash,
    final int eraPeriod = 0,
  }) {
    final output = ByteOutput();

    // method_call
    output.write(method);

    // era
    if (eraPeriod == 0) {
      output.pushByte(0);
    } else {
      Era.codec.encodeMortal(meta.blockNumber, eraPeriod);
    }

    // nonce
    CompactCodec.codec.encode(nonce);

    // tip
    if (tip is int) {
      CompactCodec.codec.encodeTo(tip, output);
    } else if (tip is BigInt) {
      CompactBigIntCodec.codec.encodeTo(tip, output);
    } else {
      throw Exception('tip can either be int or BigInt.');
    }

    // CheckMetadata Hash
    if (checkMetadataHash != null) {
      BoolCodec.codec.encodeTo(checkMetadataHash, output);
    }

    // specVersion
    U32Codec.codec.encode(meta.specVersion);

    // transactionVersion
    U32Codec.codec.encode(meta.transactionVersion);

    // genesisHash
    output.write(meta.genesisHash);

    // blockHash
    output.write(meta.blockHash);

    // CheckMetadata Hash
    if (checkMetadataHash != null) {
      BoolCodec.codec.encodeTo(checkMetadataHash, output);
    }

    return output.toBytes();
  }

  ///
  /// Signs the payload with the keypair.
  ///
  /// If the payload is greater than 256 bytes, it will be hashed with blake2b256 before signing.
  static Uint8List sign(KeyPair keyPair, Uint8List payload) {
    if (payload.length > 256) {
      payload = Hasher.blake2b256.hash(payload);
    }
    return keyPair.sign(payload);
  }
}

class ContractsBuilder {
  static Future<Uint8List> signAndBuildExtrinsic({
    required final Provider provider,
    required final KeyPair signer,
    required final InstantiateWithCodeArgs methodArgs,
    required final scale_codec.Registry registry,
    final dynamic tip = 0,
    final int eraPeriod = 0,
  }) async {
    final Uint8List methodCall =
        ContractsMethod.instantiateWithCode(args: methodArgs).encode(registry);

    final ContractMeta meta =
        await ContractMeta.fromProvider(provider: provider);
    final int nonce =
        await SystemApi(provider).accountNextIndex(signer.address);

    bool? checkMetadataHash;
    final signedExtensions =
        meta.runtimeMetadata.metadata['extrinsic']?['signedExtensions'];
    if (signedExtensions != null && signedExtensions is List) {
      for (final extension in signedExtensions) {
        if (extension is Map &&
            extension['identifier'] != null &&
            extension['identifier'] is String &&
            (extension['identifier'] as String).toLowerCase() ==
                'checkmetadatahash') {
          checkMetadataHash = false;
          break;
        }
      }
    }

    final Uint8List unsignedPayload = ContractSigningPayload.encode(
      meta: meta,
      method: methodCall,
      tip: tip,
      nonce: nonce,
      checkMetadataHash: checkMetadataHash,
    );

    final Uint8List payloadSignature =
        ContractSigningPayload.sign(signer, unsignedPayload);

    final Uint8List signedContractTx = ContractExtrinsicPayload.encode(
      version: 132,
      signer: Address.decode(signer.address).pubkey,
      signatureType: signer.signatureType,
      meta: meta,
      method: methodCall,
      tip: tip,
      nonce: nonce,
      checkMetadataHash: checkMetadataHash,
      signature: payloadSignature,
    );

    final Uint8List expectedTxHash = Hasher.blake2b256.hash(signedContractTx);
    final Uint8List actualHash =
        await submitExtrinsic(provider, signedContractTx);

    final bool isMatched = encodeHex(expectedTxHash) == encodeHex(actualHash);
    assertion(isMatched,
        'The expected hash and the actual hash of the approval transaction does not match.');
    return actualHash;
  }

  ///
  /// Submits the extrinsic to the chain and returns the hash of the transaction.
  ///
  static Future<Uint8List> submitExtrinsic(
      final Provider provider, final Uint8List extrinsic) async {
    return await AuthorApi(provider).submitExtrinsic(extrinsic);
  }
}

class ContractsMethod {
  final String method;
  final ContractArgs args;

  const ContractsMethod._(
    this.method,
    this.args,
  );

  static ContractsMethod instantiateWithCode({
    required final InstantiateWithCodeArgs args,
  }) {
    return ContractsMethod._(
      'instantiate_with_code',
      args,
    );
  }

  Uint8List encode(final scale_codec.Registry registry) {
    final contractArgument = MapEntry(
      'Contracts',
      MapEntry(method, args.toMap()),
    );

    final Uint8List result = registry.codecs['Call']!.encode(contractArgument);
    return result;
  }
}

class GasLimit {
  final BigInt refTime;
  final BigInt proofSize;

  const GasLimit({required this.refTime, required this.proofSize});

  static GasLimit from(final Map<String, dynamic> gasLimit) {
    if (gasLimit.containsKey('proof_size') &&
        gasLimit.containsKey('ref_time')) {
      // We already have th result which we wanted.
      return GasLimit(
        proofSize: BigInt.parse(gasLimit['proof_size']),
        refTime: BigInt.parse(gasLimit['ref_time']),
      );
    }

    if (gasLimit.containsKey('proofSize') && gasLimit.containsKey('refTime')) {
      // Let's convert this converted result
      return GasLimit(
        proofSize: BigInt.parse(gasLimit['proofSize']),
        refTime: BigInt.parse(gasLimit['refTime']),
      );
    }
    throw Exception('Unable to create GasLimit from $gasLimit');
  }

  Map<String, BigInt> toMap() {
    return <String, BigInt>{
      'ref_time': refTime,
      'proof_size': proofSize,
    };
  }
}

class StorageDepositLimit {
  final BigInt? value;
  const StorageDepositLimit({this.value});

  Option toOption() {
    if (value != null) {
      return Option.some(value);
    }
    return Option.none();
  }
}

abstract class ContractArgs {
  Map<String, dynamic> toMap();
}

class InstantiateWithCodeArgs implements ContractArgs {
  final BigInt value;
  final GasLimit gasLimit;
  final StorageDepositLimit storageDepositLimit;
  final Uint8List code;
  final Uint8List data;
  final Uint8List salt;

  const InstantiateWithCodeArgs({
    required this.value,
    required this.gasLimit,
    required this.storageDepositLimit,
    required this.code,
    required this.data,
    required this.salt,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'value': value,
      'gas_limit': gasLimit.toMap(),
      'storage_deposit_limit': storageDepositLimit.toOption(),
      'code': code,
      'data': data,
      'salt': salt,
    };
  }
}
