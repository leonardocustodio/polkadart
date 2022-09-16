import 'package:analyzer/dart/element/element.dart';
import 'package:scale_codec_serializable/src/helper_core.dart';

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

    final buffer = StringBuffer();

    //TODO: encode complete implementation
    buffer.writeln('String encode() => "";');

    yield buffer.toString();
  }
}
