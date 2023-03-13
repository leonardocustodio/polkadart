import 'package:recase/recase.dart' show ReCase;
import 'package:path/path.dart' as path;
import './base.dart' show Generator, LazyLoader, Field;
import './array.dart' show ArrayGenerator;
import './btreemap.dart' show BTreeMapGenerator;
import './bit_sequence.dart' show BitSequenceGenerator;
import './composite.dart' show CompositeGenerator;
import './compact.dart' show CompactGenerator;
import './variant.dart' show VariantGenerator, Variant;
import './primitive.dart' show PrimitiveGenerator;
import './sequence.dart' show SequenceGenerator;
import './option.dart' show OptionGenerator;
import './result.dart' show ResultGenerator;
import './typedef.dart' show TypeDefGenerator;
import './tuple.dart' show TupleGenerator;
import './empty.dart' show EmptyGenerator;
import '../frame_metadata.dart'
    show
        Primitive,
        TypeMetadata,
        TypeDefVariant,
        TypeDefSequence,
        TypeDefArray,
        TypeDefBitSequence,
        TypeDefCompact,
        TypeDefComposite,
        TypeDefPrimitive,
        TypeDefTuple;
import '../utils.dart' show listToFilePath;
import 'package:polkadart_scale_codec/polkadart_scale_codec.dart'
    show BitStore, BitOrder;

