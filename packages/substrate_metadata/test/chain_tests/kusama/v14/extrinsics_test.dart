@Tags(['chain'])
@Timeout(Duration(minutes: 10))
library;

import 'package:polkadart_scale_codec/polkadart_scale_codec.dart';
import 'package:test/test.dart';

import '../../test_helpers.dart';

/// Path constants relative to package root (where tests are run from)
const _blocksFile = '../../chain/kusama/v14/blocks.jsonl';
const _runtimeUpgradesFile = '../../chain/kusama/runtime_upgrades.json';
const _metadataDir = '../../chain/kusama/v14';

// Load data at top level so we can generate individual tests
final _blocks = loadBlocks(_blocksFile);
final _runtimeUpgrades = loadRuntimeUpgrades(_runtimeUpgradesFile);
final _upgradeBlockNumbers = _runtimeUpgrades.map((u) => u.blockNumber).toSet();

void main() {
  group('Kusama V14 Extrinsics - Decode', () {
    for (final block in _blocks) {
      final blockNumber = block['blockNumber'] as int;
      final extrinsics = block['extrinsics'] as List<dynamic>;

      if (extrinsics.isEmpty) continue;

      // Skip exact upgrade boundary blocks (known edge case)
      if (_upgradeBlockNumbers.contains(blockNumber)) continue;

      final extrinsicsHexList = extrinsics.map((e) => e as String).toList();

      // TODO: Remove this skip once extrinsic v5 is supported
      // See: unchecked_extrinsic_codec.dart - needs to support version 5
      if (hasExtrinsicVersion5(extrinsicsHexList)) continue;

      test('block $blockNumber', () {
        final specVersion = findSpecVersionForBlock(blockNumber, _runtimeUpgrades);
        final metadataInfo = getOrLoadMetadata(specVersion, _metadataDir, 'kusama');

        final vecExtrinsicsHex = encodeExtrinsicsAsVec(extrinsicsHexList);

        final decoded = metadataInfo.extrinsicsCodec.decode(Input.fromHex(vecExtrinsicsHex));

        expect(decoded.length, equals(extrinsicsHexList.length));
      });
    }
  });

  group('Kusama V14 Extrinsics - Round-trip', () {
    // Test every 10th block for round-trip
    for (var i = 0; i < _blocks.length; i += 10) {
      final block = _blocks[i];
      final blockNumber = block['blockNumber'] as int;
      final extrinsics = block['extrinsics'] as List<dynamic>;

      if (extrinsics.isEmpty) continue;

      // Skip exact upgrade boundary blocks (known edge case)
      if (_upgradeBlockNumbers.contains(blockNumber)) continue;

      final extrinsicsHexList = extrinsics.map((e) => e as String).toList();

      // TODO: Remove this skip once extrinsic v5 is supported
      // See: unchecked_extrinsic_codec.dart - needs to support version 5
      if (hasExtrinsicVersion5(extrinsicsHexList)) continue;

      test('block $blockNumber', () {
        final specVersion = findSpecVersionForBlock(blockNumber, _runtimeUpgrades);
        final metadataInfo = getOrLoadMetadata(specVersion, _metadataDir, 'kusama');

        final vecExtrinsicsHex = encodeExtrinsicsAsVec(extrinsicsHexList);

        // Decode
        final decoded = metadataInfo.extrinsicsCodec.decode(Input.fromHex(vecExtrinsicsHex));

        // Re-encode
        final output = HexOutput();
        metadataInfo.extrinsicsCodec.encodeTo(decoded, output);
        final reencoded = output.toString();

        expect(reencoded, equals(vecExtrinsicsHex));
      });
    }
  });
}
