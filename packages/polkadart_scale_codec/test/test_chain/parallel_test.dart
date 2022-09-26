import 'package:test/test.dart';

import 'src/chain.dart';

void main() {
  group('Chain: parallel', () {
    var obj = Chain('parallel');
    obj.testExtrinsicsScaleEncodingDecoding();
    obj.testConstantsScaleEncodingDecoding();
    obj.testEventsScaleEncodingDecoding();
  });
}
