part of primitives;

class ProxyCodec with Codec<dynamic> {
  late final Codec codec;
  final String name;
  ProxyCodec(this.name);

  @override
  dynamic decode(Input input) {
    return codec.decode(input);
  }

  @override
  void encodeTo(dynamic value, Output output) {
    codec.encodeTo(value, output);
  }
}
