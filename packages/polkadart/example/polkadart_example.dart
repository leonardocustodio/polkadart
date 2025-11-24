import 'dart:typed_data';

import 'package:convert/convert.dart';
import 'package:polkadart/apis/apis.dart';

void main() async {
  final polkadart = Provider.fromUri(Uri.parse('wss://rpc.matrix.canary.enjin.io'));
  final state = StateApi(polkadart);
  final runtimeVersion = await state.getRuntimeVersion();
  print(runtimeVersion.toJson());

  final author = AuthorApi(polkadart);
  final extrinsic = hex.decode(
    '350284004ea987928399dfe5b94bf7d37995850a21067bfa4549fa83b40250ee635fc06400036990f9642741b00d3484d2e5bd7cba6fa2eea682f6b6c612e47c204f09b0838c171ba42feae5bea1c48a48213cba42a5d590e1c07d1213d263a258f23f5102001c000a07004ea987928399dfe5b94bf7d37995850a21067bfa4549fa83b40250ee635fc064025a6202',
  );

  final submit = await author.submitAndWatchExtrinsic(
    extrinsic as Uint8List,
    (data) => print('From here: ${data.type} - ${data.value}'),
  );
  print(submit);
}
