import 'package:polkadart/polkadart.dart' show Blake2bHasher, TwoxxHasher;
import 'dart:typed_data' show Uint8List;
import 'dart:convert' show utf8;
import 'package:convert/convert.dart' show hex;
import 'package:test/expect.dart';
import 'package:test/scaffolding.dart';

void main() {
  group('Storage Hashers Test', () {
    test('Blake2bHasher works', () {
      final testCases = {
        '': hex.decode('cae66941d9efbd404e4d88758ea67670'),
        'foo': hex.decode('04136e24f85d470465c3db66e58ed56c'),
        'System': hex.decode('789f1c09383940a7773420432ffd084a'),
      };

      for (final entry in testCases.entries) {
        final hasher = Blake2bHasher(16);
        final hash = hasher.hash(Uint8List.fromList(utf8.encode(entry.key)));
        expect(hex.encode(hash), hex.encode(entry.value));
      }
    });

    test('TwoxxHasher works', () {
      final testCases = {
        '': hex.decode('99e9d85137db46ef'),
        'foo': hex.decode('3fbac459a800bf33'),
        'System': hex.decode('26aa394eea5630e0'),
      };

      for (final entry in testCases.entries) {
        final hasher = TwoxxHasher(1);
        final hash = hasher.hash(Uint8List.fromList(utf8.encode(entry.key)));
        expect(hex.encode(hash), hex.encode(entry.value));
      }
    });

    test('TwoxxHasher works', () {
      final testCases = {
        '': hex.decode('99e9d85137db46ef4bbea33613baafd5'),
        'System': hex.decode('26aa394eea5630e07c48ae0c9558cef7'),
        'CurrentPhase': hex.decode('d9764401941df7f707a47ba7db64a6ea'),
        'EndorsementTicketsPerBootstrapper': hex.decode('5c03954ec993845da1c7ff36c91390da'),
      };

      for (final entry in testCases.entries) {
        final hasher = TwoxxHasher(2);
        final hash = hasher.hash(Uint8List.fromList(utf8.encode(entry.key)));
        expect(hex.encode(hash), hex.encode(entry.value));
      }
    });
  });
}
