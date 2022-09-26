import 'package:test/test.dart';

import 'src/chain.dart';

void main() {
  group('Chain: heiko', () {
    var obj = Chain('heiko');
    obj.testExtrinsicsScaleEncodingDecoding();
    obj.testConstantsScaleEncodingDecoding();
    obj.testEventsScaleEncodingDecoding();
  });
}
