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
  late final Codec codec;
  ProxyCodec();

  @override
  dynamic decode(Input input) {
    return codec.decode(input);
  }

  @override
  void encodeTo(dynamic value, Output output) {
    codec.encodeTo(value, output);
  }
}
