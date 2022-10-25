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

  // read the blocks of the polkadot chain
  List<RawBlockEvents> getEvents(String filePath) {
    return readLines(filePath)
        .map((dynamic map) => RawBlockEvents.fromJson(map))
        .toList();
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
        final DecodedBlockEvents decodedBlockEvents =
            chain.decodeEvents(originalEvent);

        //
        // Encoding the `DecodedBlockEvents`
        final RawBlockEvents encodedEvents =
            chain.encodeEvents(decodedBlockEvents);

        //
        // match the events of `encodedEvents` and the original `rawBlock`
        expect(
          // encoded events
          encodedEvents.events,

          // original block events
          originalEvent.events,
        );
      });
    }
  });
}
