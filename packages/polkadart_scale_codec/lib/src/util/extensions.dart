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

extension DynamicExtension on dynamic {
  void assertionCheck<T>() {
    if (this is! T) {
      throw AssertionError('Expected type (`$T`), but found (`$runtimeType`)');
    }
  }

  void assertList<T>() {
    assertionCheck<List<T>>();
  }
}
