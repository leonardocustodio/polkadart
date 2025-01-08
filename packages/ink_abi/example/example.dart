import 'dart:convert';
import 'dart:io';
import 'package:ink_abi/ink_abi_base.dart';

void main() {
  final String dir = Directory.current.absolute.path;
  final String jsonFilePath = '$dir/example/v3_metadata.json';
  final json = jsonDecode(File(jsonFilePath).readAsStringSync());
  final InkAbi inkAbi = InkAbi(json);
}
