part of utils;

extension IntExtension on int {
  BigInt get bigInt {
    return BigInt.from(this);
  }
}

extension StringExtension on String {
  BigInt get bigInt {
    return BigInt.parse(this);
  }
}
