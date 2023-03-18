import 'dart:io' show File, Directory;
import 'package:frame_primitives/frame_primitives.dart' show Provider, StateApi;
import 'package:args/args.dart' show ArgParser;
import 'package:path/path.dart' as path;
import 'package:scale_codec_generator/scale_codec_generator.dart'
    show ChainGenerator, ChainProperties;
import 'package:scale_codec_generator/src/typegen/frame_metadata.dart'
    show RuntimeMetadataV14;

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
  final generator = ChainGenerator.fromChainProperties(
      basePath: Directory(basePath), properties: properties);
  generator.build(verbose: verbose);
}
