import 'package:test/test.dart';

import 'src/chain.dart';

void main() {
  group('Chain: shiden', () {
    var obj = Chain('shiden');
    obj.testExtrinsicsScaleEncodingDecoding();
    obj.testConstantsScaleEncodingDecoding();
    obj.testEventsScaleEncodingDecoding();
  });
}
