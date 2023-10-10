// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:polkadart/scale_codec.dart' as _i1;

typedef KeyTypeId = List<int>;

class KeyTypeIdCodec with _i1.Codec<KeyTypeId> {
  const KeyTypeIdCodec();

  @override
  KeyTypeId decode(_i1.Input input) {
    return const _i1.U8ArrayCodec(4).decode(input);
  }

  @override
  void encodeTo(
    KeyTypeId value,
    _i1.Output output,
  ) {
    const _i1.U8ArrayCodec(4).encodeTo(
      value,
      output,
    );
  }

  @override
  int sizeHint(KeyTypeId value) {
    return const _i1.U8ArrayCodec(4).sizeHint(value);
  }
}
