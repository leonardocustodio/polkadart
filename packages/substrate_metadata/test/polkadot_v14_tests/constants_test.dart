import 'dart:convert';
import 'dart:io';

import 'package:polkadart_scale_codec/polkadart_scale_codec.dart';
import 'package:substrate_metadata/core/metadata_decoder.dart';
import 'package:substrate_metadata/models/models.dart';
import 'package:test/expect.dart';
import 'package:test/scaffolding.dart';

void main() {
  final metadataFile = File('../../chain/metadata/metadata_v14.json');

  final metatadaJson = jsonDecode(metadataFile.readAsStringSync());

  final metadataV14 = metatadaJson['v14'];
  group('Constants Decode/Encode Test', () {
    final DecodedMetadata metadata =
        MetadataDecoder.instance.decode(metadataV14);

    final ChainInfo chainInfo = ChainInfo.fromMetadata(metadata);

    //
    // Look on constants of chain description
    for (var palletEntry in chainInfo.constants.entries) {
      test(
          'When pallet ${palletEntry.key} is decoded and encoded back then it matches the original pallet value.',
          () {
        //
        // Loop throught all the constants in this given pallet
        for (var constantEntry in palletEntry.value.entries) {
          final Constant originalConstant = constantEntry.value;

          //
          // Decoded Constant value
          final decoded = originalConstant.value;

          final output = ByteOutput(originalConstant.bytes.length);

          //
          // encoded constant value
          originalConstant.type.encodeTo(decoded, output);

          // Matching the `Uint8List` of both the objects.
          expect(output.toBytes(), originalConstant.bytes);
        }
      });
    }
  });
}
