import 'dart:convert';
import 'dart:io';
import 'dart:typed_data' show Uint8List;
import 'package:polkadart_scale_codec/polkadart_scale_codec.dart' show Input;
import 'package:substrate_metadata/substrate_metadata.dart';
import 'package:test/test.dart';

void main() {
  group('Metadata Encode Decode Test:', () {
    test('Decode/Encode version v14', () {
      // metadata file path for v14
      final String metadataFilePath = '../../chain/metadata/metadata_v14.json';

      // reading the file
      final String fileContents = File(metadataFilePath).readAsStringSync();

      final String metadataHex = jsonDecode(fileContents)['v14'];

      // decoding
      final input = Input.fromHex(metadataHex);
      final prefixed = RuntimeMetadataPrefixed.codec.decode(input);

      // Verify magic number
      expect(prefixed.isValidMagicNumber, true);

      // Verify version is 14
      expect(prefixed.metadata.version, 14);

      // Extract the v14 metadata
      final runtimeMetadataV14 = prefixed.metadata;

      // Verify we can convert to JSON
      final metadataJson = runtimeMetadataV14.toJson();
      expect(metadataJson, isNotNull);
      expect(metadataJson['pallets'], isNotNull);
      expect(metadataJson['pallets'], isA<List>());

      // Verify the metadata has expected structure
      expect(metadataJson['types'], isNotNull);
      expect(metadataJson['extrinsic'], isNotNull);
      expect(metadataJson['type'], isNotNull);

      // Verify we can encode back to hex
      final Uint8List output = RuntimeMetadataPrefixed.codec.encode(prefixed);
      final encodedHex = output.toHexString();

      // Verify encoded hex is a valid hex string with the same prefix
      expect(encodedHex, startsWith('0x6d657461')); // Should start with magic number "meta"
      expect(encodedHex.substring(10, 12), '0e'); // Version byte should be 14 (0x0e)

      // Compare lengths
      expect(encodedHex.length, metadataHex.length);

      // The encoded hex should match the original (round-trip test)
      expect(encodedHex, metadataHex);
    });

    test('Decode/Encode version v15', () {
      // metadata file path for v15
      final String metadataFilePath = '../../chain/metadata/metadata_v15.json';

      // reading the file
      final String fileContents = File(metadataFilePath).readAsStringSync();

      final String metadataHex = jsonDecode(fileContents)['v15'];

      // decoding
      final input = Input.fromHex(metadataHex);
      final prefixed = RuntimeMetadataPrefixed.codec.decode(input);

      // Verify magic number
      expect(prefixed.isValidMagicNumber, true);

      // Verify version is 15
      expect(prefixed.metadata.version, 15);

      // Extract the v15 metadata
      final runtimeMetadataV15 = prefixed.metadata;

      // Verify we can convert to JSON
      final metadataJson = runtimeMetadataV15.toJson();
      expect(metadataJson, isNotNull);
      expect(metadataJson['pallets'], isNotNull);
      expect(metadataJson['pallets'], isA<List>());

      // Verify the metadata has expected structure
      expect(metadataJson['types'], isNotNull);
      expect(metadataJson['extrinsic'], isNotNull);
      expect(metadataJson['type'], isNotNull);

      // Verify we can encode back to hex
      final Uint8List output = RuntimeMetadataPrefixed.codec.encode(prefixed);
      final encodedHex = output.toHexString();

      // Verify encoded hex is a valid hex string with the same prefix
      expect(encodedHex, startsWith('0x6d657461')); // Should start with magic number "meta"
      expect(encodedHex.substring(10, 12), '0f'); // Version byte should be 15 (0x0f)

      // Compare lengths
      expect(encodedHex.length, metadataHex.length);

      // The encoded hex should match the original (round-trip test)
      expect(encodedHex, metadataHex);
    });
  });
}
