import 'package:analyzer/dart/element/element.dart';

abstract class EncoderHelper {
  /// Write encode method implementation as example above:
  ///
  /// ```dart
  ///   // ...
  ///   String encode() => "";
  ///   // ...
  /// ```
  Iterable<String> createEncode(
      Map<String, FieldElement> accessibleFields) sync* {
    //TODO: encode complete implementation
    final buffer = StringBuffer()..writeln("String encode() => '';");

    yield buffer.toString();
  }
}
