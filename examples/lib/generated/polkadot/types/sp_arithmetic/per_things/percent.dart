// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:polkadart/scale_codec.dart' as _i1;

typedef Percent = int;

class PercentCodec with _i1.Codec<Percent> {
  const PercentCodec();

  @override
  Percent decode(_i1.Input input) {
    return _i1.U8Codec.codec.decode(input);
  }

  @override
  void encodeTo(
    Percent value,
    _i1.Output output,
  ) {
    _i1.U8Codec.codec.encodeTo(
      value,
      output,
    );
  }

  @override
  int sizeHint(Percent value) {
    return _i1.U8Codec.codec.sizeHint(value);
  }
}
