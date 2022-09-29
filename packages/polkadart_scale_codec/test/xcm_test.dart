import 'package:substrate_metadata/xcm/src.dart';
import 'package:test/test.dart';

void main() {
  final xcmHex1 =
      '0x000210010400010300a10f04320520000bf4a501cf4d010a1300010300a10f04320520000bf4a501cf4d010102286bee0d01000400010300e4201eaeb2f31d0d8321aef77936aa403a4ccc25';
  final xcmHex2 =
      '0x021000040000010608000c000bebc50fb22d140a130000010608000c000bebc50fb22d14010300286bee0d0100040001010016b8bbfec7ffe9b4ea5dd9b6d6146e96b6f56232a4f7628422133050a4b31069';

  final xcmMap1 = <String, dynamic>{
    '__kind': 'V0',
    'value': {
      'assets': [
        {'__kind': 'All', 'value': null},
        {'__kind': 'AllAbstractFungible', 'value': []},
        {'__kind': 'All', 'value': null},
        {'__kind': 'AllNonFungible', 'value': null}
      ],
      'effects': [],
      '__kind': 'TeleportAsset'
    }
  };

  final xcmMap2 = <String, dynamic>{
    '__kind': 'V2',
    'value': [
      {
        '__kind': 'WithdrawAsset',
        'value': [
          {
            'id': {
              '__kind': 'Concrete',
              'value': {
                'parents': 0,
                'interior': {
                  '__kind': 'X1',
                  'value': {
                    '__kind': 'GeneralKey',
                    'value': [0, 12]
                  }
                }
              }
            },
            'fungibility': {'__kind': 'Fungible', 'value': 22186493461995}
          }
        ]
      },
      {'__kind': 'ClearOrigin', 'value': null},
      {
        'fees': {
          'id': {
            '__kind': 'Concrete',
            'value': {
              'parents': 0,
              'interior': {
                '__kind': 'X1',
                'value': {
                  '__kind': 'GeneralKey',
                  'value': [0, 12]
                }
              }
            }
          },
          'fungibility': {'__kind': 'Fungible', 'value': 22186493461995}
        },
        'weightLimit': {'__kind': 'Limited', 'value': 4000000000},
        '__kind': 'BuyExecution'
      },
      {
        'assets': {
          '__kind': 'Wild',
          'value': {'__kind': 'All', 'value': null}
        },
        'maxAssets': 1,
        'beneficiary': {
          'parents': 0,
          'interior': {
            '__kind': 'X1',
            'value': {
              'network': {'__kind': 'Any', 'value': null},
              'id': [
                22,
                184,
                187,
                254,
                199,
                255,
                233,
                180,
                234,
                93,
                217,
                182,
                214,
                20,
                110,
                150,
                182,
                245,
                98,
                50,
                164,
                247,
                98,
                132,
                34,
                19,
                48,
                80,
                164,
                179,
                16,
                105
              ],
              '__kind': 'AccountId32'
            }
          }
        },
        '__kind': 'DepositAsset'
      }
    ]
  };
  group('Xcm Tests', () {
    test('Decode Xcm Test', () {
      // Decode the Hex to match with the desired map
      var map = decodeXcm(xcmHex1, return_map: true);
      expect(map, equals(xcmMap1));

      // Decode the Hex to match with the desired map
      var map2 = decodeXcm(xcmHex2, return_map: true);
      expect(map2, equals(xcmMap2));
    });

    test('Encode Xcm Test', () {
      // Encoding the Json Object `xcmMap1`: Output: `Uint8List`
      // Decode the encoded buffer from the above result
      //
      // Match if `xcm_map` == `result_map`
      var encodedBuffer1 = encodeXcm(xcmMap1);
      var resultMap1 = decodeXcm(encodedBuffer1, return_map: true);
      expect(resultMap1, equals(xcmMap1));

      // Encoding the Json Object `xcmMap1`: Output: `Uint8List`
      // Decode the encoded buffer from the above result
      //
      // Match if `xcm_map` == `result_map`
      var encodedBuffer2 = encodeXcm(xcmMap2);
      var resultMap2 = decodeXcm(encodedBuffer2, return_map: true);
      expect(resultMap2, equals(xcmMap2));
    });
  });
}
