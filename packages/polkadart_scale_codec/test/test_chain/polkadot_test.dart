import 'package:test/test.dart';

import 'src/chain.dart';

void main() {
  group('Chain: polkadot', () {
    var obj = Chain('polkadot');

    /// FIXME byte error
    //obj.testExtrinsicsScaleEncodingDecoding();
    obj.testConstantsScaleEncodingDecoding();
    obj.testEventsScaleEncodingDecoding();
  });
}
