part of polkadart_scale_codec_core;

extension TypeConverter on List<Type> {
  Type getUnwrappedType(int index) {
    Type def = this[index];
    switch (def.kind) {
      case TypeKind.Tuple:
      case TypeKind.Composite:
        return unwrap(def);
      default:
        return def;
    }
  }

  Type unwrap(Type def, {Set<int>? visited}) {
    int next;
    switch (def.kind) {
      case TypeKind.Tuple:
        if ((def as TupleType).tuple.length == 1) {
          next = def.tuple[0];
          break;
        } else {
          return def;
        }
      case TypeKind.Composite:
        if ((def as CompositeType).fields.isEmpty ||
            def.fields[0].name == null) {
          var tuple = def.fields.map((t) => t.type).toList();
          if (tuple.length == 1) {
            next = tuple[0];
            break;
          } else {
            return TupleType(tuple: tuple);
          }
        } else {
          return def;
        }
      default:
        return def;
    }
    if (visited?.contains(next) ?? false) {
      throw Exception('Cycle of tuples involving $next');
    }
    visited = visited ?? <int>{};
    visited.add(next);
    return unwrap(this[next], visited: visited);
  }

  CodecType getCodecType(int index) {
    Type def = getUnwrappedType(index);
    switch (def.kind) {
      case TypeKind.Sequence:
        if (isPrimitive(Primitive.U8, (def as SequenceType).type)) {
          return CodecBytesType();
        } else {
          return def;
        }
      case TypeKind.Array:
        if (isPrimitive(Primitive.U8, (def as ArrayType).type)) {
          return CodecBytesArrayType(length: def.length);
        } else {
          return def;
        }
      case TypeKind.Compact:
        final Type type = getUnwrappedType((def as CompactType).type);
        switch (type.kind) {
          case TypeKind.Tuple:
            assertionCheck((type as TupleType).tuple.isEmpty);
            return type;
          case TypeKind.Primitive:
            assertionCheck((type as PrimitiveType).primitive.name[0] == 'U');
            return CodecCompactType(integer: type.primitive);
          case TypeKind.Composite:
            assertionCheck((type as CompositeType).fields.length == 1);
            final num = getUnwrappedType(type.fields[0].type);
            assertionCheck(num.kind == TypeKind.Primitive);
            assertionCheck(
                (num as PrimitiveType).primitive.name.startsWith('U'));
            return CodecCompactType(integer: num.primitive);
          default:
            throw UnexpectedCaseException('Unexpected TypeKind: ${type.kind}.');
        }

      case TypeKind.Composite:
        return CodecStructType(
            fields: (def as CompositeType).fields.map((field) {
          var name = assertNotNull(field.name);
          return CodecStructTypeFields(name: name, type: field.type);
        }).toList());
      case TypeKind.Variant:
        List<Variant> variants = (def as VariantType).variants;
        Map<String, CodecVariant> variantsByName = <String, CodecVariant>{};
        Set<int> uniqueIndexes =
            Set<int>.from(variants.map((Variant v) => v.index));
        if (uniqueIndexes.length != variants.length) {
          throw Exception('Variant type $index has duplicate case indexes');
        }

        var length = 0;
        if (variants.isNotEmpty) {
          variants.map((v) => v.index).forEach((index) {
            length = max(length, index);
          });
          length += 1;
        }

        List<CodecVariant?> placedVariants = <CodecVariant?>[]..length = length;
        for (var v in variants) {
          late CodecVariant cv;
          if (v.fields.isEmpty || v.fields[0].name == null) {
            switch (v.fields.length) {
              case 0:
                cv = CodecEmptyVariant(name: v.name, index: v.index);
                break;
              case 1:
                cv = CodecValueVariant(
                    name: v.name, index: v.index, type: v.fields[0].type);
                break;
              default:
                cv = CodecTupleVariant(
                    name: v.name,
                    index: v.index,
                    def: TupleType(
                        tuple: v.fields.map((Field field) {
                      assertionCheck(field.name == null);
                      return field.type;
                    }).toList()));
            }
          } else {
            cv = CodecStructVariant(
                name: v.name,
                index: v.index,
                def: CodecStructType(
                    fields: v.fields.map((field) {
                  var name = assertNotNull(field.name);
                  return CodecStructTypeFields(name: name, type: field.type);
                }).toList()));
          }
          try {
            placedVariants[v.index] = cv;
            variantsByName[cv.name] = cv;
          } catch (e) {
            rethrow;
          }
        }
        return CodecVariantType(
          variants: placedVariants,
          variantsByName: variantsByName,
        );
      default:
        return def as CodecType;
    }
  }

  ///
  /// Check whether primitive is a valid [Primitive] or not
  bool isPrimitive(Primitive primitive, int index) {
    final Type type = getUnwrappedType(index);
    return type.kind == TypeKind.Primitive &&
        (type as PrimitiveType).primitive == primitive;
  }

  ///
  /// Convert list [Types] to [CodecTypes]
  List<CodecType> toCodecTypes() {
    List<CodecType> codecTypes = <CodecType>[];
    for (var i = 0; i < length; i++) {
      codecTypes.add(getCodecType(i));
    }
    return codecTypes;
  }
}
