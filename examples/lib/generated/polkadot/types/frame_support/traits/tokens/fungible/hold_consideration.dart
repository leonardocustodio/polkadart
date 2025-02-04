// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:polkadart/scale_codec.dart' as _i1;

typedef HoldConsideration = BigInt;

class HoldConsiderationCodec with _i1.Codec<HoldConsideration> {
  const HoldConsiderationCodec();

  @override
  HoldConsideration decode(_i1.Input input) {
    return _i1.U128Codec.codec.decode(input);
  }

  @override
  void encodeTo(
    HoldConsideration value,
    _i1.Output output,
  ) {
    _i1.U128Codec.codec.encodeTo(
      value,
      output,
    );
  }

  @override
  int sizeHint(HoldConsideration value) {
    return _i1.U128Codec.codec.sizeHint(value);
  }
}
