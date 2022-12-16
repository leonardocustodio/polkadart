import 'dart:typed_data';

import 'package:polkadart_scale_codec/polkadart_scale_codec.dart';
import 'package:substrate_metadata/chain_description/chain_description.model.dart';
import 'package:substrate_metadata/metadata_decoder.dart';
import 'package:substrate_metadata/models/models.dart';
import 'package:test/test.dart';

import 'metadata_v14.dart';

void main() {
  group('Polkadot Constants Test', () {
    final MetadataDecoder metadataDecoder = MetadataDecoder();

    final Metadata metadata = metadataDecoder.decodeAsMetadata(metadataV14);

    final ChainDescription chainDescription =
        ChainDescription.fromMetadata(metadata);

    //
    // Look on constants of chain description
    for (String palletName in chainDescription.constants.keys) {
      test(
          'When pallet: $palletName is decoded and encoded back then it matches the original pallet value.',
          () {
        final pallet = chainDescription.constants[palletName]!;

        //
        // Loop throught all the constants in this given pallet
        for (Constant originalConstant in pallet.values) {
          //
          // Original constant value
          final Uint8List originalConstantValue = originalConstant.value;

          //
          // Decoded Constant value
          final dynamic decodedConstant = Codec(chainDescription.types)
              .decode(originalConstant.type, originalConstantValue);

          //
          // encoded constant value
          final bytesSink = ByteEncoder();
          //
          // Re-initialize the Codec so that codec doesn't have any previous knowledge of the types and decoded data.
          Codec(chainDescription.types).encodeWithEncoder(
              originalConstant.type, decodedConstant, bytesSink);
          final encodedConstant = bytesSink.toBytes();

          // Matching the `Uint8List` of both the objects.
          expect(encodedConstant, originalConstantValue);
        }
      });
    }
  });
}
