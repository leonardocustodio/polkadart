part of scale_info;

abstract class TypeDef {
  const TypeDef();

  Set<int> typeDependencies();

  static const $TypeDefCodec codec = $TypeDefCodec._();

  Map<String, dynamic> toJson();
}

class $TypeDefCodec implements Codec<TypeDef> {
  const $TypeDefCodec._();

  @override
  TypeDef decode(Input input) {
    final index = U8Codec.codec.decode(input);
    switch (index) {
      case 0:
        {
          return $TypeDefCompositeCodec._().decode(input);
        }

      case 1:
        {
          return $TypeDefVariantCodec._().decode(input);
        }

      case 2:
        {
          return $TypeDefSequenceCodec._().decode(input);
        }

      case 3:
        {
          return $TypeDefArrayCodec._().decode(input);
        }
      case 4:
        {
          return $TypeDefTupleCodec._().decode(input);
        }
      case 5:
        {
          return $TypeDefPrimitiveCodec._().decode(input);
        }
      case 6:
        {
          return $TypeDefCompactCodec._().decode(input);
        }
      case 7:
        {
          return $TypeDefBitSequenceCodec._().decode(input);
        }
      default:
        throw Exception('Unknown type definition variant $index');
    }
  }

  @override
  Uint8List encode(TypeDef typeDef) {
    final output = ByteOutput(sizeHint(typeDef));
    encodeTo(typeDef, output);
    return output.toBytes(copy: false);
  }

  @override
  void encodeTo(TypeDef value, Output output) {
    switch (value.runtimeType) {
      case TypeDefComposite:
        {
          U8Codec.codec.encodeTo(0, output);
          $TypeDefCompositeCodec
              ._()
              .encodeTo(value as TypeDefComposite, output);
          break;
        }
      case TypeDefVariant:
        {
          U8Codec.codec.encodeTo(1, output);
          $TypeDefVariantCodec._().encodeTo(value as TypeDefVariant, output);
          break;
        }
      case TypeDefSequence:
        {
          U8Codec.codec.encodeTo(2, output);
          $TypeDefSequenceCodec._().encodeTo(value as TypeDefSequence, output);
          break;
        }
      case TypeDefArray:
        {
          U8Codec.codec.encodeTo(3, output);
          $TypeDefArrayCodec._().encodeTo(value as TypeDefArray, output);
          break;
        }
      case TypeDefTuple:
        {
          U8Codec.codec.encodeTo(4, output);
          $TypeDefTupleCodec._().encodeTo(value as TypeDefTuple, output);
          break;
        }
      case TypeDefPrimitive:
        {
          U8Codec.codec.encodeTo(5, output);
          $TypeDefPrimitiveCodec
              ._()
              .encodeTo(value as TypeDefPrimitive, output);
          break;
        }
      case TypeDefCompact:
        {
          U8Codec.codec.encodeTo(6, output);
          $TypeDefCompactCodec._().encodeTo(value as TypeDefCompact, output);
          break;
        }
      case TypeDefBitSequence:
        {
          U8Codec.codec.encodeTo(7, output);
          $TypeDefBitSequenceCodec
              ._()
              .encodeTo(value as TypeDefBitSequence, output);
          break;
        }
      default:
        throw Exception(
            'Unknown type definition runtime type ${value.runtimeType}');
    }
  }

  @override
  int sizeHint(TypeDef value) {
    switch (value.runtimeType) {
      case TypeDefComposite:
        return $TypeDefCompositeCodec._().sizeHint(value as TypeDefComposite) +
            1;
      case TypeDefVariant:
        return $TypeDefVariantCodec._().sizeHint(value as TypeDefVariant) + 1;
      case TypeDefSequence:
        return $TypeDefSequenceCodec._().sizeHint(value as TypeDefSequence) + 1;
      case TypeDefArray:
        return $TypeDefArrayCodec._().sizeHint(value as TypeDefArray) + 1;
      case TypeDefTuple:
        return $TypeDefTupleCodec._().sizeHint(value as TypeDefTuple) + 1;
      case TypeDefPrimitive:
        return $TypeDefPrimitiveCodec._().sizeHint(value as TypeDefPrimitive) +
            1;
      case TypeDefCompact:
        return $TypeDefCompactCodec._().sizeHint(value as TypeDefCompact) + 1;
      case TypeDefBitSequence:
        return $TypeDefBitSequenceCodec
                ._()
                .sizeHint(value as TypeDefBitSequence) +
            1;
      default:
        throw Exception('Unknown type definition variant $value');
    }
  }
}

/// A composite type, consisting of either named (struct) or unnamed (tuple
/// struct) fields
class TypeDefComposite extends TypeDef {
  /// The fields of the composite type.
  final List<Field> fields;

