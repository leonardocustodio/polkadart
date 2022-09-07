bool isNotEmpty(dynamic value) {
  if (value == null) {
    return false;
  }
  if (value is String) {
    return value.trim() != '';
  } else if (value is int) {
    return value != 0;
  }
  throw Exception('Unknown Type Exception');
}
