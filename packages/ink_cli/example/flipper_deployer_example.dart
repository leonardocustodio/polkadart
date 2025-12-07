import 'package:ink_cli/ink_cli.dart';
import 'package:polkadart/polkadart.dart';
import 'package:polkadart_scale_codec/utils/utils.dart';
import 'package:polkadart_keyring/polkadart_keyring.dart';
import 'constants.dart';
import 'flipper.dart';

void main() async {
  final keyPair = KeyPair.sr25519
      .fromSeed(decodeHex('0xe5be9a5092b81bca64be81d212e7f2f9eba183bb7a90954f7b76361f6edb5c0a'));
  final polkadart = Provider.fromUri(Uri.parse('wss://rpc.shibuya.astar.network'));

  final deployer = await ContractDeployer.from(provider: polkadart);

  final InstantiateRequest value = await Contract.new_default_contract(
    keyPair: keyPair,
    code: decodeHex(Constants.flipperCode),
    deployer: deployer,
  );
  print('Deployed $value');
  print('contract_address: ${encodeHex(value.contractAddress)}');
}
