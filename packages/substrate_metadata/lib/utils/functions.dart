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
  final XFile file = XFile(filePath);

  file.readAsString().then((v) {
    if (v.isEmpty) {
      // return with empty list
      return <dynamic>[];
    }

    // As File exists, now start reading line by line.
    //
    // mapping lines to jsonDecode so as to convert `stringfy` lines to `List<HashMap>`.
    final LineSplitter ls = LineSplitter();
    final List<String> content = ls.convert(v);
    final result = content.map(jsonDecode).toList(growable: false);

    return result;
  });

  return <dynamic>[];
}

extension ListExtension on Uint8List {
  // Convert Uint8List to Hexadecimal String
  String toHexString() {
    return '0x${hex.encode(this)}';
  }
}

extension ListIntExtension on List<int> {
  String toHexString() {
    return '0x${hex.encode(this)}';
  }
}
