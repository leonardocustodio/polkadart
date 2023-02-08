part of primitives;

class ArrayCodec<A> with Codec<List<A>> {
  final Codec<A> codec;
  final int size;

  const ArrayCodec(this.codec, this.size);

  @override
  void encodeTo(List<A> element, Output output) {
    assert(element.length == size, 'Invalid list length');
    for (final element in element) {
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
  int sizeHint(List<A> element) {
    assert(element.length == size, 'Invalid list length');
    var byteSize = 0;
    for (A element in element) {
      byteSize += codec.sizeHint(element);
    }
    return byteSize;
  }
}
