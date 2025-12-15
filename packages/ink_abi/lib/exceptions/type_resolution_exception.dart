part of ink_abi;

/// Exception thrown when a type cannot be resolved from the metadata
///
/// This occurs when:
/// - A type ID is not found in the registry
/// - A type path doesn't match any known types
/// - Type conversion fails during resolution
class TypeResolutionException extends InkAbiException {
  /// The type ID that failed to resolve (if applicable)
  final int? typeId;

  /// The type path that failed to resolve (if applicable)
  final String? typePath;

  const TypeResolutionException(super.message, {this.typeId, this.typePath, super.context});

  /// Create exception for missing type ID
  factory TypeResolutionException.typeNotFound(int typeId) {
    return TypeResolutionException('Type with ID $typeId not found in metadata', typeId: typeId);
  }

  /// Create exception for missing type path
  factory TypeResolutionException.pathNotFound(String path) {
    return TypeResolutionException('Type with path "$path" not found in metadata', typePath: path);
  }

  /// Create exception for invalid type definition
  factory TypeResolutionException.invalidTypeDef(int typeId, String reason) {
    return TypeResolutionException(
      'Invalid type definition for type $typeId: $reason',
      typeId: typeId,
    );
  }

  @override
  String toString() {
    final parts = <String>['TypeResolutionException: $message'];

    if (typeId != null) {
      parts.add('typeId: $typeId');
    }
    if (typePath != null) {
      parts.add('typePath: $typePath');
    }
    if (context != null && context!.isNotEmpty) {
      parts.add('context: $context');
    }

    return parts.join(', ');
  }
}
