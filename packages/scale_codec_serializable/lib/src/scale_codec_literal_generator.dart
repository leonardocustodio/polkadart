import 'package:source_helper/source_helper.dart';

/// Returns a [String] representing a valid Dart literal for [value].
String scaleCodecLiteralAsDart(Object? value) {
  if (value == null) return 'null';

  if (value is String) return escapeDartString(value);

  if (value is double) {
    if (value.isNaN) {
      return 'double.nan';
    }

    if (value.isInfinite) {
      if (value.isNegative) {
        return 'double.negativeInfinity';
      }
      return 'double.infinity';
    }
  }

  if (value is bool || value is num) return value.toString();

  if (value is List) {
    final listItems = value.map(scaleCodecLiteralAsDart).join(', ');
    return '[$listItems]';
  }

  if (value is Set) {
    final listItems = value.map(scaleCodecLiteralAsDart).join(', ');
    return '{$listItems}';
  }

  if (value is Map) return scaleCodecMapAsDart(value);

  throw StateError(
    'Should never get here – with ${value.runtimeType} - `$value`.',
  );
}

String scaleCodecMapAsDart(Map value) {
  final buffer = StringBuffer()..write('{');

  var first = true;
  value.forEach((k, v) {
    if (first) {
      first = false;
    } else {
      buffer.writeln(',');
    }
    buffer
      ..write(escapeDartString(k as String))
      ..write(': ')
      ..write(scaleCodecLiteralAsDart(v));
  });

  buffer.write('}');

  return buffer.toString();
}
