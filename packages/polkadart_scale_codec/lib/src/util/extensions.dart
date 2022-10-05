part of utils;

extension IntConverter on int {
  /// Converts `int` to BigInt.
  ///
  /// ```
  /// BigInt value = 5.toBigInt;
  /// BigInt value = 100.toBigInt;
  /// ```
  BigInt get toBigInt {
    return BigInt.from(this);
  }
}

extension StringConverter on String {
  /// Converts `String` to BigInt.
  ///
  /// ```
  /// BigInt value = '5'.toBigInt;
  /// BigInt value = '100'.toBigInt;
  /// ```
  BigInt get toBigInt {
    try {
      return BigInt.parse(trim());
    } catch (_) {
      throw UnexpectedCaseException('Can\'t convert \'$this\' to BigInt.');
    }
  }
}
