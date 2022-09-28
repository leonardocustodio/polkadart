import 'package:test/test.dart';

import 'src/chain.dart';

void main() {
  group('Chain: bifrost', () {
    var obj = Chain('bifrost');
    obj.testExtrinsicsScaleEncodingDecoding();
    obj.testConstantsScaleEncodingDecoding();
    obj.testEventsScaleEncodingDecoding();
  });
}
