import 'package:test/test.dart';

import 'src/chain.dart';

void main() {
  group('Chain: kusama', () {
    var obj = Chain('kusama');

    /// FIXME byte error
    /// obj.testExtrinsicsScaleEncodingDecoding();
    obj.testConstantsScaleEncodingDecoding();
    obj.testEventsScaleEncodingDecoding();
  });
}
