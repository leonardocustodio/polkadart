import 'package:convert/convert.dart';
import 'package:polkadart/scale_codec.dart';
import 'package:polkadart_example/generated/polkadot/types/sp_core/crypto/account_id32.dart';
import 'package:polkadart/polkadart.dart' show Provider;

import 'package:polkadart_example/generated/polkadot/polkadot.dart';

Future<void> main(List<String> arguments) async {
  final provider = Provider.fromUri(Uri.parse('wss://rpc.polkadot.io'));
  final polkadot = Polkadot(provider);

  final accountMapPrefix = polkadot.query.system.accountMapPrefix();
  final keys = await polkadot.rpc.state.getKeysPaged(key: accountMapPrefix, count: 10);

  print("First 10 account storage keys: ${keys.map((key) => '0x${hex.encode(key)}')}");

  // Decoding of the keys has to be done manually for now, see how substrate storage keys are defined:
  // https://www.shawntabrizi.com/blog/substrate/transparent-keys-in-substrate/
  final accountIds = keys.map((key) => const AccountId32Codec().decode(ByteInput(key.sublist(32))));
  print("First 10 account pubKeys: ${accountIds.map((account) => '0x${hex.encode(account)}')}");

  // Get account data of those keys
  final accountInfos = await Future.wait(accountIds.map((account) => polkadot.query.system.account(account)));

  for (final accountInfo in accountInfos) {
    print('AccountInfo: ${accountInfo.toJson()}');
  }
}
