part of utils;

Uint8List decodeHex(String value) {
  assertionCheck(value.isHex);
  if (value.contains('0x')) {
    value = value.replaceFirst(RegExp(r'0x'), '');
  }
  final v = hex.decode(value);
  return Uint8List.fromList(v);
}

String encodeHex(List<int> data) {
  return '0x${hex.encode(data)}';
}
