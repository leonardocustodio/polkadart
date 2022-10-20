import 'package:polkadart_scale_codec/polkadart_scale_codec.dart';

void main() {
  // Creates the registry for parsing the types
  final registry = TypeRegistry(
    types: {
      'OrderJuiceEnum': {
        '_enum': ['Orange', 'Apple', 'Kiwi']
      },
      'OuncesEnum': {
        '_struct': {'ounces': 'u8', 'Remarks': 'Option<Text>'}
      },
      'OrderStruct': {
        '_struct': {
          'index': 'u8',
          'note': 'Text',
          'Juice': 'OrderJuiceEnum',
          'Ounces': 'OuncesEnum'
        }
      },
    },
  );

  final typeIndex = registry.getIndex('OrderStruct');

  // fetching the parsed types from `Json` to `Type`
  final types = registry.getTypes();

  // Initializing Scale-Codec object
  final codec = Codec(types);

  final order = {
    'index': 8,
    'note': 'This is a note',
    'Juice': 'Kiwi',
    'Ounces': {
      'ounces': 1,
      'Remarks': 'This is the first order.',
    }
  };

  final encoded = codec.encode(typeIndex, order);
  final decoded = codec.decode(typeIndex, encoded);
  print(decoded);
}
