import 'package:substrate_metadata/metadata_decoder.dart';
import 'package:test/expect.dart';
import 'package:test/scaffolding.dart';
import 'metadata_hex.dart';

void main() {
  group('Test MetadataDecoder', () {
    test('When valid hexa-decimal is decoded then it produces valid metadata.',
        () {
      final decoder = MetadataDecoder();

      expect(() => decoder.decode(metadata_hex), returnsNormally);
    });
  });
}
