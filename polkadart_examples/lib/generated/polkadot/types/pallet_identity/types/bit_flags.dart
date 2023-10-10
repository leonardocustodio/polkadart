// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:polkadart/scale_codec.dart' as _i1;

typedef BitFlags = BigInt;

class BitFlagsCodec with _i1.Codec<BitFlags> {
  const BitFlagsCodec();

  @override
  BitFlags decode(_i1.Input input) {
    return _i1.U64Codec.codec.decode(input);
  }

  @override
  void encodeTo(
    BitFlags value,
    _i1.Output output,
  ) {
    _i1.U64Codec.codec.encodeTo(
      value,
      output,
    );
  }

  @override
  int sizeHint(BitFlags value) {
    return _i1.U64Codec.codec.sizeHint(value);
  }
}
