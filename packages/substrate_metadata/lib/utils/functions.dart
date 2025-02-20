part of utils;

/// Returns `true` when [value] is not empty or not null otherwise returns `false
/// It can check on data types like: `bool?, String?, num?, Map?, List?`
///
/// Throws `UnexpectedTypeException` when other type is encountered.
bool isNotEmpty(dynamic value) {
  if (value == null) {
    return false;
  }
  if (value is bool) {
    return value;
  } else if (value is String) {
    return value.trim() != '';
  } else if (value is num) {
    return value != 0;
  } else if (value is Map) {
    return value.isNotEmpty;
  } else if (value is List) {
    return value.isNotEmpty;
  }
  throw throw Exception(
      'Expected: `String`, `num`, `List`, `Map`, `bool`, found ${value.runtimeType.toString()}');
}

// read lines
List<dynamic> readLines(String filePath) {
  // check if the file exists
  if (File(filePath).existsSync() == false) {
    // return with empty list
    return <dynamic>[];
  }
  // As File exists, now start reading line by line.
  //
  // mapping lines to jsonDecode so as to convert `stringified` lines to `List<HashMap>`.
  final result =
      File(filePath).readAsLinesSync().map(jsonDecode).toList(growable: false);
  return result;
}
