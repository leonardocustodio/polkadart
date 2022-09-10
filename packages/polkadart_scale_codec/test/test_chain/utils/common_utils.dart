bool isNotEmpty(dynamic value) {
  if (value == null) {
    return false;
  }
  if (value is String) {
    return value.trim() != '';
  } else if (value is int) {
    return value != 0;
  } else if (value is Map) {
    return value.isNotEmpty;
  }
  throw Exception('Unknown Type Exception');
}
