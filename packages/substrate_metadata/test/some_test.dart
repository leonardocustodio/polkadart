import 'package:polkadart_scale_codec/polkadart_scale_codec.dart';
import 'package:test/test.dart';

void main() {
  /// Some tests for Some.fromJson()
  group('Some.fromJson()', () {
    test('When Some.fromJson() is called with null then it returns null', () {
      expect(Some.fromJson({'None': null}), isA<NoneOption>());
    });

    test(
        'When Some.fromJson() is called with empty string then it returns null',
        () {
      expect(Some.fromJson({'Some': ''}), Some(''));
    });

    test(
        'When Some.fromJson() is called with non-empty string then it returns Some(Some(value))',
        () {
      expect(
          Some.fromJson({
            'Some': {'Some': 'test'}
          }),
          Some(Some('test')));
    });

    test(
        'When Some.fromJson() is called with nested None then it returns Some(Some(None))',
        () {
      expect(
          Some.fromJson({
            'Some': {
              'Some': {'None': null}
            }
          }),
          Some(Some(None)));
    });

    test(
        'When Some.fromJson() is called with empty list then it returns Some([])',
        () {
      expect(Some.fromJson({'Some': []}), Some([]));
    });

    test(
        'Exception is thrown when Some.fromJson() is called with json not containing Some or None key.',
        () {
      expect(() => Some.fromJson({'Hey': 1}),
          throwsA(isA<UnexpectedCaseException>()));
    });
  });
}
