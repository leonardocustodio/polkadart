import 'package:test/test.dart';

import 'src/chain.dart';

void main() {
  group('Chain: calamari', () {
    var obj = Chain('calamari');
    obj.testExtrinsicsScaleEncodingDecoding();
    obj.testConstantsScaleEncodingDecoding();
    obj.testEventsScaleEncodingDecoding();
  });
}
