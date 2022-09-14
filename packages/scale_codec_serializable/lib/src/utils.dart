import 'package:analyzer/dart/element/type.dart';

/// Return the Dart code presentation for the given [type].
///
/// This function is intentionally limited, and does not support all possible
/// types and locations of these files in code. Specifically, it supports
/// only [InterfaceType]s, with optional type arguments that are also should
/// be [InterfaceType]s.
String typeToCode(
  DartType type, {
  bool forceNullable = false,
}) {
  if (type.isDynamic) {
    return 'dynamic';
  } else if (type is InterfaceType) {
    return [
      type.element2.name,
      if (type.typeArguments.isNotEmpty)
        '<${type.typeArguments.map(typeToCode).join(', ')}>',
      (type.isDartCoreNull || forceNullable) ? '?' : '',
    ].join();
  }

  if (type is TypeParameterType) {
    return type.getDisplayString(withNullability: false);
  }
  throw UnimplementedError('(${type.runtimeType}) $type');
}
