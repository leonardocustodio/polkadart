import 'dart:io';
import 'package:ink_cli/ink_cli.dart';
import 'package:polkadart/provider.dart';
import 'package:polkadart_keyring/polkadart_keyring.dart';
import 'package:polkadart_scale_codec/utils/utils.dart';

import 'constants.dart';
import 'generated_erc20.dart';

void main() async {
  final String dir = Directory.current.absolute.path;
  final fileOutput = FileOutput('$dir/example/generated_erc20.dart');
  final generator = TypeGenerator(
      abiFilePath: './example/ink_erc20.json', fileOutput: fileOutput);
  generator.generate();
  fileOutput.write();

  final polkadart =
      Provider.fromUri(Uri.parse('wss://shibuya-rpc.dwellir.com'));
  final keyPair = KeyPair.sr25519.fromSeed(decodeHex(
      '0xe5be9a5092b81bca64be81d212e7f2f9eba183bb7a90954f7b76361f6edb5c0a'));

  final deployer = await ContractDeployer.from(provider: polkadart);

  final InstantiateRequest result = await Contract.new_contract(
    total_supply: BigInt.from(100000000),
    code: decodeHex(Constants.erc20Code),
    deployer: deployer,
    keyPair: keyPair,
  );
  print('done $result');
}
