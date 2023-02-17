import 'dart:convert';
import 'dart:io';

import 'package:polkadart_scale_codec/metadata_types/metadata_decoder.dart';

void main() {
  final String metadataFilePath =
      '../polkadart_scale_codec/test/metadata_tests/metadata_v14.json';
  final String fileContents = File(metadataFilePath).readAsStringSync();

  final Map<String, dynamic> metadata = jsonDecode(fileContents);

  final String metadataHexV14 = metadata['v14'];

  final metadataDecoder = MetadataDecoder.instance;
  final value = metadataDecoder.decode(metadataHexV14);
  

  print('here');
}
