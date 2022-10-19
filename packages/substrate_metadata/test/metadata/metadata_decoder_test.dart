import 'package:substrate_metadata/metadata_decoder.dart';
import 'package:test/expect.dart';
import 'package:test/scaffolding.dart';
import 'metadata_hex.dart';
import 'metadata_json.dart';

void main() {
  group('Test MetadataDecoder', () {
    test('decoding of metadata', () {
      var decoder = MetadataDecoder.instance;
      var decodedMetadata = decoder.decode(metadata_hex);
      expect(decodedMetadata, metadata_json);
    });
  });
}
