// TODO: Remove this comment when file's other functions are implemented.
//ignore_for_file: unused_element

import 'dart:convert';
import 'dart:io';

import 'package:path/path.dart';
import 'package:cached_annotation/cached_annotation.dart';

import '../model/spec_version.model.dart';
import '../../test_chain/substrate_metadata/codec.dart';
import '../utils/lines.dart';
import '../utils/spec_version_maker.dart';

@WithCache(useStaticCache: true)
class Chain {
  final String name;
  const Chain(this.name);

  String _item(String name) {
    return join('./test/chain', this.name, name);
  }

  @Cached()
  List<SpecVersion> versions() {
    return readSpecVersions(_item('versions.jsonl'));
  }

  @Cached()
  List<int> blockNumbers() {
    return _read<List<int>>('block-numbers.json');
  }

  T _read<T>(String name) {
    var content = _readFile(name);
    return jsonDecode(content) as T;
  }

  @Cached()
  List<RawBlockEvents> events() {
    return _readLines('events.jsonl')
        .map((dynamic map) => RawBlockEvents(
            events: map['events'], blockNumber: map['blockNumber']))
        .toList();
  }

  void testConstantsScaleEncodingDecoding() {
    switch (name) {
      // fixme
      case 'heiko':
      case 'kintsugi':
        return;
    }
    description();
  }

  List<dynamic> _readLines(String name) {
    if (!_exists(name)) {
      return <dynamic>[];
    }
    var out = <dynamic>[];
    for (var line in readLines(_item(name))) {
      out.add(jsonDecode(line));
    }
    return out;
  }

  void description() {
    var vers = versions();
    for (var v in vers) {
      decodeMetadata(v.metadata);
    }
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

class RawBlockEvents {
  final int blockNumber;
  final String events;
  const RawBlockEvents({required this.blockNumber, required this.events});
}

class DecodedBlockEvents {
  final int blockNumber;
  final List<dynamic> events;
  const DecodedBlockEvents({required this.blockNumber, required this.events});
}
