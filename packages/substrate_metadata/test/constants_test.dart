import 'dart:typed_data';
import 'package:substrate_metadata/chain/chain.dart';
import 'package:substrate_metadata/chain_description/chain_description.model.dart';
import 'package:substrate_metadata/old/legacy_types_model.dart';
import 'package:test/expect.dart';
import 'package:test/scaffolding.dart';
import 'parachain_definitions/polkadot.dart';

void main() {
  group('Polkadot Constants Test', () {
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

    //
    // Looping through every block
    for (var versionDescription in chain.versioDescriptionList) {
      final ChainDescription chainDescription = versionDescription.description;

      //
      // Look on constants of chain description
      for (var palletName in chainDescription.constants.keys) {
        test(
            'When pallet $palletName is decoded and encoded back then it matches the original pallet value.',
            () {
          final pallet = chainDescription.constants[palletName]!;

          //
          // Loop throught all the constants in this given pallet
          for (var originalConstant in pallet.values) {
            //
            // Decoded Constant value
            final decoded =
                chain.decodeFromConstant(originalConstant, chainDescription);

            //
            // encoded constant value
            final Uint8List encoded = chain.encodeConstantsValue(
                originalConstant.type, decoded, chainDescription);

            // Matching the `Uint8List` of both the objects.
            expect(encoded, originalConstant.value);
          }
        });
      }
    }
  });
}
