part of utils;

extension IntExtension on int {
  ///
  /// Converts `int` to BigInt.
  ///
  /// ```
  /// BigInt value = 5.bigInt;
  /// BigInt value = 100.bigInt;
  /// ```
  BigInt get bigInt {
    return BigInt.from(this);
  }
}

extension StringExtension on String {
  ///
  /// Converts `String` to BigInt.
  ///
  /// ```
  /// BigInt value = '5'.bigInt;
  /// BigInt value = '100'.bigInt;
  /// ```
  BigInt get bigInt {
    return BigInt.parse(this);
  }
}
