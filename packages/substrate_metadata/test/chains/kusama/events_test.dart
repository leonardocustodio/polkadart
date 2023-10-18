import 'package:substrate_metadata/core/chain.dart';
import 'package:substrate_metadata/models/legacy_types.dart';
import 'package:substrate_metadata/models/models.dart';
import 'package:substrate_metadata/utils/utils.dart';
import 'package:test/test.dart';

import '../../parachain_definitions/kusama.dart';

void main() {
  group('Kusama Events Test', () {
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

    void parseEventList(List<RawBlockEvents> rawEventList) {
      for (var originalEvent in rawEventList) {
        test(
            'When original event is decoded and encoded back then it matches the original event value.',
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
          expect(decodedBlockEvents.events.toJson().toString(),
              againDecodedEvents.events.toJson().toString());
        });
      }
    }

    parseEventList(RawBlockEvents.readEventsFromPath(
        '../../chain/kusama/events.part1.jsonl'));
    parseEventList(RawBlockEvents.readEventsFromPath(
        '../../chain/kusama/events.part2.jsonl'));
  });
}
