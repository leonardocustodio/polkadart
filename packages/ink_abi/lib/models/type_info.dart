import 'package:substrate_metadata/substrate_metadata.dart';

/// Type information helper class
///
/// Provides detailed information about a type in the portable registry,
/// including its path, type definition, documentation, and convenience
/// methods for type checking.
class TypeInfo {
  /// Type ID
  final int id;

  /// Type path (e.g., ['core', 'option', 'Option'])
  final List<String> path;

  /// Type definition (primitive, composite, variant, etc.)
  final TypeDef typeDef;

  /// Documentation for this type
  final List<String> docs;

  const TypeInfo({
    required this.id,
    required this.path,
    required this.typeDef,
    required this.docs,
  });

  /// Get path as string (e.g., 'core::option::Option')
  String get pathString => path.join('::');

  /// Check if type is a primitive (u8, u32, bool, etc.)
  bool get isPrimitive => typeDef is TypeDefPrimitive;

  /// Check if type is a composite (struct)
  bool get isComposite => typeDef is TypeDefComposite;

  /// Check if type is a variant (enum)
  bool get isVariant => typeDef is TypeDefVariant;

  /// Check if type is a sequence (`Vec<T>`)
  bool get isSequence => typeDef is TypeDefSequence;

  /// Check if type is an array ([T; N])
  bool get isArray => typeDef is TypeDefArray;

  /// Check if type is a tuple ((T1, T2, ...))
  bool get isTuple => typeDef is TypeDefTuple;

  /// Check if type is compact encoded
  bool get isCompact => typeDef is TypeDefCompact;

  @override
  String toString() {
    return 'TypeInfo(id: $id, path: $pathString, isPrimitive: $isPrimitive, '
        'isComposite: $isComposite, isVariant: $isVariant)';
  }
}
