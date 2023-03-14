part of primitives;

class TupleCodec with Codec<List<dynamic>> {
  final List<Codec> codecs;

  const TupleCodec(this.codecs);

  @override
  void encodeTo(List<dynamic> value, Output output) {
    assertion(value.length == codecs.length, 'Invalid list length');
    for (var i = 0; i < codecs.length; i++) {
      codecs[i].encodeTo(value[i], output);
    }
  }

  @override
  List<dynamic> decode(Input input) {
    return List.generate(codecs.length, (index) => codecs[index].decode(input),
        growable: false);
  }

  @override
  int sizeHint(List<dynamic> value) {
    assertion(value.length == codecs.length, 'Invalid list length');
    var size = 0;
    for (var i = 0; i < codecs.length; i++) {
      size += codecs[i].sizeHint(value[i]);
    }
    return size;
  }
}
