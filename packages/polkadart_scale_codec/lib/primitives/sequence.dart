part of primitives;

class SequenceCodec<A> with Codec<List<A>> {
  final Codec<A> codec;

  const SequenceCodec(this.codec);

  @override
  void encodeTo(List<A> value, Output output) {
    CompactCodec.codec.encodeTo(value.length, output);
    for (final element in value) {
      codec.encodeTo(element, output);
    }
  }

  @override
  List<A> decode(Input input) {
    final size = CompactCodec.codec.decode(input);
    return List.generate(size, (index) => codec.decode(input), growable: true);
  }

  @override
  int sizeHint(List<A> value) {
    var size = CompactCodec.codec.sizeHint(value.length);
    for (A element in value) {
      size += codec.sizeHint(element);
    }
    return size;
  }
}
