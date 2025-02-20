import 'dart:convert';
import 'dart:io';

import 'package:substrate_metadata/models/models.dart';
import 'package:substrate_metadata/substrate_metadata.dart';
import 'package:test/test.dart';

const versions = [9, 10, 11, 12, 13, 14];

void main() {
  group('Metadata Json Conversion Test:', () {
    for (final version in versions) {
      test('Decode/Encode version: $version', () {
        // metadata file path for v9 - v14
        final String metadataFilePath =
            '../../chain/metadata/metadata_v$version.json';

        // reading the file
        final String fileContents = File(metadataFilePath).readAsStringSync();

        final String metadataHex = jsonDecode(fileContents)['v$version'];
        //
        // Here we only have the metadata but not the versions
        // so we are directly testing the decode method and
        // can confirm that if could do the decoding properly
        //

        // decoding
        final decodedMetadataJson =
            MetadataDecoder.instance.decode(metadataHex);

        //
        // Here we are creating Metadata Object from the decoded metadata
        final Metadata metadataObject = decodedMetadataJson.metadataObject;

        //
        // Here we are creating the json from the metadata object
        //
        // Hence checking testing the toJson() method
        final Map<String, dynamic> metadataJsonFromObject =
            Metadata.toJson(metadataObject);

        expect(metadataJsonFromObject.toString(),
            decodedMetadataJson.metadata.toString());
      });
    }
  });
}
