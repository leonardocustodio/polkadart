import 'dart:convert';
import 'dart:io';
import 'package:substrate_metadata/chain/chain.dart';
import 'package:substrate_metadata/models/models.dart';
import 'package:substrate_metadata/old/legacy_types_model.dart';
import 'package:test/expect.dart';
import 'package:test/scaffolding.dart';
import 'parachain_definitions/polkadot.dart';

void main() {
  // read lines
  List<dynamic> readLines(String filePath) {
    // check if the file exists
    if (File(filePath).existsSync() == false) {
      // return with empty list
      return <dynamic>[];
    }
    // As File exists, now start reading line by line.
    //
    // mapping lines to jsonDecode so as to convert `stringified` lines to `List<HashMap>`.
    final result = File(filePath).readAsLinesSync().map(jsonDecode).toList();
    return result;
  }

  // read the blocks of the acala chain
  List<RawBlock> getBlocks(String filePath) {
    return readLines(filePath)
        .map((dynamic map) => RawBlock.fromJson(map))
        .toList();
  }

  group('Polkadot Extrinsic Test', () {
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

    final List<RawBlock> rawBlocksList =
        getBlocks('../../chain/polkadot/blocks.jsonl');

    //
    // Looping through every block
    for (var originalRawBlock in rawBlocksList) {
      test(
          'When original extrinsic is decoded and encoded back then it matches the original extrinsic value.',
          () {
        //
        // Decoding the Raw Block
        final DecodedBlockExtrinsics decodedExtrinsic =
            chain.decodeExtrinsics(originalRawBlock);

        //
        // Encoding the DecodedBlockExtrinsics
        final RawBlock encodedRawBlock =
            chain.encodeExtrinsics(decodedExtrinsic);
        try {
          //
          // match the extrinsics of `encodedRawBlock` and the original `rawBlock`
          expect(
            // encoded
            encodedRawBlock.extrinsics,

            // original
            originalRawBlock.extrinsics,
          );
        } catch (e) {
          //
          // Decoding the Raw Block
          final DecodedBlockExtrinsics decodedExtrinsicFromEncoded =
              chain.decodeExtrinsics(encodedRawBlock);
          //
          // Decoding the Raw Block
          final DecodedBlockExtrinsics decodedExtrinsicFromOriginal =
              chain.decodeExtrinsics(originalRawBlock);

          expect(
            // decoded extrinsic from encoded
            decodedExtrinsicFromEncoded.extrinsics,

            // decoded extrinsic from original
            decodedExtrinsicFromOriginal.extrinsics,
          );
        }
      });
    }
  });
}
