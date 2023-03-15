import 'package:substrate_metadata/core/chain.dart';
import 'package:substrate_metadata/models/legacy_types.dart';
import 'package:test/expect.dart';
import 'package:test/scaffolding.dart';

import '../../parachain_definitions/polkadot.dart';

void main() {
  group('Spec Versions Test', () {
    test('init spec version file', () {
      //
      // Chain Types Definition to support decoding of pre-V14 metadata in spec-version
      final LegacyTypesBundle typesDefinitions =
          LegacyTypesBundle.fromJson(polkadotTypesBundle);

      //
      // Initiate chain constructor with chain specific types-definition
      final chain = Chain(typesDefinitions);

      //
      // Populating with the metadata for block-numbers available for this chain....
      chain.initSpecVersionFromFile('../../chain/polkadot/versions.jsonl');

      expect(chain.versioDescriptionList.length, 34);

      //
      // check if the versionDescriptionList is sorted by blockNumber
      for (var i = 0; i < chain.versioDescriptionList.length - 1; i++) {
        expect(
            true,
            chain.versioDescriptionList[i].blockNumber <=
                chain.versioDescriptionList[i + 1].blockNumber);
      }
    });
  });
}
