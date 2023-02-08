part of primitives;

class ArrayCodec<A> with Codec<List<A>> {
  final Codec<A> codec;
  final int size;

  const ArrayCodec(this.codec, this.size);

  @override
  void encodeTo(List<A> value, Output output) {
    assertion(value.length == size, 'Invalid list length');
    for (final element in value) {
      codec.encodeTo(element, output);
    }
  }

  @override
  List<A> decode(Input input) {
    final elements = <A>[];
    for (var i = 0; i < size; i++) {
      elements.add(codec.decode(input));
    }
    return elements;
  }

  @override
  int sizeHint(List<A> value) {
    assertion(value.length == size, 'Invalid list length');
    var byteSize = 0;
    for (A element in value) {
      byteSize += codec.sizeHint(element);
    }
    return byteSize;
  }
}
