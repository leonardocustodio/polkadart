/// This is an example for encointer that uses the `ChargeAssetTxPayment` signed
/// extension with an asset id that is not number.
///
/// The example assumes that the following has been run:
/// ```bash
/// git clone git@github.com:encointer/encointer-node.git
/// cd encointer-node
/// cargo build --release
/// ./target/release/encointer-node-notee --dev --enable-offchain-indexing true --rpc-methods unsafe -lencointer=debug,parity_ws=warn --rpc-external --rpc-port 9944
/// ```
///
/// And in another terminal we run a script to create a test community:
/// ```bash
/// cd encointer-node/client
/// ./bootstrap_demo_community.py --signer //Bob
/// ```

import 'dart:convert';
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
import 'package:polkadart_example/generated/encointer/encointer.dart';
import 'package:polkadart_example/generated/encointer/types/sp_runtime/multiaddress/multi_address.dart'
    as encointer;
import 'package:polkadart_keyring/polkadart_keyring.dart';
import 'package:polkadart_scale_codec/polkadart_scale_codec.dart'
    as scale_codec;
import 'package:polkadart_scale_codec/polkadart_scale_codec.dart';

import 'package:polkadart_example/generated/encointer/types/encointer_primitives/communities/community_identifier.dart'
    show CommunityIdentifier;

Future<void> main(List<String> arguments) async {
  // Custom Signed Extension with TypeRegistry
  {
    final alice = await KeyPair.sr25519.fromUri('//Alice');
    final bob = await KeyPair.sr25519.fromUri('//Bob');

    final alicePublicKey = hex.encode(alice.publicKey.bytes);
    print('Public Key: $alicePublicKey');
    final bobMultiAddress = encointer.$MultiAddress().id(bob.publicKey.bytes);

    final encointerProvider =
        Provider.fromUri(Uri.parse('ws://127.0.0.1:9944'));
    final encointerApi = Encointer(encointerProvider);
    final encointerState = StateApi(encointerProvider);

    final encointerRuntimeVersion = await encointerState.getRuntimeVersion();
    final encointerSpecVersion = encointerRuntimeVersion.specVersion;
    final encointerTransactionVersion =
        encointerRuntimeVersion.transactionVersion;
    final encointerBlock = await encointerProvider.send('chain_getBlock', []);
    final encointerBlockNumber =
        int.parse(encointerBlock.result['block']['header']['number']);
    final encointerBlockHash =
        (await encointerProvider.send('chain_getBlockHash', []))
            .result
            .replaceAll('0x', '');
    final encointerGenesisHash =
        (await encointerProvider.send('chain_getBlockHash', [0]))
            .result
            .replaceAll('0x', '');

    final customCall = encointerApi.tx.balances.transferKeepAlive(
        dest: bobMultiAddress, value: BigInt.from(1000000000000));
    final customEncodedCall = customCall.encode();
    print('Custom Encoded Call: ${hex.encode(customEncodedCall)}');

    // Get Metadata
    final customMetadata = await encointerState.getMetadata();
    // Get Registry
    final scale_codec.Registry registry =
        customMetadata.chainInfo.scaleCodec.registry;

    // Get SignedExtensions mapped with codecs Map<String, Codec<dynamic>>
    final Map<String, scale_codec.Codec<dynamic>> signedExtensions =
        registry.getSignedExtensionTypes();
    print('Signed Extensions Keys: ${signedExtensions.keys.toList()}');
    final nonce1 =
        await SystemApi(encointerProvider).accountNextIndex(alice.address);
    print('Alice address: ${alice.address}');
    print('Nonce: $nonce1');

    final paymentAsset = CommunityIdentifier(
        geohash: utf8.encode('sqm1v'), digest: hex.decode('f08c911c'));

    final payloadWithExtension = SigningPayload(
      method: customEncodedCall,
      specVersion: encointerSpecVersion,
      transactionVersion: encointerTransactionVersion,
      genesisHash: encointerGenesisHash,
      blockHash: encointerBlockHash,
      blockNumber: encointerBlockNumber,
      eraPeriod: 64,
      nonce: nonce1,
      tip: 0,
      customSignedExtensions: <String, dynamic>{
        'ChargeAssetTxPayment': {
          "tip": BigInt.zero,
          "asset_id": Option.some(paymentAsset.toJson()),
        }, // A custom Signed Extensions
      },
    );

    final customExtensionPayload = payloadWithExtension.encode(registry);
    print('Encoded Payload: ${hex.encode(customExtensionPayload)}');

    final customSignature = alice.sign(customExtensionPayload);
    print('Signature: ${hex.encode(customSignature)}');

    final customExtrinsic = ExtrinsicPayload(
      signer: Uint8List.fromList(alice.publicKey.bytes),
      method: customEncodedCall,
      signature: customSignature,
      eraPeriod: 64,
      blockNumber: encointerBlockNumber,
      nonce: nonce1,
      tip: 0,
      customSignedExtensions: <String, dynamic>{
        'ChargeAssetTxPayment': {
          "tip": BigInt.zero,
          "asset_id": Option.some(paymentAsset.toJson()),
        }, // A custom Signed Extensions
      },
    ).encode(registry, SignatureType.sr25519);
    print('custom signed extension extrinsic: ${hex.encode(customExtrinsic)}');

    final authorEncointer = AuthorApi(encointerProvider);
    final hash = await authorEncointer.submitExtrinsic(customExtrinsic);
    print('Custom Signed Extension Extrinsic Hash: ${hex.encode(hash)}');
  }
}
