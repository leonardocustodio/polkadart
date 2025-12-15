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
import 'package:polkadart/polkadart.dart' show ExtrinsicBuilder, Provider, StateApi;
import 'package:polkadart_example/generated/encointer/encointer.dart';
import 'package:polkadart_example/generated/encointer/types/sp_runtime/multiaddress/multi_address.dart'
    as encointer;
import 'package:polkadart_keyring/polkadart_keyring.dart';
import 'package:polkadart_scale_codec/polkadart_scale_codec.dart';
import 'package:substrate_metadata/substrate_metadata.dart';

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

    final encointerProvider = Provider.fromUri(
      Uri.parse('wss://encointer-kusama-rpc.n.dwellir.com'),
    );
    final encointerApi = Encointer(encointerProvider);
    final encointerState = StateApi(encointerProvider);

    final encointerRuntimeVersion = await encointerState.getRuntimeVersion();
    final encointerSpecVersion = encointerRuntimeVersion.specVersion;
    final encointerTransactionVersion = encointerRuntimeVersion.transactionVersion;
    final encointerBlock = await encointerProvider.send('chain_getBlock', []);
    final encointerBlockNumber = int.parse(encointerBlock.result['block']['header']['number']);
    final encointerBlockHash = (await encointerProvider.send(
      'chain_getBlockHash',
      [],
    )).result.replaceAll('0x', '');
    final encointerGenesisHash = (await encointerProvider.send('chain_getBlockHash', [
      0,
    ])).result.replaceAll('0x', '');

    final customCall = encointerApi.tx.balances.transferKeepAlive(
      dest: bobMultiAddress,
      value: BigInt.from(1000000000000),
    );
    final customEncodedCall = customCall.encode();
    print('Custom Encoded Call: ${hex.encode(customEncodedCall)}');

    // Get Metadata and build ChainInfo
    final metadata = await encointerState.getMetadata();
    final chainInfo = ChainInfo.fromRuntimeMetadataPrefixed(metadata);

    // Get SignedExtensions info
    final signedExtensions = chainInfo.registry.signedExtensions;
    print('Signed Extensions: ${signedExtensions.map((e) => e.identifier).toList()}');

    final nonce1 = await SystemApi(encointerProvider).accountNextIndex(alice.address);
    print('Alice address: ${alice.address}');
    print('Nonce: $nonce1');

    final paymentAsset = CommunityIdentifier(
      geohash: utf8.encode('sqm1v'),
      digest: hex.decode('f08c911c'),
    );

    // Build extrinsic with custom signed extension
    final builder =
        ExtrinsicBuilder(
          chainInfo: chainInfo,
          callData: customEncodedCall,
          specVersion: encointerSpecVersion,
          transactionVersion: encointerTransactionVersion,
          genesisHash: Uint8List.fromList(hex.decode(encointerGenesisHash)),
          blockHash: Uint8List.fromList(hex.decode(encointerBlockHash)),
          blockNumber: encointerBlockNumber,
          eraPeriod: 64,
          nonce: nonce1,
          tip: BigInt.zero,
        ).customExtension('ChargeAssetTxPayment', {
          "tip": BigInt.zero,
          "asset_id": Option.some(paymentAsset.toJson()),
        });

    // Get signing payload for inspection
    final customExtensionPayload = builder.getSigningPayload();
    print('Encoded Payload: ${hex.encode(customExtensionPayload)}');

    // Sign and submit
    final hash = await builder.signBuildAndSubmit(
      provider: encointerProvider,
      signerAddress: alice.address,
      signingCallback: alice.sign,
    );
    print('Custom Signed Extension Extrinsic Hash: ${hex.encode(hash)}');
  }
}
