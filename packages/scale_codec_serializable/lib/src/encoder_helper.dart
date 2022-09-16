import 'package:analyzer/dart/element/element.dart';
import 'helper_core.dart';

abstract class EncoderHelper implements HelperCore {
  /// Write encode method implementation as example above:
  ///
  /// ```dart
  ///   // ...
  ///   String encode() => "";
  ///   // ...
  /// ```
  Iterable<String> createEncode(
      Map<String, FieldElement> accessibleFields) sync* {
    assert(config.shouldCreateEncodeMethod);

    //TODO: encode complete implementation
    final buffer = StringBuffer()..writeln("String encode() => '';");

    yield buffer.toString();
  }
}
