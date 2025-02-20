import 'dart:convert';
import 'dart:io';

import 'package:polkadart_scale_codec/polkadart_scale_codec.dart';
import 'package:substrate_metadata/core/metadata_decoder.dart';
import 'package:substrate_metadata/models/models.dart';
import 'package:substrate_metadata/utils/utils.dart';
import 'package:test/expect.dart';
import 'package:test/scaffolding.dart';

void main() {
  final metadataFile = File('../../chain/metadata/metadata_v14.json');

  final metatadaJson = jsonDecode(metadataFile.readAsStringSync());

  final metadataV14 = metatadaJson['v14'];
  group('Events Decode/Encode: ', () {
    test('Encode Test', () {
      final DecodedMetadata metadata =
          MetadataDecoder.instance.decode(metadataV14);

      final ChainInfo chainInfo = ChainInfo.fromMetadata(metadata);

      final output = HexOutput();

      chainInfo.scaleCodec.encodeTo('EventCodec', _decodedEvents(), output);

      expect(_encodedEventsHex, output.toString());
    });

    test('Decode Test', () {
      final metadata = MetadataDecoder.instance.decode(metadataV14);

      final ChainInfo chainInfo = ChainInfo.fromMetadata(metadata);

      final input = Input.fromHex(_encodedEventsHex);

      final List<dynamic> decodedEvents =
          chainInfo.scaleCodec.decode('EventCodec', input);

      expect(
          (_decodedEvents() as List<dynamic>).toJson(), decodedEvents.toJson());
    });
  });
}

const _encodedEventsHex =
    '0x3800000000000000b0338609000000000200000001000000000080b2e60e0000000002000000020000000004270179b49161217dd14c4572b0fbbed18f1974af52f87c5ec6e6fcd6184d952d0000020000000501270179b49161217dd14c4572b0fbbed18f1974af52f87c5ec6e6fcd6184d952db1c62d000000000000000000000000000000020000000502270179b49161217dd14c4572b0fbbed18f1974af52f87c5ec6e6fcd6184d952d57680e93f9d60b9be427bd9f7c5b6afe6d3ad3d09372bde3103a6c2595a0685c0864265932000000000000000000000000000200000013060c4c7007000000000000000000000000000002000000050414dd41222459d521e9d9cf15c7346abcb2b2137db1926773ed23034c0809e93d0313dc01000000000000000000000000000002000000000010016b0b0000000000000000030000000004ba27afce119b843500f1be93da74c15f40983361f045ee58357b6e167da9e53c0000030000000501ba27afce119b843500f1be93da74c15f40983361f045ee58357b6e167da9e53cb1c62d000000000000000000000000000000030000000502ba27afce119b843500f1be93da74c15f40983361f045ee58357b6e167da9e53c57680e93f9d60b9be427bd9f7c5b6afe6d3ad3d09372bde3103a6c2595a0685c4032cdee0d000000000000000000000000000300000013060c4c7007000000000000000000000000000003000000050414dd41222459d521e9d9cf15c7346abcb2b2137db1926773ed23034c0809e93d0313dc01000000000000000000000000000003000000000010016b0b00000000000000';

