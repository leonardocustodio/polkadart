import 'package:polkadart_scale_codec/polkadart_scale_codec.dart';

void main() {
  final registry = TypeRegistry.createRegistry();
  {
    final codec =
        Codec(registry: registry).createTypeCodec('bool', data: Source('0x01'));
    final boolValue = codec.decode();
    print('01: decoded -> $boolValue');
  }

  {
    final codec =
        Codec(registry: registry).createTypeCodec('bool', data: Source('0x00'));
    final boolValue = codec.decode();
    print('00: decoded -> $boolValue');
  }

  /// encode
  {
    final codec = Codec(registry: registry).createTypeCodec('bool');
    final boolValue = codec.encode(true);
    print('true: encoded -> $boolValue');
  }
  {
    final Codec codec4 = Codec(registry: registry).createTypeCodec('bool');
    final boolValue = codec4.encode(false);
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
    final codec = Codec(registry: registry)
        .createTypeCodec('bool_key', data: Source('0x01'));
    final boolValue = codec.decode();
    print('01: decoded -> $boolValue');
  }

  {
    final codec = Codec(registry: registry)
        .createTypeCodec('bool_key', data: Source('0x00'));
    final boolValue = codec.decode();
    print('00: decoded -> $boolValue');
  }

  /// encode
  {
    final codec = Codec(registry: registry).createTypeCodec('bool_key');
    final boolValue = codec.encode(true);
    print('true: encoded -> $boolValue');
  }
  {
    final codec = Codec(registry: registry).createTypeCodec('bool_key');
    final boolValue = codec.encode(false);
    print('false: encoded -> $boolValue');
  }

  /// without Registry
  {
    final codec = Codec<bool>().createTypeCodec('bool', data: Source('0x01'));
    final boolValue = codec.decode();
    print('01: decoded -> $boolValue');
  }

  {
    final codec = Codec<bool>().createTypeCodec('bool', data: Source('0x00'));
    final boolValue = codec.decode();
    print('00: decoded -> $boolValue');
  }

  {
    final codec = Codec<bool>().createTypeCodec('bool');
    final boolValue = codec.encode(true);
    print('true: encoded -> $boolValue');
  }

  {
    final codec = Codec<bool>().createTypeCodec('bool');
    final boolValue = codec.encode(false);
    print('false: encoded -> $boolValue');
  }
}
