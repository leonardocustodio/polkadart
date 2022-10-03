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
  throw UnexpectedTypeException();
}

/// Asserts if the `T` value is null or not.
///
/// Returns `T` if not null otherwise throws `AssertionException`
T assertNotNull<T>(T? val, [String? msg]) {
  if (val == null) {
    throw AssertionException(msg ?? 'Assertion Error occured.');
  }
  return val;
}

/// Asserts if the [val] value is true or not
///
/// Throws `AssertionException` if `false`
void assertionCheck(bool val, [String? msg]) {
  if (!val) {
    throw AssertionException(msg ?? 'Assertion Error occured.');
  }
}

/// Returns `true` if the val is `num` and is in range of [min, max] with `min` and `max` being inclusive.
///
/// Throws `InvalidSizeException` if the above condition is `false`.
///
/// Sign:
/// - u --> unsigned
/// - i --> signed
bool checkInt(int val, String sign, int bitSize, int min, int max) {
  final bool ok = min <= val && max >= val;
  if (!ok) {
    throw InvalidSizeException('Invalid $sign$bitSize: $val');
  }
  return ok;
}

/// Returns `true` if the val is in range of [min, max] with `min` and `max` being inclusive.
///
/// Throws `InvalidSizeException` if the above condition is `false`.
///
/// Sign:
/// - u --> unsigned
/// - i --> signed
bool checkBigInt(BigInt val, String sign, int bitSize, BigInt min, BigInt max) {
  final bool ok = min <= val && max >= val;
  if (!ok) {
    throw InvalidSizeException('Invalid $sign$bitSize: $val');
  }
  return ok;
}

/// Returns `true` if the Signed int `val` is in range of [min, max] according to `bitSize`.
///
/// bitsize ranges are:
/// - 8 -> [-128, 127]
/// - 16 -> [-32768, 32767]
/// - 32 -> [-2147483648, 2147483647]
///
/// Exceptions:
/// - `UnexpectedCaseException` if the `bitsize` is not (8 || 16 || 32)
/// - `InvalidSizeException` if the val is not in range.
///
bool checkSignedInt(int val, int bitSize) {
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
      throw UnexpectedCaseException(bitSize);
  }
  return checkInt(val, 'I', bitSize, min, max);
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

/// Returns `true` if the Signed BigInt `val` is in range of [min, max] according to `bitSize`.
///
/// bitsize ranges are:
/// - 64 -> [-9223372036854775808, 9223372036854775807]
/// - 128 -> [-170141183460469231731687303715884105728, 170141183460469231731687303715884105727]
/// - 256 -> [-57896044618658097711785492504343953926634992332820282019728792003956564819968, 57896044618658097711785492504343953926634992332820282019728792003956564819967]
///
/// Exceptions:
/// - `UnexpectedCaseException` if the `bitsize` is not (64 || 128 || 256)
/// - `InvalidSizeException` if the val is not in range.
///
bool checkSignedBigInt(BigInt val, int bitSize) {
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
      throw UnexpectedCaseException(bitSize);
  }
  return checkBigInt(val, 'I', bitSize, min, max);
}

/// Returns `true` if the Unsigned int `val` is in range of [min, max] according to `bitSize`.
///
/// bitsize ranges are:
/// - 8 -> [0, 127]
/// - 16 -> [0, 32767]
/// - 32 -> [0, 2147483647]
///
/// Exceptions:
/// - `UnexpectedCaseException` if the `bitsize` is not (8 || 16 || 32)
/// - `InvalidSizeException` if the val is not in range.
///
bool checkUnsignedInt(int val, int bitSize) {
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
      throw UnexpectedCaseException(bitSize);
  }
  return checkInt(val, 'U', bitSize, 0, max);
}

/// Returns `true` if the Signed BigInt `val` is in range of [min, max] according to `bitSize`.
///
/// bitsize ranges are:
/// - 64 -> [0, 18446744073709551615]
/// - 128 -> [0, 170141183460469231731687303715884105727]
/// - 256 -> [0, 57896044618658097711785492504343953926634992332820282019728792003956564819967]
///
/// Exceptions:
/// - `UnexpectedCaseException` if the `bitsize` is not (64 || 128 || 256)
/// - `InvalidSizeException` if the val is not in range.
///
bool checkUnsignedBigInt(BigInt val, int bitSize) {
  late BigInt max;
  switch (bitSize) {
    case 64:
    case 128:
    case 256:
      max = calculateBigIntPow(2, bitSize) - 1.toBigInt;
      break;
    default:
      throw UnexpectedCaseException(bitSize);
  }
  return checkBigInt(val, 'U', bitSize, 0.toBigInt, max);
}

///
/// Accepts `val` as `int` or `String`.
///
/// Throws `UnexpectedTypeException` when val is not `int` or `String`.
///
///Example:
/// ```dart
///BigInt val = toSignedBigInt(2, 64);
///// val = 2;
///```
BigInt toSignedBigInt(dynamic val, int bitSize) {
  late BigInt value;
  if (val is String) {
    value = BigInt.parse(val);
  } else if (val is int) {
    value = BigInt.from(val);
  } else {
    throw UnexpectedTypeException(
        'Only `String` and `int` are valid parameters.');
  }

  checkSignedBigInt(value, bitSize);
  return value;
}

///
/// Accepts `val` as `int` or `String`.
///
/// Throws `UnexpectedTypeException` when val is not `int` or `String`.
///
///Example:
/// ```dart
///BigInt val = toUnsignedBigInt(2, 64);
///// val = 2;
///```
BigInt toUnsignedBigInt(dynamic val, int bitSize) {
  late BigInt value;
  if (val is String) {
    value = BigInt.parse(val);
  } else if (val is int) {
    value = BigInt.from(val);
  } else {
    throw UnexpectedTypeException(
        'Only `String` and `int` are valid parameters.');
  }
  checkUnsignedBigInt(value, bitSize);
  return value;
}

/// Encodes UTF-8 String
///
/// Throws `FormatException` when undetermined Unicode Character sequence is found.
///
///Example:
/// ```dart
/// var val = utf8Encoder('polkadot');
/// // val = [112, 111, 108, 107, 97, 100, 111, 116]
/// ```
List<int> utf8Encoder(String input) => Utf8Codec().encode(input);

///
/// Counts the shifts made to the the bits of [val] to the right by shiftAmount:`8` before becoming `0`.
int unsignedIntByteLength(BigInt val) {
  int len = 0;
  BigInt bigInt0 = 0.toBigInt;
  int bigInt8 = 8.toBigInt.toInt();
  while (val > bigInt0) {
    val = val >> bigInt8;
    len += 1;
  }
  return len;
}