Map<int, Generator> generatorsFromTypes(
    List<TypeMetadata> registry, String typesPath) {
  // Type Definitions
  final Map<int, TypeMetadata> types = {
    for (var type in registry) type.id: type
  };

  // Create all Generators
  final Map<int, Generator> generators = {};
  final lazyLoader = LazyLoader();
  for (final type in types.values) {
    if (generators.containsKey(type.id)) {
      continue;
    }

    // Create Primitive Generator
    if (type.typeDef is TypeDefPrimitive) {
      generators[type.id] =
          PrimitiveGenerator((type.typeDef as TypeDefPrimitive).primitive);
      continue;
    }

    // Create Compact Generator
    if (type.typeDef is TypeDefCompact) {
      // Ignore the compact type, is not important
      generators[type.id] = CompactGenerator();
      continue;
    }

    // Create Sequences Generator
    if (type.typeDef is TypeDefSequence) {
      final sequence = type.typeDef as TypeDefSequence;
      generators[type.id] =
          SequenceGenerator.lazy(loader: lazyLoader, codec: sequence.type);
      continue;
    }

    // Create Array Generator
    if (type.typeDef is TypeDefArray) {
      final array = type.typeDef as TypeDefArray;
      generators[type.id] = ArrayGenerator.lazy(
          loader: lazyLoader, codec: array.type, length: array.length);
      continue;
    }

    // Create Tuple Generator
    if (type.typeDef is TypeDefTuple) {
      final tuple = type.typeDef as TypeDefTuple;

      // Create an Empty Type
      if (tuple.types.isEmpty && type.path.isEmpty) {
        generators[type.id] = EmptyGenerator();
        continue;
      }

      // Create TypeDef Generator
      if (tuple.types.isEmpty) {
        generators[type.id] = TypeDefGenerator(
            filePath: listToFilePath([typesPath, ...type.path]),
            name: ReCase(type.path.last).pascalCase,
            generator: EmptyGenerator(),
            docs: type.docs);
        continue;
      }

      generators[type.id] = TupleGenerator.lazy(
        loader: lazyLoader,
        filePath: path.join(typesPath, 'tuples.dart'),
        codecs: tuple.types,
      );
      continue;
    }

    // Create Bit Sequence
    if (type.typeDef is TypeDefBitSequence) {
      final bitSequence = type.typeDef as TypeDefBitSequence;
      final storeTypeDef = types[bitSequence.bitStoreType]!.typeDef;
      final orderType = types[bitSequence.bitOrderType]!;

      final BitOrder bitOrder =
          orderType.path.last == 'Lsb0' ? BitOrder.LSB : BitOrder.MSB;
      if (storeTypeDef is TypeDefPrimitive) {
        generators[type.id] = BitSequenceGenerator.fromPrimitive(
            primitive: storeTypeDef.primitive, order: bitOrder);
        continue;
      }
      generators[type.id] =
          BitSequenceGenerator(store: BitStore.U8, order: bitOrder);
      continue;
    }

    // Create Composite Generators
    if (type.typeDef is TypeDefComposite) {
      final composite = type.typeDef as TypeDefComposite;

      // Create an Empty Type
      if (composite.fields.isEmpty && type.path.isEmpty) {
        generators[type.id] = EmptyGenerator();
        continue;
      }

      // Create TypeDef Generator
      if (composite.fields.isEmpty) {
        generators[type.id] = TypeDefGenerator(
            filePath: listToFilePath([typesPath, ...type.path]),
            name: ReCase(type.path.last).pascalCase,
            generator: EmptyGenerator(),
            docs: type.docs);
        continue;
      }

      // BTreeMap generator
      if (type.path.length == 1 &&
          type.path.last == 'BTreeMap' &&
          composite.fields.length == 1 &&
          composite.fields.first.name == null) {
        final sequenceTypeDef = types[composite.fields.first.type]!.typeDef;
        if (sequenceTypeDef is TypeDefSequence) {
          final tupleTypeDef = types[sequenceTypeDef.type]!.typeDef;
          if (tupleTypeDef is TypeDefTuple && tupleTypeDef.types.length == 2) {
            generators[type.id] = BTreeMapGenerator.lazy(
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
          if (sequence is TypeDefSequence) {
            generators[type.id] = SequenceGenerator.lazy(
                loader: lazyLoader, codec: sequence.type);
            continue;
          }
        }

        // BoundedBTreeMap
        if (type.path.isNotEmpty && type.path.last == 'BoundedBTreeMap') {
          final btreemap = types[composite.fields.first.type]!.typeDef;
          if (btreemap is TypeDefComposite &&
              btreemap.fields.length == 1 &&
              btreemap.fields.first.name == null) {
            final sequenceTypeDef = types[btreemap.fields.first.type]!.typeDef;
            if (sequenceTypeDef is TypeDefSequence) {
              final tupleTypeDef = types[sequenceTypeDef.type]!.typeDef;
              if (tupleTypeDef is TypeDefTuple &&
                  tupleTypeDef.types.length == 2) {
                generators[type.id] = BTreeMapGenerator.lazy(
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
          if (boundedVec is TypeDefComposite &&
              boundedVec.fields.length == 1 &&
              boundedVec.fields.first.name == null) {
            final sequenceTypeDef =
                types[boundedVec.fields.first.type]!.typeDef;
            if (sequenceTypeDef is TypeDefSequence) {
              final primitiveTypeDef = types[sequenceTypeDef.type]!.typeDef;
              if (primitiveTypeDef is TypeDefPrimitive &&
                  primitiveTypeDef.primitive == Primitive.U8) {
                generators[type.id] = PrimitiveGenerator.str;
                continue;
              }
            }
          } else if (boundedVec is TypeDefSequence) {
            final primitiveTypeDef = types[boundedVec.type]!.typeDef;
            if (primitiveTypeDef is TypeDefPrimitive &&
                primitiveTypeDef.primitive == Primitive.U8) {
              generators[type.id] = PrimitiveGenerator.str;
              continue;
            }
          }
        }

        generators[type.id] = TypeDefGenerator.lazy(
          loader: lazyLoader,
          filePath: listToFilePath([typesPath, ...type.path]),
          name: ReCase(type.path.last).pascalCase,
          codec: composite.fields[0].type,
          docs: type.docs,
        );
        continue;
      }

      // Create Compose Generator
      generators[type.id] = CompositeGenerator(
          filePath: listToFilePath([typesPath, ...type.path]),
          name: type.path.last,
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
    if (type.typeDef is TypeDefVariant) {
      final variant = type.typeDef as TypeDefVariant;

      // Create Empty Generator
      if (variant.variants.isEmpty && type.path.isEmpty) {
        generators[type.id] = EmptyGenerator();
        continue;
      }

      // Create TypeDef Generator
      if (variant.variants.isEmpty) {
        generators[type.id] = TypeDefGenerator(
            filePath: listToFilePath([typesPath, ...type.path]),
            name: ReCase(type.path.last).pascalCase,
            generator: EmptyGenerator(),
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
        generators[type.id] = OptionGenerator.lazy(
            loader: lazyLoader, codec: variant.variants[1].fields[0].type);
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
        generators[type.id] = ResultGenerator.lazy(
          loader: lazyLoader,
          ok: variant.variants[0].fields[0].type,
          err: variant.variants[1].fields[0].type,
        );
        continue;
      }

      // Create Variant Generator
      generators[type.id] = VariantGenerator(
          filePath: listToFilePath([typesPath, ...type.path]),
          name: type.path.last,
          docs: type.docs,
          variants: variant.variants.map((variant) {
            String variantName = ReCase(variant.name).pascalCase;
            if (variantName == type.path.last) {
              variantName = '${variantName}Variant';
            }
            return Variant(
                name: variantName,
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
