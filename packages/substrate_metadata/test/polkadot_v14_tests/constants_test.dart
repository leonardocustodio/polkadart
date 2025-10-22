import 'dart:convert';
import 'dart:io';
import 'dart:typed_data' show Uint8List;

import 'package:polkadart_scale_codec/polkadart_scale_codec.dart';
import 'package:substrate_metadata/derived_codecs/derived_codecs.dart';
import 'package:substrate_metadata/extensions/runtime_metadata_extensions.dart';
import 'package:substrate_metadata/models/models.dart';
import 'package:substrate_metadata/substrate_metadata.dart';
import 'package:test/expect.dart';
import 'package:test/scaffolding.dart';

void main() {
  final metadataFile = File('../../chain/metadata/metadata_v14.json');
  final snapshotFile = File('test/snapshots/v14_constants_test_snapshot.json');

  final metadataJson = jsonDecode(metadataFile.readAsStringSync());
  final metadataV14 = metadataJson['v14'];

  group('Constants Decode Tests: ', () {
    late MetadataTypeRegistry registry;
    late ConstantsCodec constantsCodec;
    late List<ConstantInfo> allConstants;

    setUp(() {
      final inputBytes = decodeHex(metadataV14);
      final RuntimeMetadataPrefixed prefixedMetadata =
          RuntimeMetadataPrefixed.fromBytes(inputBytes);
      registry = MetadataTypeRegistry(prefixedMetadata);
      constantsCodec = ConstantsCodec(registry);

      // Decode all constants as ConstantInfo objects
      allConstants = [];
      for (final pallet in registry.prefixed.metadata.pallets) {
        if (pallet.constants.isNotEmpty) {
          for (final constant in pallet.constants) {
            final constantInfo = constantsCodec.getConstantInfo(pallet.name, constant.name);
            if (constantInfo != null) {
              allConstants.add(constantInfo);
            }
          }
        }
      }
    });

    test('Snapshot Comparison Test - Decode matches saved snapshot', () {
      // Load the snapshot
      final snapshot = jsonDecode(snapshotFile.readAsStringSync());
      final expectedConstants = snapshot['constants'] as List;

      // Convert decoded constants to JSON
      final actualJson = allConstants.map((c) => c.toJson()).toList();

      // Compare counts
      expect(actualJson.length, expectedConstants.length,
          reason: 'Number of constants should match snapshot');

      // Verify metadata
      expect(snapshot['metadata']['totalConstants'], allConstants.length);
      expect(snapshot['metadata']['source'], 'Polkadot v14 metadata');

      // Compare each constant
      for (var i = 0; i < actualJson.length; i++) {
        final actual = actualJson[i];
        final expected = expectedConstants[i];

        expect(actual['name'], expected['name'], reason: 'Constant name mismatch at index $i');
        expect(actual['palletName'], expected['palletName'],
            reason: 'Pallet name mismatch at index $i');
        expect(actual['typeId'], expected['typeId'],
            reason: 'TypeId mismatch for ${actual['name']}');
        expect(actual['value'], expected['value'],
            reason: 'Value mismatch for ${actual['palletName']}.${actual['name']}');
        expect(actual['type'], expected['type'],
            reason: 'Type string mismatch for ${actual['name']}');
        expect(actual['docs'], expected['docs'], reason: 'Docs mismatch for ${actual['name']}');
      }
    });

    test('Decode All Constants Test', () {
      expect(allConstants.isNotEmpty, true);
      expect(allConstants.length, 122, reason: 'Should decode 122 constants from v14 metadata');
    });

    test('Decode Specific Pallet Constants - System', () {
      final systemConstants = constantsCodec.getPalletConstants('System');

      expect(systemConstants.isNotEmpty, true);

      final blockWeights = constantsCodec.getConstant('System', 'BlockWeights');
      expect(blockWeights, isNotNull);

      final blockLength = constantsCodec.getConstant('System', 'BlockLength');
      expect(blockLength, isNotNull);

      final blockHashCount = constantsCodec.getConstant('System', 'BlockHashCount');
      expect(blockHashCount, isNotNull);
    });

    test('Decode Specific Pallet Constants - Balances', () {
      final balancesConstants = constantsCodec.getPalletConstants('Balances');

      expect(balancesConstants.isNotEmpty, true);

      final existentialDeposit = constantsCodec.getConstant('Balances', 'ExistentialDeposit');
      expect(existentialDeposit, isNotNull);

      final maxLocks = constantsCodec.getConstant('Balances', 'MaxLocks');
      expect(maxLocks, isNotNull);
    });

    test('Decode Specific Pallet Constants - Timestamp', () {
      final timestampConstants = constantsCodec.getPalletConstants('Timestamp');

      expect(timestampConstants.isNotEmpty, true);

      final minimumPeriod = constantsCodec.getConstant('Timestamp', 'MinimumPeriod');
      expect(minimumPeriod, isNotNull);
    });

    test('ConstantInfo toJson() Serialization Test', () {
      final blockHashCount = constantsCodec.getConstantInfo('System', 'BlockHashCount');
      expect(blockHashCount, isNotNull);

      final json = blockHashCount!.toJson();

      expect(json['name'], 'BlockHashCount');
      expect(json['palletName'], 'System');
      expect(json['typeId'], isA<int>());
      expect(json['value'], isA<String>());
      expect(json['docs'], isA<List>());
      expect(json['type'], isA<String>());
    });

    test('Verify Constant Metadata - getConstantInfo', () {
      final constantInfo = constantsCodec.getConstantInfo('System', 'BlockHashCount');

      expect(constantInfo, isNotNull);
      expect(constantInfo!.name, 'BlockHashCount');
      expect(constantInfo.palletName, 'System');
      expect(constantInfo.value, isA<Uint8List>());
      expect(constantInfo.docs, isA<List>());
      expect(constantInfo.type, isA<PortableType>());
    });

    test('Verify All Pallets Have Constants Accessible', () {
      final palletGroups = <String, List<ConstantInfo>>{};
      for (final constant in allConstants) {
        palletGroups.putIfAbsent(constant.palletName, () => []).add(constant);
      }

      expect(palletGroups.isNotEmpty, true);
      expect(palletGroups.containsKey('System'), true);
      expect(palletGroups.containsKey('Balances'), true);
    });
  });
}
