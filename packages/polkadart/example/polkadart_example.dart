import 'dart:typed_data';

import 'package:convert/convert.dart';
import 'package:polkadart/apis/apis.dart';
import 'package:polkadart/polkadart.dart' show Provider, StateApi;
import 'package:substrate_metadata/utils/utils.dart';

void main() async {
  final polkadart = Provider.fromUri(Uri.parse('wss://kusama-rpc.polkadot.io'));
  final state = StateApi(polkadart);
  final runtimeVersion = await state.getRuntimeVersion();
  print(runtimeVersion.toJson());

  final author = AuthorApi(polkadart);
  final extrinsic = hex.decode(
      '410284000419dda7ddda7bd4fe6bd4058305359cf42bf9dac4e0d5ddec7bb5ae6753c053012000ed4b286c114ee5e73e62a98815bcf5927f79063bd1b89719edfd32bf2d25034d06b98b4929cfa981ce63bd098b31c4b2381151d6cb6bf31182295821fa88d5020000040700b63ff0add4c15b95c6feedc900305b1f125c907c89149b5fd92f5eb4e5ea7c12070010a5d4e8');
  final submit = await author.submitExtrinsic(extrinsic as Uint8List);
  print('Extrinsic hash: ${submit.toJson}');

  await polkadart.disconnect();
}