dynamic _decodedEvents() {
  return [
    {
      'phase': MapEntry('ApplyExtrinsic', 0),
      'event': MapEntry(
          'System',
          MapEntry('ExtrinsicSuccess', {
            'DispatchInfo': {
              'weight': BigInt.from(159790000),
              'class': 'Mandatory',
              'pays_fee': 'Yes'
            }
          })),
      'topics': []
    },
    {
      'phase': MapEntry('ApplyExtrinsic', 1),
      'event': MapEntry(
          'System',
          MapEntry('ExtrinsicSuccess', {
            'DispatchInfo': {
              'weight': BigInt.from(250000000),
              'class': 'Mandatory',
              'pays_fee': 'Yes'
            }
          })),
      'topics': []
    },
    {
      'phase': MapEntry('ApplyExtrinsic', 2),
      'event': MapEntry(
          'System',
          MapEntry('KilledAccount', {
            'T::AccountId': [
              39,
              1,
              121,
              180,
              145,
              97,
              33,
              125,
              209,
              76,
              69,
              114,
              176,
              251,
              190,
              209,
              143,
              25,
              116,
              175,
              82,
              248,
              124,
              94,
              198,
              230,
              252,
              214,
              24,
              77,
              149,
              45
            ]
          })),
      'topics': []
    },
    {
      'phase': MapEntry('ApplyExtrinsic', 2),
      'event': MapEntry(
          'Balances',
          MapEntry('DustLost', {
            'T::AccountId': [
              39,
              1,
              121,
              180,
              145,
              97,
              33,
              125,
              209,
              76,
              69,
              114,
              176,
              251,
              190,
              209,
              143,
              25,
              116,
              175,
              82,
              248,
              124,
              94,
              198,
              230,
              252,
              214,
              24,
              77,
              149,
              45
            ],
            'T::Balance': BigInt.from(2999985)
          })),
      'topics': []
    },
    {
      'phase': MapEntry('ApplyExtrinsic', 2),
      'event': MapEntry(
          'Balances',
          MapEntry('Transfer', [
            [
              39,
              1,
              121,
              180,
              145,
              97,
              33,
              125,
              209,
              76,
              69,
              114,
              176,
              251,
              190,
              209,
              143,
              25,
              116,
              175,
              82,
              248,
              124,
              94,
              198,
              230,
              252,
              214,
              24,
              77,
              149,
              45
            ],
            [
              87,
              104,
              14,
              147,
              249,
              214,
              11,
              155,
              228,
              39,
              189,
              159,
              124,
              91,
              106,
              254,
              109,
              58,
              211,
              208,
              147,
              114,
              189,
              227,
              16,
              58,
              108,
              37,
              149,
              160,
              104,
              92
            ],
            BigInt.from(216244053000)
          ])),
      'topics': []
    },
    {
      'phase': MapEntry('ApplyExtrinsic', 2),
      'event': MapEntry('Treasury',
          MapEntry('Deposit', {'BalanceOf<T, I>': BigInt.from(124800012)})),
      'topics': []
    },
    {
      'phase': MapEntry('ApplyExtrinsic', 2),
      'event': MapEntry(
          'Balances',
          MapEntry('Reserved', {
            'T::AccountId': [
              20,
              221,
              65,
              34,
              36,
              89,
              213,
              33,
              233,
              217,
              207,
              21,
              199,
              52,
              106,
              188,
              178,
              178,
              19,
              125,
              177,
              146,
              103,
              115,
              237,
              35,
              3,
              76,
              8,
              9,
              233,
              61
            ],
            'T::Balance': BigInt.from(31200003)
          })),
      'topics': []
    },
    {
      'phase': MapEntry('ApplyExtrinsic', 2),
      'event': MapEntry(
          'System',
          MapEntry('ExtrinsicSuccess', {
            'DispatchInfo': {
              'weight': BigInt.from(191562000),
              'class': 'Normal',
              'pays_fee': 'Yes'
            }
          })),
      'topics': []
    },
    {
      'phase': MapEntry('ApplyExtrinsic', 3),
      'event': MapEntry(
          'System',
          MapEntry('KilledAccount', {
            'T::AccountId': [
              186,
              39,
              175,
              206,
              17,
              155,
              132,
              53,
              0,
              241,
              190,
              147,
              218,
              116,
              193,
              95,
              64,
              152,
              51,
              97,
              240,
              69,
              238,
              88,
              53,
              123,
              110,
              22,
              125,
              169,
              229,
              60
            ]
          })),
      'topics': []
    },
    {
      'phase': MapEntry('ApplyExtrinsic', 3),
      'event': MapEntry(
          'Balances',
          MapEntry('DustLost', {
            'T::AccountId': [
              186,
              39,
              175,
              206,
              17,
              155,
              132,
              53,
              0,
              241,
              190,
              147,
              218,
              116,
              193,
              95,
              64,
              152,
              51,
              97,
              240,
              69,
              238,
              88,
              53,
              123,
              110,
              22,
              125,
              169,
              229,
              60
            ],
            'T::Balance': BigInt.from(2999985)
          })),
      'topics': []
    },
    {
      'phase': MapEntry('ApplyExtrinsic', 3),
      'event': MapEntry(
          'Balances',
          MapEntry('Transfer', [
            [
              186,
              39,
              175,
              206,
              17,
              155,
              132,
              53,
              0,
              241,
              190,
              147,
              218,
              116,
              193,
              95,
              64,
              152,
              51,
              97,
              240,
              69,
              238,
              88,
              53,
              123,
              110,
              22,
              125,
              169,
              229,
              60
            ],
            [
              87,
              104,
              14,
              147,
              249,
              214,
              11,
              155,
              228,
              39,
              189,
              159,
              124,
              91,
              106,
              254,
              109,
              58,
              211,
              208,
              147,
              114,
              189,
              227,
              16,
              58,
              108,
              37,
              149,
              160,
              104,
              92
            ],
            BigInt.from(59841000000)
          ])),
      'topics': []
    },
    {
      'phase': MapEntry('ApplyExtrinsic', 3),
      'event': MapEntry('Treasury',
          MapEntry('Deposit', {'BalanceOf<T, I>': BigInt.from(124800012)})),
      'topics': []
    },
    {
      'phase': MapEntry('ApplyExtrinsic', 3),
      'event': MapEntry(
          'Balances',
          MapEntry('Reserved', {
            'T::AccountId': [
              20,
              221,
              65,
              34,
              36,
              89,
              213,
              33,
              233,
              217,
              207,
              21,
              199,
              52,
              106,
              188,
              178,
              178,
              19,
              125,
              177,
              146,
              103,
              115,
              237,
              35,
              3,
              76,
              8,
              9,
              233,
              61
            ],
            'T::Balance': BigInt.from(31200003)
          })),
      'topics': []
    },
    {
      'phase': MapEntry('ApplyExtrinsic', 3),
      'event': MapEntry(
          'System',
          MapEntry('ExtrinsicSuccess', {
            'DispatchInfo': {
              'weight': BigInt.from(191562000),
              'class': 'Normal',
              'pays_fee': 'Yes'
            }
          })),
      'topics': []
    }
  ];
}
