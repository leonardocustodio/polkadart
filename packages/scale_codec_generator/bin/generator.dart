import 'dart:io' show File, Directory;
import 'package:recase/recase.dart' show ReCase;
import 'package:frame_primitives/frame_primitives.dart'
    show Provider, StateApi, RuntimeVersion;
import 'package:args/args.dart' show ArgParser;
import 'package:path/path.dart' as path;
import 'package:scale_codec_generator/scale_codec_generator.dart'
    show
        CompositeGenerator,
        VariantGenerator,
        TypeDefGenerator,
        TupleGenerator,
        Generator,
        GeneratedOutput,
        PalletGenerator,
        PolkadartGenerator;
import 'package:scale_codec_generator/src/generator/frame_metadata.dart'
    show RuntimeMetadataV14;

class ChainProperties {
  final RuntimeMetadataV14 metadata;
  final RuntimeVersion version;

  ChainProperties(this.metadata, this.version);
}

Future<ChainProperties> chainProperties(String url) async {
  final provider = Provider(url);
  final api = StateApi(provider);
  final decodedMetadata = await api.getMetadata();
  if (decodedMetadata.version != 14) {
    await provider.disconnect();
    throw Exception('Only metadata version 14 is supported');
  }
  final version = await api.getRuntimeVersion();
  await provider.disconnect();
  return ChainProperties(
    RuntimeMetadataV14.fromJson(decodedMetadata.toJson()['metadata']),
    version,
  );
}

void main(List<String> args) async {
  final parser = ArgParser();
  parser.addOption('url',
      mandatory: true,
      help: 'Substrate\'s node endpoint url, accept http and websocket');
  parser.addOption('output',
      defaultsTo: './', help: 'Output directory for generated files');
  parser.addFlag('verbose', abbr: 'v', defaultsTo: true);
  final arguments = parser.parse(args);

  final basePath = path.normalize(path.absolute(arguments['output']));
  final verbose = arguments['verbose'] as bool;

  if (!Directory(basePath).existsSync()) {
    print(
        '[ERROR] Provided directory doesn\'t exists: "${path.normalize(arguments['output'])}"');
    return;
  }

  // Get chain properties
  final ChainProperties properties = await chainProperties(arguments['url']);
  final chainDirectory = ReCase(properties.version.specName).snakeCase;

  // Create pallets and types directory
  final typesPath = path.join(basePath, chainDirectory, 'types');
  final palletsPath = path.join(basePath, chainDirectory, 'pallets');
  Directory(path.join(basePath, chainDirectory)).createSync(recursive: false);
  Directory(typesPath).createSync(recursive: false);
  Directory(palletsPath).createSync(recursive: false);

  // Polkadart path
  final polkadartPath = path.setExtension(
      path.join(basePath, chainDirectory, chainDirectory), '.dart');

  // Get type generators
  final Map<int, Generator> generators =
      Generator.fromTypes(properties.metadata.registry, typesPath);

  // Get pallet generators
  final List<PalletGenerator> palletGenerators = properties.metadata.pallets
      // Remove Empty Pallets
      // TODO: remove this field once we support extrinsics
      .where((pallet) => pallet.storage != null || pallet.constants.isNotEmpty)
      .map((pallet) => PalletGenerator.fromMetadata(
            filePath:
                path.join(palletsPath, '${ReCase(pallet.name).snakeCase}.dart'),
            palletMetadata: pallet,
            registry: generators,
          ))
      .toList();

  if (verbose) {
    print('  Types found: ${generators.length}');
    print('Pallets found: ${palletGenerators.length}');
  }

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
        continue;
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
          final filename = path.basenameWithoutExtension(generator.filePath);
          generator.filePath = path.join(
              path.dirname(generator.filePath), '${filename}_$index.dart');
          generatorPerFile[generator.filePath] = [generator];
          return true;
        } else if (generator is VariantGenerator) {
          final filename = path.basenameWithoutExtension(generator.filePath);
          generator.filePath = path.join(
              path.dirname(generator.filePath), '${filename}_$index.dart');
          for (final variant in generator.variants) {
            if (variant.name == generator.name) {
              variant.name = '${variant.name}Variant';
            }
          }
          generatorPerFile[generator.filePath] = [generator];
          return true;
        } else if (generator is TypeDefGenerator) {
          final filename = path.basenameWithoutExtension(generator.filePath);
          generator.filePath = path.join(
              path.dirname(generator.filePath), '${filename}_$index.dart');
          generatorPerFile[generator.filePath] = [generator];
          return true;
        }
        return false;
      });
    }
  }

  // Write the Generated Files
  for (final entry in generatorPerFile.entries) {
    if (entry.value.isEmpty) {
      continue;
    }
    if (verbose) {
      print(path.relative(entry.key, from: basePath));
    }

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

    final String code = entry.value
        .fold(
            GeneratedOutput(classes: [], enums: [], typedefs: []),
            (previousValue, element) =>
                previousValue.merge(element.generated()!))
        .build();
    Directory(path.dirname(entry.key)).createSync(recursive: true);
    File(entry.key).writeAsStringSync(code);
  }

  // Write the Pallets Files
  for (final pallet in palletGenerators) {
    final String code = pallet.generated().build();
    Directory(path.dirname(pallet.filePath)).createSync(recursive: true);
    File(pallet.filePath).writeAsStringSync(code);
    if (verbose) {
      print(path.relative(pallet.filePath, from: basePath));
    }
  }

  // Write the Polkadart File
  final polkadartGenerator = PolkadartGenerator(
    filePath: polkadartPath,
    name: ReCase(properties.version.specName).pascalCase,
    pallets: palletGenerators,
  ).generated().build();
  File(polkadartPath).writeAsStringSync(polkadartGenerator);
  if (verbose) {
    print(path.relative(polkadartPath, from: basePath));
  }
}
