import 'package:test/test.dart';
import './test_chain/chain.dart';

void main() {
  final chains = <String>[
    'acala',
    'altair',
    'astar',
    'basilisk',
    'bifrost',
    'calamari',
    'clover',
    'crust',
    'darwinia',
    'heiko',
    'hydradx',
    'karura',
    'khala',
    'kilt',
    'kintsugi',
    'kusama',
    'moonriver',
    'parallel',
    'pioneer',
    'polkadot',
    'quartz',
    'shibuya',
    'shiden',
    'statemine',
    'statemint',
    'subsocial',
  ];

  for (var chain in chains) {
    var obj = Chain(chain);
    obj.testConstantsScaleEncodingDecoding();
    obj.testEventsScaleEncodingDecoding();
  }
}
