@Tags(['chain'])
@Timeout(Duration(minutes: 10))
library;

import 'package:polkadart_scale_codec/polkadart_scale_codec.dart';
import 'package:test/test.dart';

import '../../test_helpers.dart';

/// Path constants relative to monorepo root (where melos runs tests from)
const _eventsFile = 'chain/kusama/v14/events.jsonl';
const _runtimeUpgradesFile = 'chain/kusama/runtime_upgrades.json';
const _metadataDir = 'chain/kusama/v14';

// Load data at top level so we can generate individual tests
final _events = loadEvents(_eventsFile);
final _runtimeUpgrades = loadRuntimeUpgrades(_runtimeUpgradesFile);
final _upgradeBlockNumbers = _runtimeUpgrades.map((u) => u.blockNumber).toSet();

void main() {
  group('Kusama V14 Events - Decode', () {
    for (final eventRecord in _events) {
      final blockNumber = eventRecord['blockNumber'] as int;
      final eventsHex = eventRecord['events'] as String;

      // Skip exact upgrade boundary blocks (known edge case)
      if (_upgradeBlockNumbers.contains(blockNumber)) continue;

      test('block $blockNumber', () {
        final specVersion = findSpecVersionForBlock(blockNumber, _runtimeUpgrades);
        final metadataInfo = getOrLoadMetadata(specVersion, _metadataDir, 'kusama');

        final decoded = metadataInfo.eventsCodec.decode(Input.fromHex(eventsHex));

        expect(decoded, isNotNull);
        expect(decoded, isA<List>());
      });
    }
  });

  group('Kusama V14 Events - Round-trip', () {
    // Test every 10th block for round-trip
    for (var i = 0; i < _events.length; i += 10) {
      final eventRecord = _events[i];
      final blockNumber = eventRecord['blockNumber'] as int;
      final eventsHex = eventRecord['events'] as String;

      // Skip exact upgrade boundary blocks (known edge case)
      if (_upgradeBlockNumbers.contains(blockNumber)) continue;

      test('block $blockNumber', () {
        final specVersion = findSpecVersionForBlock(blockNumber, _runtimeUpgrades);
        final metadataInfo = getOrLoadMetadata(specVersion, _metadataDir, 'kusama');

        // Decode
        final decoded = metadataInfo.eventsCodec.decode(Input.fromHex(eventsHex));

        // Re-encode
        final output = HexOutput();
        metadataInfo.eventsCodec.encodeTo(decoded, output);
        final reencoded = output.toString();

        expect(reencoded, equals(eventsHex));
      });
    }
  });
}
