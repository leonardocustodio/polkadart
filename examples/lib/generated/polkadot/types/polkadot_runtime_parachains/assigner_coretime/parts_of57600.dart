// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:polkadart/scale_codec.dart' as _i1;

typedef PartsOf57600 = int;

class PartsOf57600Codec with _i1.Codec<PartsOf57600> {
  const PartsOf57600Codec();

  @override
  PartsOf57600 decode(_i1.Input input) {
    return _i1.U16Codec.codec.decode(input);
  }

  @override
  void encodeTo(
    PartsOf57600 value,
    _i1.Output output,
  ) {
    _i1.U16Codec.codec.encodeTo(
      value,
      output,
    );
  }

  @override
  int sizeHint(PartsOf57600 value) {
    return _i1.U16Codec.codec.sizeHint(value);
  }
}
