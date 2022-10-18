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
  throw throw UnexpectedTypeException(
    expectedType: '`String`, `num`, `List`, `Map`, `bool`',
    receivedType: value.runtimeType.toString(),
  );
}

/// Asserts if the `T` value is null or not.
///
/// Returns `T` if not null otherwise throws `AssertionException`
T assertNotNull<T>(T? value, [String? msg]) {
  if (value == null) {
    throw AssertionException(msg ?? 'Assertion Error occured.');
  }
  return value;
}

/// Asserts if the [value] value is true or not
///
/// Throws `AssertionException` if `false`
void assertionCheck(bool value, [String? msg]) {
  if (!value) {
    throw AssertionException(msg ?? 'Assertion Error occured.');
  }
}

/// Returns `true` if the value is `num` and is in range of [min, max] with `min` and `max` being inclusive.
///
/// Throws `InvalidSizeException` if the above condition is `false`.
///
/// Sign:
/// - u --> unsigned
/// - i --> signed
bool checkInt(int value, String sign, int bitSize, int min, int max) {
  final bool ok = min <= value && max >= value;
  if (!ok) {
    throw InvalidSizeException('Invalid $sign$bitSize: $value');
  }
  return ok;
}

/// Returns `true` if the value is in range of [min, max] with `min` and `max` being inclusive.
///
/// Throws `InvalidSizeException` if the above condition is `false`.
///
/// Sign:
/// - u --> unsigned
/// - i --> signed
bool checkBigInt(
    BigInt value, String sign, int bitSize, BigInt min, BigInt max) {
  final bool ok = min <= value && max >= value;
  if (!ok) {
    throw InvalidSizeException('Invalid $sign$bitSize: $value');
  }
  return ok;
}

/// Returns `true` if the Signed int `value` is in range of [min, max] according to `bitSize`.
///
/// bitsize ranges are:
/// - 8 -> [-128, 127]
/// - 16 -> [-32768, 32767]
/// - 32 -> [-2147483648, 2147483647]
///
/// Exceptions:
/// - `UnexpectedCaseException` if the `bitsize` is not (8 || 16 || 32)
/// - `InvalidSizeException` if the value is not in range.
///
bool checkSignedInt(int value, int bitSize) {
  late int min;
  late int max;
  switch (bitSize) {
    case 8:
      min = -0x80;
      max = 0x7f;
      break;
    case 16:
      min = -0x8000;
      max = 0x7fff;
      break;
    case 32:
      min = -0x80000000;
      max = 0x7fffffff;
      break;
    default:
      throw UnexpectedCaseException('Unexpected BitSize: $bitSize.');
  }
  return checkInt(value, 'I', bitSize, min, max);
}

/// Calculates BigInt power.
///
///Example:
/// ```dart
/// BigInt value = calculateBigIntPow(2, 7);
/// ```
BigInt calculateBigIntPow(int number, int exponent) {
  return number.toBigInt.pow(exponent.toBigInt.toInt());
}

/// Returns `true` if the Signed BigInt `value` is in range of [min, max] according to `bitSize`.
///
/// bitsize ranges are:
/// - 64 -> [-9223372036854775808, 9223372036854775807]
/// - 128 -> [-170141183460469231731687303715884105728, 170141183460469231731687303715884105727]
/// - 256 -> [-57896044618658097711785492504343953926634992332820282019728792003956564819968, 57896044618658097711785492504343953926634992332820282019728792003956564819967]
///
/// Exceptions:
/// - `UnexpectedCaseException` if the `bitsize` is not (64 || 128 || 256)
/// - `InvalidSizeException` if the value is not in range.
///
bool checkSignedBigInt(BigInt value, int bitSize) {
  late BigInt min;
  late BigInt max;
  switch (bitSize) {
    case 64:
    case 128:
    case 256:
      var value = calculateBigIntPow(2, bitSize - 1);
      min = -value;
      max = value - 1.toBigInt;
      break;
    default:
      throw UnexpectedCaseException('Unexpected BitSize: $bitSize.');
  }
  return checkBigInt(value, 'I', bitSize, min, max);
}

