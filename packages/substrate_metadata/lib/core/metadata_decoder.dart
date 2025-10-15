import 'package:polkadart_scale_codec/polkadart_scale_codec.dart';
import 'package:substrate_metadata/definitions/metadata/metadata.dart' as metadata_definitions;
import 'package:substrate_metadata/models/models.dart';

class MetadataDecoder {
  ///
  /// Constructor
  const MetadataDecoder._();

  static const instance = MetadataDecoder._();

  ///
  /// Decode metadata from Input
  DecodedMetadata decode(String metadataHex) {
    //
    // Create input from Hexa-deciaml String
    final source = Input.fromHex(metadataHex);

    //
    // Decode the magic number
    final magic = U32Codec.codec.decode(source);

    //
    // assert that the magic number is 0x6174656d
    assertion(magic == 0x6174656d, 'Expected magic number 0x6174656d, but got $magic');

    // decode the version information
    final version = U8Codec.codec.decode(source);

    // Only V14 and V15 are supported
    if (version < 14) {
      throw UnsupportedError(
        'Metadata version $version is not supported. '
        'Only v14 and v15 are supported. '
        'Use substrate_metadata v1.x for legacy version support.'
      );
    }

    if (version > 15) {
      throw UnsupportedError(
        'Metadata version $version is not yet supported. '
        'Maximum supported version is v15.'
      );
    }

    final metadata =
        ScaleCodec(RegistryCreator.instance[version]).decode('MetadataV$version', source);

    return DecodedMetadata(metadata: metadata, version: version);
  }

  void encode(DecodedMetadata metadata, Output output) {
    //
    // encode magic number
    U32Codec.codec.encodeTo(0x6174656d, output);

    //
    // encode version (only V14 and V15 supported)
    U8Codec.codec.encodeTo(metadata.version, output);

    final typeRegistry = RegistryCreator.instance[metadata.version];

    ScaleCodec(typeRegistry).encodeTo('MetadataV${metadata.version}', metadata.metadata, output);
  }
}

/// Singleton class to create and parse Registry for V14-V15 only once and use it again and again.
class RegistryCreator {
  static final RegistryCreator _singleton = RegistryCreator._internal();

  factory RegistryCreator() {
    return _singleton;
  }

  static RegistryCreator get instance => _singleton;

  RegistryCreator._internal();

  // Only store V14 and V15 (indices 0 and 1)
  final _registry = <Registry?>[]..length = 2;

  // create [] operator
  Registry operator [](int version) {
    if (version < 14 || version > 15) {
      throw UnsupportedError(
          'Metadata version $version is not supported. Only V14 and V15 are supported.');
    }
    // Convert version 14->0, 15->1
    return Registry.from((_registry[version - 14] ?? _createRegistry(version)).codecs);
  }

  Registry _createRegistry(int version) {
    _registry[version - 14] ??= Registry()
      ..parseSpecificCodec(metadata_definitions.metadataTypes, 'MetadataV$version');

    return _registry[version - 14]!;
  }
}
