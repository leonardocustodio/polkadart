import 'dart:typed_data';
import 'package:ink_cli/ink_cli.dart';
import 'package:polkadart/polkadart.dart';
import 'package:polkadart/scale_codec.dart';
import 'package:polkadart_keyring/polkadart_keyring.dart';

import 'constants.dart';
import 'generated_erc20.dart';

void main() async {
  final fileOutput = FileOutput(
      '/Users/kawal/Desktop/git_projects/polkadart/packages/ink_cli/example/generated_erc20.dart');
  final generator = TypeGenerator(
      abiFilePath: './example/ink_erc20.json', fileOutput: fileOutput);
  generator.generate();
  fileOutput.write();

  final polkadart =
      Provider.fromUri(Uri.parse('wss://shibuya-rpc.dwellir.com'));
  final keyPair = KeyPair.sr25519.fromSeed(decodeHex(
      '0xe5be9a5092b81bca64be81d212e7f2f9eba183bb7a90954f7b76361f6edb5c0a'));

  final contract = Contract(
    provider: polkadart,
    address: Uint8List.fromList([]),
  );

  final InstantiateRequest result = await contract.new_contract(
    total_supply: BigInt.from(100000000),
    code: decodeHex(Constants.erc20Code),
    keyPair: keyPair,
  );
  print('done $result');
}
