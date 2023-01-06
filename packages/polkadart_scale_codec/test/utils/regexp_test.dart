import 'package:polkadart_scale_codec/polkadart_scale_codec.dart';
import 'package:test/test.dart';

void main() {
  group('getVecMatch test', () {
    test('When Vec<u8> is matched then [Vec<u8>, Vec, u8] is matched in groups',
        () {
      final type = 'Vec<u8>';

      final RegExpMatch? match = getVecMatch(type);

      expect(match![0], 'Vec<u8>');
      expect(match[1], 'Vec');
      expect(match[2], 'u8');
    });

    test(
        'When Vec<(u8, u8)> is matched then [Vec<(u8, u8)>, Vec, (u8, u8)] is matched in groups',
        () {
      final type = 'Vec<(u8, u8)>';

      final RegExpMatch? match = getVecMatch(type);

      expect(match![0], 'Vec<(u8, u8)>');
      expect(match[1], 'Vec');
      expect(match[2], '(u8, u8)');
    });

    test(
        'When Vec<(u8, Vec<u8>)> is matched then [Vec<(u8, Vec<u8>)>, Vec, (u8, Vec<u8>)] is matched in groups',
        () {
      final type = 'Vec<(u8, Vec<u8>)>';

      final RegExpMatch? match = getVecMatch(type);

      expect(match![0], 'Vec<(u8, Vec<u8>)>');
      expect(match[1], 'Vec');
      expect(match[2], '(u8, Vec<u8>)');
    });

    test('When \'\' is matched then null is returned.', () {
      final type = '';

      final RegExpMatch? match = getVecMatch(type);

      expect(match, null);
    });

    test(
        'Testing invalid type string \'polkadart\' is matched then null is returned.',
        () {
      final type = 'polkadart';

      final RegExpMatch? match = getVecMatch(type);

      expect(match, null);
    });
  });
}
