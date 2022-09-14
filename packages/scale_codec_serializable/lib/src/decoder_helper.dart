import 'package:analyzer/dart/element/element.dart';

import 'helper_core.dart';

abstract class DecodeHelper implements HelperCore {
  /// Write decode method implementation as example above:
  ///
  /// ```dart
  ///   // ...
  ///   Example decode(String encodedData) =>
  ///     Example();
  ///   // ...
  /// ```
  Iterable<String> createDecode(Set<FieldElement> accessibleFields) sync* {
    assert(config.createDecodeMethod);

    final buffer = StringBuffer();

    buffer.writeln('//TODO: decode method implementation');
    buffer.writeln(
        '$targetClassReference decode(String encodedData) => $targetClassReference();');

    yield buffer.toString();
  }
}
