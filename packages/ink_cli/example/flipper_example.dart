import 'package:ink_cli/ink_cli.dart';
import 'package:polkadart/polkadart.dart';
import 'package:polkadart/scale_codec.dart';
import 'package:polkadart_keyring/polkadart_keyring.dart';
import 'constants.dart';

void main() async {
  final keyPair = KeyPair.sr25519.fromSeed(decodeHex(
      '0xe5be9a5092b81bca64be81d212e7f2f9eba183bb7a90954f7b76361f6edb5c0a'));
  final polkadart =
      Provider.fromUri(Uri.parse('wss://shibuya-rpc.dwellir.com'));
  final inkContract = await ContractDeployer.from(provider: polkadart);

  final InstantiateRequest value = await inkContract.deployContract(
    code: decodeHex(Constants.flipperCode),
    selector: '0x9bae9d5e01',
    keypair: keyPair,
    constructorArgs: [],
  );
  print('Deployed $value');
}
