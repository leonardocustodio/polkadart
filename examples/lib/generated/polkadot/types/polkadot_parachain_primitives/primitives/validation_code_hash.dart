// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:polkadart/scale_codec.dart' as _i2;

import '../../primitive_types/h256.dart' as _i1;

typedef ValidationCodeHash = _i1.H256;

class ValidationCodeHashCodec with _i2.Codec<ValidationCodeHash> {
  const ValidationCodeHashCodec();

  @override
  ValidationCodeHash decode(_i2.Input input) {
    return const _i2.U8ArrayCodec(32).decode(input);
  }

  @override
  void encodeTo(
    ValidationCodeHash value,
    _i2.Output output,
  ) {
    const _i2.U8ArrayCodec(32).encodeTo(
      value,
      output,
    );
  }

  @override
  int sizeHint(ValidationCodeHash value) {
    return const _i1.H256Codec().sizeHint(value);
  }
}
