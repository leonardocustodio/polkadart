import 'package:polkadart_scale_codec/polkadart_scale_codec.dart';
import 'package:test/test.dart';

void main() {
  group('Test TypeRegistry', () {
    test('When registry is created then it should have the defined keys.', () {
      final keys = ['bool', 'u8'];

      final Registry registry = TypeRegistry.createRegistry();

      final evaluatedKeys = registry.keys.toList();

      expect(evaluatedKeys, equals(keys));
      expect(registry.length, equals(keys.length));
    });

    test('When map of codecs is added to registry then its keys matched', () {
      final Registry registry = Registry();

      registry.addCodecs({'test': BoolCodec(), 'test2': BoolCodec()});

      final evaluatedKeys = registry.keys.toList();

      expect(registry.length, equals(evaluatedKeys.length));
      expect(evaluatedKeys, equals(['test', 'test2']));
    });
  });
}
