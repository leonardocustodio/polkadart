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
import 'package:polkadart_example/generated/assethub/assethub.dart';
import 'package:polkadart_example/generated/assethub/types/sp_runtime/multiaddress/multi_address.dart'
    as asset_hub;
import 'package:polkadart_example/generated/westend/types/sp_runtime/multiaddress/multi_address.dart';
import 'package:polkadart_example/generated/westend/westend.dart';
import 'package:polkadart_keyring/polkadart_keyring.dart';
import 'package:polkadart_scale_codec/polkadart_scale_codec.dart'
    as scale_codec;
import 'package:ss58/ss58.dart';

Future<void> main(List<String> arguments) async {
  final westProvider =
      Provider.fromUri(Uri.parse('wss://westend-rpc.polkadot.io'));
  final westApi = Westend(westProvider);

  // Create sr25519 wallet
  final sr25519Wallet = await KeyPair.sr25519.fromMnemonic(
      "resource mirror lecture smooth midnight muffin position cup pepper fruit vanish also//1");
  print('Sr25519 Wallet: ${sr25519Wallet.address}');

  // Create ecdsa wallet
  final ecdsaWallet = await KeyPair.ecdsa.fromMnemonic(
      "resource mirror lecture smooth midnight muffin position cup pepper fruit vanish also//1");
  print('Ecdsa Wallet: ${ecdsaWallet.address}');

  // Random destination address
  final dest = '5GP3LivcsffRZXZhJ6EMxe4kYXYdhs3aLjgHFz3Ap2iLxcSw';
  final multiDest = $MultiAddress().id(Address.decode(dest).pubkey);
  print('Destination: $dest');

  // Get info necessary to build an extrinsic
  final stateApi = StateApi(westProvider);
  final runtimeVersion = await stateApi.getRuntimeVersion();
  final specVersion = runtimeVersion.specVersion;
  final transactionVersion = runtimeVersion.transactionVersion;
  final block = await westProvider.send('chain_getBlock', []);
  final blockNumber = int.parse(block.result['block']['header']['number']);
  final blockHash = (await westProvider.send('chain_getBlockHash', []))
      .result
      .replaceAll('0x', '');
  final genesisHash = (await westProvider.send('chain_getBlockHash', [0]))
      .result
      .replaceAll('0x', '');

  // Encode call
  final runtimeCall =
      westApi.tx.balances.transferAll(dest: multiDest, keepAlive: false);
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

  // Build payload and sign with sr25519 wallet
  final srPayload = payloadToSign.encode(westApi.registry);
  print('Payload: ${hex.encode(srPayload)}');

  final srSignature = sr25519Wallet.sign(srPayload);
  print('Signature: ${hex.encode(srSignature)}');

  // Build extrinsic with sr25519 wallet
  final srExtrinsic = ExtrinsicPayload(
    signer: Uint8List.fromList(sr25519Wallet.publicKey.bytes),
    method: encodedCall,
    signature: srSignature,
    eraPeriod: 64,
    blockNumber: blockNumber,
    nonce: 0,
    tip: 0,
  ).encode(westApi.registry, SignatureType.sr25519);
  print('sr25519 wallet extrinsic: ${hex.encode(srExtrinsic)}');

  // Build payload and sign with ecdsa wallet
  final ecPayload = payloadToSign.encode(westApi.registry);
  print('Payload: ${hex.encode(ecPayload)}');

  final ecSignature = ecdsaWallet.sign(ecPayload);
  print('Signature: ${hex.encode(ecSignature)}');

  // Build extrinsic with ecdsa wallet
  final ecExtrinsic = ExtrinsicPayload(
    signer: Uint8List.fromList(ecdsaWallet.publicKey.bytes),
    method: encodedCall,
    signature: ecSignature,
    eraPeriod: 64,
    blockNumber: blockNumber,
    nonce: 0,
    tip: 0,
  ).encode(westApi.registry, SignatureType.ecdsa);
  print('ecdsa wallet extrinsic: ${hex.encode(ecExtrinsic)}');

  // Send both extrinsic
  final author = AuthorApi(westProvider);
  // final srHash = await author.submitExtrinsic(srExtrinsic);
  // print('Sr25519 extrinsic hash: $srHash');
  // final ecHash = await author.submitExtrinsic(ecExtrinsic);
  // print('Ecdsa extrinsic hash: $ecHash');

  // Sign & verify messages

  // Custom RPC call
  final astarProvider = Provider.fromUri(Uri.parse('wss://rpc.astar.network'));
  final gasPrice = await astarProvider.send('eth_gasPrice', []);
  print('Gas Price: ${gasPrice.result}');

  // Custom Signed Extension with TypeRegistry
  final assetProvider =
      Provider.fromUri(Uri.parse('wss://westend-asset-hub-rpc.polkadot.io'));
  final assetApi = Assethub(assetProvider);
  final assetState = StateApi(assetProvider);

  final assetRuntimeVersion = await assetState.getRuntimeVersion();
  final assetSpecVersion = assetRuntimeVersion.specVersion;
  final assetTransactionVersion = assetRuntimeVersion.transactionVersion;
  final assetBlock = await assetProvider.send('chain_getBlock', []);
  final assetBlockNumber =
      int.parse(assetBlock.result['block']['header']['number']);
  final assetBlockHash = (await assetProvider.send('chain_getBlockHash', []))
      .result
      .replaceAll('0x', '');
  final assetGenesisHash = (await assetProvider.send('chain_getBlockHash', [0]))
      .result
      .replaceAll('0x', '');

  final customDest = asset_hub.$MultiAddress().id(Address.decode(dest).pubkey);
  final customCall =
      assetApi.tx.balances.transferAll(dest: customDest, keepAlive: false);
  final customEncodedCall = customCall.encode();
  print('Encoded custom call: $encodedCall');

  // Get Metadata
  final customMetadata = await assetState.getMetadata();
  // Get Registry
  final scale_codec.Registry registry =
      customMetadata.chainInfo.scaleCodec.registry;

  // Get SignedExtensions mapped with codecs Map<String, Codec<dynamic>>
  final Map<String, scale_codec.Codec<dynamic>> signedExtensions =
      registry.getSignedExtensionTypes();
  print('Signed Extensions Keys: ${signedExtensions.keys.toList()}');

  final payloadWithExtension = SigningPayload(
    method: customEncodedCall,
    specVersion: assetSpecVersion,
    transactionVersion: assetTransactionVersion,
    genesisHash: assetGenesisHash,
    blockHash: assetBlockHash,
    blockNumber: assetBlockNumber,
    eraPeriod: 64,
    nonce: 0, // Supposing it is this wallet first transaction
    tip: 0,
    customSignedExtensions: <String, dynamic>{
      'ChargeAssetTxPayment': 10, // A custom Signed Extensions
    },
  );

  final customExtensionPayload = payloadWithExtension.encode(registry);
  print('Payload: ${hex.encode(customExtensionPayload)}');

  final customSignature = sr25519Wallet.sign(customExtensionPayload);
  print('Signature: ${hex.encode(customSignature)}');

  final customExtrinsic = ExtrinsicPayload(
    signer: Uint8List.fromList(sr25519Wallet.publicKey.bytes),
    method: customEncodedCall,
    signature: customSignature,
    eraPeriod: 64,
    blockNumber: assetBlockNumber,
    nonce: 0,
    tip: 0,
    customSignedExtensions: <String, dynamic>{
      'ChargeAssetTxPayment': 10, // A custom Signed Extensions
    },
  ).encode(assetApi.registry, SignatureType.sr25519);
  print('custom signed extension extrinsic: ${hex.encode(customExtrinsic)}');

  // final author = AuthorApi(matrixProvider);
  // author.submitAndWatchExtrinsic(
  //     extrinsic, (p0) => print("Extrinsic result: ${p0.type} - {${p0.value}}"));
}

// 0x
// 3102 84
// 00 2ef81b9b68f63a5f92e4cc8f370750c575f3005e284d6a2c8ecfeee0daf49f35
// 01 7c2c089ae6c97884325ebb059805a208d4591a2e2a1193dc7a7bbeaecbd4821233d87db9e85bc31b64720f271ac94756ee5b4a9332f6c62a95b817048b004288
// 7501
// 00
// 00
// 00
// 0a04
// 00
// beecf0681cf7e50992bdd7016c956c2b667fcd69d6143b0daec4165017586237
// 00

// 0x
// 3102 84
// 00 88796d1a489e2d12becd39b5db88b431cf76b1bedc3c35216c5cc7dc4fa0d412
// 01 e0630ddb8965152008659e831b62b76c7c00f2b3854071ff47fa344e33475437f01b8835375cbc00e5b5f99c0c6f9366a9fe5cb6bdc08471201d1b9728809382
// c503
// 00
// 00
// 00
// 0404
// 00
// beecf0681cf7e50992bdd7016c956c2b667fcd69d6143b0daec4165017586237
// 00
