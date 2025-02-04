// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:polkadart/scale_codec.dart' as _i2;

import 'asset.dart' as _i1;

typedef Assets = List<_i1.Asset>;

class AssetsCodec with _i2.Codec<Assets> {
  const AssetsCodec();

  @override
  Assets decode(_i2.Input input) {
    return const _i2.SequenceCodec<_i1.Asset>(_i1.Asset.codec).decode(input);
  }

  @override
  void encodeTo(
    Assets value,
    _i2.Output output,
  ) {
    const _i2.SequenceCodec<_i1.Asset>(_i1.Asset.codec).encodeTo(
      value,
      output,
    );
  }

  @override
  int sizeHint(Assets value) {
    return const _i2.SequenceCodec<_i1.Asset>(_i1.Asset.codec).sizeHint(value);
  }
}
