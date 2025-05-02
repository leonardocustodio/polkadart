import 'package:polkadart/polkadart.dart';
import 'package:ss58/ss58.dart';
import './generated/polkadot/polkadot.dart';
import './generated/polkadot/types/frame_system/account_info.dart';

Future<void> main(List<String> arguments) async {
  final address = '1zugcag7cJVBtVRnFxv5Qftn7xKAnR6YJ9x4x3XLgGgmNnS';
  final provider = Provider.fromUri(Uri.parse('wss://rpc.polkadot.io'));
  final api = Polkadot(provider);

  Address wallet = Address.decode(address);
  AccountInfo accountInfo = await api.query.system.account(wallet.pubkey);

  print("""
    Free balance: ${accountInfo.data.free}
    Reserved balance: ${accountInfo.data.reserved}
    Nonce: ${accountInfo.nonce}
  """);
}
