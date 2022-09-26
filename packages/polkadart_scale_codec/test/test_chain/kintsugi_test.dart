import 'package:test/test.dart';

import 'src/chain.dart';

void main() {
  group('Chain: kintsugi', () {
    var obj = Chain('kintsugi');
    obj.testExtrinsicsScaleEncodingDecoding();
    obj.testConstantsScaleEncodingDecoding();
    obj.testEventsScaleEncodingDecoding();
  });
}
