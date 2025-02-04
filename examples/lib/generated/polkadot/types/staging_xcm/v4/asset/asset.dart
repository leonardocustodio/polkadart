// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:typed_data' as _i4;

import 'package:polkadart/scale_codec.dart' as _i1;

import '../location/location.dart' as _i5;
import 'asset_id.dart' as _i2;
import 'fungibility.dart' as _i3;

class Asset {
  const Asset({
    required this.id,
    required this.fun,
  });

  factory Asset.decode(_i1.Input input) {
    return codec.decode(input);
  }

  /// AssetId
  final _i2.AssetId id;

  /// Fungibility
  final _i3.Fungibility fun;

  static const $AssetCodec codec = $AssetCodec();

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
      other is Asset && other.id == id && other.fun == fun;

  @override
  int get hashCode => Object.hash(
        id,
        fun,
      );
}

class $AssetCodec with _i1.Codec<Asset> {
  const $AssetCodec();

  @override
  void encodeTo(
    Asset obj,
    _i1.Output output,
  ) {
    _i5.Location.codec.encodeTo(
      obj.id,
      output,
    );
    _i3.Fungibility.codec.encodeTo(
      obj.fun,
      output,
    );
  }

  @override
  Asset decode(_i1.Input input) {
    return Asset(
      id: _i5.Location.codec.decode(input),
      fun: _i3.Fungibility.codec.decode(input),
    );
  }

  @override
  int sizeHint(Asset obj) {
    int size = 0;
    size = size + const _i2.AssetIdCodec().sizeHint(obj.id);
    size = size + _i3.Fungibility.codec.sizeHint(obj.fun);
    return size;
  }
}
