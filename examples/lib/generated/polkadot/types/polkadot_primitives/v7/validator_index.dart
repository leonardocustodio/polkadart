// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:polkadart/scale_codec.dart' as _i1;

typedef ValidatorIndex = int;

class ValidatorIndexCodec with _i1.Codec<ValidatorIndex> {
  const ValidatorIndexCodec();

  @override
  ValidatorIndex decode(_i1.Input input) {
    return _i1.U32Codec.codec.decode(input);
  }

  @override
  void encodeTo(
    ValidatorIndex value,
    _i1.Output output,
  ) {
    _i1.U32Codec.codec.encodeTo(
      value,
      output,
    );
  }

  @override
  int sizeHint(ValidatorIndex value) {
    return _i1.U32Codec.codec.sizeHint(value);
  }
}
