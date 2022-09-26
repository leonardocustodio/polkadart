import 'package:test/test.dart';

import 'src/chain.dart';

void main() {
  group('Chain: hydradx', () {
    var obj = Chain('hydradx');
    obj.testExtrinsicsScaleEncodingDecoding();
    obj.testConstantsScaleEncodingDecoding();
    obj.testEventsScaleEncodingDecoding();
  });
}
