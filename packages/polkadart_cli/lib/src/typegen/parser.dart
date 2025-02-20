part of descriptors;

/// Transform a list of [TypeMetadata] into a [Map] of [TypeDescriptor]
Map<int, TypeDescriptor> parseTypes(
    List<metadata.PortableType> registry, String typesPath) {
  // Type Definitions
  final Map<int, metadata.PortableType> types = {
    for (var type in registry) type.id: type
  };

  // Create all Generators
  final Map<int, TypeDescriptor> generators = {};
  final lazyLoader = LazyLoader();
  for (final portable in types.values) {
    final typeID = portable.id;
    final type = portable.type;
    if (generators.containsKey(typeID)) {
      continue;
    }

    // Create Primitive Generator
    if (type.typeDef is metadata.TypeDefPrimitive) {
      final primitiveTypeDef = type.typeDef as metadata.TypeDefPrimitive;
      generators[typeID] = PrimitiveDescriptor(
          id: typeID, primitive: primitiveTypeDef.primitive);
      continue;
    }

    // Create Compact Generator
    if (type.typeDef is metadata.TypeDefCompact) {
      // Ignore the compact type, is not important
      generators[typeID] = CompactDescriptor(typeID);
      continue;
    }

    // Create Sequences Generator
    if (type.typeDef is metadata.TypeDefSequence) {
      final sequence = type.typeDef as metadata.TypeDefSequence;
      generators[typeID] = SequenceDescriptor.lazy(
          id: typeID, loader: lazyLoader, codec: sequence.type);
      continue;
    }

    // Create Array Generator
    if (type.typeDef is metadata.TypeDefArray) {
      final array = type.typeDef as metadata.TypeDefArray;
      generators[typeID] = ArrayDescriptor.lazy(
          id: typeID,
          loader: lazyLoader,
          codec: array.type,
          length: array.length);
      continue;
    }

    // Create Tuple Generator
    if (type.typeDef is metadata.TypeDefTuple) {
      final tuple = type.typeDef as metadata.TypeDefTuple;

      // Create an Empty Type
      if (tuple.fields.isEmpty && type.path.isEmpty) {
        generators[typeID] = EmptyDescriptor(typeID);
        continue;
      }

      // Create TypeDef Generator
      if (tuple.fields.isEmpty) {
        generators[typeID] = TypeDefBuilder(
            filePath: listToFilePath([typesPath, ...type.path]),
            name: sanitizeClassName(type.path.last),
            generator: EmptyDescriptor(typeID),
            docs: type.docs);
        continue;
      }

      // Create a Tuple Generator
      generators[typeID] = TupleBuilder.lazy(
        id: typeID,
        loader: lazyLoader,
        filePath: p.join(typesPath, 'tuples.dart'),
        codecs: tuple.fields,
      );
      continue;
    }

    // Create Bit Sequence
    if (type.typeDef is metadata.TypeDefBitSequence) {
      final bitSequence = type.typeDef as metadata.TypeDefBitSequence;
      final storeType = types[bitSequence.bitStoreType]!.type;
      final orderType = types[bitSequence.bitOrderType]!.type;

      final BitOrder bitOrder =
          orderType.path.last == 'Lsb0' ? BitOrder.LSB : BitOrder.MSB;
      if (storeType.typeDef is metadata.TypeDefPrimitive) {
        final primitiveTypeDef = storeType.typeDef as metadata.TypeDefPrimitive;
        generators[typeID] = BitSequenceDescriptor.fromPrimitive(
            id: typeID, primitive: primitiveTypeDef.primitive, order: bitOrder);
        continue;
      }
      generators[typeID] = BitSequenceDescriptor(
          id: typeID, store: BitStore.U8, order: bitOrder);
      continue;
    }

    // Create Composite Generators
    if (type.typeDef is metadata.TypeDefComposite) {
      final composite = type.typeDef as metadata.TypeDefComposite;

      // Create an Empty Type
      if (composite.fields.isEmpty && type.path.isEmpty) {
        generators[typeID] = EmptyDescriptor(typeID);
        continue;
      }

      // Create TypeDef Generator
      if (composite.fields.isEmpty) {
        generators[typeID] = TypeDefBuilder(
            filePath: listToFilePath([typesPath, ...type.path]),
            name: sanitizeClassName(type.path.last),
            generator: EmptyDescriptor(typeID),
            docs: type.docs);
        continue;
      }

      // BTreeMap generator
      if (type.path.length == 1 &&
          type.path.last == 'BTreeMap' &&
          composite.fields.length == 1 &&
          composite.fields.first.name == null) {
        final sequenceTypeID = composite.fields.first.type;
        final sequenceType = types[sequenceTypeID]!.type;
        if (sequenceType.typeDef is metadata.TypeDefSequence) {
          final tupleType = types[sequenceTypeID]!.type;
          if (tupleType.typeDef is metadata.TypeDefTuple) {
            final tupleTypeDef = tupleType.typeDef as metadata.TypeDefTuple;
            if (tupleTypeDef.fields.length == 2) {
              generators[typeID] = BTreeMapDescriptor.lazy(
                  id: typeID,
                  loader: lazyLoader,
                  key: tupleTypeDef.fields[0],
                  value: tupleTypeDef.fields[1]);
              continue;
            }
          }
        }
      }

      // Alias (a composite which only have one unnamed field)
      if (composite.fields.length == 1 && composite.fields[0].name == null) {
        // Use the inner generator (ex: BoundedVec == Vec)
        if (type.path.isNotEmpty &&
            (type.path.last == 'BoundedVec' ||
                type.path.last == 'WeakBoundedVec')) {
          final sequenceTypeID = composite.fields.first.type;
          final sequenceType = types[sequenceTypeID]!.type;
          if (sequenceType.typeDef is metadata.TypeDefSequence) {
            final sequenceTypeDef =
                sequenceType.typeDef as metadata.TypeDefSequence;
            generators[typeID] = SequenceDescriptor.lazy(
                id: typeID, loader: lazyLoader, codec: sequenceTypeDef.type);
            continue;
          }
        }

        // BoundedBTreeMap
        if (type.path.isNotEmpty && type.path.last == 'BoundedBTreeMap') {
          final btreemapTypeID = composite.fields.first.type;
          final btreemapType = types[btreemapTypeID]!.type;
          if (btreemapType is metadata.TypeDefComposite) {
            final btreemapTypeDef =
                btreemapType.typeDef as metadata.TypeDefComposite;
            if (btreemapTypeDef.fields.length == 1 &&
                btreemapTypeDef.fields.first.name == null) {
              final sequenceTypeID = btreemapTypeDef.fields.first.type;
              final sequenceType = types[sequenceTypeID]!.type;
              if (sequenceType.typeDef is metadata.TypeDefSequence) {
                final sequenceTypeDef =
                    sequenceType.typeDef as metadata.TypeDefSequence;
                final tupleTypeID = sequenceTypeDef.type;
                final tupleType = types[tupleTypeID]!.type;
                if (tupleType.typeDef is metadata.TypeDefTuple) {
                  final tupleTypeDef =
                      tupleType.typeDef as metadata.TypeDefTuple;
                  if (tupleTypeDef.fields.length == 2) {
                    generators[typeID] = BTreeMapDescriptor.lazy(
                        id: typeID,
                        loader: lazyLoader,
                        key: tupleTypeDef.fields[0],
                        value: tupleTypeDef.fields[1]);
                    continue;
                  }
                }
              }
            }
          }
        }

        // BoundedString
        if (type.path.isNotEmpty && type.path.last == 'BoundedString') {
          final boundedVecTypeID = composite.fields.first.type;
          final boundedVecType = types[boundedVecTypeID]!.type;
          if (boundedVecType.typeDef is metadata.TypeDefComposite) {
            final boundedVecTypeDef =
                boundedVecType.typeDef as metadata.TypeDefComposite;
            if (boundedVecTypeDef.fields.length == 1 &&
                boundedVecTypeDef.fields.first.name == null) {
              final sequenceTypeID = boundedVecTypeDef.fields.first.type;
              final sequenceType = types[sequenceTypeID]!.type;
              if (sequenceType.typeDef is metadata.TypeDefSequence) {
                final sequenceTypeDef =
                    sequenceType.typeDef as metadata.TypeDefSequence;
                final primitiveTypeID = sequenceTypeDef.type;
                final primitiveType = types[primitiveTypeID]!.type;
                if (primitiveType.typeDef is metadata.TypeDefPrimitive) {
                  final primitiveTypeDef =
                      primitiveType as metadata.TypeDefPrimitive;
                  if (primitiveTypeDef.primitive == metadata.Primitive.U8) {
                    generators[typeID] = PrimitiveDescriptor.str(typeID);
                    continue;
                  }
                }
              }
            }
          } else if (boundedVecType.typeDef is metadata.TypeDefSequence) {
            final boundedVecTypeDef =
                boundedVecType.typeDef as metadata.TypeDefSequence;
            final primitiveTypeID = boundedVecTypeDef.type;
            final primitiveType = types[primitiveTypeID]!.type;
            if (primitiveType.typeDef is metadata.TypeDefPrimitive) {
              final primitiveTypeDef =
                  primitiveType as metadata.TypeDefPrimitive;
              if (primitiveTypeDef.primitive == metadata.Primitive.U8) {
                generators[typeID] = PrimitiveDescriptor.str(typeID);
                continue;
              }
            }
          }
        }

        generators[typeID] = TypeDefBuilder.lazy(
          id: typeID,
          loader: lazyLoader,
          filePath: listToFilePath([typesPath, ...type.path]),
          name: sanitizeClassName(type.path.last),
          codec: composite.fields[0].type,
          docs: type.docs,
        );
        continue;
      }

      // Create Compose Generator
      generators[typeID] = CompositeBuilder(
          id: typeID,
          filePath: listToFilePath([typesPath, ...type.path]),
          name: sanitizeClassName(type.path.last),
          docs: type.docs,
          fields: composite.fields
              .map((field) => Field.lazy(
                  loader: lazyLoader,
                  codec: field.type,
                  docs: field.docs,
                  name: field.name,
                  rustTypeName: field.typeName))
              .toList());
      continue;
    }

    // Create Variant / Option / Result
    if (type.typeDef is metadata.TypeDefVariant) {
      final variant = type.typeDef as metadata.TypeDefVariant;

      // Create Empty Generator
      if (variant.variants.isEmpty && type.path.isEmpty) {
        generators[typeID] = EmptyDescriptor(typeID);
        continue;
      }

      // Create TypeDef Generator
      if (variant.variants.isEmpty) {
        generators[typeID] = TypeDefBuilder(
            filePath: listToFilePath([typesPath, ...type.path]),
            name: sanitizeClassName(type.path.last),
            generator: EmptyDescriptor(typeID),
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
        generators[typeID] = OptionDescriptor.lazy(
            id: typeID,
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
        generators[typeID] = ResultDescriptor.lazy(
          id: typeID,
          loader: lazyLoader,
          ok: variant.variants[0].fields[0].type,
          err: variant.variants[1].fields[0].type,
        );
        continue;
      }

      // Create Variant Generator
      final enumName =
          sanitizeClassName(type.path.last, prefix: 'Enum', suffix: 'Enum');
      generators[typeID] = VariantBuilder(
          id: typeID,
          filePath: listToFilePath([typesPath, ...type.path]),
          name: enumName,
          originalName: type.path.last,
          docs: type.docs,
          variants: variant.variants.map((variant) {
            String variantName = sanitizeClassName(variant.name,
                prefix: 'Variant', suffix: 'Variant');
            if (variantName == enumName) {
              variantName = '${variantName}Variant';
            }
            return Variant(
                name: variantName,
                originalName: variant.name,
                index: variant.index,
                docs: variant.docs,
                fields: variant.fields
                    .map((field) => Field.lazy(
                          loader: lazyLoader,
                          codec: field.type,
                          name: field.name,
                          docs: field.docs,
                          rustTypeName: field.typeName,
                        ))
                    .toList());
          }).toList());
      continue;
    }

    throw Exception('Unknown type ${type.typeDef.runtimeType}');
  }

  // Load generators
  for (final callback in lazyLoader.loaders) {
    callback(generators);
  }

  return generators;
}
