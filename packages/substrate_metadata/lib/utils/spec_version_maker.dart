part of utils;

bool validateSpecVersion(dynamic data, {bool reportMultipleErrors = false}) {
  final schema = JsonSchema.create(SPEC_VERSION_SCHEMA);
  return Validator(schema).validate(data, reportMultipleErrors: reportMultipleErrors).isValid;
}

bool validateSpecVersionArray(dynamic data, {bool reportMultipleErrors = false}) {
  final schema = JsonSchema.create(
    <String, dynamic>{
      'type': 'array',
      'items': SPEC_VERSION_SCHEMA,
    },
  );
  return Validator(schema).validate(data, reportMultipleErrors: reportMultipleErrors).isValid;
}

Future<List<SpecVersion>> readSpecVersionsFromFilePath(String filePath) async {
  if (filePath.endsWith('.json')) {
    return await _readSpecVersionFromJson(filePath);
  } else {
    return await _readSpecVersionJsonLines(filePath);
  }
}

Future<List<SpecVersion>> _readSpecVersionJsonLines(String filePath) async {
  final result = <SpecVersion>[];
  final XFile file = XFile(filePath);
  final LineSplitter ls = LineSplitter();
  final List<String> content = ls.convert(await file.readAsString());

  for (var line in content) {
    dynamic json;
    try {
      json = jsonDecode(line);
    } catch (e) {
      throw SpecFileException('Failed to parse record #${result.length + 1} of $filePath: $e');
    }

    if (validateSpecVersion(json, reportMultipleErrors: true)) {
      result.add(SpecVersion.fromJson(json));
    } else {
      throw SpecFileException(
          'Failed to extract chain version from record #${result.length} of $filePath');
    }
  }

  return result;
}

Future<List<SpecVersion>> _readSpecVersionFromJson(String filePath) async {
  final file = XFile(filePath);
  final content = await file.readAsString();

  if (content.isEmpty) {
    throw SpecFileException('Failed to read $filePath');
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
        .toList(growable: false);
  } else {
    throw SpecFileException('Failed to extract chain versions from $filePath');
  }
}
