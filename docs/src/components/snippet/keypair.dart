import 'package:polkadart_keyring/polkadart_keyring.dart';

Future<void> main(List<String> arguments) async {
  final keyring = Keyring();
  final keyPair = await keyring.fromUri('//Alice');

  print('Alice address: ${keyPair.address}');
}