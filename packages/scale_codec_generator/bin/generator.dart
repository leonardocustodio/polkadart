import 'dart:convert' show jsonDecode;
import 'dart:io' show File, Directory;
import 'package:recase/recase.dart' show ReCase;
import 'package:polkadart_scale_codec/polkadart_scale_codec.dart'
    show BitStore, BitOrder;

import './generators/array.dart' show ArrayGenerator;
import './generators/btreemap.dart' show BTreeMapGenerator;
import './generators/bit_sequence.dart' show BitSequenceGenerator;
import './generators/composite.dart' show CompositeGenerator;
import './generators/compact.dart' show CompactGenerator;
import './generators/variant.dart' show VariantGenerator, Variant;
import './generators/primitive.dart' show PrimitiveGenerator;
import './generators/sequence.dart' show SequenceGenerator;
import './generators/option.dart' show OptionGenerator;
import './generators/result.dart' show ResultGenerator;
import './generators/typedef.dart' show TypeDefGenerator;
import './generators/tuple.dart' show TupleGenerator;
import './generators/empty.dart' show EmptyGenerator;
import './generators/base.dart'
    show Field, Generator, LazyLoader, GeneratedOutput;
import './generators/pallet.dart' show PalletGenerator;
import './generators/polkadart.dart' show PolkadartGenerator;
import './metadata_parser.dart'
    show
        TypeMetadata,
        TypeDefVariant,
        TypeDefSequence,
        TypeDefArray,
        TypeDefBitSequence,
        TypeDefCompact,
        TypeDefComposite,
        TypeDefPrimitive,
        TypeDefTuple;

const generatedPath = 'generated/types';
const palletsPath = 'generated/pallets';

class SimpleEnumCodec {
  final Map<int, String> variants;

  const SimpleEnumCodec.sparse(this.variants);

  factory SimpleEnumCodec(List<String> variants) {
    return SimpleEnumCodec.sparse(
        {for (var i = 0; i < variants.length; i++) i: variants[i]});
  }
}

