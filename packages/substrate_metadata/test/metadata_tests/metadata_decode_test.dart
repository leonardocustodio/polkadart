import 'dart:convert';
import 'dart:io';

import 'package:polkadart_scale_codec/io/io.dart';
import 'package:polkadart_scale_codec/utils/utils.dart';
import 'package:substrate_metadata/substrate_metadata.dart';

void main() {
  final versions = [12, 13, 14];
  for (final version in versions) {
    final String metadataFilePath =
        '../substrate_metadata/test/metadata_tests/metadata.json';
    final String fileContents = File(metadataFilePath).readAsStringSync();

    final Map<String, dynamic> metadata = jsonDecode(fileContents);
    final String metadataHex = metadata['v$version']!;

    // decoding
    final input = HexInput(metadataHex);

    final decodedMetadata = MetadataDecoder.instance.decode(input);

    final output = HexOutput();
    MetadataDecoder.instance.encode(decodedMetadata, output);

    final encodedMetadataHex = output.toString();

    assertion(encodedMetadataHex == metadataHex);
  }
}
