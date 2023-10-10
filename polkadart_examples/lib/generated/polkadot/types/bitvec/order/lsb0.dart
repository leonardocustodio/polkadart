// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:polkadart/scale_codec.dart' as _i1;

typedef Lsb0 = dynamic;

class Lsb0Codec with _i1.Codec<Lsb0> {
  const Lsb0Codec();

  @override
  Lsb0 decode(_i1.Input input) {
    return _i1.NullCodec.codec.decode(input);
  }

  @override
  void encodeTo(
    Lsb0 value,
    _i1.Output output,
  ) {
    _i1.NullCodec.codec.encodeTo(
      value,
      output,
    );
  }

  @override
  int sizeHint(Lsb0 value) {
    return _i1.NullCodec.codec.sizeHint(value);
  }
}
