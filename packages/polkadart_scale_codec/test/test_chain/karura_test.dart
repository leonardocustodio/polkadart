import 'package:test/test.dart';

import 'src/chain.dart';

void main() {
  group('Chain: karura', () {
    var obj = Chain('karura');
    obj.testExtrinsicsScaleEncodingDecoding();
    obj.testConstantsScaleEncodingDecoding();
    obj.testEventsScaleEncodingDecoding();
  });
}
