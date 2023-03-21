import 'dart:convert';
import 'dart:io';

import 'package:substrate_metadata/core/chain.dart';
import 'package:substrate_metadata/models/legacy_types.dart';
import 'package:substrate_metadata/models/models.dart';
import 'package:substrate_metadata/types/metadata_types.dart';
import 'package:test/test.dart';

import '../../parachain_definitions/polkadot.dart';

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
    final result = File(filePath)
        .readAsLinesSync()
        .map(jsonDecode)
        .toList(growable: false);
    return result;
  }

  // read the blocks of the polkadot chain
  List<RawBlockExtrinsics> getBlocks(String filePath) {
    return readLines(filePath)
        .map((dynamic map) => RawBlockExtrinsics.fromJson(map))
        .toList(growable: false);
  }

  group('Polkadot Extrinsics Test', () {
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

    final List<RawBlockExtrinsics> rawBlocksList =
        getBlocks('../../chain/polkadot/blocks.jsonl');
    //
    // Looping through every block
    for (var originalExtrinsics in rawBlocksList) {
      test('When original extrinsics is decode it should return normally ', () {
        //
        // Decoding the `Raw Block Extrinsics`
        final decodedBlockExtrinsics =
            chain.decodeExtrinsics(originalExtrinsics);

        //
        // Encoding the `Decoded Block Extrinsics`
        final encodedBlockExtrinsics =
            chain.encodeExtrinsics(decodedBlockExtrinsics);

        expect(encodedBlockExtrinsics.extrinsics.toString(),
            originalExtrinsics.extrinsics.toString());

        /// Match the hashes of the extrinsics
        for (var i = 0; i < originalExtrinsics.extrinsics.length; i++) {
          expect(
            decodedBlockExtrinsics.extrinsics[i]['hash'],
            ExtrinsicsCodec.computeHashFromString(
                encodedBlockExtrinsics.extrinsics[i]),
          );
        }

        //
        // Comparing the original extrinsics with the encoded extrinsics
        expect(
            originalExtrinsics.extrinsics, encodedBlockExtrinsics.extrinsics);
      });
    }
  });
}
