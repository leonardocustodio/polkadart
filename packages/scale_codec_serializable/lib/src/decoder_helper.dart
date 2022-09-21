import 'package:analyzer/dart/element/element.dart';

abstract class DecodeHelper {
  /// Write decode method implementation as example above:
  ///
  /// ```dart
  ///   // ...
  ///   Example decode(String encodedData) =>
  ///     Example();
  ///   // ...
  /// ```
  Iterable<String> createDecode(
      Map<String, FieldElement> accessibleFields) sync* {
    //TODO: write decode complete implementation

    final buffer = StringBuffer()..writeln(' decode(String encodedData) => ');

    _writeDefaultConstructor(buffer, accessibleFields);

    yield buffer.toString();
  }

  void _writeDefaultConstructor(
      StringBuffer stringBuffer, Map<String, FieldElement> fields) {
    stringBuffer.write('(');

    for (var field in fields.keys) {
      final fieldName = field.replaceFirst('_', '');
      stringBuffer.write('$fieldName, ');
    }

    stringBuffer.writeln(');');
  }
}
