// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:polkadart/scale_codec.dart' as _i1;

typedef EthereumAddress = List<int>;

class EthereumAddressCodec with _i1.Codec<EthereumAddress> {
  const EthereumAddressCodec();

  @override
  EthereumAddress decode(_i1.Input input) {
    return const _i1.U8ArrayCodec(20).decode(input);
  }

  @override
  void encodeTo(
    EthereumAddress value,
    _i1.Output output,
  ) {
    const _i1.U8ArrayCodec(20).encodeTo(
      value,
      output,
    );
  }

  @override
  int sizeHint(EthereumAddress value) {
    return const _i1.U8ArrayCodec(20).sizeHint(value);
  }
}
