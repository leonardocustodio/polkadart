// ignore_for_file: non_constant_identifier_names
import 'dart:typed_data';
import 'package:convert/convert.dart';
import 'package:polkadart/polkadart.dart' show ExtrinsicBuilder, Provider, StateApi;
import 'package:polkadart/apis/apis.dart';
import 'package:polkadart_example/generated/polkadot/types/sp_runtime/multiaddress/multi_address.dart'
    as polkadot;
import 'package:polkadart_keyring/polkadart_keyring.dart';
import 'package:substrate_metadata/substrate_metadata.dart';
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
  final blockNumber = int.parse(block.result['block']['header']['number']);
  final blockHash = Uint8List.fromList(
    hex.decode((await provider.send('chain_getBlockHash', [])).result.replaceAll('0x', '')),
  );
  final genesisHash = Uint8List.fromList(
    hex.decode((await provider.send('chain_getBlockHash', [0])).result.replaceAll('0x', '')),
  );

  final call = api.tx.balances.transferKeepAlive(
    dest: bobMultiAddress,
    value: BigInt.from(1000000000000),
  );
  final encodedCall = call.encode();
  print('Custom Encoded Call: ${hex.encode(encodedCall)}');

  // Get Metadata and build ChainInfo
  final metadata = await state.getMetadata();
  final chainInfo = ChainInfo.fromRuntimeMetadataPrefixed(metadata);

  // Get MetadataHash
  final merkleizer = MetadataMerkleizer.fromMetadata(
    metadata.metadata,
    decimals: 10,
    tokenSymbol: 'DOT',
  );
  final metadataHash = merkleizer.digest();
  print('Metadata Hash: ${hex.encode(metadataHash)}');

  final nextNonce = await SystemApi(provider).accountNextIndex(alice.address);
  print('Alice address: ${alice.address}');
  print('Nonce: $nextNonce');

  // Build extrinsic with metadata hash
  final builder = ExtrinsicBuilder(
    chainInfo: chainInfo,
    callData: encodedCall,
    specVersion: specVersion,
    transactionVersion: txVersion,
    genesisHash: genesisHash,
    blockHash: blockHash,
    blockNumber: blockNumber,
    eraPeriod: 64,
    nonce: nextNonce,
    tip: BigInt.zero,
  ).metadataHash(enabled: true, hash: metadataHash);

  // Get signing payload for inspection
  final signingPayload = builder.getSigningPayload();
  print('Encoded Payload: ${hex.encode(signingPayload)}');

  // Sign and submit
  final txHash = await builder.signBuildAndSubmit(
    provider: provider,
    signerAddress: alice.address,
    signingCallback: alice.sign,
  );
  print('Extrinsic hash: ${hex.encode(txHash)}');
}
