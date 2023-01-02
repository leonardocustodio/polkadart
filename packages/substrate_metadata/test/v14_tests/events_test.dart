import 'package:polkadart_scale_codec/polkadart_scale_codec.dart';
import 'package:substrate_metadata/chain_description/chain_description.model.dart';
import 'package:substrate_metadata/metadata_decoder.dart';
import 'package:substrate_metadata/models/models.dart';
import 'package:test/expect.dart';
import 'package:test/scaffolding.dart';

import 'metadata_v14.dart';

void main() {
  group('Events Decode/Encode: ', () {
    test('Encode Test', () {
      final MetadataDecoder metadataDecoder = MetadataDecoder();

      final Metadata metadata = metadataDecoder.decodeAsMetadata(metadataV14);

      final ChainDescription chainDescription =
          ChainDescription.fromMetadata(metadata);

      final Codec codec = Codec(chainDescription.types);

      final String eventsHex =
          codec.encode(chainDescription.eventRecordList, _decodedEvents());

      expect(_encodedEventsHex, eventsHex);
    });

    test('Decode Test', () {
      final MetadataDecoder metadataDecoder = MetadataDecoder();

      final Metadata metadata = metadataDecoder.decodeAsMetadata(metadataV14);

      final ChainDescription chainDescription =
          ChainDescription.fromMetadata(metadata);

      final Codec codec = Codec(chainDescription.types);

      final dynamic decoded =
          codec.decode(chainDescription.eventRecordList, _encodedEventsHex);

      expect(_decodedEvents(), decoded);
    });
  });
}

const _encodedEventsHex =
    '0x3800000000000000b0338609000000000200000001000000000080b2e60e0000000002000000020000000004270179b49161217dd14c4572b0fbbed18f1974af52f87c5ec6e6fcd6184d952d0000020000000501270179b49161217dd14c4572b0fbbed18f1974af52f87c5ec6e6fcd6184d952db1c62d000000000000000000000000000000020000000502270179b49161217dd14c4572b0fbbed18f1974af52f87c5ec6e6fcd6184d952d57680e93f9d60b9be427bd9f7c5b6afe6d3ad3d09372bde3103a6c2595a0685c0864265932000000000000000000000000000200000013060c4c7007000000000000000000000000000002000000050414dd41222459d521e9d9cf15c7346abcb2b2137db1926773ed23034c0809e93d0313dc01000000000000000000000000000002000000000010016b0b0000000000000000030000000004ba27afce119b843500f1be93da74c15f40983361f045ee58357b6e167da9e53c0000030000000501ba27afce119b843500f1be93da74c15f40983361f045ee58357b6e167da9e53cb1c62d000000000000000000000000000000030000000502ba27afce119b843500f1be93da74c15f40983361f045ee58357b6e167da9e53c57680e93f9d60b9be427bd9f7c5b6afe6d3ad3d09372bde3103a6c2595a0685c4032cdee0d000000000000000000000000000300000013060c4c7007000000000000000000000000000003000000050414dd41222459d521e9d9cf15c7346abcb2b2137db1926773ed23034c0809e93d0313dc01000000000000000000000000000003000000000010016b0b00000000000000';

