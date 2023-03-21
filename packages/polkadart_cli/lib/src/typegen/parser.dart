part of generators;

/// Transform a list of [TypeMetadata] into a [Map] of [TypeDescriptor]
Map<int, TypeDescriptor> parseTypes(
    List<metadata.TypeMetadata> registry, String typesPath) {
  // Type Definitions
  final Map<int, metadata.TypeMetadata> types = {
    for (var type in registry) type.id: type
  };

  // Create all Generators
  final Map<int, TypeDescriptor> generators = {};
  final lazyLoader = LazyLoader();
  for (final type in types.values) {
    if (generators.containsKey(type.id)) {
      continue;
    }

    // Create Primitive Generator
    if (type.typeDef is metadata.TypeDefPrimitive) {
      final primitiveTypeDef = type.typeDef as metadata.TypeDefPrimitive;
      generators[type.id] = PrimitiveDescriptor(
          id: type.id, primitive: primitiveTypeDef.primitive);
      continue;
    }

    // Create Compact Generator
    if (type.typeDef is metadata.TypeDefCompact) {
      // Ignore the compact type, is not important
      generators[type.id] = CompactDescriptor(type.id);
      continue;
    }

    // Create Sequences Generator
    if (type.typeDef is metadata.TypeDefSequence) {
      final sequence = type.typeDef as metadata.TypeDefSequence;
      generators[type.id] = SequenceDescriptor.lazy(
          id: type.id, loader: lazyLoader, codec: sequence.type);
      continue;
    }

    // Create Array Generator
    if (type.typeDef is metadata.TypeDefArray) {
      final array = type.typeDef as metadata.TypeDefArray;
      generators[type.id] = ArrayDescriptor.lazy(
          id: type.id,
          loader: lazyLoader,
          codec: array.type,
          length: array.length);
      continue;
    }

    // Create Tuple Generator
    if (type.typeDef is metadata.TypeDefTuple) {
      final tuple = type.typeDef as metadata.TypeDefTuple;

      // Create an Empty Type
      if (tuple.types.isEmpty && type.path.isEmpty) {
        generators[type.id] = EmptyDescriptor(type.id);
        continue;
      }

      // Create TypeDef Generator
      if (tuple.types.isEmpty) {
        generators[type.id] = TypeDefBuilder(
            filePath: listToFilePath([typesPath, ...type.path]),
            name: sanitizeClassName(type.path.last),
            generator: EmptyDescriptor(type.id),
            docs: type.docs);
        continue;
      }

      // Create a Tuple Generator
      generators[type.id] = TupleBuilder.lazy(
        id: type.id,
        loader: lazyLoader,
        filePath: p.join(typesPath, 'tuples.dart'),
        codecs: tuple.types,
      );
      continue;
    }

    // Create Bit Sequence
    if (type.typeDef is metadata.TypeDefBitSequence) {
      final bitSequence = type.typeDef as metadata.TypeDefBitSequence;
      final storeTypeDef = types[bitSequence.bitStoreType]!.typeDef;
      final orderType = types[bitSequence.bitOrderType]!;

      final BitOrder bitOrder =
          orderType.path.last == 'Lsb0' ? BitOrder.LSB : BitOrder.MSB;
      if (storeTypeDef is metadata.TypeDefPrimitive) {
        generators[type.id] = BitSequenceDescriptor.fromPrimitive(
            id: type.id, primitive: storeTypeDef.primitive, order: bitOrder);
        continue;
      }
      generators[type.id] = BitSequenceDescriptor(
          id: type.id, store: BitStore.U8, order: bitOrder);
      continue;
    }

    // Create Composite Generators
    if (type.typeDef is metadata.TypeDefComposite) {
      final composite = type.typeDef as metadata.TypeDefComposite;

      // Create an Empty Type
      if (composite.fields.isEmpty && type.path.isEmpty) {
        generators[type.id] = EmptyDescriptor(type.id);
        continue;
      }

      // Create TypeDef Generator
      if (composite.fields.isEmpty) {
        generators[type.id] = TypeDefBuilder(
            filePath: listToFilePath([typesPath, ...type.path]),
            name: sanitizeClassName(type.path.last),
            generator: EmptyDescriptor(type.id),
            docs: type.docs);
        continue;
      }

      // BTreeMap generator
      if (type.path.length == 1 &&
          type.path.last == 'BTreeMap' &&
          composite.fields.length == 1 &&
          composite.fields.first.name == null) {
        final sequenceTypeDef = types[composite.fields.first.type]!.typeDef;
        if (sequenceTypeDef is metadata.TypeDefSequence) {
          final tupleTypeDef = types[sequenceTypeDef.type]!.typeDef;
          if (tupleTypeDef is metadata.TypeDefTuple &&
              tupleTypeDef.types.length == 2) {
            generators[type.id] = BTreeMapDescriptor.lazy(
                id: type.id,
                loader: lazyLoader,
                key: tupleTypeDef.types[0],
                value: tupleTypeDef.types[1]);
            continue;
          }
        }
      }

      // Alias (a composite which only have one unnamed field)
      if (composite.fields.length == 1 && composite.fields[0].name == null) {
        // Use the inner generator (ex: BoundedVec == Vec)
        if (type.path.isNotEmpty &&
            (type.path.last == 'BoundedVec' ||
                type.path.last == 'WeakBoundedVec')) {
          final sequence = types[composite.fields.first.type]!.typeDef;
          if (sequence is metadata.TypeDefSequence) {
            generators[type.id] = SequenceDescriptor.lazy(
                id: type.id, loader: lazyLoader, codec: sequence.type);
            continue;
          }
        }

        // BoundedBTreeMap
        if (type.path.isNotEmpty && type.path.last == 'BoundedBTreeMap') {
          final btreemap = types[composite.fields.first.type]!.typeDef;
          if (btreemap is metadata.TypeDefComposite &&
              btreemap.fields.length == 1 &&
              btreemap.fields.first.name == null) {
            final sequenceTypeDef = types[btreemap.fields.first.type]!.typeDef;
            if (sequenceTypeDef is metadata.TypeDefSequence) {
              final tupleTypeDef = types[sequenceTypeDef.type]!.typeDef;
              if (tupleTypeDef is metadata.TypeDefTuple &&
                  tupleTypeDef.types.length == 2) {
                generators[type.id] = BTreeMapDescriptor.lazy(
                    id: type.id,
                    loader: lazyLoader,
                    key: tupleTypeDef.types[0],
                    value: tupleTypeDef.types[1]);
                continue;
              }
            }
          }
        }

        // BoundedString
        if (type.path.isNotEmpty && type.path.last == 'BoundedString') {
          final boundedVec = types[composite.fields.first.type]!.typeDef;
          if (boundedVec is metadata.TypeDefComposite &&
              boundedVec.fields.length == 1 &&
              boundedVec.fields.first.name == null) {
            final sequenceTypeDef =
                types[boundedVec.fields.first.type]!.typeDef;
            if (sequenceTypeDef is metadata.TypeDefSequence) {
              final primitiveTypeDef = types[sequenceTypeDef.type]!.typeDef;
              if (primitiveTypeDef is metadata.TypeDefPrimitive &&
                  primitiveTypeDef.primitive == metadata.Primitive.U8) {
                generators[type.id] = PrimitiveDescriptor.str(type.id);
                continue;
              }
            }
          } else if (boundedVec is metadata.TypeDefSequence) {
            final primitiveTypeDef = types[boundedVec.type]!.typeDef;
            if (primitiveTypeDef is metadata.TypeDefPrimitive &&
                primitiveTypeDef.primitive == metadata.Primitive.U8) {
              generators[type.id] = PrimitiveDescriptor.str(type.id);
              continue;
            }
          }
        }

        generators[type.id] = TypeDefBuilder.lazy(
          id: type.id,
          loader: lazyLoader,
          filePath: listToFilePath([typesPath, ...type.path]),
          name: sanitizeClassName(type.path.last),
          codec: composite.fields[0].type,
          docs: type.docs,
        );
        continue;
      }

      // Create Compose Generator
      generators[type.id] = CompositeBuilder(
          id: type.id,
          filePath: listToFilePath([typesPath, ...type.path]),
          name: sanitizeClassName(type.path.last),
          docs: type.docs,
          fields: composite.fields
              .map((field) => Field.lazy(
                  loader: lazyLoader,
                  codec: field.type,
                  docs: field.docs,
                  name: field.name))
              .toList());
      continue;
    }

    // Create Variant / Option / Result
    if (type.typeDef is metadata.TypeDefVariant) {
      final variant = type.typeDef as metadata.TypeDefVariant;

      // Create Empty Generator
      if (variant.variants.isEmpty && type.path.isEmpty) {
        generators[type.id] = EmptyDescriptor(type.id);
        continue;
      }

      // Create TypeDef Generator
      if (variant.variants.isEmpty) {
        generators[type.id] = TypeDefBuilder(
            filePath: listToFilePath([typesPath, ...type.path]),
            name: sanitizeClassName(type.path.last),
            generator: EmptyDescriptor(type.id),
            docs: type.docs);
        continue;
      }

      // Create Option Generator
      if (variant.variants.length == 2 &&
          variant.variants[0].index == 0 &&
          variant.variants[0].fields.isEmpty &&
          variant.variants[0].name == 'None' &&
          variant.variants[1].index == 1 &&
          variant.variants[1].fields.length == 1 &&
          variant.variants[1].name == 'Some') {
        generators[type.id] = OptionDescriptor.lazy(
            id: type.id,
            loader: lazyLoader,
            codec: variant.variants[1].fields[0].type);
        continue;
      }

      // Create Result Generator
      if (type.path.length == 1 &&
          type.path.first == 'Result' &&
          variant.variants.length == 2 &&
          variant.variants[0].index == 0 &&
          variant.variants[0].fields.length == 1 &&
          variant.variants[1].index == 1 &&
          variant.variants[1].fields.length == 1) {
        generators[type.id] = ResultDescriptor.lazy(
          id: type.id,
          loader: lazyLoader,
          ok: variant.variants[0].fields[0].type,
          err: variant.variants[1].fields[0].type,
        );
        continue;
      }

      // Create Variant Generator
      final enumName =
          sanitizeClassName(type.path.last, prefix: 'Enum', suffix: 'Enum');
      generators[type.id] = VariantBuilder(
          id: type.id,
          filePath: listToFilePath([typesPath, ...type.path]),
          name: enumName,
          orginalName: type.path.last,
          docs: type.docs,
          variants: variant.variants.map((variant) {
            String variantName = sanitizeClassName(variant.name,
                prefix: 'Variant', suffix: 'Variant');
            if (variantName == enumName) {
              variantName = '${variantName}Variant';
            }
            return Variant(
                name: variantName,
                orignalName: variant.name,
                index: variant.index,
                docs: variant.docs,
                fields: variant.fields
                    .map((field) => Field.lazy(
                          loader: lazyLoader,
                          codec: field.type,
                          name: field.name,
                          docs: field.docs,
                        ))
                    .toList());
          }).toList());
      continue;
    }

    throw Exception('Unknown type ${type.typeDef}');
  }

  // Load generators
  for (final callback in lazyLoader.loaders) {
    callback(generators);
  }

  return generators;
}
