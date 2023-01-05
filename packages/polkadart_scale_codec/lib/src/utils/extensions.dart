part of utils;

extension StringConverter on String {
  ///
  /// returns first character of string
  String get first {
    if (isEmpty) {
      throw EmptyStringException();
    }
    return this[0];
  }

  ///
  /// returns last character of string
  String get last {
    if (isEmpty) {
      throw EmptyStringException();
    }
    return this[length - 1];
  }
}
