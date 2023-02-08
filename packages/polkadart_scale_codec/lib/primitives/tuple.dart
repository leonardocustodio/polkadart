part of primitives;

class TupleCodec with Codec<List<dynamic>> {
  final List<Codec> codecs;

  const TupleCodec(this.codecs);

  @override
  void encodeTo(List<dynamic> element, Output output) {
    assert(element.length == codecs.length, 'Invalid list length');
    for (var i = 0; i < codecs.length; i++) {
      codecs[i].encodeTo(element[i], output);
    }
  }

  @override
  List<dynamic> decode(Input input) {
    final elements = <dynamic>[];
    for (final codec in codecs) {
      elements.add(codec.decode(input));
    }
    return elements;
  }

  @override
  int sizeHint(List<dynamic> element) {
    assert(element.length == codecs.length, 'Invalid list length');
    var size = 0;
    for (var i = 0; i < codecs.length; i++) {
      size += codecs[i].sizeHint(element[i]);
    }
    return size;
  }
}
