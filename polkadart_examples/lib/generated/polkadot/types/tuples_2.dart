// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:polkadart/scale_codec.dart' as _i1;

class Tuple3<T0, T1, T2> {
  const Tuple3(
    this.value0,
    this.value1,
    this.value2,
  );

  final T0 value0;

  final T1 value1;

  final T2 value2;
}

class Tuple3Codec<T0, T1, T2> with _i1.Codec<Tuple3<T0, T1, T2>> {
  const Tuple3Codec(
    this.codec0,
    this.codec1,
    this.codec2,
  );

  final _i1.Codec<T0> codec0;

  final _i1.Codec<T1> codec1;

  final _i1.Codec<T2> codec2;

  @override
  void encodeTo(
    Tuple3<T0, T1, T2> tuple,
    _i1.Output output,
  ) {
    codec0.encodeTo(tuple.value0, output);
    codec1.encodeTo(tuple.value1, output);
    codec2.encodeTo(tuple.value2, output);
  }

  @override
  Tuple3<T0, T1, T2> decode(_i1.Input input) {
    return Tuple3(
      codec0.decode(input),
      codec1.decode(input),
      codec2.decode(input),
    );
  }

  @override
  int sizeHint(Tuple3<T0, T1, T2> tuple) {
    int size = 0;
    size += codec0.sizeHint(tuple.value0);
    size += codec1.sizeHint(tuple.value1);
    size += codec2.sizeHint(tuple.value2);
    return size;
  }
}