void main(List<String> arguments) {
  // URL -> rpc.polkadot.io
  // outputPath -> ./generated
  final filePath = './metadata-polkadot.json';
  final typesJson = (jsonDecode(File(filePath).readAsStringSync())['lookup']
      ['types'] as List<dynamic>);
  final palletsJson = (jsonDecode(File(filePath).readAsStringSync())['pallets']
      as List<dynamic>);

  // Type Definitions
  final Map<int, TypeMetadata> types = {
    for (var type in typesJson) type['id']: TypeMetadata.parseJSON(type)
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
            filePath: '$generatedPath/${type.path.join('/')}.dart',
            name: ReCase(type.path.last).pascalCase,
            generator: EmptyGenerator());
        continue;
      }

      generators[type.id] = TupleGenerator.lazy(
        loader: lazyLoader,
        filePath: '$generatedPath/tuples.dart',
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
            filePath: '$generatedPath/${type.path.join('/')}.dart',
            name: ReCase(type.path.last).pascalCase,
            generator: EmptyGenerator());
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

        generators[type.id] = TypeDefGenerator.lazy(
          loader: lazyLoader,
          filePath: '$generatedPath/${type.path.join('/')}.dart',
          name: ReCase(type.path.last).pascalCase,
          codec: composite.fields[0].type,
        );
        continue;
      }

      // Create Compose Generator
      int index = 0;
      generators[type.id] = CompositeGenerator(
          filePath: '$generatedPath/${type.path.join('/')}.dart',
          name: type.path.last,
          fields: composite.fields
              .map((field) => Field.lazy(
                  loader: lazyLoader,
                  codec: field.type,
                  name: field.name ?? 'value${index++}'))
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
            filePath: '$generatedPath/${type.path.join('/')}.dart',
            name: ReCase(type.path.last).pascalCase,
            generator: EmptyGenerator());
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
          filePath: '$generatedPath/${type.path.join('/')}.dart',
          name: type.path.last,
          variants: variant.variants.map((variant) {
            String variantName = ReCase(variant.name).pascalCase;
            if (variantName == type.path.last) {
              variantName = '${variantName}Variant';
            }
            int index = 0;
            return Variant(
                name: variantName,
                index: variant.index,
                fields: variant.fields.map((field) {
                  final String name =
                      Field.toFieldName(field.name ?? 'value$index');
                  index++;
                  return Field.lazy(
                      loader: lazyLoader, codec: field.type, name: name);
                }).toList());
          }).toList());
      continue;
    }

    throw Exception('Unknown type ${type.typeDef}');
  }

  // Load generators
  for (final callback in lazyLoader.loaders) {
    callback(generators);
  }

  print('Generators found: ${generators.length}');
  final List<PalletGenerator> palletGenerators = palletsJson
      .map((json) => PalletGenerator.fromJson(
            filePrefix: palletsPath,
            json: json,
            generators: generators,
          ))
      .toList();
  print('   Pallets found: ${palletGenerators.length}');

  // Group generators per file
  // key = file path
  // value = list of generators
  final Map<String, List<Generator>> generatorPerFile = {};
  for (final generator in generators.values) {
    if (generator is CompositeGenerator) {
      if (!generatorPerFile.containsKey(generator.filePath)) {
        generatorPerFile[generator.filePath] = [];
      }
      generatorPerFile[generator.filePath]!.add(generator);
    } else if (generator is VariantGenerator) {
      if (!generatorPerFile.containsKey(generator.filePath)) {
        generatorPerFile[generator.filePath] = [];
      }
      generatorPerFile[generator.filePath]!.add(generator);
    } else if (generator is TypeDefGenerator) {
      if (!generatorPerFile.containsKey(generator.filePath)) {
        generatorPerFile[generator.filePath] = [];
      }
      generatorPerFile[generator.filePath]!.add(generator);
    } else if (generator is TupleGenerator) {
      if (!generatorPerFile.containsKey(generator.filePath)) {
        generatorPerFile[generator.filePath] = [];
      }
      final tupleGenerators =
          generatorPerFile[generator.filePath] as List<Generator>;
      if (tupleGenerators.any((tuple) {
        if (tuple is TupleGenerator) {
          return tuple.generators.length == generator.generators.length;
        }
        return false;
      })) {
        return;
      }
      generatorPerFile[generator.filePath]!.add(generator);
    }
  }

  // Rename ambiguous generators
  for (final entry
      in Map<String, List<Generator>>.from(generatorPerFile).entries) {
    final generatorList = entry.value;
    if (generatorList.length > 1) {
      int index = 0;
      generatorList.removeWhere((generator) {
        index++;
        if (generator is CompositeGenerator) {
          generator.filePath =
              '${generator.filePath.substring(0, generator.filePath.length - 5)}_$index.dart';
          generatorPerFile[generator.filePath] = [generator];
          return true;
        } else if (generator is VariantGenerator) {
          generator.filePath =
              '${generator.filePath.substring(0, generator.filePath.length - 5)}_$index.dart';
          for (final variant in generator.variants) {
            if (variant.name == generator.name) {
              variant.name = '${variant.name}Variant';
            }
          }
          generatorPerFile[generator.filePath] = [generator];
          return true;
        } else if (generator is TypeDefGenerator) {
          generator.filePath =
              '${generator.filePath.substring(0, generator.filePath.length - 5)}_$index.dart';
          generatorPerFile[generator.filePath] = [generator];
          return true;
        }
        return false;
      });
    }
  }

  final polkadartGenerator = PolkadartGenerator(
    filePath: 'generated/polkadart.dart',
    name: 'Polkadot',
    pallets: palletGenerators,
  ).generated().build().replaceAll('import \'generated/', 'import \'./');
  Directory('./bin/generated').createSync(recursive: true);
  File('./bin/generated/polkadart.dart').writeAsStringSync(polkadartGenerator);

  // Write the Pallets Files
  for (final pallet in palletGenerators) {
    final List path = pallet.filePath.split('/').toList();
    final fileName = path.removeLast();
    final dir = './bin/${path.join('/')}';
    print('$dir/$fileName');

    String code = pallet.generated().build();

    if (path.length == 1) {
      code = code.replaceAll('import \'$generatedPath/', 'import \'../types/');
    } else if (path.length == 2) {
      code = code.replaceAll('import \'$generatedPath/', 'import \'../types/');
    } else if (path.length == 3) {
      code = code.replaceAll('import \'$generatedPath/', 'import \'../types/');
    } else if (path.length == 4) {
      code =
          code.replaceAll('import \'$generatedPath/', 'import \'../../types/');
    } else if (path.length == 5) {
      code = code.replaceAll(
          'import \'$generatedPath/', 'import \'../../../types/');
    }

    if (path.length == 1) {
      code = code.replaceAll('import \'$palletsPath/', 'import \'');
    } else if (path.length == 2) {
      code = code.replaceAll('import \'$palletsPath/', 'import \'');
    } else if (path.length == 3) {
      code = code.replaceAll('import \'$palletsPath/', 'import \'../');
    } else if (path.length == 4) {
      code = code.replaceAll('import \'$palletsPath/', 'import \'../../');
    } else if (path.length == 5) {
      code = code.replaceAll('import \'$palletsPath/', 'import \'../../../');
    }

    Directory(dir).createSync(recursive: true);
    File('$dir/$fileName').writeAsStringSync(code);
  }

  // Write the Generated Files
  for (final entry in generatorPerFile.entries) {
    if (entry.value.isEmpty) {
      continue;
    }

    final List path = entry.key.split('/').toList();
    final fileName = path.removeLast();
    final dir = './bin/${path.join('/')}';
    print('$dir/$fileName');

    for (final generator in entry.value) {
      if (generator is CompositeGenerator) {
        assert(entry.key == generator.filePath);
      } else if (generator is VariantGenerator) {
        assert(entry.key == generator.filePath);
      } else if (generator is TypeDefGenerator) {
        assert(entry.key == generator.filePath);
      } else if (generator is TupleGenerator) {
        assert(entry.key == generator.filePath);
      }
    }

    String code = entry.value
        .fold(
            GeneratedOutput(classes: [], enums: [], typedefs: []),
            (previousValue, element) =>
                previousValue.merge(element.generated()!))
        .build();

    if (path.length == 1) {
      code = code.replaceAll('import \'$generatedPath/', 'import \'');
    } else if (path.length == 2) {
      code = code.replaceAll('import \'$generatedPath/', 'import \'');
    } else if (path.length == 3) {
      code = code.replaceAll('import \'$generatedPath/', 'import \'../');
    } else if (path.length == 4) {
      code = code.replaceAll('import \'$generatedPath/', 'import \'../../');
    } else if (path.length == 5) {
      code = code.replaceAll('import \'$generatedPath/', 'import \'../../../');
    }

    Directory(dir).createSync(recursive: true);
    File('$dir/$fileName').writeAsStringSync(code);
  }
}
