import 'dart:typed_data';

import 'package:convert/convert.dart';
import 'package:polkadart/apis/apis.dart';
import 'package:polkadart/polkadart.dart' show Provider, StateApi;
import 'package:substrate_metadata/utils/utils.dart';

void main() async {
  final polkadart =
      Provider.fromUri(Uri.parse('wss://rpc.matrix.canary.enjin.io'));
  final state = StateApi(polkadart);
  final runtimeVersion = await state.getRuntimeVersion();
  print(runtimeVersion.toJson());

  final author = AuthorApi(polkadart);
  final extrinsic = hex.decode(
      '4d0284003a158a287b46acd830ee9a83d304a63569f8669968a20ea80720e338a565dd0901eaf91ade00a638bc8e9ac5a35bae3e5f3fabed1f1759e4db52bcc3ee463e1e79725f8da13dddc27d249e844c740c5ae51999799dd2c5a75b356712d47342488af5003c000a03003a158a287b46acd830ee9a83d304a63569f8669968a20ea80720e338a565dd0913000064a7b3b6e00d');

  final submit = await author.submitAndWatchExtrinsic(
      extrinsic as Uint8List, (data) => print('From here: $data'));
}
