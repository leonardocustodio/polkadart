// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:polkadart/scale_codec.dart' as _i1;

typedef PerU16 = int;

class PerU16Codec with _i1.Codec<PerU16> {
  const PerU16Codec();

  @override
  PerU16 decode(_i1.Input input) {
    return _i1.U16Codec.codec.decode(input);
  }

  @override
  void encodeTo(
    PerU16 value,
    _i1.Output output,
  ) {
    _i1.U16Codec.codec.encodeTo(
      value,
      output,
    );
  }

  @override
  int sizeHint(PerU16 value) {
    return _i1.U16Codec.codec.sizeHint(value);
  }
}
