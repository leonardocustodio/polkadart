import 'dart:typed_data';
import 'package:polkadart_keyring/polkadart_keyring.dart';
import 'package:test/test.dart';

void main() {
  test('creates a valid multikey (aligning with Rust, needs sorting)', () {
    final multisig = MultiSig(2)
      ..addBytesList([
        Uint8List.fromList([1, 0, 0, 0, 0, 0, 0, 0]),
        Uint8List.fromList([3, 0, 0, 0, 0, 0, 0, 0]),
        Uint8List.fromList([2, 0, 0, 0, 0, 0, 0, 0])
      ]);

    expect(
        multisig.generateMultiSig().toList().toString(),
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
}
