// ignore_for_file: non_constant_identifier_names
import 'dart:io';
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
import 'package:polkadart_keyring/polkadart_keyring.dart';
import 'package:polkadart_scale_codec/polkadart_scale_codec.dart'
    as scale_codec;
import 'package:polkadart_scale_codec/polkadart_scale_codec.dart';
import 'package:ss58/ss58.dart';
import 'package:polkadart_example/generated/polkadot/polkadot.dart';
import 'package:polkadart_example/generated/polkadot/types/sp_runtime/multiaddress/multi_address.dart';

Future<void> main(List<String> arguments) async {
  final alice = await KeyPair.sr25519.fromUri('//Alice');
  final dest = $MultiAddress().id(alice.publicKey.bytes);

  final alicePublicKey = hex.encode(alice.publicKey.bytes);
  print('Public Key: $alicePublicKey');

  final provider =
  Provider.fromUri(Uri.parse('ws://127.0.0.1:9944'));
  final api = Polkadot(provider);
  final state = StateApi(provider);

  final runtime = await state.getRuntimeVersion();
  final specVersion = runtime.specVersion;
  final txVersion =
      runtime.transactionVersion;

  final block = await provider.send('chain_getBlock', []);
  final blockNumber =
  int.parse(block.result['block']['header']['number']);
  final blockHash =
  (await provider.send('chain_getBlockHash', []))
      .result
      .replaceAll('0x', '');
  final genesisHash =
  (await provider.send('chain_getBlockHash', [0]))
      .result
      .replaceAll('0x', '');

  final customCall = api.tx.balances.transferKeepAlive(
      dest: dest, value: BigInt.from(1000000000000));



  // final customEncodedCall = customCall.encode();
  // print('Custom Encoded Call: ${hex.encode(customEncodedCall)}');
  //
  // // Get Metadata
  // final customMetadata = await polkadotState.getMetadata();
  // // Get Registry
  // final scale_codec.Registry registry =
  // scale_codec.Registry.fromRuntimeMetadata(customMetadata.metadata);
  //
  // // Get SignedExtensions mapped with codecs Map<String, Codec<dynamic>>
  // final Map<String, scale_codec.Codec<dynamic>> signedExtensions =
  // registry.getSignedExtensionTypes();
  // print('Signed Extensions Keys: ${signedExtensions.keys.toList()}');
  // final nonce1 =
  // await SystemApi(polkadotProvider).accountNextIndex(alice.address);
  // print('Alice address: ${alice.address}');
  // print('Nonce: $nonce1');
  //
  // final paymentAsset = CommunityIdentifier(
  //     geohash: utf8.encode('sqm1v'), digest: hex.decode('f08c911c'));
  //
  // final payloadWithExtension = SigningPayload(
  //   method: customEncodedCall,
  //   specVersion: polkadotSpecVersion,
  //   transactionVersion: polkadotTransactionVersion =,
  //   genesisHash: encointerGenesisHash,
  //   blockHash: encointerBlockHash,
  //   blockNumber: encointerBlockNumber,
  //   eraPeriod: 64,
  //   nonce: nonce1,
  //   tip: 0,
  //   customSignedExtensions: <String, dynamic>{
  //     'ChargeAssetTxPayment': {
  //       "tip": BigInt.zero,
  //       "asset_id": Option.some(paymentAsset.toJson()),
  //     }, // A custom Signed Extensions
  //   },
  // );
  //
  // final customExtensionPayload = payloadWithExtension.encode(registry);
  // print('Encoded Payload: ${hex.encode(customExtensionPayload)}');
  //
  // final customSignature = alice.sign(customExtensionPayload);
  // print('Signature: ${hex.encode(customSignature)}');
  //
  // final customExtrinsic = ExtrinsicPayload(
  //   signer: Uint8List.fromList(alice.publicKey.bytes),
  //   method: customEncodedCall,
  //   signature: customSignature,
  //   eraPeriod: 64,
  //   blockNumber: encointerBlockNumber,
  //   nonce: nonce1,
  //   tip: 0,
  //   customSignedExtensions: <String, dynamic>{
  //     'ChargeAssetTxPayment': {
  //       "tip": BigInt.zero,
  //       "asset_id": Option.some(paymentAsset.toJson()),
  //     }, // A custom Signed Extensions
  //   },
  // ).encode(registry, SignatureType.sr25519);
  // print('custom signed extension extrinsic: ${hex.encode(customExtrinsic)}');
  //
  // final authorEncointer = AuthorApi(polkadotProvider);
  // final hash = await authorEncointer.submitExtrinsic(customExtrinsic);
  // print('Custom Signed Extension Extrinsic Hash: ${hex.encode(hash)}');
}
