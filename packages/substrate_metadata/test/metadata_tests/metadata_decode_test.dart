import 'dart:convert';
import 'dart:io';

import 'package:polkadart_scale_codec/polkadart_scale_codec.dart';
import 'package:substrate_metadata/substrate_metadata.dart';
import 'package:test/test.dart';

void main() {
  group('Metadata Tests:', () {
    // metadata file path for v9 - v14
    final String metadataFilePath = '../../chain/metadata.json';

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
        final decodedMetadata = MetadataDecoder().decode(metadataHex);

        final output = HexOutput();

        // encoding to output;
        MetadataDecoder().encode(
            decodedMetadata['metadata'], decodedMetadata['version'], output);

        final encodedMetadataHex = output.toString();
        expect(encodedMetadataHex, metadataHex);
      });
    }
  });
}
