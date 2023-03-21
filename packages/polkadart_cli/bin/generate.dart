import 'dart:io' show Directory;
import 'package:polkadart/polkadart.dart'
    show Provider, StateApi, RuntimeVersion;
import 'package:args/args.dart' show ArgParser;
import 'package:path/path.dart' as path;
import 'package:recase/recase.dart' show ReCase;
import 'package:polkadart_cli/polkadart_cli.dart'
    show ChainGenerator, PubspecConfig;
import 'package:polkadart_cli/src/typegen/runtime_metadata_v14.dart'
    show RuntimeMetadataV14;

class ChainProperties {
  final RuntimeMetadataV14 metadata;
  final RuntimeVersion version;

  ChainProperties(this.metadata, this.version);

  static Future<ChainProperties> fromURL(Uri uri) async {
    final provider = Provider(uri);
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
}

Future<ChainProperties> chainProperties(Uri url) async {
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
  final config = PubspecConfig.fromPubspecFile();
  final parser = ArgParser();
  parser.addFlag('verbose', abbr: 'v', defaultsTo: false);
  final arguments = parser.parse(args);

  final basePath = path.normalize(path.absolute(config.outputDir));
  print(basePath);
  final verbose = arguments['verbose'] as bool;

  if (!Directory(basePath).existsSync()) {
    print(
        '[ERROR] Provided directory doesn\'t exists: "${path.normalize(arguments['output'])}"');
    return;
  }

  for (final entry in config.chains.entries) {
    final chainName = entry.key;
    final chain = entry.value;

    // Get chain properties
    final ChainProperties properties = await chainProperties(chain.metadataUri);

    // Create chain directory
    final chainDirectory =
        Directory(path.join(basePath, ReCase(chainName).snakeCase));
    await chainDirectory.create(recursive: false);

    // Extract metadata
    final generator = ChainGenerator.fromMetadata(
        chainName: chainName,
        basePath: chainDirectory,
        metadata: properties.metadata);

    // Generate files
    await generator.build(verbose: verbose);
  }
}
