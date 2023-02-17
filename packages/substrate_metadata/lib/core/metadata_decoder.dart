import 'package:polkadart_scale_codec/polkadart_scale_codec.dart';
import 'package:substrate_metadata/metadata_definitions/metadata_definitions.dart'
    as metadata_definitions;

class MetadataDecoder {
  late final Registry typeRegistry;

  MetadataDecoder._() {
    typeRegistry = Registry()
      ..registerCustomCodec(metadata_definitions.METADATA_DEFINITIONS);
  }

  static final MetadataDecoder _instance = MetadataDecoder._();

  static MetadataDecoder get instance => _instance;

  ///
  /// Decode metadata from Input
  Map<String, dynamic> decode(Input input) {
    return _decodePrivate(input);
  }

  void encode(Map<String, dynamic> metadata, Output output) {
    final magic = 0x6174656d;
    U32Codec.instance.encodeTo(magic, output);

    final version = metadata['version'];
    U8Codec.instance.encodeTo(version, output);

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

    // Kusama Hack :o
    // See https://github.com/polkadot-js/api/commit/a9211690be6b68ad6c6dad7852f1665cadcfa5b2
    // for why try-catch and version decoding stuff is here
    //try {
    return {
      'version': version,
      'metadata': ScaleCodec(typeRegistry).decode('MetadataV$version', source),
    };
    /* } catch (e) {
      if (version != 9) {
        rethrow;
      }
      try {
        source = ByteInput(content);
        U32Codec.instance.decode(source);
        U8Codec.instance.decode(source);
        return {
          'version': 10,
          'metadata':
              ScaleCodec(typeRegistry).decode('MetadataV$version', source),
        };
      } catch (unknownError) {
        rethrow;
      }
    } */
  }
}
