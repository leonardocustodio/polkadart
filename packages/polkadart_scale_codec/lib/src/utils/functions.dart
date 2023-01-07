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
/// final bytes = [2, 1];
/// final val = bytesToLittleEndianInt(bytes);
/// print(val); // 258
/// ```
///
/// Example:
/// ```dart
/// final bytes = [1, 2, 3, 4];
/// final val = bytesToLittleEndianInt(bytes);
/// print(val); // 67305985
/// ```
int bytesToLittleEndianInt(List<int> bytes) {
  switch (bytes.length) {
    case 1:
    case 2:
    case 4:
    case 8:
      {
        var byte = bytes[0];
        for (var index = 1; index < bytes.length; index++) {
          byte |= bytes[index] << (8 * index);
        }
        return byte;
      }
  }
  return 0;
}

///
/// Converts a [int] to [List<int>]
///
/// Example:
/// ```dart
/// final val = 1;
/// final bytes = littleEndianIntToBytes(val, 1);
/// print(bytes); // [1]
/// ```
///
/// Example:
/// ```dart
/// final val = 258;
/// final bytes = littleEndianIntToBytes(val, 2);
/// print(bytes); // [2, 1]
/// ```
///
/// Example:
/// ```dart
/// final val = 16909060;
/// final bytes = littleEndianIntToBytes(val, 4);
/// print(bytes); // [4, 3, 2, 1]
/// ```
///
/// Example:
/// ```dart
/// final val = 65535;
/// final bytes = littleEndianIntToBytes(val, 2);
/// print(bytes); // [255, 255]
/// ```
List<int> littleEndianIntToBytes(int value, int length) {
  switch (length) {
    case 1:
    case 2:
    case 4:
    case 8:
      {
        final bytes = <int>[];
        for (var index = 0; index < length; index++) {
          bytes.add(value & 0xff);
          value >>= 8;
        }
        return bytes;
      }
    default:
      throw UnexpectedCaseException(
          'Expected length to be 1, 2, 4 or 8, but found $length');
  }
}
