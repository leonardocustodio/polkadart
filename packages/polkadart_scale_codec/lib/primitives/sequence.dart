part of primitives;

class SequenceCodec<A> with Codec<List<A>> {
  final Codec<A> codec;

  const SequenceCodec(this.codec);

  @override
  void encodeTo(List<A> value, Output output) {
    CompactCodec.instance.encodeTo(value.length, output);
    for (final element in value) {
      codec.encodeTo(element, output);
    }
  }

  @override
  List<A> decode(Input input) {
    final size = CompactCodec.instance.decode(input).toInt();
    final elements = <A>[];
    for (var i = 0; i < size; i++) {
      final value = codec.decode(input);
      elements.add(value);
    }
    return elements;
  }

  @override
  int sizeHint(List<A> value) {
    var size = CompactCodec.instance.sizeHint(value.length);
    for (A element in value) {
      size += codec.sizeHint(element);
    }
    return size;
  }
}
