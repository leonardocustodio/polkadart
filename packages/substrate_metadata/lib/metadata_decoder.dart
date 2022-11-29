import 'dart:typed_data';
import 'models/models.dart' as model;
import 'package:polkadart_scale_codec/polkadart_scale_codec.dart' as scale;
import 'package:substrate_metadata/old/definitions/metadata/metadata.dart'
    as metadata_definitions;

///
/// It helps to create a single instance of [MetadataDecoder] which helps to decode Metadata.
class MetadataDecoder {
  /// Decodes metadata and returns `Metadata` model
  ///
  /// [data] can be: (Hexa-Decimal [String] || [Uint8List] bytes)
  ///
  /// ```dart
  ///
  /// final Metadata decodedMetadata =  MetadataDecoder().decodeAsMetadata('0x090820....');
  /// ```
  model.Metadata decodeAsMetadata(dynamic data) {
    final result = _decodePrivate(data);
    final version = result['version'];
    final metadata = result['metadata'];
    return model.Metadata.fromVersion(metadata, version);
  }

  /// Decodes metadata and returns `Map<String, dynamic>`
  ///
  /// [data] can be: (Hexa-Decimal [String] || [Uint8List] bytes)
  ///
  /// ```dart
  ///
  /// Map<String, dynamic> decodedMetadataMap =  MetadataDecoder().decode('0x090820....');
  /// ```
  Map<String, dynamic> decode(dynamic data) {
    final result = _decodePrivate(data);
    return result['metadata'];
  }

  /// Private method to decode metadata
  Map<String, dynamic> _decodePrivate(dynamic data) {
    scale.assertionCheck(data is String || data is Uint8List);
    late Uint8List content;
    if (data is String) {
      content = scale.decodeHex(data);
    } else {
      content = data;
    }
    var source = scale.Source(content);

    var magic = source.u32();
    scale.assertionCheck(magic == 0x6174656d,
        'Expected magic number 0x6174656d, but got $magic');

    var version = source.u8();
    scale.assertionCheck(9 <= version,
        'Expected version greater then 9, but got $version. Versions below 9 are not supported by this lib');
    scale.assertionCheck(15 > version,
        'Expected version less then 15, but got $version. Versions above 15 are not supported by this lib');

    // Kusama Hack :o
    // See https://github.com/polkadot-js/api/commit/a9211690be6b68ad6c6dad7852f1665cadcfa5b2
    // for why try-catch and version decoding stuff is here
    try {
      return {
        'version': version,
        'metadata': _decode(version, source),
      };
    } catch (e) {
      if (version != 9) {
        rethrow;
      }
      try {
        source = scale.Source(content);
        source.u32();
        source.u8();
        return {
          'version': 10,
          'metadata': _decode(10, source),
        };
      } catch (unknownError) {
        rethrow;
      }
    }
  }

  /// decodes metadata from the correct match of the metadata version
  Map<String, dynamic> _decode(int version, scale.Source source) {
    var metadataMap = _codec.decodeFromSource(_versions[version - 9], source);
    source.assertEOF();
    return metadataMap;
  }
}

Map<String, dynamic> _objectMap = _createScaleCodec();

List<int> _versions = _objectMap['versions'];
scale.Codec _codec = _objectMap['scale_codec'];

/// Create scale codec to help in decoding the [Source]
Map<String, dynamic> _createScaleCodec() {
  var registry = scale.TypeRegistry(types: metadata_definitions.types.types);
  var versions = List<int>.filled(6, 0);
  for (var i = 9; i < 15; i++) {
    versions[i - 9] = registry.getIndex('MetadataV$i');
  }

  return {
    'versions': versions,
    'scale_codec': scale.Codec(registry.getTypes())
  };
}
