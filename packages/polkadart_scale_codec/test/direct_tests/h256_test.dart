import 'dart:typed_data';

import 'package:polkadart_scale_codec/polkadart_scale_codec.dart';
import 'package:test/test.dart';

void main() {
  group('H256 Encode Test', () {
    test('should encode', () {
      final output = HexOutput();
      H256Codec.instance.encodeTo(
          Uint8List.fromList(
            [
              208,
              51,
              188,
              138,
              168,
              18,
              204,
              1,
              15,
              50,
              66,
              170,
              113,
              201,
              115,
              92,
              232,
              20,
              153,
              125,
              246,
              23,
              133,
              202,
              116,
              37,
              55,
              136,
              221,
              164,
              26,
              81
            ],
          ),
          output);

      expect(output.toString(),
          '0xd033bc8aa812cc010f3242aa71c9735ce814997df61785ca74253788dda41a51');
    });
  });

  group('H256 Decode Test', () {
    test('should decode', () {
      final input = HexInput(
          '0xd033bc8aa812cc010f3242aa71c9735ce814997df61785ca74253788dda41a51');
      expect(
          H256Codec.instance.decode(input),
          Uint8List.fromList(
            [
              208,
              51,
              188,
              138,
              168,
              18,
              204,
              1,
              15,
              50,
              66,
              170,
              113,
              201,
              115,
              92,
              232,
              20,
              153,
              125,
              246,
              23,
              133,
              202,
              116,
              37,
              55,
              136,
              221,
              164,
              26,
              81
            ],
          ));
    });
  });
}
