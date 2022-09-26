import 'package:test/test.dart';

import 'src/chain.dart';

void main() {
  group('Chain: khala', () {
    var obj = Chain('khala');
    obj.testExtrinsicsScaleEncodingDecoding();
    obj.testConstantsScaleEncodingDecoding();
    obj.testEventsScaleEncodingDecoding();
  });
}
