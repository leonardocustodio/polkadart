import 'package:polkadart_scale_codec/polkadart_scale_codec.dart';
import 'package:test/test.dart';

void main() {
  /// extensions test cases
  group('Test String extension', () {
    test('first should return first character', () {
      final firstChar = 'Hello'.first;
      expect(firstChar, equals('H'));
    });

    test('last should return last character', () {
      final lastChar = 'Hello'.last;
      expect(lastChar, equals('o'));
    });

    test(
        'When getter first is called on \'\' then UnexpectedCaseException is thrown',
        () {
      expect(() => ''.first, throwsA(isA<EmptyStringException>()));
    });

    test(
        'When getter last is called on \'\' then UnexpectedCaseException is thrown',
        () {
      expect(() => ''.last, throwsA(isA<EmptyStringException>()));
    });
  });
}
