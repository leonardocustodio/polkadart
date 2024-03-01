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
import 'package:polkadart_example/generated/assethub/assethub.dart';
import 'package:polkadart_example/generated/assethub/types/sp_runtime/multiaddress/multi_address.dart'
    as asset_hub;
import 'package:polkadart_example/generated/westend/types/sp_runtime/multiaddress/multi_address.dart';
import 'package:polkadart_example/generated/westend/westend.dart';
import 'package:polkadart_keyring/polkadart_keyring.dart';
import 'package:polkadart_scale_codec/polkadart_scale_codec.dart'
    as scale_codec;
import 'package:polkadart_scale_codec/polkadart_scale_codec.dart';
import 'package:ss58/ss58.dart';

Future<void> main(List<String> arguments) async {
  // Create sr25519 wallet
  final sr25519Wallet = await KeyPair.sr25519.fromMnemonic(
      "resource mirror lecture smooth midnight muffin position cup pepper fruit vanish also//10");
  print('Sr25519 Wallet: ${sr25519Wallet.address}');

  // Create ecdsa wallet
  final ecdsaWallet = await KeyPair.ecdsa.fromMnemonic(
      "mushroom grab answer fork ripple virus swamp food excess old client arena//10");
  print('Ecdsa Wallet: ${ecdsaWallet.address}');

  {
    final westProvider =
        Provider.fromUri(Uri.parse('wss://westend-rpc.polkadot.io'));
    final westApi = Westend(westProvider);

    // Get info necessary to build an extrinsic
    final stateApi = StateApi(westProvider);
    final runtimeVersion = await stateApi.getRuntimeVersion();
    final specVersion = runtimeVersion.specVersion;
    final transactionVersion = runtimeVersion.transactionVersion;
    final block = await westProvider.send('chain_getBlock', []);
    final blockNumber = int.parse(block.result['block']['header']['number']);
    print('Block Number: $blockNumber');

    final blockHash = (await westProvider.send('chain_getBlockHash', []))
        .result
        .replaceAll('0x', '');
    final genesisHash = (await westProvider.send('chain_getBlockHash', [0]))
        .result
        .replaceAll('0x', '');

    // Initiate Author Api
    final author = AuthorApi(westProvider);

    //
    //
    // sending balance from sr25519 wallet to ecdsa wallet
    {
      //
      //
      // Ecdsa Wallet is becoming the receiver and the sr25519 wallet is the sender
      final dest = ecdsaWallet.address;
      final multiDest = $MultiAddress().id(Address.decode(dest).pubkey);
      print('Destination: $dest');

      // Encode call
      final runtimeCall =
          westApi.tx.balances.transferAll(dest: multiDest, keepAlive: false);
      final encodedCall = runtimeCall.encode();

      final nonce1 =
          await SystemApi(westProvider).accountNextIndex(sr25519Wallet.address);

      final sr25519_payloadToSign = SigningPayload(
        method: encodedCall,
        specVersion: specVersion,
        transactionVersion: transactionVersion,
        genesisHash: genesisHash,
        blockHash: blockHash,
        blockNumber: blockNumber,
        eraPeriod: 64,
        nonce: nonce1, // Supposing it is this wallet first transaction
        tip: 0,
      );

      // Build payload and sign with sr25519 wallet
      final srPayload = sr25519_payloadToSign.encode(westApi.registry);
      print('Payload: ${hex.encode(srPayload)}');

      final srSignature = sr25519Wallet.sign(srPayload);
      print('Signature: ${hex.encode(srSignature)}');

      // Build extrinsic with sr25519 wallet
      final srExtrinsic = ExtrinsicPayload(
        signer: Uint8List.fromList(sr25519Wallet.bytes()),
        method: encodedCall,
        signature: srSignature,
        eraPeriod: 64,
        blockNumber: blockNumber,
        nonce: nonce1,
        tip: 0,
      ).encode(westApi.registry, SignatureType.sr25519);
      print('sr25519 wallet extrinsic: ${hex.encode(srExtrinsic)}');

      final srHash = await author.submitExtrinsic(srExtrinsic);
      print('Sr25519 extrinsic hash: ${hex.encode(srHash)}');
    }

    sleep(Duration(seconds: 10));

    //
    // Here we are sending back the received funds which we received from sr25519 wallet in previous step.
    //
    // sending back balance from ecdsa wallet to sr25519 wallet.
    {
      //
      //
      // sr25519 Wallet is becoming the receiver and the ecdsa wallet is the sender
      final dest = sr25519Wallet.address;
      final multiDest = $MultiAddress().id(Address.decode(dest).pubkey);
      print('Destination: $dest');

      // Encode call
      final runtimeCall =
          westApi.tx.balances.transferAll(dest: multiDest, keepAlive: false);
      final encodedCall = runtimeCall.encode();

      final nonce1 =
          await SystemApi(westProvider).accountNextIndex(ecdsaWallet.address);

      final ecdsa_payloadToSign = SigningPayload(
        method: encodedCall,
        specVersion: specVersion,
        transactionVersion: transactionVersion,
        genesisHash: genesisHash,
        blockHash: blockHash,
        blockNumber: blockNumber,
        eraPeriod: 64,
        nonce: nonce1,
        tip: 0,
      );

      // Build payload and sign with ecdsa wallet
      final ecdsaPayload = ecdsa_payloadToSign.encode(westApi.registry);
      print('Payload: ${hex.encode(ecdsaPayload)}');

      final ecdsaSignature = ecdsaWallet.sign(ecdsaPayload);
      print('Signature: ${hex.encode(ecdsaSignature)}');

      // Build extrinsic with ecdsa wallet
      final ecdsaExtrinsic = ExtrinsicPayload(
        signer: Uint8List.fromList(ecdsaWallet.publicKey.bytes),
        method: encodedCall,
        signature: ecdsaSignature,
        eraPeriod: 64,
        blockNumber: blockNumber,
        nonce: nonce1,
        tip: 0,
      ).encode(westApi.registry, SignatureType.ecdsa);
      print('Ecdsa wallet extrinsic: ${hex.encode(ecdsaExtrinsic)}');

      final ecdsaHash = await author.submitExtrinsic(ecdsaExtrinsic);
      print('Ecdsa extrinsic hash: ${hex.encode(ecdsaHash)}');
    }
  }

  //
  //
  // Custom RPC call
  {
    final astarProvider =
        Provider.fromUri(Uri.parse('wss://rpc.astar.network'));
    final gasPrice = await astarProvider.send('eth_gasPrice', []);
    print('Gas Price: ${gasPrice.result}');
  }

  // Custom Signed Extension with TypeRegistry
  {
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
    final assetGenesisHash =
        (await assetProvider.send('chain_getBlockHash', [0]))
            .result
            .replaceAll('0x', '');

    final customDest = asset_hub
        .$MultiAddress()
        .id(Address.decode(ecdsaWallet.address).pubkey);
    print('Custom Destination: $customDest');
    final customCall =
        assetApi.tx.balances.transferAll(dest: customDest, keepAlive: false);
    final customEncodedCall = customCall.encode();
    print('Custom Encoded Call: ${hex.encode(customEncodedCall)}');

    // Get Metadata
    final customMetadata = await assetState.getMetadata();
    // Get Registry
    final scale_codec.Registry registry =
        customMetadata.chainInfo.scaleCodec.registry;

    // Get SignedExtensions mapped with codecs Map<String, Codec<dynamic>>
    final Map<String, scale_codec.Codec<dynamic>> signedExtensions =
        registry.getSignedExtensionTypes();
    print('Signed Extensions Keys: ${signedExtensions.keys.toList()}');
    final nonce1 =
        await SystemApi(assetProvider).accountNextIndex(sr25519Wallet.address);
    print('sr25519 assethub address: ${sr25519Wallet.address}');
    print('Nonce: $nonce1');

    final payloadWithExtension = SigningPayload(
      method: customEncodedCall,
      specVersion: assetSpecVersion,
      transactionVersion: assetTransactionVersion,
      genesisHash: assetGenesisHash,
      blockHash: assetBlockHash,
      blockNumber: assetBlockNumber,
      eraPeriod: 64,
      nonce: nonce1,
      tip: 0,
      customSignedExtensions: <String, dynamic>{
        'ChargeAssetTxPayment': {
          "tip": BigInt.zero,
          "asset_id": Option.none(),
        }, // A custom Signed Extensions
      },
    );

    final customExtensionPayload = payloadWithExtension.encode(registry);
    print('Encoded Payload: ${hex.encode(customExtensionPayload)}');

    final customSignature = sr25519Wallet.sign(customExtensionPayload);
    print('Signature: ${hex.encode(customSignature)}');

    final customExtrinsic = ExtrinsicPayload(
      signer: Uint8List.fromList(sr25519Wallet.publicKey.bytes),
      method: customEncodedCall,
      signature: customSignature,
      eraPeriod: 64,
      blockNumber: assetBlockNumber,
      nonce: nonce1,
      tip: 0,
      customSignedExtensions: <String, dynamic>{
        'ChargeAssetTxPayment': {
          "tip": BigInt.zero,
          "asset_id": Option.none(),
        }, // A custom Signed Extensions
      },
    ).encode(registry, SignatureType.sr25519);
    print('custom signed extension extrinsic: ${hex.encode(customExtrinsic)}');

    final authorAssetHub = AuthorApi(assetProvider);
    final hash = await authorAssetHub.submitExtrinsic(customExtrinsic);
    print('Custom Signed Extension Extrinsic Hash: ${hex.encode(hash)}');
  }
}
