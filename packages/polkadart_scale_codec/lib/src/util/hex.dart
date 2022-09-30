part of utils;

/// Decodes hex [value] and converts to Buffer of Uint8List
Uint8List decodeHex(String value) {
  assertNotNull(value.isHex);
  if (value.contains('0x')) {
    value = value.replaceFirst(RegExp(r'0x'), '');
  }
  final v = hex.decode(value);
  return Uint8List.fromList(v);
}

/// Encodes buffer of list of integers [data] to hexa-decimal.
String encodeHex(List<int> data) {
  return '0x${hex.encode(data)}';
}
