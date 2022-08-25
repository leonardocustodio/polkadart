import 'package:ss58_codec/src/address.dart';
import 'package:test/test.dart';

extension StringMatch on String {
  ///
  /// matches that the current string is equal to the passed parameter
  void isEqual(String value) {
    expect(this, equals(value));
  }
}

extension IntMatch on int {
  ///
  /// matches that the current int is equal to the passed parameter
  void isEqual(int value) {
    expect(this, equals(value));
  }
}

extension AddressMatch on Address {
  ///
  /// matches that the current address is equal to the passed parameter
  void isEqual(Address value) {
    expect(this, equals(value));
  }
}
