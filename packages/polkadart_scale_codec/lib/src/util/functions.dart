part of utils;

T assertNotNull<T>(T? val, {String? msg}) {
  assertionCheck(val != null, msg);
  return val as T;
}

bool checkInt(dynamic val, String sign, int bitSize, int min, int max) {
  final bool ok = isNumber(val) && min <= (val as num) && max >= val;
  if (!ok) {
    throw InvalidSizeException('Invalid $sign$bitSize: $val');
  }
  return ok;
}

bool checkBigInt(
    dynamic val, String sign, int bitSize, BigInt min, BigInt max) {
  final bool ok = val is BigInt && min <= val && max >= val;
  if (!ok) {
    throw InvalidSizeException('Invalid $sign$bitSize: $val');
  }
  return ok;
}

bool checkSignedInt(dynamic val, int bitSize) {
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

BigInt calculateBigIntPow(int number, int exponent) {
  return number.bigInt.pow(exponent.bigInt.toInt());
}

bool checkSignedBigInt(dynamic val, int bitSize) {
  late BigInt min;
  late BigInt max;
  switch (bitSize) {
    case 64:
    case 128:
    case 256:
      var value = calculateBigIntPow(2, bitSize - 1);
      min = -value;
      max = value - 1.bigInt;
      break;
    default:
      throw UnexpectedCaseException(bitSize);
  }
  return checkBigInt(val, 'I', bitSize, min, max);
}

bool checkUnsignedInt(dynamic val, int bitSize) {
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

bool checkUnsignedBigInt(dynamic val, int bitSize) {
  late BigInt max;
  switch (bitSize) {
    case 64:
      max = BigInt.parse('0xffffffffffffffff');
      break;
    case 128:
    case 256:
      max = calculateBigIntPow(2, bitSize) - 1.bigInt;
      break;
    default:
      throw UnexpectedCaseException(bitSize);
  }
  return checkBigInt(val, 'U', bitSize, 0.bigInt, max);
}

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
List<int> utf8Encoder(String input) => Utf8Codec().encode(input);

int unsignedIntByteLength(BigInt val) {
  int len = 0;
  BigInt bigInt0 = 0.bigInt;
  int bigInt8 = 8.bigInt.toInt();
  while (val > bigInt0) {
    val = val >> bigInt8;
    len += 1;
  }
  return len;
}

void assertionCheck(bool condition, [String? msg]) {
  if (!condition) {
    throw AssertionException(msg ?? 'Assertion Error occured.');
  }
}
