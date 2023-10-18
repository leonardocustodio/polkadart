import 'dart:typed_data';

import 'package:convert/convert.dart';
import 'package:polkadart/apis/apis.dart';
import 'package:polkadart/polkadart.dart' show Provider, StateApi;
import 'package:substrate_metadata/utils/utils.dart';

void main() async {
  final polkadart =
      Provider.fromUri(Uri.parse('wss://rpc.matrix.canary.enjin.io'));
  final state = StateApi(polkadart);
  // final runtimeVersion = await state.getRuntimeVersion();
  // print(runtimeVersion.toJson());

  // final author = AuthorApi(polkadart);
  // final extrinsic = hex.decode(
  //     '4d0284003a158a287b46acd830ee9a83d304a63569f8669968a20ea80720e338a565dd0901c8dc2161c8a844c6f783f674271f67f71591d980425fca3a90ac016ccf1a5712ad868fc45014d418aa6feeb655b4e40e04354ac1b985c7b172a283dfdfa66484750344000a03003a158a287b46acd830ee9a83d304a63569f8669968a20ea80720e338a565dd0913000064a7b3b6e00d');

  final test =
      await state.subscribeRuntimeVersion((p0) => print('From P0: $p0'));

  // final submit = await author.submitAndWatchExtrinsic(
  //     extrinsic as Uint8List, (data) => print('From here: $data'));
  //
}
