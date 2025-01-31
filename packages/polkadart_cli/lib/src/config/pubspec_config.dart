import 'dart:io' show File;
import 'package:yaml/yaml.dart' as yaml;

import '../utils/file_utils.dart';
import 'config_exception.dart';

class PubspecConfig {
  /// Must be set to true to activate the package. Default: false
  final bool _enabled;

  /// Sets the directory of generated polkadart files. Provided value should be a valid path on your system. Default: lib/generated
  final String _outputDir;

  /// Chain settings
  final Map<String, ChainSettings> _chains;

  PubspecConfig._({
    required bool enabled,
    required String outputDir,
    required Map<String, ChainSettings> chains,
  })  : _enabled = enabled,
        _outputDir = outputDir,
        _chains = chains;

  factory PubspecConfig.fromPubspecFile() {
    final pubspecFile = getPubspecFile();
    if (pubspecFile == null) {
      throw ConfigException("Can't find 'pubspec.yaml' file.");
    }
    return PubspecConfig.fromYAML(pubspecFile);
  }

  factory PubspecConfig.fromYAML(File pubspecFile) {
    final pubspecFileContent = pubspecFile.readAsStringSync();
    final pubspecYaml = yaml.loadYaml(pubspecFileContent);

    if (pubspecYaml is! yaml.YamlMap) {
      throw ConfigException.parseError(
          'Expected YAML map but got ${pubspecYaml.runtimeType}.');
    }

    // Extract polkadart section
    final polkadartConfig = pubspecYaml['polkadart'];
    if (polkadartConfig == null) {
      throw ConfigException.parseError("Can't find 'polkadart' section.");
    }

    // Extract polkadart.enabled section
    final enabled = polkadartConfig['enabled'];
    if (enabled != null && enabled is! bool) {
      throw ConfigException.invalidField(
          path: 'polkadart.enabled',
          expect: 'boolean',
          actual: enabled.runtimeType);
    }

    // Extract polkadart.output_dir section
    final outputDir = polkadartConfig['output_dir'];
    if (outputDir != null && outputDir is! String) {
      throw ConfigException.invalidField(
          path: 'polkadart.output_dir',
          expect: 'string',
          actual: outputDir.runtimeType);
    }

    // Extract polkadart.chains section
    final chains = polkadartConfig['chains'];
    if (chains == null) {
      throw ConfigException.parseError(
          "Can't find 'polkadart.chains' section.");
    }
    if (chains is! yaml.YamlMap) {
      throw ConfigException.invalidField(
          path: 'polkadart.chains',
          expect: 'YAML map',
          actual: chains.runtimeType);
    }

    return PubspecConfig._(
      enabled: polkadartConfig['enabled'] ?? false,
      outputDir: polkadartConfig['output_dir'] ?? './lib/generated',
      chains: {
        for (final entry in chains.entries)
          entry.key: ChainSettings.fromConfig(
              'polkadart.chains.${entry.key}', entry.value)
      },
    );
  }

  bool get enabled => _enabled;

  String get outputDir => _outputDir;

  Map<String, ChainSettings> get chains => _chains;
}

const Set<String> _validUriSchemes = {'wss', 'ws', 'https', 'http', 'file'};

class ChainSettings {
  /// Sets the name for the generated polkadart class. Default to chain implName
  Uri _metadataUri;

  /// Sets the name for the generated polkadart class. Default: Polkadart
  String? _className;

  ChainSettings(this._metadataUri, [this._className]);

  factory ChainSettings.fromConfig(String path, dynamic chainSettings) {
    if (chainSettings == null) {
      throw ConfigException('"$path": Chain settings cannot be empty');
    }

    // Parse metadata_uri
    final Uri metadataUri;
    if (chainSettings is String) {
      metadataUri = Uri.parse(chainSettings);
    } else {
      if (chainSettings is yaml.YamlMap) {
        final uri = chainSettings['metadata_uri'];
        if (uri == null) {
          throw ConfigException.parseError(
              "Can't find '$path.metadata_uri' section.");
        }
        if (uri is! String) {
          throw ConfigException.invalidField(
              path: '$path.metadata_uri',
              expect: 'string',
              actual: uri.runtimeType);
        }
        metadataUri = Uri.parse(uri);
      } else {
        throw ConfigException.invalidField(
            path: path,
            expect: 'string or YAML map',
            actual: chainSettings.runtimeType);
      }
    }

    // if (!_validUriSchemes.contains(metadataUri.scheme)) {
    //   throw ConfigException(
    //       'The parameter "$path.metadata_uri" is invalid, must a valid Websocket (wss/ws) or (http/https) uri');
    // }

    // Parse class_name
    // final classname = chainSettings['class_name'];
    // if (classname != null && classname is! String) {
    //   throw ConfigException.invalidField(
    //       path: '$path.metadata_uri',
    //       expect: 'string',
    //       actual: classname.runtimeType);
    // }

    return ChainSettings(metadataUri, 'Polkadot');
  }

  Uri get metadataUri => _metadataUri;

  String? get className => _className;
}
