import 'dart:convert';
import 'dart:io';

import 'package:polkadart_scale_codec/polkadart_scale_codec.dart';
import 'package:substrate_metadata/substrate_metadata.dart';
import 'package:test/test.dart';

const versions = [9, 10, 11, 12, 13, 14];

void main() {
  group('Metadata Tests:', () {
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
        final decodedMetadata = MetadataDecoder.instance.decode(metadataHex);

        final output = HexOutput();

        // encoding to output;
        MetadataDecoder.instance.encode(decodedMetadata, output);

        final encodedMetadataHex = output.toString();
        expect(encodedMetadataHex, metadataHex);
      });
    }
  });
}
