import 'package:test/test.dart';
import 'package:polkadart_scale_codec/polkadart_scale_codec.dart';

void main() {
  group('IntConverter Extension:', () {
    test(
        '5 as int will be converted to BigInt.from(5) when used with IntConverter Extension',
        () {
      final bigInt = 5.toBigInt;
      expect(BigInt.from(5), equals(bigInt));
    });
    test(
        '500 as int will be converted to BigInt.from(500) when used with IntConverter Extension',
        () {
      final bigInt = 500.toBigInt;
      expect(BigInt.from(500), equals(bigInt));
    });
  });

  group('StringConverter Extension:', () {
    test(
        '\'5\' as int will be converted to BigInt.from(5) when used with StringConverter Extension',
        () {
      final bigInt = '500'.toBigInt;
      expect(BigInt.from(500), equals(bigInt));
    });
  });

  group('Throw Exception at StringConverter Extension:', () {
    test(
        '\'toBigInt\' method call Throws \'UnexpectedCaseException\' when trying to convert \'ABC\' to BigInt.',
        () {
      final exceptionMessage = 'Can\'t convert \'ABC\' to BigInt.';

      expect(
          () => 'ABC'.toBigInt,
          equals(throwsA(predicate((e) =>
              e is UnexpectedCaseException &&
              e.toString() == exceptionMessage))));
    });
  });
}
