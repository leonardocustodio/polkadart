// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:polkadart/scale_codec.dart' as _i1;

typedef FixedI64 = BigInt;

class FixedI64Codec with _i1.Codec<FixedI64> {
  const FixedI64Codec();

  @override
  FixedI64 decode(_i1.Input input) {
    return _i1.I64Codec.codec.decode(input);
  }

  @override
  void encodeTo(
    FixedI64 value,
    _i1.Output output,
  ) {
    _i1.I64Codec.codec.encodeTo(
      value,
      output,
    );
  }

  @override
  int sizeHint(FixedI64 value) {
    return _i1.I64Codec.codec.sizeHint(value);
  }
}
