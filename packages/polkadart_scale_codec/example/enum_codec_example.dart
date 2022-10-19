import 'package:polkadart_scale_codec/polkadart_scale_codec.dart';

void main() {
  // Creates the registry for parsing the types and selecting particular schema.
  final registry = TypeRegistry(
    types: {
      'FavouriteColorEnum': {
        '_enum': ['Red', 'Orange']
      },
      'CustomComplexEnum': {
        '_enum': {
          'Plain': 'Text',
          'ExtraData': {
            'index': 'u8',
            'name': 'Text',
            'customTuple': '(FavouriteColorEnum, bool)'
          }
        }
      },
    },
  );

  // specifying which schema key to select and use
  final registryIndexComplexEnum = registry.getIndex('CustomComplexEnum');

  // fetching the parsed types from `Json` to `Type`
  final types = registry.getTypes();

  // Initializing Scale-Codec object
  final codec = Codec(types);

  final plainComplex = {
    'Plain': 'scale-codec',
  };

  final plainEncoded = codec.encode(registryIndexComplexEnum, plainComplex);
  final plainDecoded = codec.decode(registryIndexComplexEnum, plainEncoded);
  print(plainDecoded);

  final extraDataComplex = {
    'ExtraData': {
      'index': 1,
      'name': 'polkadart',
      'customTuple': ['Red', true]
    },
  };

  final extraDataEncoded =
      codec.encode(registryIndexComplexEnum, extraDataComplex);
  final extraDataDecoded =
      codec.decode(registryIndexComplexEnum, extraDataEncoded);
  print(extraDataDecoded);

  final registryIndexFavouriteColorEnum =
      registry.getIndex('FavouriteColorEnum');

  final value = 'Red';
  // encoding and decoding
  String encodedColor = codec.encode(registryIndexFavouriteColorEnum, value);
  String decodedColor =
      codec.decode(registryIndexFavouriteColorEnum, encodedColor);
  print(decodedColor);
}
