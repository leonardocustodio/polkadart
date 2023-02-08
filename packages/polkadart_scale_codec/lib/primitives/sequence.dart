part of primitives;

class SequenceCodec<A> with Codec<List<A>> {
  final Codec<A> codec;

  const SequenceCodec(this.codec);

  @override
  void encodeTo(List<A> element, Output output) {
    CompactCodec.instance.encodeTo(element.length, output);
    for (final element in element) {
      codec.encodeTo(element, output);
    }
  }

  @override
  List<A> decode(Input input) {
    final size = CompactCodec.instance.decode(input).toInt();
    final elements = <A>[];
    for (var i = 0; i < size; i++) {
      elements.add(codec.decode(input));
    }
    return elements;
  }

  @override
  int sizeHint(List<A> element) {
    var size = CompactCodec.instance.sizeHint(element.length);
    for (A element in element) {
      size += codec.sizeHint(element);
    }
    return size;
  }
}
