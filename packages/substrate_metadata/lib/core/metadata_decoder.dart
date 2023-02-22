import 'package:polkadart_scale_codec/polkadart_scale_codec.dart';
import 'package:substrate_metadata/definitions/metadata/metadata.dart'
    as metadata_definitions;
import 'package:substrate_metadata/types/metadata_types.dart';

class MetadataDecoder {
  late Registry typeRegistry;

  MetadataDecoder.fromTypes(Map<String, dynamic> types) {
    typeRegistry = Registry()..registerCustomCodec(types);
  }

  MetadataDecoder();

  ///
  /// Decode metadata from Input
  Map<String, dynamic> decode(Input input) {
    return _decodePrivate(input);
  }

  void encode(Map<String, dynamic> metadata, int version, Output output) {
    final magic = 0x6174656d;
    U32Codec.instance.encodeTo(magic, output);

    U8Codec.instance.encodeTo(version, output);

    typeRegistry = Registry()
      ..registerCustomCodec(
          metadata_definitions.metadataTypes.types, 'MetadataV$version');

    ScaleCodec(typeRegistry)
        .encodeTo('MetadataV$version', metadata['metadata'], output);
  }

  ///
  /// Private method to decode metadata
  Map<String, dynamic> _decodePrivate(Input source) {
    final magic = U32Codec.instance.decode(source);
    assertion(magic == 0x6174656d,
        'Expected magic number 0x6174656d, but got $magic');

    final version = U8Codec.instance.decode(source);
    assertion(9 <= version,
        'Expected version greater then 9, but got $version. Versions below 9 are not supported by this lib');
    assertion(15 > version,
        'Expected version less then 15, but got $version. Versions above 15 are not supported by this lib');

    typeRegistry = Registry()
      ..registerCustomCodec(
          metadata_definitions.metadataTypes.types, 'MetadataV$version');
    //
    // This is important to separate the V14 decoding because
    // the types mapping is changed with optimisation in v14
    //
    // Hence V14 decoding is handled separately to simplify the decoding of events and extrinsics by pre-analysing the lookup types.

    if (version == 14) {
      return MetadataV14.fromRegistry(typeRegistry).decode(source);
    }

    // Kusama Hack :o
    // See https://github.com/polkadot-js/api/commit/a9211690be6b68ad6c6dad7852f1665cadcfa5b2
    // for why try-catch and version decoding stuff is here
    try {
      return {
        'version': version,
        'metadata':
            ScaleCodec(typeRegistry).decode('MetadataV$version', source),
      };
    } catch (e) {
      if (version != 9) {
        rethrow;
      }
      try {
        return {
          'version': 10,
          'metadata':
              ScaleCodec(typeRegistry).decode('MetadataV$version', source),
        };
      } catch (unknownError) {
        rethrow;
      }
    }
  }
}
