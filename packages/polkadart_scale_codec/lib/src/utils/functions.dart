part of utils;

/// Asserts if the [value] value is true or not
///
/// Throws `AssertionException` if `false`
void assertionCheck(bool value, [String? msg]) {
  if (!value) {
    throw AssertionException(msg ?? 'Assertion Error occured.');
  }
}

/// Converts a [List<int>] to [int]
///
/// Example:
/// ```dart
/// final bytes = [1];
/// final val = bytesToLittleEndianInt(bytes);
/// print(val); // 1
/// ```
///
/// Example:
/// ```dart
/// final bytes = [1, 2];
/// final val = bytesToLittleEndianInt(bytes);
/// print(val); // 258
/// ```
///
/// Example:
/// ```dart
/// final bytes = [1, 2, 3, 4];
/// final val = bytesToLittleEndianInt(bytes);
/// print(val); // 16909060
/// ```
int bytesToLittleEndianInt(List<int> bytes) {
  switch (bytes.length) {
    case 1:
      return bytes[0];
    case 2:
      return bytes[0] | bytes[1] << 8;
    case 4:
      return bytes[0] | bytes[1] << 8 | bytes[2] << 16 | bytes[3] << 24;
    case 8:
      return bytes[0] |
          bytes[1] << 8 |
          bytes[2] << 16 |
          bytes[3] << 24 |
          bytes[4] << 32 |
          bytes[5] << 40 |
          bytes[6] << 48 |
          bytes[7] << 56;
  }
  return 0;
}
