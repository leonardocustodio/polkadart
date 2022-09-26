import 'package:test/test.dart';

import 'src/chain.dart';

void main() {
  group('Chain: astar', () {
    var obj = Chain('astar');
    obj.testExtrinsicsScaleEncodingDecoding();
    obj.testConstantsScaleEncodingDecoding();
    obj.testEventsScaleEncodingDecoding();
  });
}
