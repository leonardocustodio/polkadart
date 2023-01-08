import 'package:polkadart_scale_codec/polkadart_scale_codec.dart';
import 'package:test/test.dart';

void main() {
  group('Test TypeRegistry', () {
    test('When registry is created then it should have the defined keys.', () {
      final keys = ['bool'];

      final Registry registry = TypeRegistry.createRegistry();

      final evaluatedKeys = registry.keys.toList();
      expect(evaluatedKeys, equals(keys));
      expect(registry.length, equals(keys.length));
    });

    test('When map of codecs is added to registry then it should have length 2',
        () {
      final Registry registry = Registry();

      registry.addCodecs({'test': BoolCodec()});

      expect(registry.length, equals(1));

      final evaluatedKeys = registry.keys.toList();

      expect(evaluatedKeys, equals(['test']));
    });
  });
}
