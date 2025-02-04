// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:polkadart/scale_codec.dart' as _i1;

typedef EcdsaSignature = List<int>;

class EcdsaSignatureCodec with _i1.Codec<EcdsaSignature> {
  const EcdsaSignatureCodec();

  @override
  EcdsaSignature decode(_i1.Input input) {
    return const _i1.U8ArrayCodec(65).decode(input);
  }

  @override
  void encodeTo(
    EcdsaSignature value,
    _i1.Output output,
  ) {
    const _i1.U8ArrayCodec(65).encodeTo(
      value,
      output,
    );
  }

  @override
  int sizeHint(EcdsaSignature value) {
    return const _i1.U8ArrayCodec(65).sizeHint(value);
  }
}
