import 'dart:convert';
import 'dart:io';

import 'package:substrate_metadata/models/models.dart';
import 'package:substrate_metadata/substrate_metadata.dart';
import 'package:test/test.dart';

void main() {
  group('Metadata Json Conversion Test:', () {
    // metadata file path for v9 - v14
    final String metadataFilePath =
        '../substrate_metadata/test/metadata_tests/metadata.json';

    // reading the file
    final String fileContents = File(metadataFilePath).readAsStringSync();

    final List<String> metadataVersions =
        (jsonDecode(fileContents)['metadataVersions'] as List<dynamic>)
            .cast<String>();

    // testing for v9 - v14
    //
    // looping throught all the metadata
    for (var index = 0; index < metadataVersions.length; index++) {
      final metadataHex = metadataVersions[index];

      test('Decode/Encode at index: $index', () {
        //
        // Here we only have the metadata but not the versions
        // so we are directly testing the decode method and
        // can confirm that if could do the decoding properly
        //

        // decoding
        final Map<String, dynamic> decodedMetadataJson =
            MetadataDecoder().decode(metadataHex);

        //
        // Here we are creating Metadata Object from the decoded metadata
        final Metadata metadataObject = Metadata.fromVersion(
            decodedMetadataJson['metadata'], decodedMetadataJson['version']);

        //
        // Here we are creating the json from the metadata object
        //
        // Hence checking testing the toJson() method
        final Map<String, dynamic> metadataJsonFromObject =
            Metadata.toJson(metadataObject);

        expect(metadataJsonFromObject.toString(),
            decodedMetadataJson['metadata'].toString());
      });
    }
  });
}
