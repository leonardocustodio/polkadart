import 'package:polkadart_scale_codec/polkadart_scale_codec.dart';

void main() {
  final registry = TypeRegistry.createRegistry();
  {
    final codec = Codec(registry).createTypeCodec('bool', data: Source('0x01'));
    final boolValue = codec.decode();
    print('01: decoded -> $boolValue');
  }

  {
    final codec2 =
        Codec(registry).createTypeCodec('bool', data: Source('0x00'));
    final boolValue2 = codec2.decode();
    print('00: decoded -> $boolValue2');
  }

  /// encode
  {
    final codec3 = Codec(registry).createTypeCodec('bool');
    final boolValue3 = codec3.encode(true);
    print('true: encoded -> $boolValue3');
  }
  {
    final Codec codec4 = Codec(registry).createTypeCodec('bool');
    final boolValue4 = codec4.encode(false);
    print('false: encoded -> $boolValue4');
  }

  /// with custom json
  TypeRegistry.addCustomCodec(
    registry,
    <String, dynamic>{
      'bool_key': 'bool',
    },
  );
  {
    final codec5 =
        Codec(registry).createTypeCodec('bool_key', data: Source('0x01'));
    final boolValue5 = codec5.decode();
    print('01: decoded -> $boolValue5');
  }

  {
    final codec6 =
        Codec(registry).createTypeCodec('bool_key', data: Source('0x00'));
    final boolValue6 = codec6.decode();
    print('00: decoded -> $boolValue6');
  }

  /// encode
  {
    final codec7 = Codec(registry).createTypeCodec('bool_key');
    final boolValue7 = codec7.encode(true);
    print('true: encoded -> $boolValue7');
  }
  {
    final codec8 = Codec(registry).createTypeCodec('bool_key');
    final boolValue8 = codec8.encode(false);
    print('false: encoded -> $boolValue8');
  }
}
