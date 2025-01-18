import 'dart:io' show Directory;
import 'package:polkadart/polkadart.dart'
    show Provider, StateApi, RuntimeVersion;
import 'package:args/args.dart' show ArgParser;
import 'package:path/path.dart' as path;
import 'package:recase/recase.dart' show ReCase;
import 'package:polkadart_cli/polkadart_cli.dart'
    show ChainGenerator, PubspecConfig;
import 'package:substrate_metadata/substrate_metadata.dart'
    show RuntimeMetadataV15, RuntimeMetadataV14;

class ChainProperties {
  final RuntimeMetadataV14 metadata;
  final RuntimeVersion version;

  ChainProperties(this.metadata, this.version);

  static Future<ChainProperties> fromURL(Uri uri) async {
    final provider = Provider.fromUri(uri);
    final api = StateApi(provider);
    final decodedMetadata = await api.getMetadata();
    if (decodedMetadata.metadata is! RuntimeMetadataV15 &&
        decodedMetadata.metadata is! RuntimeMetadataV14) {
      await provider.disconnect();
      throw Exception('Only metadata versions 14 and 15 are supported');
    }
    final version = await api.getRuntimeVersion();
    await provider.disconnect();
    return ChainProperties(
      decodedMetadata.metadata as RuntimeMetadataV14,
      version,
    );
  }
}

void main(List<String> args) async {
  final config = PubspecConfig.fromPubspecFile();
  final parser = ArgParser();
  parser.addFlag('verbose', abbr: 'v', defaultsTo: false);
  final arguments = parser.parse(args);

  final basePath = Directory(path.normalize(path.absolute(config.outputDir)));
  final verbose = arguments['verbose'] as bool;

  if (verbose) {
    print('output directory: "${basePath.path}"');
  }

  if (!basePath.existsSync()) {
    basePath.createSync(recursive: false);
  }

  for (final entry in config.chains.entries) {
    final chainName = entry.key;
    final chain = entry.value;

    // Get chain properties
    final ChainProperties properties =
        await ChainProperties.fromURL(chain.metadataUri);

    // Create chain directory
    final chainDirectory =
        Directory(path.join(basePath.path, ReCase(chainName).snakeCase));
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
