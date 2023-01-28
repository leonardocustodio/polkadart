import 'package:polkadart_scale_codec/polkadart_scale_codec.dart';
import 'package:test/test.dart';

void main() {
  group('Enum Registry Encode Test', () {
    final registry = TypeRegistry.createRegistry()
      ..registerCustomCodec({
        'A': {
          '_enum': ['Ok', 'Err'],
        },
        'B': {
          '_enum': {
            'Ok': 'u8',
            'Err': 'bool',
          },
        }
      });
    test('When value "Ok" is encoded then it returns 0x00', () {
      final codec = Codec(registry: registry).fetchTypeCodec('A');
      final encoder = HexEncoder();
      codec.encode(encoder, 'Ok');
      expect(encoder.toHex(), equals('0x00'));
    });
  });
}
