import 'package:substrate_metadata/extrinsic.dart';
import 'package:test/expect.dart';
import 'package:test/scaffolding.dart';

void main() {
  // Extrinsic compute hash test cases
  group('Hash test:', () {
    test('Extrinsic', () {
      // Given
      final String extrinsic =
          '0x2102840068b427dda4f3894613e113b570d5878f3eee981196133e308c0a82584cf2e16001b823777051938422d8cfe79aa16e95cf612991266d68ff109ce388a94f2bcb5c2bef37532d2bf6cd6505b562f16b49aa846fe2f2fbcefa06a580971d634e1e893300c144002800016400000000000000016400000000000000000000000000000000000000';

      final String actualHash =
          '0x86691c41a7e2c855e40ef13944d207ebd56ad1d1a251b4c33b7743a270accb51';

      // When
      final String computedHash = Extrinsic.computeHash(extrinsic);

      // Then
      expect(actualHash, computedHash);
    });
  });
}
