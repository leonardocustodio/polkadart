import 'dart:convert';
import 'dart:io';
import 'package:json_schema2/json_schema2.dart';
import 'package:substrate_metadata/exceptions/exceptions.dart';
import 'package:substrate_metadata/spec_version/spec_version.model.dart';
import 'package:substrate_metadata/spec_version/spec_version_schema.dart';

bool validateSpecVersion(dynamic data, {bool reportMultipleErrors = false}) {
  var schema = JsonSchema.createSchema(SPEC_VERSION_SCHEMA);
  return schema.validate(data, reportMultipleErrors: reportMultipleErrors);
}

bool validateSpecVersionArray(dynamic data,
    {bool reportMultipleErrors = false}) {
  var schema = JsonSchema.createSchema(
    <String, dynamic>{
      'type': 'array',
      'items': SPEC_VERSION_SCHEMA,
    },
  );
  return schema.validate(data, reportMultipleErrors: reportMultipleErrors);
}

List<SpecVersion> readSpecVersionsFromFilePath(String filePath) {
  if (filePath.endsWith('.json')) {
    return _readSpecVersionFromJson(filePath);
  } else {
    return _readSpecVersionJsonLines(filePath);
  }
}

List<SpecVersion> _readSpecVersionJsonLines(String filePath) {
  var result = <SpecVersion>[];
  File file = File(filePath);
  for (var line in file.readAsLinesSync()) {
    dynamic json;
    try {
      json = jsonDecode(line);
    } catch (e) {
      throw SpecFileException(
          'Failed to parse record #${result.length + 1} of $file: $e');
    }
    if (validateSpecVersion(json, reportMultipleErrors: true)) {
      result.add(SpecVersion.fromJson(json));
    } else {
      throw SpecFileException(
          'Failed to extract chain version from record #${result.length} of $file');
    }
  }
  return result;
}

List<SpecVersion> _readSpecVersionFromJson(String filePath) {
  late String content;
  try {
    content = File(filePath).readAsStringSync();
  } catch (e) {
    throw SpecFileException('Failed to read $filePath: $e');
  }
  dynamic json;
  try {
    json = jsonDecode(content);
  } catch (e) {
    throw SpecFileException('Failed to parse Json $filePath: $e');
  }
  if (validateSpecVersionArray(json)) {
    return (json['items'] as List<dynamic>)
        .map((spec) => SpecVersion.fromJson(spec))
        .toList();
  } else {
    throw SpecFileException('Failed to extract chain versions from $filePath');
  }
}
