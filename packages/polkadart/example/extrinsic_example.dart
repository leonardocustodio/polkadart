import 'dart:async' show Completer;
import 'dart:typed_data' show Uint8List;
import 'package:polkadart/apis/apis.dart' show StateApi, ChainDataFetcher, Provider;
import 'package:polkadart/balances/balances_base.dart';
import 'package:polkadart/extrinsic_builder/extrinsic_builder_base.dart' show ExtrinsicBuilder;
import 'package:polkadart/primitives/primitives.dart' show ExtrinsicStatus;
import 'package:polkadart_keyring/polkadart_keyring.dart' as keyring show KeyPair;
import 'package:substrate_metadata/chain/chain_info.dart' show ChainInfo;
import 'package:substrate_metadata/metadata/metadata.dart' show RuntimeMetadataPrefixed;
import 'package:convert/convert.dart' show hex;

Future<void> main() async {
  final Provider provider = Provider.fromUri(Uri.parse('wss://westend-rpc.polkadot.io'));
  final RuntimeMetadataPrefixed runtimeMetadataPrefixed = await StateApi(provider).getMetadata();
  final ChainInfo chainInfo = runtimeMetadataPrefixed.buildChainInfo();

  // Keypairs (using sr25519 with dev phrase)
  // const devPhrase = 'bottom drive obey lake curtain smoke basket hold race lonely fit walk';
  final keyring.KeyPair sender = await keyring.KeyPair.sr25519.fromUri('//Friday1');
  sender.ss58Format = 42;
  final keyring.KeyPair receiver = await keyring.KeyPair.sr25519.fromUri('//Friday2');
  receiver.ss58Format = 42;

  print('📝 Sender address: ${sender.address}');
  print('📝 Receiver address: ${receiver.address}');

  final BigInt transferAmount = BigInt.from(0.1 * 1e12); // 0.5 WEST

  // Fetch chain data
  // Also fetches the nonce for the sender to use in the extrinsic
  final chainData =
      await ChainDataFetcher(provider).fetchStandardData(accountAddress: sender.address);

  print('\n📊 Chain data:');
  print('  - Genesis hash: 0x${hex.encode(chainData.genesisHash)}');
  print('  - Block hash: 0x${hex.encode(chainData.blockHash)}');
  print('  - Spec version: ${chainData.specVersion}');
  print('  - Transaction version: ${chainData.transactionVersion}');
  print('  - Nonce: ${chainData.nonce}');

  final call = Balances.transferKeepAlive.toAccountId(
    destination: Uint8List.fromList(receiver.publicKey.bytes),
    amount: transferAmount,
  );
  final Uint8List encodedCall = call.encode(chainInfo);

  final extrinsicBuilder = ExtrinsicBuilder.fromChainData(
    chainInfo: chainInfo,
    callData: encodedCall,
    chainData: chainData,
  );

  final completer = Completer<void>();

  extrinsicBuilder.signBuildAndSubmitWatch(
    signerPublicKey: Uint8List.fromList(sender.publicKey.bytes),
    signingCallback: (final Uint8List payload) {
      print('\n🔏 Signing payload: 0x${hex.encode(payload)}');
      final signature = sender.sign(payload);
      print('✍️  Signature: 0x${hex.encode(signature)}');
      return signature;
    },
    provider: provider,
    signerAddress: sender.address,
    onStatusChange: (final ExtrinsicStatus status) {
      if (status.isInBlock) {
        print('✅ Extrinsic included in block: ${status.blockHash ?? ''}');
      } else if (status.isFinalized) {
        print('✅ Extrinsic finalized in block: ${status.blockHash ?? ''}');
        completer.complete();
      } else if (status.isInvalid || status.isDropped || status.isError) {
        print('ℹ️ Extrinsic status: $status');
        completer.complete();
      } else {
        print('ℹ️ Extrinsic status: $status');
      }
    },
  );
  return completer.future;
}