  static const $TypeDefCodec codec = TypeDef.codec;

  /// Creates a new struct definition with named fields.
  const TypeDefComposite({required this.fields});

  @override
  Set<int> typeDependencies() {
    return fields.map((field) => field.type).toSet();
  }

  @override
  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{};
    if (fields.isNotEmpty) {
      json['fields'] = fields.map((e) => e.toJson()).toList();
    }
    return json;
  }
}

class $TypeDefCompositeCodec implements Codec<TypeDefComposite> {
  const $TypeDefCompositeCodec._();

  @override
  TypeDefComposite decode(Input input) {
    final fields = SequenceCodec(Field.codec).decode(input);
    return TypeDefComposite(fields: fields);
  }

  @override
  Uint8List encode(TypeDefComposite value) {
    final output = ByteOutput(sizeHint(value));
    encodeTo(value, output);
    return output.toBytes(copy: false);
  }

  @override
  void encodeTo(TypeDefComposite value, Output output) {
    SequenceCodec(Field.codec).encodeTo(value.fields, output);
    print('After seq: ${(output as ByteOutput).toBytes()}');
  }

  @override
  int sizeHint(TypeDefComposite value) {
    return SequenceCodec(Field.codec).sizeHint(value.fields);
  }
}

/// A Enum type (consisting of variants).
class TypeDefVariant extends TypeDef {
  /// The variants of a variant type
  final List<Variant> variants;

  /// Create a new `TypeDefVariant` with the given variants
  const TypeDefVariant({required this.variants});

  static const $TypeDefCodec codec = TypeDef.codec;

  @override
  Set<int> typeDependencies() {
    final Set<int> dependencies = {};
    for (final variant in variants) {
      dependencies.addAll(variant.typeDependencies());
    }
    return dependencies;
  }

  @override
  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{};
    if (variants.isNotEmpty) {
      json['variants'] = variants.map((e) => e.toJson()).toList();
    }
    return json;
  }
}

class $TypeDefVariantCodec implements Codec<TypeDefVariant> {
  const $TypeDefVariantCodec._();

  @override
  TypeDefVariant decode(Input input) {
    final variants = SequenceCodec(Variant.codec).decode(input);
    return TypeDefVariant(variants: variants);
  }

  @override
  Uint8List encode(TypeDefVariant typeDef) {
    final output = ByteOutput(sizeHint(typeDef));
    encodeTo(typeDef, output);
    return output.toBytes(copy: false);
  }

  @override
  void encodeTo(TypeDefVariant typeDef, Output output) {
    SequenceCodec(Variant.codec).encodeTo(typeDef.variants, output);
  }

  @override
  int sizeHint(TypeDefVariant typeDef) {
    return SequenceCodec(Variant.codec).sizeHint(typeDef.variants);
  }
}

/// A type to refer to a sequence of elements of the same type.
class TypeDefSequence extends TypeDef {
  /// The element type of the sequence type.
  final TypeId type;

  /// Creates a new sequence type.
  const TypeDefSequence({required this.type});

  static const $TypeDefCodec codec = TypeDef.codec;

  @override
  Set<int> typeDependencies() {
    return {type};
  }

  @override
  Map<String, dynamic> toJson() => {'type': type};
}

class $TypeDefSequenceCodec implements Codec<TypeDefSequence> {
  const $TypeDefSequenceCodec._();

  @override
  TypeDefSequence decode(Input input) {
    final type = TypeIdCodec.codec.decode(input);
    return TypeDefSequence(type: type);
  }

  @override
  Uint8List encode(TypeDefSequence typeDef) {
    final output = ByteOutput(sizeHint(typeDef));
    encodeTo(typeDef, output);
    return output.toBytes(copy: false);
  }

  @override
  void encodeTo(TypeDefSequence typeDef, Output output) {
    TypeIdCodec.codec.encodeTo(typeDef.type, output);
  }

  @override
  int sizeHint(TypeDefSequence typeDef) {
    return TypeIdCodec.codec.sizeHint(typeDef.type);
  }
}

/// An array type.
class TypeDefArray extends TypeDef {
  /// The length of the array type.
  final int length;

  /// The element type of the array type.
  final TypeId type;

  static const $TypeDefCodec codec = TypeDef.codec;

  /// Creates a new array type.
  const TypeDefArray({required this.type, required this.length});

  @override
  Set<int> typeDependencies() {
    return {type};
  }

  @override
  Map<String, int> toJson() => {
        'len': length,
        'type': type,
      };
}

class $TypeDefArrayCodec implements Codec<TypeDefArray> {
  const $TypeDefArrayCodec._();

  @override
  TypeDefArray decode(Input input) {
    final length = U32Codec.codec.decode(input);
    final type = TypeIdCodec.codec.decode(input);
    return TypeDefArray(length: length, type: type);
  }

