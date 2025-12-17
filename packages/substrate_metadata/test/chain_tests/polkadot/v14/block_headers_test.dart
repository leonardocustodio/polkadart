@Tags(['chain'])
@Timeout(Duration(minutes: 5))
library;

import 'package:test/test.dart';

import '../../test_helpers.dart';

/// Path constants relative to package root (where tests are run from)
const _blocksFile = '../../chain/polkadot/v14/blocks.jsonl';

// Load data at top level so we can generate individual tests
final _blocks = loadBlocks(_blocksFile);

void main() {
  group('Polkadot V14 Block Headers - Required Fields', () {
    for (final block in _blocks) {
      final blockNumber = block['blockNumber'] as int;

      test('block $blockNumber', () {
        expect(block.containsKey('blockNumber'), isTrue, reason: 'missing blockNumber');
        expect(block.containsKey('extrinsics'), isTrue, reason: 'missing extrinsics');
        expect(block.containsKey('header'), isTrue, reason: 'missing header');

        final header = block['header'] as Map<String, dynamic>;

        expect(header.containsKey('parentHash'), isTrue, reason: 'missing parentHash');
        expect(header.containsKey('number'), isTrue, reason: 'missing number');
        expect(header.containsKey('stateRoot'), isTrue, reason: 'missing stateRoot');
        expect(header.containsKey('extrinsicsRoot'), isTrue, reason: 'missing extrinsicsRoot');
        expect(header.containsKey('digest'), isTrue, reason: 'missing digest');

        // Validate header number matches blockNumber
        final headerNumber = int.parse((header['number'] as String).substring(2), radix: 16);
        expect(headerNumber, equals(blockNumber), reason: 'header number mismatch');
      });
    }
  });

  group('Polkadot V14 Block Headers - Digest Logs', () {
    for (final block in _blocks) {
      final blockNumber = block['blockNumber'] as int;

      test('block $blockNumber', () {
        final header = block['header'] as Map<String, dynamic>;
        final digest = header['digest'] as Map<String, dynamic>;
        final logs = digest['logs'] as List<dynamic>;

        for (final log in logs) {
          expect(log, isA<String>(), reason: 'log is not a string');
          expect((log as String).startsWith('0x'), isTrue, reason: 'log should be hex');
        }
      });
    }
  });

  test('block numbers are in ascending order', () {
    int lastBlockNumber = -1;

    for (final block in _blocks) {
      final blockNumber = block['blockNumber'] as int;
      expect(
        blockNumber,
        greaterThan(lastBlockNumber),
        reason: 'Block numbers not in ascending order at $blockNumber',
      );
      lastBlockNumber = blockNumber;
    }
  });
}
