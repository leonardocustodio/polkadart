part of metadata;

/// Variants of type definitions
///
/// Represents the different kinds of types that can exist in the type system.
/// This is a sealed class hierarchy for type-safe pattern matching.
sealed class TypeDef {
  /// Codec instance for TypeDef
  static const $TypeDef codec = $TypeDef._();
  const TypeDef();

  Set<int> typeDependencies();
  Map<String, dynamic> toJson();
}

/// Codec for TypeDef
///
/// Handles encoding and decoding of the different type definition variants.
/// Uses an enum-style encoding with an index byte followed by variant data.
class $TypeDef with Codec<TypeDef> {
  const $TypeDef._();

  @override
  TypeDef decode(Input input) {
    final index = input.read();

    switch (index) {
      case 0: // Composite
        return $TypeDefComposite._().decode(input);

      case 1: // Variant
        return $TypeDefVariant._().decode(input);

      case 2: // Sequence
        return $TypeDefSequence._().decode(input);

      case 3: // Array
        return $TypeDefArray._().decode(input);

      case 4: // Tuple
        return $TypeDefTuple._().decode(input);

      case 5: // Primitive
        return $TypeDefPrimitive._().decode(input);

      case 6: // Compact
        return $TypeDefCompact._().decode(input);

      case 7: // BitSequence
        return $TypeDefBitSequence._().decode(input);

      default:
        throw Exception('Unknown TypeDefVariant index: $index');
    }
  }

  @override
  void encodeTo(TypeDef value, Output output) {
    switch (value) {
      case final TypeDefComposite typeDefComposite:
        U8Codec.codec.encodeTo(0, output);
        $TypeDefComposite._().encodeTo(typeDefComposite, output);
        return;

      case final TypeDefVariant typeDefVariant:
        U8Codec.codec.encodeTo(1, output);
        $TypeDefVariant._().encodeTo(typeDefVariant, output);
        break;

      case final TypeDefSequence typeDefSequence:
        U8Codec.codec.encodeTo(2, output);
        $TypeDefSequence._().encodeTo(typeDefSequence, output);
        break;

      case final TypeDefArray typeDefArray:
        U8Codec.codec.encodeTo(3, output);
        $TypeDefArray._().encodeTo(typeDefArray, output);
        break;

      case final TypeDefTuple typeDefTuple:
        U8Codec.codec.encodeTo(4, output);
        $TypeDefTuple._().encodeTo(typeDefTuple, output);
        break;

      case final TypeDefPrimitive typeDefPrimitive:
        U8Codec.codec.encodeTo(5, output);
        $TypeDefPrimitive._().encodeTo(typeDefPrimitive, output);
        break;

      case final TypeDefCompact typeDefCompact:
        U8Codec.codec.encodeTo(6, output);
        $TypeDefCompact._().encodeTo(typeDefCompact, output);
        break;

      case final TypeDefBitSequence typeDefBitSequence:
        U8Codec.codec.encodeTo(7, output);
        $TypeDefBitSequence._().encodeTo(typeDefBitSequence, output);
        break;
    }
  }

  @override
  int sizeHint(TypeDef value) {
    int size = 1;

    switch (value) {
      case final TypeDefComposite typeDefComposite:
        size += $TypeDefComposite._().sizeHint(typeDefComposite);

      case final TypeDefVariant typeDefVariant:
        size += $TypeDefVariant._().sizeHint(typeDefVariant);

      case final TypeDefSequence typeDefSequence:
        size += $TypeDefSequence._().sizeHint(typeDefSequence);

      case final TypeDefArray typeDefArray:
        size += $TypeDefArray._().sizeHint(typeDefArray);

      case final TypeDefTuple typeDefTuple:
        size += $TypeDefTuple._().sizeHint(typeDefTuple);

      case final TypeDefPrimitive typeDefPrimitive:
        size += $TypeDefPrimitive._().sizeHint(typeDefPrimitive);

      case final TypeDefCompact typeDefCompact:
        size += $TypeDefCompact._().sizeHint(typeDefCompact);

      case final TypeDefBitSequence typeDefBitSequence:
        size += $TypeDefBitSequence._().sizeHint(typeDefBitSequence);
    }

    return size;
  }

  @override
  bool isSizeZero() => false; // Always encodes variant index byte
}
