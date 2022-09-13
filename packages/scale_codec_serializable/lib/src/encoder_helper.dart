import 'package:analyzer/dart/element/element.dart';
import 'package:scale_codec_serializable/src/helper_core.dart';

abstract class EncoderHelper implements HelperCore {
  Iterable<String> createEncode(Set<FieldElement> accessibleFields) sync* {
    assert(config.createEncodeMethod);

    yield '// create decode method';
  }
}
