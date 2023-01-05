import 'package:polkadart_scale_codec/polkadart_scale_codec.dart';
import 'package:test/test.dart';

void main() {
  /// extensions test cases
  group('Test String extension', () {
    test('When getter first is called on \'Hello\' then \'H\' is returned', () {
      final firstChar = 'Hello'.first;
      expect(firstChar, equals('H'));
    });

    test('When getter last is called on \'Hello\' then \'o\' is returned', () {
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