dynamic _decodedEvents() {
  return [
    {
      'phase': {'ApplyExtrinsic': 0},
      'event': {
        'System': {
          'ExtrinsicSuccess': {
            'dispatch_info': {
              'weight': {'ref_time': BigInt.from(159790000)},
              'class': 'Mandatory',
              'pays_fee': 'Yes'
            }
          }
        }
      },
      'topics': []
    },
    {
      'phase': {'ApplyExtrinsic': 1},
      'event': {
        'System': {
          'ExtrinsicSuccess': {
            'dispatch_info': {
              'weight': {'ref_time': BigInt.from(250000000)},
              'class': 'Mandatory',
              'pays_fee': 'Yes'
            }
          }
        }
      },
      'topics': []
    },
    {
      'phase': {'ApplyExtrinsic': 2},
      'event': {
        'System': {
          'KilledAccount': {
            'account':
                '270179b49161217dd14c4572b0fbbed18f1974af52f87c5ec6e6fcd6184d952d'
          }
        }
      },
      'topics': []
    },
    {
      'phase': {'ApplyExtrinsic': 2},
      'event': {
        'Balances': {
          'DustLost': {
            'account':
                '270179b49161217dd14c4572b0fbbed18f1974af52f87c5ec6e6fcd6184d952d',
            'amount': BigInt.from(2999985)
          }
        }
      },
      'topics': []
    },
    {
      'phase': {'ApplyExtrinsic': 2},
      'event': {
        'Balances': {
          'Transfer': {
            'from':
                '270179b49161217dd14c4572b0fbbed18f1974af52f87c5ec6e6fcd6184d952d',
            'to':
                '57680e93f9d60b9be427bd9f7c5b6afe6d3ad3d09372bde3103a6c2595a0685c',
            'amount': BigInt.from(216244053000)
          }
        }
      },
      'topics': []
    },
    {
      'phase': {'ApplyExtrinsic': 2},
      'event': {
        'Treasury': {
          'Deposit': {'value': BigInt.from(124800012)}
        }
      },
      'topics': []
    },
    {
      'phase': {'ApplyExtrinsic': 2},
      'event': {
        'Balances': {
          'Reserved': {
            'who':
                '14dd41222459d521e9d9cf15c7346abcb2b2137db1926773ed23034c0809e93d',
            'amount': BigInt.from(31200003)
          }
        }
      },
      'topics': []
    },
    {
      'phase': {'ApplyExtrinsic': 2},
      'event': {
        'System': {
          'ExtrinsicSuccess': {
            'dispatch_info': {
              'weight': {'ref_time': BigInt.from(191562000)},
              'class': 'Normal',
              'pays_fee': 'Yes'
            }
          }
        }
      },
      'topics': []
    },
    {
      'phase': {'ApplyExtrinsic': 3},
      'event': {
        'System': {
          'KilledAccount': {
            'account':
                'ba27afce119b843500f1be93da74c15f40983361f045ee58357b6e167da9e53c'
          }
        }
      },
      'topics': []
    },
    {
      'phase': {'ApplyExtrinsic': 3},
      'event': {
        'Balances': {
          'DustLost': {
            'account':
                'ba27afce119b843500f1be93da74c15f40983361f045ee58357b6e167da9e53c',
            'amount': BigInt.from(2999985)
          }
        }
      },
      'topics': []
    },
    {
      'phase': {'ApplyExtrinsic': 3},
      'event': {
        'Balances': {
          'Transfer': {
            'from':
                'ba27afce119b843500f1be93da74c15f40983361f045ee58357b6e167da9e53c',
            'to':
                '57680e93f9d60b9be427bd9f7c5b6afe6d3ad3d09372bde3103a6c2595a0685c',
            'amount': BigInt.from(59841000000)
          }
        }
      },
      'topics': []
    },
    {
      'phase': {'ApplyExtrinsic': 3},
      'event': {
        'Treasury': {
          'Deposit': {'value': BigInt.from(124800012)}
        }
      },
      'topics': []
    },
    {
      'phase': {'ApplyExtrinsic': 3},
      'event': {
        'Balances': {
          'Reserved': {
            'who':
                '14dd41222459d521e9d9cf15c7346abcb2b2137db1926773ed23034c0809e93d',
            'amount': BigInt.from(31200003)
          }
        }
      },
      'topics': []
    },
    {
      'phase': {'ApplyExtrinsic': 3},
      'event': {
        'System': {
          'ExtrinsicSuccess': {
            'dispatch_info': {
              'weight': {'ref_time': BigInt.from(191562000)},
              'class': 'Normal',
              'pays_fee': 'Yes'
            }
          }
        }
      },
      'topics': []
    }
  ];
}
