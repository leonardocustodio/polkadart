// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:typed_data' as _i4;

import 'package:polkadart/scale_codec.dart' as _i1;

import 'asset_id.dart' as _i2;
import 'fungibility.dart' as _i3;

class MultiAsset {
  const MultiAsset({
    required this.id,
    required this.fun,
  });

  factory MultiAsset.decode(_i1.Input input) {
    return codec.decode(input);
  }

  /// AssetId
  final _i2.AssetId id;

  /// Fungibility
  final _i3.Fungibility fun;

  static const $MultiAssetCodec codec = $MultiAssetCodec();

  _i4.Uint8List encode() {
    return codec.encode(this);
  }

  Map<String, Map<String, dynamic>> toJson() => {
        'id': id.toJson(),
        'fun': fun.toJson(),
      };

  @override
  bool operator ==(Object other) =>
      identical(
        this,
        other,
      ) ||
      other is MultiAsset && other.id == id && other.fun == fun;

  @override
  int get hashCode => Object.hash(
        id,
        fun,
      );
}

class $MultiAssetCodec with _i1.Codec<MultiAsset> {
  const $MultiAssetCodec();

  @override
  void encodeTo(
    MultiAsset obj,
    _i1.Output output,
  ) {
    _i2.AssetId.codec.encodeTo(
      obj.id,
      output,
    );
    _i3.Fungibility.codec.encodeTo(
      obj.fun,
      output,
    );
  }

  @override
  MultiAsset decode(_i1.Input input) {
    return MultiAsset(
      id: _i2.AssetId.codec.decode(input),
      fun: _i3.Fungibility.codec.decode(input),
    );
  }

  @override
  int sizeHint(MultiAsset obj) {
    int size = 0;
    size = size + _i2.AssetId.codec.sizeHint(obj.id);
    size = size + _i3.Fungibility.codec.sizeHint(obj.fun);
    return size;
  }
}
