import 'package:polkadart_scale_codec/polkadart_scale_codec.dart';
import 'package:substrate_metadata/models/models.dart' as models;
import 'package:substrate_metadata/definitions/metadata/metadata.dart'
    as metadata_definitions;

class MetadataDecoder {
  //
  // Constructor
  const MetadataDecoder();

  ///
  /// Decode metadata from Input
  models.Metadata decodeAsMetadata(String metadataHex) {
    final result = _decodePrivate(metadataHex);
    final version = result['version'];
    return models.Metadata.fromVersion(result['metadata'], version);
  }

  ///
  /// Decode metadata from Hexadecimal String
  Map<String, dynamic> decode(String metadataHex) {
    return _decodePrivate(metadataHex);
  }

  ///
  /// Private method to decode metadata
  Map<String, dynamic> _decodePrivate(String hex) {
    //
    // Create input from Hexa-deciaml String
    final source = HexInput(hex);

    //
    // Decode the magic number
    final magic = U32Codec.instance.decode(source);

    //
    // assert that the magic number is 0x6174656d
    assertion(magic == 0x6174656d,
        'Expected magic number 0x6174656d, but got $magic');

    // decode the version information
    final version = U8Codec.instance.decode(source);
    assertion(9 <= version,
        'Expected version greater then 9, but got $version. Versions below 9 are not supported by this lib');
    assertion(15 > version,
        'Expected version less then 15, but got $version. Versions above 15 are not supported by this lib');

    // Kusama Hack :o
    // See https://github.com/polkadot-js/api/commit/a9211690be6b68ad6c6dad7852f1665cadcfa5b2
    // for why try-catch and version decoding stuff is here
    try {
      final metadata = ScaleCodec(RegistryCreator.instance[version])
          .decode('MetadataV$version', source);

      return {
        'version': version,
        'metadata': metadata,
      };
    } catch (e) {
      if (version != 9) {
        rethrow;
      }
      try {
        final clonnedSource = HexInput(hex);

        U32Codec.instance.decode(clonnedSource);
        U8Codec.instance.decode(clonnedSource);

        final metadata = ScaleCodec(RegistryCreator.instance[10])
            .decode('MetadataV10', clonnedSource);
        return {
          'version': 10,
          'metadata': metadata,
        };
      } catch (unknownError) {
        rethrow;
      }
    }
  }

  void encode(Map<String, dynamic> metadata, int version, Output output) {
    final magic = 0x6174656d;
    //
    // encode magic number
    U32Codec.instance.encodeTo(magic, output);

    //
    // encode version
    U8Codec.instance.encodeTo(version == 10 ? 9 : version, output);

    final typeRegistry = RegistryCreator.instance[version];

    ScaleCodec(typeRegistry).encodeTo('MetadataV$version', metadata, output);
  }
}

/// Singleton class to create and parse Registry for V9-V14 only once and use it again and again.
class RegistryCreator {
  static final RegistryCreator _singleton = RegistryCreator._internal();

  factory RegistryCreator() {
    return _singleton;
  }

  static RegistryCreator get instance => _singleton;

  RegistryCreator._internal() {
    for (var i = 9; i < 15; i++) {
      _createRegistry(i);
    }
  }

  final registry = <Registry>[];

  // create [] operator
  Registry operator [](int version) {
    if (version < 9 || version > 14) {
      throw Exception(
          'Expected version between 9 and 14, but got $version, Only V9 - V14 are supported');
    }
    return registry[version - 9];
  }

  void _createRegistry(int version) {
    registry.add(Registry()
      ..registerCustomCodec(
          metadata_definitions.metadataTypes.types, 'MetadataV$version'));
  }
}
