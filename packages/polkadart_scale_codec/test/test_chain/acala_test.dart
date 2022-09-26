import 'package:test/test.dart';
import 'src/chain.dart';

void main() {
  group('Chain: acala', () {
    var obj = Chain('acala');
    obj.testExtrinsicsScaleEncodingDecoding();
    obj.testConstantsScaleEncodingDecoding();
    obj.testEventsScaleEncodingDecoding();
  });
}
