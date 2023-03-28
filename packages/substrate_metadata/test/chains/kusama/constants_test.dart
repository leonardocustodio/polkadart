import 'package:polkadart_scale_codec/polkadart_scale_codec.dart';
import 'package:substrate_metadata/core/chain.dart';
import 'package:substrate_metadata/models/legacy_types.dart';
import 'package:substrate_metadata/models/models.dart';
import 'package:test/test.dart';

import '../../parachain_definitions/kusama.dart';

void main() {
  group('Kusama Constants Test', () {
    //
    // Chain Types Definition to support decoding of pre-V14 metadata in spec-version
    final LegacyTypesBundle typesDefinitions =
        LegacyTypesBundle.fromJson(kusamaTypesBundle);

    //
    // Initiate chain constructor with chain specific types-definition
    final chain = Chain(typesDefinitions);

    //
    // Populating with the metadata for block-numbers available for this chain....
    chain.initSpecVersionFromFile('../../chain/kusama/versions.jsonl');

    //
    // Looping through every block
    for (var versionDescription in chain.versioDescriptionList) {
      final ChainInfo chainInfo = versionDescription.chainInfo;

      //
      // Look on constants of chain description
      for (var palletEntry in chainInfo.constants.entries) {
        test(
            'When pallet ${palletEntry.key} is decoded and encoded back then it matches the original pallet value.',
            () {
          //
          // Loop throught all the constants in this given pallet
          for (var constantEntry in palletEntry.value.entries) {
            final Constant originalConstant = constantEntry.value;

            //
            // Decoded Constant value
            final decoded = originalConstant.value;

            final output = ByteOutput(originalConstant.bytes.length);

            //
            // encoded constant value
            originalConstant.type.encodeTo(decoded, output);

            // Matching the `Uint8List` of both the objects.
            expect(output.toBytes(), originalConstant.bytes);
          }
        });
      }
    }
  });
}
