import 'package:frame_primitives/frame_primitives.dart'
    show Blake2bHasher, TwoxxHasher;
import 'dart:typed_data' show Uint8List;
import 'dart:convert' show utf8;
import 'package:hex/hex.dart' show HEX;
import 'package:test/expect.dart';
import 'package:test/scaffolding.dart';

void main() {
  test('Blake2bHasher works', () {
    final testCases = {
      '': HEX.decode('cae66941d9efbd404e4d88758ea67670'),
      'foo': HEX.decode('04136e24f85d470465c3db66e58ed56c'),
      'System': HEX.decode('789f1c09383940a7773420432ffd084a'),
    };

    for (final entry in testCases.entries) {
      final hasher = Blake2bHasher(16);
      final hash = hasher.hash(Uint8List.fromList(utf8.encode(entry.key)));
      expect(HEX.encode(hash), HEX.encode(entry.value));
    }
  });

  test('TwoxxHasher works', () {
    final testCases = {
      '': HEX.decode('99e9d85137db46ef'),
      'foo': HEX.decode('3fbac459a800bf33'),
      'System': HEX.decode('26aa394eea5630e0'),
    };

    for (final entry in testCases.entries) {
      final hasher = TwoxxHasher(1);
      final hash = hasher.hash(Uint8List.fromList(utf8.encode(entry.key)));
      expect(HEX.encode(hash), HEX.encode(entry.value));
    }
  });
}
