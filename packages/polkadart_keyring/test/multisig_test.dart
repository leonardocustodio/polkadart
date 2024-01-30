import 'dart:typed_data';
import 'package:polkadart_keyring/polkadart_keyring.dart';
import 'package:test/test.dart';

void main() {
  test('creates a valid multikey (aligning with Rust, needs sorting)', () {
    final result = MultiSig.createMultiSigBytes([
      Uint8List.fromList([1, 0, 0, 0, 0, 0, 0, 0]),
      Uint8List.fromList([3, 0, 0, 0, 0, 0, 0, 0]),
      Uint8List.fromList([2, 0, 0, 0, 0, 0, 0, 0])
    ], 2);

    expect(
        result.toList().toString(),
        Uint8List.fromList([
          67,
          151,
          196,
          155,
          179,
          207,
          47,
          123,
          90,
          2,
          35,
          54,
          162,
          111,
          241,
          226,
          88,
          148,
          54,
          193,
          252,
          195,
          93,
          101,
          16,
          5,
          93,
          101,
          186,
          186,
          254,
          79
        ]).toList().toString());
  });

  test('creates a valid multikey for the address.', () {
    final result = MultiSig.createMultiSigAddress([
      '5GrwvaEF5zXb26Fz9rcQpDWS57CtERHpNehXCPcNoHGKutQY',
      '5FHneW46xGXgs5mUiveU4sbTyGBzmstUspZC92UhjJM694ty',
      '5FLSigC9HGRKVhB9FiEo4Y3koPsNmBmLJbpXg2mp1hXcS59Y'
    ], 2);

    expect(result, '5DjYJStmdZ2rcqXbXGX7TW85JsrW6uG4y9MUcLq2BoPMpRA7');
  });
}
