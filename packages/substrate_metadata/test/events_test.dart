import 'dart:convert';
import 'dart:io';

import 'package:substrate_metadata/core/chain.dart';
import 'package:substrate_metadata/models/legacy_types.dart';
import 'package:substrate_metadata/models/models.dart';
import 'package:test/test.dart';

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
    final result = File(filePath)
        .readAsLinesSync()
        .map(jsonDecode)
        .toList(growable: false);
    return result;
  }

  // read the blocks of the polkadot chain
  List<RawBlockEvents> getEvents(String filePath) {
    return readLines(filePath)
        .map((dynamic map) => RawBlockEvents.fromJson(map))
        .toList(growable: false);
  }

  group('Polkadot Events Test', () {
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

    final List<RawBlockEvents> rawBlocksList =
        getEvents('../../chain/polkadot/events.jsonl');

    //
    // Looping through every block
    for (var originalEvent in rawBlocksList) {
      test(
          'When original event is decoded and encoded back then it matches the provided event value.',
          () {
        //
        // Decoding the `Raw Block Events`
        final decodedBlockEvents = chain.decodeEvents(originalEvent);

        //
        // Encoding the `Decoded Block Events`
        final encodedBlockEvents = chain.encodeEvents(decodedBlockEvents);

        //
        // Comparing the original event with the encoded event
        expect(originalEvent.events, encodedBlockEvents.events);

        final againDecodedEvents = chain.decodeEvents(encodedBlockEvents);

        //
        // Comparing the decoded event with the decodedFromEncoded event
        expect(decodedBlockEvents.events.toString(),
            againDecodedEvents.events.toString());
      });
    }
  });
}