  @override
  Uint8List encode(TypeDefArray typeDef) {
    final output = ByteOutput(sizeHint(typeDef));
    encodeTo(typeDef, output);
    return output.toBytes(copy: false);
  }

  @override
  void encodeTo(TypeDefArray typeDef, Output output) {
    U32Codec.codec.encodeTo(typeDef.length, output);
    TypeIdCodec.codec.encodeTo(typeDef.type, output);
  }

  @override
  int sizeHint(TypeDefArray typeDef) {
    int size = U32Codec.codec.sizeHint(typeDef.length);
    size += TypeIdCodec.codec.sizeHint(typeDef.type);
    return size;
  }
}

/// A type wrapped in [`Compact`].
class TypeDefCompact extends TypeDef {
  /// The element type of the compact type.
  final int type;

  static const $TypeDefCodec codec = TypeDef.codec;

  /// Creates a new compact type.
  const TypeDefCompact({required this.type});

  @override
  Set<int> typeDependencies() {
    return {type};
  }

  @override
  Map<String, int> toJson() => {
        'type': type,
      };
}

class $TypeDefCompactCodec implements Codec<TypeDefCompact> {
  const $TypeDefCompactCodec._();

  @override
  TypeDefCompact decode(Input input) {
    final type = TypeIdCodec.codec.decode(input);
    return TypeDefCompact(type: type);
  }

  @override
  Uint8List encode(TypeDefCompact typeDef) {
    final output = ByteOutput(sizeHint(typeDef));
    encodeTo(typeDef, output);
    return output.toBytes(copy: false);
  }

  @override
  void encodeTo(TypeDefCompact typeDef, Output output) {
    TypeIdCodec.codec.encodeTo(typeDef.type, output);
  }

  @override
  int sizeHint(TypeDefCompact typeDef) {
    return TypeIdCodec.codec.sizeHint(typeDef.type);
  }
}

/// A type to refer to tuple types.
class TypeDefTuple extends TypeDef {
  /// The element type of the compact type.
  final List<TypeId> fields;

  static const $TypeDefCodec codec = TypeDef.codec;

  /// Creates a new compact type.
  const TypeDefTuple(this.fields);

  @override
  Set<int> typeDependencies() {
    return fields.toSet();
  }

  @override
  Map<String, List<int>> toJson() => {
        'fields': fields,
      };
}

class $TypeDefTupleCodec implements Codec<TypeDefTuple> {
  const $TypeDefTupleCodec._();

  @override
  TypeDefTuple decode(Input input) {
    final fields = SequenceCodec(TypeIdCodec.codec).decode(input);
    return TypeDefTuple(fields);
  }

  @override
  Uint8List encode(TypeDefTuple typeDef) {
    final output = ByteOutput(sizeHint(typeDef));
    encodeTo(typeDef, output);
    return output.toBytes(copy: false);
  }

  @override
  void encodeTo(TypeDefTuple typeDef, Output output) {
    SequenceCodec(TypeIdCodec.codec).encodeTo(typeDef.fields, output);
  }

  @override
  int sizeHint(TypeDefTuple typeDef) {
    return SequenceCodec(TypeIdCodec.codec).sizeHint(typeDef.fields);
  }
}

enum Primitive {
  Bool,
  Char,
  Str,
  U8,
  U16,
  U32,
  U64,
  U128,
  U256,
  I8,
  I16,
  I32,
  I64,
  I128,
  I256;

  static const $PrimitiveCodec codec = $PrimitiveCodec._();

  /// Creates a new compact type.
  const Primitive();
}

class $PrimitiveCodec implements Codec<Primitive> {
  const $PrimitiveCodec._();

  @override
  Primitive decode(Input input) {
    final index = U8Codec.codec.decode(input);
    switch (index) {
      case 0:
        return Primitive.Bool;
      case 1:
        return Primitive.Char;
      case 2:
        return Primitive.Str;
      case 3:
        return Primitive.U8;
      case 4:
        return Primitive.U16;
      case 5:
        return Primitive.U32;
      case 6:
        return Primitive.U64;
      case 7:
        return Primitive.U128;
      case 8:
        return Primitive.U256;
      case 9:
        return Primitive.I8;
      case 10:
        return Primitive.I16;
      case 11:
        return Primitive.I32;
      case 12:
        return Primitive.I64;
      case 13:
        return Primitive.I128;
      case 14:
        return Primitive.I256;
      default:
        throw Exception('Unknown primitive type $index');
    }
  }

  @override
  Uint8List encode(Primitive primitive) {
    final output = ByteOutput(sizeHint(primitive));
    encodeTo(primitive, output);
    return output.toBytes(copy: false);
  }

