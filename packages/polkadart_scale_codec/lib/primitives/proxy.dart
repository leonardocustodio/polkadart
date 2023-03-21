part of primitives;

///
/// A proxy codec that can be used to dynamically change the codec
///
/// This is useful when you want to use a codec that is not yet known and is calling itself recursively.
///
/// It helps to resolve the circular dependency.
///
///
/// 'OrangeStruct': {
///   'value1': 'bool',
///   'value2': 'JuiceEnumComplex',
/// },
///
/// 'JuiceEnum': {
///  '_enum': ['Apple', 'Orange'],
/// },
///
/// 'JuiceEnumComplex': {
///  '_enum': {
///    'Apple': 'U8',
///    'Orange': 'OrangeStruct',
///  },
/// }
///
///
/// In above example, 'OrangeStruct' is calling 'JuiceEnumComplex' and 'JuiceEnumComplex' is calling 'OrangeStruct'.
class ProxyCodec with Codec<dynamic> {
  late final Codec _codec;
  ProxyCodec();

  set codec(Codec codec) {
    if (codec is ProxyCodec) {
      throw Exception('Nested ProxyCodecs is not allowed');
    }
    _codec = codec;
  }

  Codec get codec => _codec;

  @override
  dynamic decode(Input input) {
    return _codec.decode(input);
  }

  @override
  void encodeTo(dynamic value, Output output) {
    _codec.encodeTo(value, output);
  }
}
