import 'dart:convert';
import 'dart:io';
import 'package:ink_abi/ink_abi_base.dart';

void main() {
  final jsonFile =
      '/Users/kawal/Desktop/git_projects/polkadart/packages/ink_abi/example/v3_metadata.json';
  final json = jsonDecode(File(jsonFile).readAsStringSync());
  final jsonMap = SchemaValidator.getInkProject(json);
  final inkAbi = InkAbi(jsonMap);
}
