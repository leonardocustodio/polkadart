part of utils;

Uint8List decodeHex(String value) {
  assertionCheck(value.isHex);
  return Uint8List.fromList(hex.decode(value));
}
