import 'package:polkadart_scale_codec/src/util/exceptions.dart';
import 'package:utility/utility.dart';

T assertNotNull<T>(T val, {String? msg}) {
  assert(val != null, msg);
  return val;
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

BigInt calculateBigIntPow(int number, int pow) {
  return BigInt.from(number).pow(BigInt.from(pow).toInt());
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
      max = value - BigInt.from(1);
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
      max = calculateBigIntPow(2, bitSize) - BigInt.from(1);
      break;
    default:
      throw UnexpectedCaseException(bitSize);
  }
  return checkBigInt(val, 'U', bitSize, BigInt.from(0), max);
}

BigInt toSignedBigInt(dynamic val, int bitSize) {
  late BigInt value;
  if (val is String) {
    value = BigInt.parse(val);
  } else if (val is int) {
    value = BigInt.from(val);
  } else {
    throw UnexpectedTypeException(val);
  }

  checkSignedBigInt(value, bitSize);
  return val;
}

BigInt toUnsignedBigInt(dynamic val, int bitSize) {
  late BigInt value;
  if (val is String) {
    value = BigInt.parse(val);
  } else if (val is int) {
    value = BigInt.from(val);
  } else {
    throw UnexpectedTypeException(val);
  }
  checkUnsignedBigInt(value, bitSize);
  return value;
}