/// Returns `true` if the Unsigned int `value` is in range of [min, max] according to `bitSize`.
///
/// bitsize ranges are:
/// - 8 -> [0, 255]
/// - 16 -> [0, 65535]
/// - 32 -> [0, 4294967295]
///
/// Exceptions:
/// - `UnexpectedCaseException` if the `bitsize` is not (8 || 16 || 32)
/// - `InvalidSizeException` if the value is not in range.
///
bool checkUnsignedInt(int value, int bitSize) {
  late int max;
  switch (bitSize) {
    case 8:
      max = 0xff;
      break;
    case 16:
      max = 0xffff;
      break;
    case 32:
      max = 0xffffffff;
      break;
    default:
      throw UnexpectedCaseException('Unexpected BitSize: $bitSize.');
  }
  return checkInt(value, 'U', bitSize, 0, max);
}

/// Returns `true` if the Signed BigInt `value` is in range of [min, max] according to `bitSize`.
///
/// bitsize ranges are:
/// - 64 -> [0, 18446744073709551615]
/// - 128 -> [0, 340282366920938463463374607431768211455]
/// - 256 -> [0, 115792089237316195423570985008687907853269984665640564039457584007913129639935]
///
/// Exceptions:
/// - `UnexpectedCaseException` if the `bitsize` is not (64 || 128 || 256)
/// - `InvalidSizeException` if the value is not in range.
///
bool checkUnsignedBigInt(BigInt value, int bitSize) {
  late BigInt max;
  switch (bitSize) {
    case 64:
    case 128:
    case 256:
      max = calculateBigIntPow(2, bitSize) - 1.toBigInt;
      break;
    default:
      throw UnexpectedCaseException('Unexpected BitSize: $bitSize.');
  }
  return checkBigInt(value, 'U', bitSize, 0.toBigInt, max);
}

///
/// Accepts `value` as `int` or `String`.
///
/// Throws `UnexpectedTypeException` when value is not `int` or `String`.
///
///Example:
/// ```dart
///BigInt value = toSignedBigInt(2, 64);
///// value = 2;
///```
BigInt toSignedBigInt(dynamic value, int bitSize) {
  late BigInt bigIntValue;
  if (value is String) {
    bigIntValue = BigInt.parse(value);
  } else if (value is int) {
    bigIntValue = BigInt.from(value);
  } else {
    throw UnexpectedTypeException(
      expectedType: '`String` or `int`',
      receivedType: value.runtimeType.toString(),
    );
  }

  checkSignedBigInt(bigIntValue, bitSize);
  return bigIntValue;
}

///
/// Accepts `value` as `int` or `String`.
///
/// Throws `UnexpectedTypeException` when value is not `int` or `String`.
///
///Example:
/// ```dart
///BigInt value = toUnsignedBigInt(2, 64);
///// value = 2;
///```
BigInt toUnsignedBigInt(dynamic value, int bitSize) {
  late BigInt bigIntValue;
  if (value is String) {
    bigIntValue = BigInt.parse(value);
  } else if (value is int) {
    bigIntValue = BigInt.from(value);
  } else {
    throw UnexpectedTypeException(
      expectedType: '`String` or `int`',
      receivedType: value.runtimeType.toString(),
    );
  }
  checkUnsignedBigInt(bigIntValue, bitSize);
  return bigIntValue;
}

/// Encodes UTF-8 String
///
/// Throws `FormatException` when undetermined Unicode Character sequence is found.
///
///Example:
/// ```dart
/// var value = utf8Encoder('polkadot');
/// // value = [112, 111, 108, 107, 97, 100, 111, 116]
/// ```
List<int> utf8Encoder(String input) => Utf8Codec().encode(input);

///
/// Counts the shifts made to the the bits of [value] to the right by shiftAmount:`8` before becoming `0`.
int unsignedIntByteLength(BigInt value) {
  int length = 0;
  BigInt bigInt0 = 0.toBigInt;
  int bigInt8 = 8.toBigInt.toInt();
  while (value > bigInt0) {
    value = value >> bigInt8;
    length += 1;
  }
  return length;
}
