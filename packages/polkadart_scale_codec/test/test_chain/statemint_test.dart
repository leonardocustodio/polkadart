import 'package:test/test.dart';

import 'src/chain.dart';

void main() {
  group('Chain: statemint', () {
    var obj = Chain('statemint');
    obj.testExtrinsicsScaleEncodingDecoding();
    obj.testConstantsScaleEncodingDecoding();
    obj.testEventsScaleEncodingDecoding();
  });
}
