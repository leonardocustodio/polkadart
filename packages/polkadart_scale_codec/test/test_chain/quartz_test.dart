import 'package:test/test.dart';

import 'src/chain.dart';

void main() {
  group('Chain: quartz', () {
    var obj = Chain('quartz');
    obj.testExtrinsicsScaleEncodingDecoding();
    obj.testConstantsScaleEncodingDecoding();
    obj.testEventsScaleEncodingDecoding();
  });
}
