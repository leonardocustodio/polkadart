// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:polkadart/scale_codec.dart' as _i2;

import '../location/location.dart' as _i1;

typedef AssetId = _i1.Location;

class AssetIdCodec with _i2.Codec<AssetId> {
  const AssetIdCodec();

  @override
  AssetId decode(_i2.Input input) {
    return _i1.Location.codec.decode(input);
  }

  @override
  void encodeTo(
    AssetId value,
    _i2.Output output,
  ) {
    _i1.Location.codec.encodeTo(
      value,
      output,
    );
  }

  @override
  int sizeHint(AssetId value) {
    return _i1.Location.codec.sizeHint(value);
  }
}
