import 'package:convert/convert.dart' show hex;
import './polkadot/types/sp_core/crypto/account_id32.dart'
    show AccountId32;
import './polkadot/types/frame_system/account_info.dart'
    show AccountInfo;
import './polkadot/polkadot.dart' show Polkadot;

void main() async {
  final polkadart = Polkadot.url('wss://polkadot-rpc-tn.dwellir.com');
  final AccountId32 account = hex.decode('4d9527fd1a39c7b9687653aa5a80889390517180b33dbcc890017b70eb71bec0');
  final AccountInfo accountInfo = await polkadart.query.system.account(account);
  final int eventCount = await polkadart.query.system.eventCount();
  print('EventCount: $eventCount');
  print(accountInfo.toJson());
  final extrinsicCount = await polkadart.query.system.extrinsicCount();
  print('ExtrinsicCount: $extrinsicCount');
  print(polkadart.constant.balances.existentialDeposit);
  await polkadart.disconnect();
}
