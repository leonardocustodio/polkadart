// ignore_for_file: non_constant_identifier_names
import 'dart:typed_data';
import 'package:convert/convert.dart';
import 'package:polkadart/apis/apis.dart';
import 'package:polkadart/polkadart.dart'
    show
        AuthorApi,
        ExtrinsicPayload,
        Provider,
        SignatureType,
        SigningPayload,
        StateApi;
import 'package:polkadart_example/generated/polkadot/types/sp_runtime/multiaddress/multi_address.dart'
    as polkadot;
import 'package:polkadart_keyring/polkadart_keyring.dart';
import 'package:polkadart_scale_codec/polkadart_scale_codec.dart'
    as scale_codec;
import 'package:substrate_metadata/metadata/merkleize.dart';
import 'generated/polkadot/polkadot.dart';

Future<void> main(List<String> arguments) async {
  final alice = await KeyPair.sr25519.fromUri('//Alice');
  final bob = await KeyPair.sr25519.fromUri('//Bob');

  final alicePublicKey = hex.encode(alice.publicKey.bytes);
  print('Public Key: $alicePublicKey');
  final bobMultiAddress = polkadot.$MultiAddress().id(bob.publicKey.bytes);

  final provider = Provider.fromUri(Uri.parse('wss://rpc.polkadot.io'));
  final api = Polkadot(provider);
  final state = StateApi(provider);

  final runtimeVersion = await state.getRuntimeVersion();
  final specVersion = runtimeVersion.specVersion;
  final txVersion = runtimeVersion.transactionVersion;
  final block = await provider.send('chain_getBlock', []);
  final blockHeight = int.parse(block.result['block']['header']['number']);
  final blockHash = (await provider.send('chain_getBlockHash', []))
      .result
      .replaceAll('0x', '');
  final genesisHash = (await provider.send('chain_getBlockHash', [0]))
      .result
      .replaceAll('0x', '');

  final call = api.tx.balances.transferKeepAlive(
      dest: bobMultiAddress, value: BigInt.from(1000000000000));
  final encodedCall = call.encode();
  print('Custom Encoded Call: ${hex.encode(encodedCall)}');

  // Get Metadata
  final metadata = await state.getMetadata();
  // Get Registry
  final scale_codec.Registry registry = metadata.chainInfo.scaleCodec.registry;

  // Get MetadataHash
  final typedMetadata = await state.getTypedMetadata();
  final merkleizer = MetadataMerkleizer.fromMetadata(typedMetadata.metadata,
      decimals: 10, tokenSymbol: 'DOT');
  final metadataHash = hex.encode(merkleizer.digest());

  // Get SignedExtensions mapped with codecs Map<String, Codec<dynamic>>
  final Map<String, scale_codec.Codec<dynamic>> signedExtensions =
      registry.getSignedExtensionTypes();
  print('Signed Extensions Keys: ${signedExtensions.keys.toList()}');

  final nextNonce = await SystemApi(provider).accountNextIndex(alice.address);
  print('Alice address: ${alice.address}');
  print('Nonce: $nextNonce');

  final payloadWithExtension = SigningPayload(
    method: encodedCall,
    specVersion: specVersion,
    transactionVersion: txVersion,
    genesisHash: genesisHash,
    blockHash: blockHash,
    blockNumber: blockHeight,
    eraPeriod: 64,
    nonce: nextNonce,
    tip: 0,
    metadataHash: metadataHash,
  );

  final customExtensionPayload = payloadWithExtension.encode(registry);
  print('Encoded Payload: ${hex.encode(customExtensionPayload)}');

  final signature = alice.sign(customExtensionPayload);
  print('Signature: ${hex.encode(signature)}');

  final srExtrinsic = ExtrinsicPayload(
    signer: Uint8List.fromList(alice.publicKey.bytes),
    method: encodedCall,
    signature: signature,
    eraPeriod: 64,
    blockNumber: blockHeight,
    nonce: nextNonce,
    tip: 0,
    metadataHash: metadataHash,
  ).encode(registry, SignatureType.sr25519);
  print('Encoded extrinsic: ${hex.encode(srExtrinsic)}');

  final author = AuthorApi(provider);
  final hash = await author.submitExtrinsic(srExtrinsic);
  print('Extrinsic hash: ${hex.encode(hash)}');
}
