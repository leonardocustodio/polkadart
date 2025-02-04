// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:polkadart/scale_codec.dart' as _i1;

typedef Permill = int;

class PermillCodec with _i1.Codec<Permill> {
  const PermillCodec();

  @override
  Permill decode(_i1.Input input) {
    return _i1.U32Codec.codec.decode(input);
  }

  @override
  void encodeTo(
    Permill value,
    _i1.Output output,
  ) {
    _i1.U32Codec.codec.encodeTo(
      value,
      output,
    );
  }

  @override
  int sizeHint(Permill value) {
    return _i1.U32Codec.codec.sizeHint(value);
  }
}
