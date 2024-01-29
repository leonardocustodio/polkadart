import 'dart:io';
import 'package:secp256k1_ecdsa/secp256k1.dart';
import 'package:test/test.dart';
import 'helpers/utils.dart';

void main() {
  late List<(String, String, String)> publicKeys;

  setUpAll(() {
    {
      final file = File('test/test_resources/privates-2.txt');

      // split the lines into (private, x, y) which are separated with ':'
      publicKeys = file.readAsLinesSync().map((line) {
        final List<String> value = line.split(':');
        return (value[0], value[1], value[2]);
      }).toList();
    }
  });

  test('test keys', () {
    for (final (String priv, String x, String y) in publicKeys) {
      {
        final PrivateKey privateKey = PrivateKey(BigInt.parse(priv));
        final AffinePoint affinePoint = privateKey.point.affinePoint();
        final String xHex = toBEHex(affinePoint.x);
        expect(xHex, x);
        final String yHex = toBEHex(affinePoint.y);
        expect(yHex, y);
      }

      {
        final PrivateKey privateKey = PrivateKey(BigInt.parse(priv));
        final AffinePoint affinePoint = privateKey.point.affinePoint();
        final String xHex = toBEHex(affinePoint.x);
        expect(xHex, x);
        final String yHex = toBEHex(affinePoint.y);
        expect(yHex, y);
      }
    }
  });
}
