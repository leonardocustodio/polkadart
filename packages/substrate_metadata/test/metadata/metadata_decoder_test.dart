import 'dart:convert';
import 'dart:io';
import 'package:substrate_metadata/metadata_decoder.dart';
import 'package:test/expect.dart';
import 'package:test/scaffolding.dart';
import 'metadata_hex.dart';

void main() {
  group('Test MetadataDecoder', () {
    test('When valid hexa-decimal is decoded then it produces valid metadata.',
        () {
      var decoder = MetadataDecoder.instance;
      var decodedMetadata = decoder.decode(metadata_hex);

      final file = File('../substrate_metadata/test/metadata/metadata.json');
      final expectedMetadataJson = jsonDecode(file.readAsStringSync());

      expect(decodedMetadata, expectedMetadataJson);
    });
  });
}
