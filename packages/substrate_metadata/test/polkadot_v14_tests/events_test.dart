import 'dart:convert';
import 'dart:io';

import 'package:polkadart_scale_codec/polkadart_scale_codec.dart';
import 'package:substrate_metadata/derived_codecs/derived_codecs.dart';
import 'package:substrate_metadata/substrate_metadata.dart';
import 'package:test/expect.dart';
import 'package:test/scaffolding.dart';

import 'events_test_data.dart';

void main() {
  final metadataFile = File('../../chain/metadata/metadata_v14.json');

  final metatadaJson = jsonDecode(metadataFile.readAsStringSync());

  final metadataV14 = metatadaJson['v14'];
  group('Events Decode/Encode: ', () {
    test('Decode Test', () {
      final inputBytes = decodeHex(metadataV14);
      final RuntimeMetadataPrefixed prefixedMetadata =
          RuntimeMetadataPrefixed.fromBytes(inputBytes);
      final MetadataTypeRegistry registry = MetadataTypeRegistry(prefixedMetadata);

      final EventsRecordCodec eventsCodec = EventsRecordCodec(registry);
      final decodedEventRecord = eventsCodec.decode(Input.fromHex(encodedEventRecordHex));

      final expectedJson = decodedEventRecords.map((e) => e.toJson()).toList();
      final actualJson = decodedEventRecord.map((e) => e.toJson()).toList();

      expect(expectedJson, actualJson);
    });

    test('Encode Test', () {
      final inputBytes = decodeHex(metadataV14);
      final RuntimeMetadataPrefixed prefixedMetadata =
          RuntimeMetadataPrefixed.fromBytes(inputBytes);
      final MetadataTypeRegistry registry = MetadataTypeRegistry(prefixedMetadata);
      final EventsRecordCodec eventsCodec = EventsRecordCodec(registry);

      final output = HexOutput();
      eventsCodec.encodeTo(decodedEventRecords, output);
      final encodedHex = output.toString();

      expect(encodedHex, encodedEventRecordHex);
    });

    test('Round-Trip Test (Decode First)', () {
      final inputBytes = decodeHex(metadataV14);
      final RuntimeMetadataPrefixed prefixedMetadata =
          RuntimeMetadataPrefixed.fromBytes(inputBytes);
      final MetadataTypeRegistry registry = MetadataTypeRegistry(prefixedMetadata);

      final EventsRecordCodec eventsCodec = EventsRecordCodec(registry);
      // Decode first
      final decodedEventRecord = eventsCodec.decode(Input.fromHex(encodedEventRecordHex));

      final EventsRecordCodec eventsCodec2 = EventsRecordCodec(registry);
      // Then encode
      final output = HexOutput();
      eventsCodec2.encodeTo(decodedEventRecord, output);
      final roundTripEncodedHex = output.toString();

      expect(roundTripEncodedHex, encodedEventRecordHex);
    });

    test('Round-Trip Test (Encode First)', () {
      final inputBytes = decodeHex(metadataV14);
      final RuntimeMetadataPrefixed prefixedMetadata =
          RuntimeMetadataPrefixed.fromBytes(inputBytes);
      final MetadataTypeRegistry registry = MetadataTypeRegistry(prefixedMetadata);

      final EventsRecordCodec eventsCodec = EventsRecordCodec(registry);

      // Encode first
      final output = HexOutput();
      eventsCodec.encodeTo(decodedEventRecords, output);
      final encodedHex = output.toString();

      // Then decode
      final decodedEventRecord = eventsCodec.decode(Input.fromHex(encodedHex));

      final expectedJson = decodedEventRecords.map((e) => e.toJson()).toList();
      final actualJson = decodedEventRecord.map((e) => e.toJson()).toList();

      expect(actualJson, expectedJson);
    });
  });
}
