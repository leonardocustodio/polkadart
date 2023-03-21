import 'package:polkadart_scale_codec/polkadart_scale_codec.dart';
import 'package:substrate_metadata/definitions/metadata/metadata.dart'
    as metadata_definitions;
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
    assertion(magic == 0x6174656d,
        'Expected magic number 0x6174656d, but got $magic');

    // decode the version information
    final version = U8Codec.codec.decode(source);
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

      return DecodedMetadata(metadata: metadata, version: version);
    } catch (e) {
      if (version != 9) {
        rethrow;
      }
      try {
        final clonnedSource = Input.fromHex(metadataHex);

        U32Codec.codec.decode(clonnedSource);
        U8Codec.codec.decode(clonnedSource);

        final metadata = ScaleCodec(RegistryCreator.instance[10])
            .decode('MetadataV10', clonnedSource);
        return DecodedMetadata(metadata: metadata, version: 10);
      } catch (unknownError) {
        rethrow;
      }
    }
  }

  void encode(DecodedMetadata metadata, Output output) {
    //
    // encode magic number
    U32Codec.codec.encodeTo(0x6174656d, output);

    //
    // encode version
    U8Codec.codec
        .encodeTo(metadata.version == 10 ? 9 : metadata.version, output);

    final typeRegistry = RegistryCreator.instance[metadata.version];

    ScaleCodec(typeRegistry)
        .encodeTo('MetadataV${metadata.version}', metadata.metadata, output);
  }
}

/// Singleton class to create and parse Registry for V9-V14 only once and use it again and again.
class RegistryCreator {
  static final RegistryCreator _singleton = RegistryCreator._internal();

  factory RegistryCreator() {
    return _singleton;
  }

  static RegistryCreator get instance => _singleton;

  RegistryCreator._internal();

  final _registry = <Registry?>[]..length = 6;

  // create [] operator
  Registry operator [](int version) {
    if (version < 9 || version > 14) {
      throw Exception(
          'Expected version between 9 and 14, but got $version, Only V9 - V14 are supported');
    }
    return Registry.from(
        (_registry[version - 9] ?? _createRegistry(version)).codecs);
  }

  Registry _createRegistry(int version) {
    _registry[version - 9] ??= Registry()
      ..parseSpecificCodec(
          metadata_definitions.metadataTypes.types, 'MetadataV$version');

    return _registry[version - 9]!;
  }
}
