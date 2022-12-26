import 'package:substrate_metadata/chain_description/chain_description.model.dart';
import 'package:substrate_metadata/extrinsic.dart';
import 'package:substrate_metadata/metadata_decoder.dart';
import 'package:substrate_metadata/models/models.dart';
import 'package:test/expect.dart';
import 'package:test/scaffolding.dart';

import 'metadata_v14.dart';

void main() {
  group('Extrinsics Decode/Encode: ', () {
    test('Encode Test', () {
      final MetadataDecoder metadataDecoder = MetadataDecoder();

      final Metadata metadata = metadataDecoder.decodeAsMetadata(metadataV14);

      final ChainDescription chainDescription =
          ChainDescription.fromMetadata(metadata);

      final String encodedHex =
          Extrinsic.encodeExtrinsic(_decodedExtrinsicMap(), chainDescription);

      expect(encodedHex, _encodedExtrinsicHex);
    });

    test('Decode Test', () {
      final MetadataDecoder metadataDecoder = MetadataDecoder();

      final Metadata metadata = metadataDecoder.decodeAsMetadata(metadataV14);

      final ChainDescription chainDescription =
          ChainDescription.fromMetadata(metadata);

      final dynamic decoded =
          Extrinsic.decodeExtrinsic(_encodedExtrinsicHex, chainDescription);

      expect(decoded, _decodedExtrinsicMap());
    });
  });
}

const _encodedExtrinsicHex =
    '0x99040436000000004f0fd348d45083cfc987db027a6c093b7f2b5d04eea4a9f0c752922cd90ea5ed1a3bb901b7b922bf8f589915c3042968995ec5f4845a0e47d92d3017df4520a90be65a0687ff11c060f52d2b0e15e7c01c86a5c004e89a239426cd50ac5fc6dd9822e470080642414245b501030a000000139f3b10000000009c7d5389e591bad6f06e4bbeedc05c32adb5fe2f98534c0e4e9cf83e222a180be8d102c101f4b7fa5383cdc9373359466b6be3be59bad84c96179a470ae8c60c4058b13b1370451d1027487e92556d696e7b817e3dbd1682e2d6ee56bace9105054241424501015a09b657fab77668b5d370b1e4ca57ded589a7afaba583e8a7118b073f694a3cb5b606611f2d4fce4cfc38a3ccb972db3684f3e53f23e747827f52dca2f9e184';

Map<String, dynamic> _decodedExtrinsicMap() {
  return {
    'version': 4,
    'extrinsic_length': 294,
    'call': {
      'ParaInherent': {
        'enter': {
          'data': {
            'bitfields': [],
            'backed_candidates': [],
            'disputes': [],
            'parent_header': {
              'parent_hash':
                  '4f0fd348d45083cfc987db027a6c093b7f2b5d04eea4a9f0c752922cd90ea5ed',
              'number': 7229126,
              'state_root':
                  'b7b922bf8f589915c3042968995ec5f4845a0e47d92d3017df4520a90be65a06',
              'extrinsics_root':
                  '87ff11c060f52d2b0e15e7c01c86a5c004e89a239426cd50ac5fc6dd9822e470',
              'digest': {
                'logs': [
                  {
                    'PreRuntime': [
                      '42414245',
                      [
                        3,
                        10,
                        0,
                        0,
                        0,
                        19,
                        159,
                        59,
                        16,
                        0,
                        0,
                        0,
                        0,
                        156,
                        125,
                        83,
                        137,
                        229,
                        145,
                        186,
                        214,
                        240,
                        110,
                        75,
                        190,
                        237,
                        192,
                        92,
                        50,
                        173,
                        181,
                        254,
                        47,
                        152,
                        83,
                        76,
                        14,
                        78,
                        156,
                        248,
                        62,
                        34,
                        42,
                        24,
                        11,
                        232,
                        209,
                        2,
                        193,
                        1,
                        244,
                        183,
                        250,
                        83,
                        131,
                        205,
                        201,
                        55,
                        51,
                        89,
                        70,
                        107,
                        107,
                        227,
                        190,
                        89,
                        186,
                        216,
                        76,
                        150,
                        23,
                        154,
                        71,
                        10,
                        232,
                        198,
                        12,
                        64,
                        88,
                        177,
                        59,
                        19,
                        112,
                        69,
                        29,
                        16,
                        39,
                        72,
                        126,
                        146,
                        85,
                        109,
                        105,
                        110,
                        123,
                        129,
                        126,
                        61,
                        189,
                        22,
                        130,
                        226,
                        214,
                        238,
                        86,
                        186,
                        206,
                        145,
                        5
                      ]
                    ]
                  },
                  {
                    'Seal': [
                      '42414245',
                      [
                        90,
                        9,
                        182,
                        87,
                        250,
                        183,
                        118,
                        104,
                        181,
                        211,
                        112,
                        177,
                        228,
                        202,
                        87,
                        222,
                        213,
                        137,
                        167,
                        175,
                        171,
                        165,
                        131,
                        232,
                        167,
                        17,
                        139,
                        7,
                        63,
                        105,
                        74,
                        60,
                        181,
                        182,
                        6,
                        97,
                        31,
                        45,
                        79,
                        206,
                        76,
                        252,
                        56,
                        163,
                        204,
                        185,
                        114,
                        219,
                        54,
                        132,
                        243,
                        229,
                        63,
                        35,
                        231,
                        71,
                        130,
                        127,
                        82,
                        220,
                        162,
                        249,
                        225,
                        132
                      ]
                    ]
                  }
                ]
              }
            }
          }
        }
      }
    }
  };
}
