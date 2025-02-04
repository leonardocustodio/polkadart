// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:polkadart/scale_codec.dart' as _i2;

import 'multi_asset.dart' as _i1;

typedef MultiAssets = List<_i1.MultiAsset>;

class MultiAssetsCodec with _i2.Codec<MultiAssets> {
  const MultiAssetsCodec();

  @override
  MultiAssets decode(_i2.Input input) {
    return const _i2.SequenceCodec<_i1.MultiAsset>(_i1.MultiAsset.codec)
        .decode(input);
  }

  @override
  void encodeTo(
    MultiAssets value,
    _i2.Output output,
  ) {
    const _i2.SequenceCodec<_i1.MultiAsset>(_i1.MultiAsset.codec).encodeTo(
      value,
      output,
    );
  }

  @override
  int sizeHint(MultiAssets value) {
    return const _i2.SequenceCodec<_i1.MultiAsset>(_i1.MultiAsset.codec)
        .sizeHint(value);
  }
}
