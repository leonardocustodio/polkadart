import 'dart:convert';
import 'dart:io';
import 'package:abi/abi_description.dart';

void main() {
  final jsonFile =
      '/Users/kawal/Desktop/git_projects/polkadart/packages/abi/example/v5_metadata.json';
  final jsonMap = jsonDecode(File(jsonFile).readAsStringSync());
  final abiDescription = AbiDescription(jsonMap);
  print('done Parsing');
}
