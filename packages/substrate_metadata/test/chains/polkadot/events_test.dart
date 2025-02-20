import 'package:substrate_metadata/core/chain.dart';
import 'package:substrate_metadata/models/legacy_types.dart';
import 'package:substrate_metadata/models/models.dart';
import 'package:substrate_metadata/utils/utils.dart';
import 'package:test/test.dart';

import '../../parachain_definitions/polkadot.dart';

void main() {
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
        RawBlockEvents.readEventsFromPath('../../chain/polkadot/events.jsonl');

    //
    // Looping through every block
    for (var originalEvent in rawBlocksList) {
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
  });
}
