import 'package:polkadart_scale_codec/src/utils/utils.dart';
import 'package:test/test.dart';

void main() {
  group('assertionCheck Test: ', () {
    test('When [true] is passed then it returns true.', () {
      expect(() => assertionCheck(true), returnsNormally);
    });

    test('When [false] is passed then it throws AssertionException.', () {
      expect(() => assertionCheck(false), throwsA(isA<AssertionException>()));
    });
  });
}
