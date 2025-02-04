// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:polkadart/scale_codec.dart' as _i1;

typedef Perquintill = BigInt;

class PerquintillCodec with _i1.Codec<Perquintill> {
  const PerquintillCodec();

  @override
  Perquintill decode(_i1.Input input) {
    return _i1.U64Codec.codec.decode(input);
  }

  @override
  void encodeTo(
    Perquintill value,
    _i1.Output output,
  ) {
    _i1.U64Codec.codec.encodeTo(
      value,
      output,
    );
  }

  @override
  int sizeHint(Perquintill value) {
    return _i1.U64Codec.codec.sizeHint(value);
  }
}
