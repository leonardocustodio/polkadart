import 'dart:typed_data';
import 'package:polkadart_scale_codec/polkadart_scale_codec.dart' as scale;
import 'models/models.dart' as model;
import './old/definitions/metadata/index.dart' as metadata_definitions;
import './old/type_registry.dart' as type_registry;

model.Metadata decodeMetadata(dynamic data) {
  scale.assertionCheck(data is String || data is Uint8List);
  late Uint8List content;
  if (data is String) {
    content = scale.decodeHex(data);
  } else {
    content = data;
  }
  var src = scale.Src(content);

  var magic = src.u32();
  scale.assertionCheck(
      magic == 0x6174656d, 'No magic number 0x6174656d at the start of data');

  var version = src.u8();
  scale.assertionCheck(
      9 <= version && version < 15, 'Invalid metadata version');

  // See https://github.com/polkadot-js/api/commit/a9211690be6b68ad6c6dad7852f1665cadcfa5b2
  // for why try-catch and version decoding stuff is here
  try {
    return decode(version, src);
  } catch (e) {
    if (version != 9) {
      rethrow;
    }
    try {
      src = scale.Src(content);
      src.u32();
      src.u8();
      return decode(10, src);
    } catch (anotherError) {
      rethrow;
    }
  }
}

model.Metadata decode(int version, scale.Src src) {
  var metadataVal = codec.decode(versions[version - 9], src);
  src.assertEOF();
  var meta = model.MetadataV14.fromJson(metadataVal);
  return model.Metadata_V14(value: meta);
}

Map<String, dynamic> createScaleCodec() {
  print('creating scale codec...');
  var registry = type_registry.OldTypeRegistry(metadata_definitions.types);
  var versions = List<int>.filled(6, 0);
  for (var i = 9; i < 15; i++) {
    versions[i - 9] = registry.use('MetadataV$i');
  }

  print('scale codec created....');
  return <String, dynamic>{
    'codec': scale.Codec(registry.getTypes()),
    'versions': versions
  };
}

final Map<String, dynamic> map = createScaleCodec();
final scale.Codec codec = map['codec']!;
final List<int> versions = map['versions']!;
