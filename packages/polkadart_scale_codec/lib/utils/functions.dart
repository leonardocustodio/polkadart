part of utils;

/// Asserts if the [value] value is true or not
///
/// Throws `AssertionException` if `false`
void assertion(bool value, [String? msg]) {
  if (!value) {
    throw AssertionException(msg ?? 'Assertion Error occured.');
  }
}

/// Decodes hex [value] and converts to Buffer of Uint8List
Uint8List decodeHex(String value) {
  if (value.contains('0x')) {
    value = value.replaceFirst(RegExp(r'0x'), '');
  }

  try {
    return Uint8List.fromList(hex.decode(value));
  } catch (_) {
    throw HexException(value);
  }
}

/// Encodes buffer of list of integers [bytes] to hexa-decimal.
String encodeHex(List<int> bytes) {
  try {
    return hex.encode(bytes);
  } catch (_) {
    throw HexException('$bytes');
  }
}
