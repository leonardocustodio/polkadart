// ignore_for_file: unused_local_variable

import 'dart:convert';
import 'dart:io';
import 'package:abi/abi_description.dart';
import 'package:abi/schemas/schema_validator.dart';

void main() {
  final jsonFile =
      '/Users/kawal/Desktop/git_projects/polkadart/packages/abi/example/v5_metadata.json';
  final json = jsonDecode(File(jsonFile).readAsStringSync());
  final jsonMap = SchemaValidator.getInkProject(json);
  final abiDescription = AbiDescription(jsonMap);
  abiDescription
    ..abiEvents()
    ..constructorSelectors()
    ..messageSelectors()
    ..constructors()
    ..event()
    ..messages();
  print('done Parsing');
}
