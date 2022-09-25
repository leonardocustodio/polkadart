import 'package:test/test.dart';
import './test_chain/chain.dart';

void main() {
  group('Chain: acala', () {
    var obj = Chain('acala');
    obj.testExtrinsicsScaleEncodingDecoding();
    obj.testConstantsScaleEncodingDecoding();
    obj.testEventsScaleEncodingDecoding();
  });

  group('Chain: altair', () {
    var obj = Chain('altair');
    obj.testExtrinsicsScaleEncodingDecoding();
    obj.testConstantsScaleEncodingDecoding();
    obj.testEventsScaleEncodingDecoding();
  });
  group('Chain: astar', () {
    var obj = Chain('astar');
    obj.testExtrinsicsScaleEncodingDecoding();
    obj.testConstantsScaleEncodingDecoding();
    obj.testEventsScaleEncodingDecoding();
  });

  group('Chain: basilisk', () {
    var obj = Chain('basilisk');
    obj.testExtrinsicsScaleEncodingDecoding();
    obj.testConstantsScaleEncodingDecoding();
    obj.testEventsScaleEncodingDecoding();
  });

  group('Chain: bifrost', () {
    var obj = Chain('bifrost');
    obj.testExtrinsicsScaleEncodingDecoding();
    obj.testConstantsScaleEncodingDecoding();
    obj.testEventsScaleEncodingDecoding();
  });

  group('Chain: calamari', () {
    var obj = Chain('calamari');
    obj.testExtrinsicsScaleEncodingDecoding();
    obj.testConstantsScaleEncodingDecoding();
    obj.testEventsScaleEncodingDecoding();
  });

  group('Chain: clover', () {
    var obj = Chain('clover');
    obj.testExtrinsicsScaleEncodingDecoding();
    obj.testConstantsScaleEncodingDecoding();
    obj.testEventsScaleEncodingDecoding();
  });

  group('Chain: crust', () {
    var obj = Chain('crust');
    obj.testExtrinsicsScaleEncodingDecoding();
    obj.testConstantsScaleEncodingDecoding();
    obj.testEventsScaleEncodingDecoding();
  });

  group('Chain: darwinia', () {
    var obj = Chain('darwinia');
    obj.testExtrinsicsScaleEncodingDecoding();
    obj.testConstantsScaleEncodingDecoding();
    obj.testEventsScaleEncodingDecoding();
  });

  group('Chain: heiko', () {
    var obj = Chain('heiko');
    obj.testExtrinsicsScaleEncodingDecoding();
    obj.testConstantsScaleEncodingDecoding();
    obj.testEventsScaleEncodingDecoding();
  });

  group('Chain: hydradx', () {
    var obj = Chain('hydradx');
    obj.testExtrinsicsScaleEncodingDecoding();
    obj.testConstantsScaleEncodingDecoding();
    obj.testEventsScaleEncodingDecoding();
  });

  group('Chain: karura', () {
    var obj = Chain('karura');
    obj.testExtrinsicsScaleEncodingDecoding();
    obj.testConstantsScaleEncodingDecoding();
    obj.testEventsScaleEncodingDecoding();
  });

  group('Chain: khala', () {
    var obj = Chain('khala');
    obj.testExtrinsicsScaleEncodingDecoding();
    obj.testConstantsScaleEncodingDecoding();
    obj.testEventsScaleEncodingDecoding();
  });

  group('Chain: kilt', () {
    var obj = Chain('kilt');
    obj.testExtrinsicsScaleEncodingDecoding();
    obj.testConstantsScaleEncodingDecoding();
    obj.testEventsScaleEncodingDecoding();
  });

  group('Chain: kintsugi', () {
    var obj = Chain('kintsugi');
    obj.testExtrinsicsScaleEncodingDecoding();
    obj.testConstantsScaleEncodingDecoding();
    obj.testEventsScaleEncodingDecoding();
  });

  group('Chain: kusama', () {
    var obj = Chain('kusama');

    /// FIXME byte error
    /// obj.testExtrinsicsScaleEncodingDecoding();
    obj.testConstantsScaleEncodingDecoding();
    obj.testEventsScaleEncodingDecoding();
  });

  group('Chain: moonriver', () {
    var obj = Chain('moonriver');
    obj.testExtrinsicsScaleEncodingDecoding();
    obj.testConstantsScaleEncodingDecoding();
    obj.testEventsScaleEncodingDecoding();
  });

  group('Chain: parallel', () {
    var obj = Chain('parallel');
    obj.testExtrinsicsScaleEncodingDecoding();
    obj.testConstantsScaleEncodingDecoding();
    obj.testEventsScaleEncodingDecoding();
  });

  group('Chain: pioneer', () {
    var obj = Chain('pioneer');
    obj.testExtrinsicsScaleEncodingDecoding();
    obj.testConstantsScaleEncodingDecoding();
    obj.testEventsScaleEncodingDecoding();
  });

  group('Chain: polkadot', () {
    var obj = Chain('polkadot');

    /// FIXME byte error
    //obj.testExtrinsicsScaleEncodingDecoding();
    obj.testConstantsScaleEncodingDecoding();
    obj.testEventsScaleEncodingDecoding();
  });

  group('Chain: quartz', () {
    var obj = Chain('quartz');
    obj.testExtrinsicsScaleEncodingDecoding();
    obj.testConstantsScaleEncodingDecoding();
    obj.testEventsScaleEncodingDecoding();
  });

  group('Chain: shibuya', () {
    var obj = Chain('shibuya');
    obj.testExtrinsicsScaleEncodingDecoding();
    obj.testConstantsScaleEncodingDecoding();
    obj.testEventsScaleEncodingDecoding();
  });

  group('Chain: shiden', () {
    var obj = Chain('shiden');
    obj.testExtrinsicsScaleEncodingDecoding();
    obj.testConstantsScaleEncodingDecoding();
    obj.testEventsScaleEncodingDecoding();
  });

  group('Chain: statemine', () {
    var obj = Chain('statemine');
    obj.testExtrinsicsScaleEncodingDecoding();
    obj.testConstantsScaleEncodingDecoding();
    obj.testEventsScaleEncodingDecoding();
  });

  group('Chain: statemint', () {
    var obj = Chain('statemint');
    obj.testExtrinsicsScaleEncodingDecoding();
    obj.testConstantsScaleEncodingDecoding();
    obj.testEventsScaleEncodingDecoding();
  });

  /// TODO: Resolve Conflicts of this chain: `subsocial` at
  ///
  /// description.specversion: `1`,
  /// pallet: `Scores`
  /// name: `CommentVoteDownAction`
  ///
  /// group('Chain: subsocial', () {
  ///  var obj = Chain('subsocial');
  /// obj.testExtrinsicsScaleEncodingDecoding();
  /// obj.testConstantsScaleEncodingDecoding();
  ///  obj.testEventsScaleEncodingDecoding();
  ///});
}
