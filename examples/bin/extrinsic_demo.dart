import 'dart:typed_data';

import 'package:convert/convert.dart';
import 'package:polkadart/polkadart.dart'
    show
        AuthorApi,
        ExtrinsicPayload,
        Provider,
        SignatureType,
        SigningPayload,
        StateApi;
import 'package:polkadart_scale_codec/polkadart_scale_codec.dart'
    as scale_codec;
import 'package:polkadart_keyring/polkadart_keyring.dart';

import 'package:polkadart_example/generated/polkadot/polkadot.dart';
import 'package:polkadart_example/generated/polkadot/types/sp_runtime/multiaddress/multi_address.dart';

Future<void> main(List<String> arguments) async {
  final provider = Provider.fromUri(Uri.parse('wss://rpc.polkadot.io'));
  final api = Polkadot(provider);

  final stateApi = StateApi(provider);

  final runtimeVersion = await stateApi.getRuntimeVersion();

  // Get Metadata
  final runtimeMetadata = await stateApi.getMetadata();
  // Get Registry
  final scale_codec.Registry registry =
      runtimeMetadata.chainInfo.scaleCodec.registry;

  //
  // Get SignedExtensions mapped with codecs Map<String, Codec<dynamic>>
  final Map<String, scale_codec.Codec<dynamic>> signedExtensions =
      registry.getSignedExtensionTypes();
  print('Signed Extensions Keys: ${signedExtensions.keys.toList()}');

  final specVersion = runtimeVersion.specVersion;

  final transactionVersion = runtimeVersion.transactionVersion;

  final block = await provider.send('chain_getBlock', []);

  final blockNumber = int.parse(block.result['block']['header']['number']);

  final blockHash = (await provider.send('chain_getBlockHash', []))
      .result
      .replaceAll('0x', '');

  final genesisHash = (await provider.send('chain_getBlockHash', [0]))
      .result
      .replaceAll('0x', '');

  final keyring = await KeyPair.sr25519.fromMnemonic(
      "resource mirror lecture smooth midnight muffin position cup pepper fruit vanish also//0"); // This is a random key

  final publicKey = keyring.publicKey.bytes;
  print('Public Key: $publicKey');
  final dest = $MultiAddress().id(publicKey);
  final runtimeCall = api.tx.balances.transferAll(dest: dest, keepAlive: true);
  final encodedCall = runtimeCall.encode();
  print('Encoded call: $encodedCall');

  final payloadToSign = SigningPayload(
    method: encodedCall,
    specVersion: specVersion,
    transactionVersion: transactionVersion,
    genesisHash: genesisHash,
    blockHash: blockHash,
    blockNumber: blockNumber,
    eraPeriod: 64,
    nonce: 0, // Supposing it is this wallet first transaction
    tip: 0,
  );

  final payload = payloadToSign.encode(api.registry);
  print('Payload: ${hex.encode(payload)}');

  final signature = keyring.sign(payload);
  final hexSignature = hex.encode(signature);
  print('Signature: $hexSignature');

  final extrinsic = ExtrinsicPayload(
    signer: Uint8List.fromList(publicKey),
    method: encodedCall,
    signature: signature,
    eraPeriod: 64,
    blockNumber: blockNumber,
    nonce: 0,
    tip: 0,
  ).encode(api.registry, SignatureType.sr25519);

  final hexExtrinsic = hex.encode(extrinsic);
  print('Extrinsic: $hexExtrinsic');

  final author = AuthorApi(provider);
  author.submitAndWatchExtrinsic(
      extrinsic, (p0) => print("Extrinsic result: ${p0.type} - {${p0.value}}"));
}
