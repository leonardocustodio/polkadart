import 'package:test/test.dart';

import 'src/chain.dart';

void main() {
  group('Chain: altair', () {
    var obj = Chain('altair');
    obj.testExtrinsicsScaleEncodingDecoding();
    obj.testConstantsScaleEncodingDecoding();
    obj.testEventsScaleEncodingDecoding();
  });
}
