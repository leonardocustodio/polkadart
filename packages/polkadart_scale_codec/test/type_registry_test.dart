import 'package:polkadart_scale_codec/polkadart_scale_codec.dart';
import 'package:test/test.dart';

void main() {
  group('Test TypeRegistry', () {
    test('When registry is created then it should have the defined keys.', () {
      final keys = ['bool', 'u8', 'u16', 'u32', 'u64', 'u128'];

      final Registry registry = TypeRegistry.createRegistry();

      final evaluatedKeys = registry.keys.toList();

      expect(evaluatedKeys, equals(keys));
    });

    test('When map of codecs is added to registry then it should have length 1',
        () {
      final Registry registry = Registry();

      registry.addCodecs({'test': BoolCodec()});

      expect(registry.length, equals(1));

      final evaluatedKeys = registry.keys.toList();

      expect(evaluatedKeys, equals(['test']));
    });
  });
}