  @override
  void encodeTo(Primitive primitive, Output output) {
    U8Codec.codec.encodeTo(primitive.index, output);
  }

  @override
  int sizeHint(Primitive primitive) {
    return U8Codec.codec.sizeHint(primitive.index);
  }
}

/// A primitive Rust type.
class TypeDefPrimitive extends TypeDef {
  /// The primitive type.
  final Primitive primitive;

  /// Creates a new primitive type.
  const TypeDefPrimitive(this.primitive);

  static const $TypeDefCodec codec = TypeDef.codec;

  factory TypeDefPrimitive.fromString(String primitive) {
    switch (primitive) {
      case 'Bool':
        return TypeDefPrimitive(Primitive.Bool);
      case 'Char':
        return TypeDefPrimitive(Primitive.Char);
      case 'Str':
        return TypeDefPrimitive(Primitive.Str);
      case 'U8':
        return TypeDefPrimitive(Primitive.U8);
      case 'U16':
        return TypeDefPrimitive(Primitive.U16);
      case 'U32':
        return TypeDefPrimitive(Primitive.U32);
      case 'U64':
        return TypeDefPrimitive(Primitive.U64);
      case 'U128':
        return TypeDefPrimitive(Primitive.U128);
      case 'U256':
        return TypeDefPrimitive(Primitive.U256);
      case 'I8':
        return TypeDefPrimitive(Primitive.I8);
      case 'I16':
        return TypeDefPrimitive(Primitive.I16);
      case 'I32':
        return TypeDefPrimitive(Primitive.I32);
      case 'I64':
        return TypeDefPrimitive(Primitive.I64);
      case 'I128':
        return TypeDefPrimitive(Primitive.I128);
      case 'I256':
        return TypeDefPrimitive(Primitive.I256);
      default:
        throw Exception('Unknown primitive type $primitive');
    }
  }

  @override
  Set<int> typeDependencies() {
    return <int>{};
  }

  @override
  Map<String, String> toJson() => {
        'primitive': primitive.name.toLowerCase(),
      };
}

/// A primitive Rust type.
class $TypeDefPrimitiveCodec implements Codec<TypeDefPrimitive> {
  const $TypeDefPrimitiveCodec._();

  @override
  TypeDefPrimitive decode(Input input) {
    final primitive = Primitive.codec.decode(input);
    return TypeDefPrimitive(primitive);
  }

  @override
  Uint8List encode(TypeDefPrimitive typeDef) {
    return Primitive.codec.encode(typeDef.primitive);
  }

  @override
  void encodeTo(TypeDefPrimitive typeDef, Output output) {
    Primitive.codec.encodeTo(typeDef.primitive, output);
  }

  @override
  int sizeHint(TypeDefPrimitive typeDef) {
    return Primitive.codec.sizeHint(typeDef.primitive);
  }
}

/// Type describing a [`bitvec::vec::BitVec`].
class TypeDefBitSequence extends TypeDef {
  /// The type of the BitStore
  final TypeId bitStoreType;

  /// The type of the BitOrder
  final TypeId bitOrderType;

  static const $TypeDefCodec codec = TypeDef.codec;

  /// Creates a new bit sequence type.
  const TypeDefBitSequence(
      {required this.bitStoreType, required this.bitOrderType});

  @override
  Set<int> typeDependencies() {
    return {bitStoreType, bitOrderType};
  }

  @override
  Map<String, int> toJson() => {
        'bitStoreType': bitStoreType,
        'bitOrderType': bitOrderType,
      };
}

class $TypeDefBitSequenceCodec implements Codec<TypeDefBitSequence> {
  const $TypeDefBitSequenceCodec._();

  @override
  TypeDefBitSequence decode(Input input) {
    final bitStoreType = TypeIdCodec.codec.decode(input);
    final bitOrderType = TypeIdCodec.codec.decode(input);
    return TypeDefBitSequence(
        bitStoreType: bitStoreType, bitOrderType: bitOrderType);
  }

  @override
  Uint8List encode(TypeDefBitSequence typeDef) {
    final output = ByteOutput(sizeHint(typeDef));
    encodeTo(typeDef, output);
    return output.toBytes(copy: false);
  }

  @override
  void encodeTo(TypeDefBitSequence typeDef, Output output) {
    TypeIdCodec.codec.encodeTo(typeDef.bitStoreType, output);
    TypeIdCodec.codec.encodeTo(typeDef.bitOrderType, output);
  }

  @override
  int sizeHint(TypeDefBitSequence typeDef) {
    int size = TypeIdCodec.codec.sizeHint(typeDef.bitStoreType);
    size += TypeIdCodec.codec.sizeHint(typeDef.bitOrderType);
    return size;
  }
}
