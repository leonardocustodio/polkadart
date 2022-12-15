import 'dart:typed_data';

import 'package:substrate_metadata/chain/chain.dart';
import 'package:substrate_metadata/chain_description/chain_description.model.dart';
import 'package:substrate_metadata/metadata_decoder.dart';
import 'package:substrate_metadata/models/models.dart';
import 'package:test/test.dart';

import 'metadata_v14.dart';

void main() {
  group('Polkadot Constants Test', () {
    //
    // Initiate chain constructor with chain specific types-definition
    final chain = Chain();

    final MetadataDecoder metadataDecoder = MetadataDecoder();

    // decode `polkadot_v14_metadata.dart` -> `v14Metadata`
    final Metadata metadata = metadataDecoder.decodeAsMetadata(metadataV14);

    final ChainDescription chainDescription =
        ChainDescription.getFromMetadata(metadata, null);

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
  });
}
