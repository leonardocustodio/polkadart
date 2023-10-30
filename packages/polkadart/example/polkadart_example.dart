import 'dart:typed_data';

import 'package:convert/convert.dart';
import 'package:polkadart/apis/apis.dart';
import 'package:polkadart/provider.dart';

void main() async {
  final polkadart = Provider.fromUri(Uri.parse('wss://rpc.polkadot.io'));

  final state = StateApi(polkadart);
  final blockHash = hex.decode(
      '26aa394eea5630e07c48ae0c9558cef780d41e5e16056765bc8461851072c9d7');

  //polkadart.connect();
  final submit = await state.subscribeEvents(blockHash as Uint8List, (data) {
    data.eventRecord.forEach(print);
  });
  print(submit);
}
