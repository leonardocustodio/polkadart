import 'dart:convert';
import 'dart:io' show Directory, File;
import 'package:polkadart/polkadart.dart'
    show Provider, StateApi, RuntimeVersion;
import 'package:args/args.dart' show ArgParser;
import 'package:path/path.dart' as path;
import 'package:polkadart/scale_codec.dart';
import 'package:recase/recase.dart' show ReCase;
import 'package:polkadart_cli/polkadart_cli.dart'
    show ChainGenerator, PubspecConfig;
import 'package:substrate_metadata/substrate_metadata.dart'
    show RuntimeMetadata, RuntimeMetadataPrefixed;

class ChainProperties {
  final RuntimeMetadata metadata;
  final RuntimeVersion version;

  ChainProperties(this.metadata, this.version);

  static Future<ChainProperties> fromFile(Uri uri) async {
    print(uri.path);
    final provider =
        Provider.fromUri(Uri.parse('wss://kusama-rpc.polkadot.io'));
    final api = StateApi(provider);
    final version = await api.getRuntimeVersion();

    final metadata = await File(uri.path).readAsBytes();
    final metadataPrefixed =
        RuntimeMetadataPrefixed.fromHex(encodeHex(metadata));

    // write json to file
    final metadataFile = File('metadata.json');
    metadataFile.writeAsStringSync(metadataPrefixed.toJson().toString());

    return ChainProperties(
      metadataPrefixed.metadata,
      version,
    );
  }

  static Future<ChainProperties> fromURL(Uri uri) async {
    final provider = Provider.fromUri(uri);
    final api = StateApi(provider);
    final decodedMetadata = await api.getMetadata();
    final version = await api.getRuntimeVersion();

    await provider.disconnect();

    if (![14, 15].contains(decodedMetadata.metadata.runtimeMetadataVersion())) {
      throw Exception('Only metadata versions 14 and 15 are supported');
    }

    return ChainProperties(
      decodedMetadata.metadata,
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
        await ChainProperties.fromFile(chain.metadataUri);

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
