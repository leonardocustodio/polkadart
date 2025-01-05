part of ink_abi;

List<CodecInterface> normalizeMetadataTypes(List<CodecInterface> types) {
  types = _fixWrapperKeepOpaqueTypes(types);
  types = _fixU256Structs(types);
  types = _eliminateWrappers(types);
  types = _mutateResultType(types);
  types = _removeUnitFieldsFromVariants(types);
  types = _fixCompactTypes(types);
  types = _introduceOptionType(types);
  types = _replaceUnitOptionWithBoolean(types);
  types = _eliminateOptionsChain(types);
  types = _normalizedFieldNames(types);
  return types;
}

List<CodecInterface> _fixWrapperKeepOpaqueTypes(List<CodecInterface> types) {
  final int u8 = types.length;
  bool replaced = false;
  types = types.map((final CodecInterface type) {
    if (type.path == null || type.path!.isEmpty) {
      return type;
    }
    if (type.path!.last != 'WrapperKeepOpaque') {
      return type;
    }
    if (type.kind != TypeKind.composite) {
      return type;
    }
    if (type is CompositeCodecInterface && type.fields.length != 2) {
      return type;
    }
    if (type is CompositeCodecInterface &&
        types[type.fields[0].type].kind != TypeKind.compact) {
      return type;
    }
    replaced = true;
    return SequenceCodecInterface(
      id: type.id,
      type: u8,
      docs: type.docs,
    );
  }).toList();
  if (replaced) {
    final int newId = types.length;
    types.add(
      PrimitiveCodecInterface(
        id: newId,
        primitive: Primitive.u8,
        docs: <String>[
          'This was added from `_fixWrapperKeepOpaqueTypes` normalizer function call.',
        ],
      ),
    );
  }
  return types;
}

List<CodecInterface> _fixU256Structs(final List<CodecInterface> types) {
  return types.map((final CodecInterface type) {
    //
    // Check if type.path is not null and not empty
    if (type.path != null && type.path!.isNotEmpty) {
      //
      // Check if the last element of type.path is 'U256'
      // and type.kind is TypeKind.Composite
      // and type.fields.length is 1
      if (type.path!.last.toUpperCase() == 'U256' &&
          type.kind == TypeKind.composite &&
          (type as CompositeCodecInterface).fields.length == 1) {
        final CodecInterface field = types[type.fields[0].type];
        //
        // Check if field.kind is TypeKind.Array
        // and field.length is 4
        if (field.kind == TypeKind.array &&
            (field as ArrayCodecInterface).len == 4) {
          final CodecInterface element = types[field.type];
          //
          // Check if element.kind is TypeKind.Primitive
          // and element.primitive is Primitive.U64
          if (element.kind == TypeKind.primitive &&
              (element as PrimitiveCodecInterface).primitive == Primitive.u64) {
            return PrimitiveCodecInterface(
              id: type.id,
              primitive: Primitive.u256,
            );
          }
        }
      }
    }

    return type;
  }).toList();
}

List<CodecInterface> _eliminateWrappers(List<CodecInterface> types) {
  bool changed = true;
  while (changed) {
    changed = false;
    types = types.map((final CodecInterface type) {
      switch (type.kind) {
        case TypeKind.tuple:
          if ((type as TupleCodecInterface).tuple.length == 1) {
            changed = true;
            final newType =
                CodecInterface.fromJson(types[type.tuple[0]].toJson());
            newType.id = type.id;
            return _replaceType(type, newType);
          }
          return type;
        case TypeKind.composite:
          if ((type as CompositeCodecInterface).fields.isEmpty) {
            changed = true;
            return _replaceType(
              type,
              TupleCodecInterface(
                id: type.id,
                tuple: [],
              ),
            );
          }

          if (type.fields[0].name == null) {
            changed = true;
            return _replaceType(
              type,
              TupleCodecInterface(
                id: type.id,
                tuple: type.fields.map(
                  (final Field field) {
                    assert(field.name == null);
                    return field.type;
                  },
                ).toList(),
              ),
            );
          }

          final List<Field> nonUnitFields = type.fields.where(
            (final Field field) {
              return !_isUnitType(types[field.type]);
            },
          ).toList();

          if (nonUnitFields.length != type.fields.length) {
            changed = true;
            type.fields = nonUnitFields;
          }

          return type;
        default:
          return type;
      }
    }).toList();
  }
  return types;
}

List<CodecInterface> _removeUnitFieldsFromVariants(List<CodecInterface> types) {
  return types.map((final CodecInterface type) {
    if (type.kind != TypeKind.variant) {
      return type;
    }
    final List<Variants> variants =
        (type as VariantCodecInterface).variants.map((final Variants variant) {
      final List<Field> nonUnitFields = variant.fields.where(
        (final Field field) {
          return !_isUnitType(types[field.type]);
        },
      ).toList();
      if (nonUnitFields.length == variant.fields.length) {
        return variant;
      }
      if (variant.fields[0].name == null && nonUnitFields.isNotEmpty) {
        return variant;
      }
      variant.fields = nonUnitFields;
      return variant;
    }).toList();
    type.variants = variants;
    return type;
  }).toList();
}

