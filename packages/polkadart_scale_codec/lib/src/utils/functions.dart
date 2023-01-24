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
/// Copies the properties of [from] to [to]
Codec copyProperties(Codec from, Codec to) {
  to.registry = from.registry;
  to.subType = from.subType;
  to.metadata = from.metadata;
  to.bitLength = from.bitLength;
  to.fixedLength = from.fixedLength;
  to.typeString = from.typeString;
  to.valueList = from.valueList;
  return to;
}
