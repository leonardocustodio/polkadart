import 'package:polkadart_scale_codec/polkadart_scale_codec.dart';
import 'package:test/test.dart';

void main() {
  group('Test TypeRegistry', () {
    test('When registry is created then it should have the defined keys.', () {
      final keys = ['bool', 'u8', 'u16', 'u32', 'u64', 'u128'];

      final Registry registry = TypeRegistry.createRegistry();

      final evaluatedKeys = registry.keys.toList();

      expect(evaluatedKeys, equals(keys));
      expect(registry.length, equals(keys.length));
    });
  });
}
