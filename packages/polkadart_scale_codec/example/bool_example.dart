import 'package:polkadart_scale_codec/polkadart_scale_codec.dart';

void main() {
  final registry = TypeRegistry.createRegistry();
  {
    final codec = Codec(registry: registry).createTypeCodec('bool');
    final boolValue = codec.decode(Input('0x01'));
    print('01: decoded -> $boolValue');
  }

  {
    final codec = Codec(registry: registry).createTypeCodec('bool');
    final boolValue = codec.decode(Input('0x00'));
    print('00: decoded -> $boolValue');
  }

  /// encode
  {
    final codec = Codec(registry: registry).createTypeCodec('bool');
    final encoder = HexEncoder();
    codec.encode(encoder, true);
    final boolValue = encoder.toHex();
    print('true: encoded -> $boolValue');
  }
  {
    final Codec codec4 = Codec(registry: registry).createTypeCodec('bool');
    final encoder = HexEncoder();
    codec4.encode(encoder, false);
    final boolValue = encoder.toHex();
    print('false: encoded -> $boolValue');
  }

  /// with custom json
  TypeRegistry.addCustomCodec(
    registry,
    <String, dynamic>{
      'bool_key': 'bool',
    },
  );
  {
    final codec = Codec(registry: registry).createTypeCodec('bool_key');
    final boolValue = codec.decode(Input('0x01'));
    print('01: decoded -> $boolValue');
  }

  {
    final codec = Codec(registry: registry).createTypeCodec('bool_key');
    final boolValue = codec.decode(Input('0x00'));
    print('00: decoded -> $boolValue');
  }

  /// encode
  {
    final codec = Codec(registry: registry).createTypeCodec('bool_key');
    final encoder = HexEncoder();
    codec.encode(encoder, true);
    final boolValue = encoder.toHex();
    print('true: encoded -> $boolValue');
  }
  {
    final codec = Codec(registry: registry).createTypeCodec('bool_key');
    final encoder = HexEncoder();
    codec.encode(encoder, false);
    final boolValue = encoder.toHex();
    print('false: encoded -> $boolValue');
  }

  /// without Registry
  {
    final codec = Codec<bool>().createTypeCodec('bool');
    final boolValue = codec.decode(Input('0x01'));
    print('01: decoded -> $boolValue');
  }

  {
    final codec = Codec<bool>().createTypeCodec('bool');
    final boolValue = codec.decode(Input('0x00'));
    print('00: decoded -> $boolValue');
  }

  {
    final codec = Codec<bool>().createTypeCodec('bool');
    final encoder = HexEncoder();
    codec.encode(encoder, true);
    final boolValue = encoder.toHex();
    print('true: encoded -> $boolValue');
  }

  {
    final codec = Codec<bool>().createTypeCodec('bool');
    final encoder = HexEncoder();
    codec.encode(encoder, false);
    final boolValue = encoder.toHex();
    print('false: encoded -> $boolValue');
  }
}
