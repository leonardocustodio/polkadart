// TODO: Remove this comment when file's other functions are implemented.
//ignore_for_file: unused_element

import 'dart:convert';
import 'dart:io';

import 'package:path/path.dart';

import '../model/spec_version.model.dart';
import '../utils/spec_version_maker.dart';

class Chain {
  final String name;
  const Chain(this.name);

  info() {}

  String _item(String name) {
    return join('../chain', this.name, name);
  }

  List<SpecVersion> versions() {
    return readSpecVersions(_item('versions.jsonl'));
  }

  void _save(String filePath, dynamic content) {
    late String jsonString;
    if (content is String) {
      jsonString = content;
    } else {
      jsonString = JsonEncoder().convert(content);
    }
    File(_item(filePath))
      ..createSync()
      ..writeAsStringSync(jsonString);
  }

  void _append(String filePath, dynamic content) {
    late String jsonString;
    if (content is String) {
      jsonString = content;
    } else {
      jsonString = JsonEncoder().convert(content);
    }
    File(_item(filePath))
      ..createSync()
      ..writeAsStringSync('$jsonString\n', mode: FileMode.append);
  }

  bool _exists(String fileName) {
    return File(_item(fileName)).existsSync();
  }

  String _readFile(String fileName) {
    return File(_item(fileName)).readAsStringSync();
  }
}
