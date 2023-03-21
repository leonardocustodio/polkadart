import 'dart:io' show Directory;
import 'package:polkadart/polkadart.dart'
    show Provider, StateApi, RuntimeVersion;
import 'package:args/args.dart' show ArgParser;
import 'package:path/path.dart' as path;
import 'package:recase/recase.dart' show ReCase;
import 'package:polkadart_cli/polkadart_cli.dart' show ChainGenerator;
import 'package:polkadart_cli/src/typegen/frame_metadata.dart'
    show RuntimeMetadataV14;

class ChainProperties {
  final RuntimeMetadataV14 metadata;
  final RuntimeVersion version;

  ChainProperties(this.metadata, this.version);

  static Future<ChainProperties> fromURL(String url) async {
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

  // Create chain directory
  final chainDirectory = Directory(
      path.join(basePath, ReCase(properties.version.implName).snakeCase));
  chainDirectory.createSync(recursive: false);

  final generator = ChainGenerator.fromMetadata(
      chainName: properties.version.implName,
      basePath: chainDirectory,
      metadata: properties.metadata);
  generator.build(verbose: verbose);
}
