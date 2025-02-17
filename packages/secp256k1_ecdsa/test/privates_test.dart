import 'package:secp256k1_ecdsa/secp256k1.dart';
import 'package:test/test.dart';

import 'helpers/json_model.dart';
import 'helpers/models.dart';
import 'helpers/utils.dart';

void main() {
  final PointModel points =
      getJsonFor('test/test_resources/points.json', ModelsType.points) as PointModel;

  group('Privates Test', () {
    test('fromHex() assertValidity', () {
      for (final vector in points.valid.isPoint) {
        final (String p, bool expected) = (vector.p, vector.expected);
        if (expected) {
          expect(() => Point.fromHex(p), returnsNormally);
        } else {
          expect(() => Point.fromHex(p), throwsA(isA<Exception>()));
        }
      }
    });

    test('PrivateKey.fromHex()', () {
      for (final vector in points.valid.pointFromScalar) {
        final (String d, String expected) = (vector.d, vector.expected!);
        final p = PrivateKey.fromHex(d).point;
        expect(p.toHex(true), expected);
      }
    });

    test('#toHex(compressed)', () {
      for (final vector in points.valid.pointCompress) {
        final (String p, bool compress, String expected) =
            (vector.p, vector.compress, vector.expected!);
        final got = Point.fromHex(p);
        expect(got.toHex(compress), expected);
      }
    });

    test('#toHex() roundtrip', () {
      final randomBigInt = getRandomBigInt();
      final point = Point.fromPrivateKey(randomBigInt);
      final hex = point.toHex(true);
      expect(Point.fromHex(hex).toHex(true), hex);
    });

    test('#add(other)', () {
      for (final vector in points.valid.pointAdd) {
        final (String P, String Q, String? expected) = (vector.p, vector.q, vector.expected);
        final gotP = Point.fromHex(P);
        final gotQ = Point.fromHex(Q);
        if (expected != null) {
          expect(gotP.add(gotQ).toHex(true), expected);
        } else {
          if (!gotP.equals(gotQ.negate())) {
            expect(() => gotP.add(gotQ).toHex(true), throwsA(isA<Exception>()));
          }
        }
      }
    });

    test('#multiply(privateKey)', () {
      for (final vector in points.valid.pointMultiply) {
        final (String P, String d, String? expected) = (vector.p, vector.d, vector.expected);
        final p = Point.fromHex(P);
        if (expected != null) {
          expect(p.multiply(hexToBigInt(d)).toHex(true), expected, reason: P);
        } else {
          expect(() => p.multiply(hexToBigInt(d)).toHex(true), throwsA(isA<Exception>()));
        }
      }

      for (final vector in points.invalid.pointMultiply) {
        final (String P, String d) = (vector.p, vector.d);
        if (hexToBigInt(d) < Curve.secp256k1.n) {
          expect(() {
            final p = Point.fromHex(P);
            p.multiply(hexToBigInt(d)).toHex(true);
          }, throwsA(isA<Exception>()));
        }
      }
      for (final BigInt num in [BigInt.zero, BigInt.from(-1)]) {
        expect(() => Point.BASE.multiply(num), throwsA(isA<Exception>()));
      }
    });
  });
}
