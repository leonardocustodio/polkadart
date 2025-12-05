// ignore_for_file: unused_local_variable

import 'dart:io';
import 'dart:typed_data';
import 'package:ink_cli/ink_cli.dart';
import 'package:polkadart/polkadart.dart';
import 'package:polkadart_scale_codec/utils/utils.dart';
import 'package:polkadart_keyring/polkadart_keyring.dart';

import 'flipper.dart';

void main() async {
  final String dir = Directory.current.absolute.path;
  final fileOutput = FileOutput('$dir/example/flipper.dart');
  final generator = TypeGenerator(abiFilePath: './example/flipper.json', fileOutput: fileOutput);
  generator.generate();
  fileOutput.write();

  final polkadart = Provider.fromUri(Uri.parse('wss://shibuya-rpc.dwellir.com'));
  final keyPair = KeyPair.sr25519
      .fromSeed(decodeHex('0xe5be9a5092b81bca64be81d212e7f2f9eba183bb7a90954f7b76361f6edb5c0a'));

  final flipperContract = '0xfe6d6f70ff2940ae47bfb3fac7cbb5189a1e1e46ee1852acadb0490625d064ec';

  final contract = Contract(
    provider: polkadart,
    address: Uint8List.fromList(keyPair.publicKey.bytes.toList()),
    contractAddress: Uint8List.fromList(decodeHex(flipperContract)),
  );

  final firstFetch = await contract.get();
  print('Initial Value: $firstFetch');

  final mutator = await ContractMutator.fromProvider(provider: polkadart);
  final flipped = await contract.flip(
    keyPair: keyPair,
    mutator: mutator,
  );

  // Wait for 1 minute to let the changes be in the block
  await Future.delayed(Duration(seconds: 60));

  final secondFetch = await contract.get();
  print('Value after doing flip: $secondFetch');
  return;
}
