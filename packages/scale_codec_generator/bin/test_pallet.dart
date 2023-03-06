import "package:hex/hex.dart" show HEX;
import 'dart:typed_data' show Uint8List;

import 'package:frame_primitives/frame_primitives.dart' show Provider, WsProvider;
import './generated/types/sp_core/crypto/AccountId32.dart' show AccountId32;
import './generated/types/frame_system/AccountInfo.dart' show AccountInfo;
import './generated/polkadart.dart' show Polkadot;

void main(List<String> arguments) async {
  final ws = const WsProvider(url: 'rpc.polkadot.io');
  final polkadart = Polkadot(ws);

  AccountId32 account = Uint8List.fromList(HEX.decode("4d9527fd1a39c7b9687653aa5a80889390517180b33dbcc890017b70eb71bec0"));
  final accountInfo = await polkadart.query.system.account(account);

  int eventCount = await polkadart.query.system.eventCount();
  print('EventCount: $eventCount');
  
  print(accountInfo.nonce);
  print(accountInfo.providers);
  print(accountInfo.consumers);
  print(accountInfo.sufficients);
  print(accountInfo.data.free);
  print(accountInfo.data.feeFrozen);
  print(accountInfo.data.miscFrozen);
  print(accountInfo.data.reserved);

  final extrinsicCount = await polkadart.query.system.extrinsicCount();
  print('ExtrinsicCount: $extrinsicCount');
}