List<CodecInterface> _fixCompactTypes(final List<CodecInterface> types) {
  return types.map((final CodecInterface type) {
    if (type.kind != TypeKind.compact) {
      return type;
    }
    CodecInterface compact = types[(type as CompactCodecInterface).type];
    switch (compact.kind) {
      case TypeKind.primitive:
        assert((compact as PrimitiveCodecInterface).primitive.name[0] == 'U');
        return type;
      case TypeKind.tuple:
        assert((compact as TupleCodecInterface).tuple.isEmpty);
        return _replaceType(
          type,
          TupleCodecInterface(
            id: type.id,
            tuple: <int>[],
          ),
        );
      case TypeKind.composite:
        assert((compact as CompositeCodecInterface).fields.length == 1);
        final int compactTi =
            (compact as CompositeCodecInterface).fields[0].type;
        compact = types[compactTi];

        assert(compact.kind == TypeKind.primitive);
        assert((compact as PrimitiveCodecInterface)
                .primitive
                .name[0]
                .toUpperCase() ==
            'U');
        type.type = compactTi;
        return type;
      default:
        throw Exception('Not handled for ${compact.kind}');
    }
  }).toList();
}

List<CodecInterface> _introduceOptionType(final List<CodecInterface> types) {
  return types.map((final CodecInterface type) {
    if (isOptionType(type)) {
      return _replaceType(
        type,
        OptionCodecInterface(
          id: type.id,
          type: (type as VariantCodecInterface).variants[1].fields[0].type,
          params: [
            Params(
              name: 'T',
              type: type.variants[1].fields[0].type,
            ),
          ],
        ),
      );
    }
    return type;
  }).toList();
}

bool isOptionType(CodecInterface type) {
  if (type.kind != TypeKind.variant ||
      (type as VariantCodecInterface).variants.length != 2) {
    return false;
  }
  final Variants v0 = type.variants[0];
  final Variants v1 = type.variants[1];
  return v0.name == 'None' &&
      v0.fields.isEmpty &&
      v0.index == 0 &&
      v1.name == 'Some' &&
      v1.index == 1 &&
      v1.fields.length == 1 &&
      v1.fields[0].name == null;
}

List<CodecInterface> _mutateResultType(final List<CodecInterface> types) {
  return types.map((final CodecInterface type) {
    if (isResultType(type)) {
      (type as VariantCodecInterface).params = [
        Params(
          name: type.variants[0].name,
          type: type.variants[0].fields[0].type,
        ),
        Params(
          name: type.variants[1].name,
          type: type.variants[1].fields[0].type,
        ),
      ];
    }
    return type;
  }).toList();
}

bool isResultType(CodecInterface type) {
  if (type.kind != TypeKind.variant ||
      (type as VariantCodecInterface).variants.length != 2 ||
      (type.path == null ||
          type.path!.length != 1 ||
          type.path![0] != 'Result')) {
    return false;
  }
  final Variants v0 = type.variants[0];
  final Variants v1 = type.variants[1];
  return v0.name == 'Ok' &&
      v0.fields.length == 1 &&
      v0.index == 0 &&
      v1.name == 'Err' &&
      v1.index == 1 &&
      v1.fields.length == 1 &&
      v1.fields[0].name == null;
}

List<CodecInterface> _replaceUnitOptionWithBoolean(List<CodecInterface> types) {
  return types.map((final CodecInterface type) {
    if (type.kind == TypeKind.option &&
        _isUnitType(types[(type as OptionCodecInterface).type])) {
      return _replaceType(
        type,
        PrimitiveCodecInterface(
          id: type.id,
          primitive: Primitive.bool,
        ),
      );
    }
    return type;
  }).toList();
}

List<CodecInterface> _eliminateOptionsChain(final List<CodecInterface> types) {
  return types.map((final CodecInterface type) {
    if (type.kind != TypeKind.option) {
      return type;
    }
    final int param = (type as OptionCodecInterface).type;
    if (types[param].kind != TypeKind.option) {
      return type;
    }
    return VariantCodecInterface(
      id: type.id,
      variants: <Variants>[
        Variants(
          name: 'None',
          index: 0,
          fields: <Field>[],
        ),
        Variants(
          name: 'Some',
          index: 1,
          fields: <Field>[Field(type: param)],
        ),
      ],
    );
  }).toList();
}

List<CodecInterface> _normalizedFieldNames(final List<CodecInterface> types) {
  return types.map((final CodecInterface type) {
    switch (type.kind) {
      case TypeKind.composite:
        (type as CompositeCodecInterface).fields =
            _convertToCamelCase(type.fields);
        return type;
      case TypeKind.variant:
        (type as VariantCodecInterface).variants = type.variants.map(
          (final Variants variant) {
            variant.fields = _convertToCamelCase(variant.fields);
            return variant;
          },
        ).toList();
        return type;
      default:
        return type;
    }
  }).toList();
}

List<Field> _convertToCamelCase(final List<Field> fields) {
  return fields.map((final Field field) {
    if (field.name != null &&
        field.name!.trim().isNotEmpty &&
        field.name!.contains('_')) {
      final List<String> parts = field.name!.split('_');
      if (parts.length > 1) {
        field.name = parts[0] +
            parts.sublist(1).map(
              (final String part) {
                return part[0].toUpperCase() + part.substring(1);
              },
            ).join();
      }
    }
    return field;
  }).toList();
}

CodecInterface _replaceType(
    final CodecInterface prev, final CodecInterface next) {
  if (prev.path != null && prev.path!.isNotEmpty) {
    next.path = prev.path?.toList();
  }
  if (prev.docs != null && prev.docs!.isNotEmpty) {
    next.docs = prev.docs?.toList();
  }
  return next;
}

bool _isUnitType(final CodecInterface type) {
  return type.kind == TypeKind.tuple &&
      (type as TupleCodecInterface).tuple.isEmpty;
}
