import 'package:analyzer/dart/element/element.dart';

import 'helper_core.dart';

abstract class DecodeHelper implements HelperCore {
  Iterable<String> createDecode(Set<FieldElement> accessibleFields) sync* {
    assert(config.createEncodeMethod);

    yield '// create encode method';
  }
}
