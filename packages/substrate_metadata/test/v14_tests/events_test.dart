import 'dart:convert';
import 'dart:io';
import 'package:substrate_metadata/core/chain.dart';
import 'package:substrate_metadata/models/models.dart';
import 'package:test/scaffolding.dart';

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
    // Initiate chain constructor with chain specific types-definition
    final chain = Chain();

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

        print(decodedBlockEvents?.events);
      });
    }
  });
}
