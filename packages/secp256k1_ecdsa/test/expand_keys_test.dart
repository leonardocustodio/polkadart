import 'package:secp256k1_ecdsa/secp256k1.dart';
import 'package:test/test.dart';

void main() {
  group('Expand Keys', () {
    test('expand a key', () {
      expect(
          Point.fromHex('03b9dc646dd71118e5f7fda681ad9eca36eb3ee96f344f582fbe7b5bcdebb13077')
              .toHex(false),
          '04b9dc646dd71118e5f7fda681ad9eca36eb3ee96f344f582fbe7b5bcdebb1307763fe926c273235fd979a134076d00fd1683cbd35868cb485d4a3a640e52184af');
    });
    test('should compress the uncompressed key', () {
      expect(
          Point.fromHex(
                  '04b9dc646dd71118e5f7fda681ad9eca36eb3ee96f344f582fbe7b5bcdebb1307763fe926c273235fd979a134076d00fd1683cbd35868cb485d4a3a640e52184af')
              .toHex(false),
          '04b9dc646dd71118e5f7fda681ad9eca36eb3ee96f344f582fbe7b5bcdebb1307763fe926c273235fd979a134076d00fd1683cbd35868cb485d4a3a640e52184af');
    });
  });
}
