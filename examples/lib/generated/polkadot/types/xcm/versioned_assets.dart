// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:typed_data' as _i2;

import 'package:polkadart/scale_codec.dart' as _i1;
import 'package:quiver/collection.dart' as _i7;

import '../staging_xcm/v4/asset/asset.dart' as _i9;
import '../staging_xcm/v4/asset/assets.dart' as _i5;
import 'v2/multiasset/multi_asset.dart' as _i6;
import 'v2/multiasset/multi_assets.dart' as _i3;
import 'v3/multiasset/multi_asset.dart' as _i8;
import 'v3/multiasset/multi_assets.dart' as _i4;

abstract class VersionedAssets {
  const VersionedAssets();

  factory VersionedAssets.decode(_i1.Input input) {
    return codec.decode(input);
  }

  static const $VersionedAssetsCodec codec = $VersionedAssetsCodec();

  static const $VersionedAssets values = $VersionedAssets();

  _i2.Uint8List encode() {
    final output = _i1.ByteOutput(codec.sizeHint(this));
    codec.encodeTo(this, output);
    return output.toBytes();
  }

  int sizeHint() {
    return codec.sizeHint(this);
  }

  Map<String, List<Map<String, Map<String, dynamic>>>> toJson();
}

class $VersionedAssets {
  const $VersionedAssets();

  V2 v2(_i3.MultiAssets value0) {
    return V2(value0);
  }

  V3 v3(_i4.MultiAssets value0) {
    return V3(value0);
  }

  V4 v4(_i5.Assets value0) {
    return V4(value0);
  }
}

class $VersionedAssetsCodec with _i1.Codec<VersionedAssets> {
  const $VersionedAssetsCodec();

  @override
  VersionedAssets decode(_i1.Input input) {
    final index = _i1.U8Codec.codec.decode(input);
    switch (index) {
      case 1:
        return V2._decode(input);
      case 3:
        return V3._decode(input);
      case 4:
        return V4._decode(input);
      default:
        throw Exception('VersionedAssets: Invalid variant index: "$index"');
    }
  }

  @override
  void encodeTo(
    VersionedAssets value,
    _i1.Output output,
  ) {
    switch (value.runtimeType) {
      case V2:
        (value as V2).encodeTo(output);
        break;
      case V3:
        (value as V3).encodeTo(output);
        break;
      case V4:
        (value as V4).encodeTo(output);
        break;
      default:
        throw Exception(
            'VersionedAssets: Unsupported "$value" of type "${value.runtimeType}"');
    }
  }

  @override
  int sizeHint(VersionedAssets value) {
    switch (value.runtimeType) {
      case V2:
        return (value as V2)._sizeHint();
      case V3:
        return (value as V3)._sizeHint();
      case V4:
        return (value as V4)._sizeHint();
      default:
        throw Exception(
            'VersionedAssets: Unsupported "$value" of type "${value.runtimeType}"');
    }
  }
}

class V2 extends VersionedAssets {
  const V2(this.value0);

  factory V2._decode(_i1.Input input) {
    return V2(const _i1.SequenceCodec<_i6.MultiAsset>(_i6.MultiAsset.codec)
        .decode(input));
  }

  /// v2::MultiAssets
  final _i3.MultiAssets value0;

  @override
  Map<String, List<Map<String, Map<String, dynamic>>>> toJson() =>
      {'V2': value0.map((value) => value.toJson()).toList()};

  int _sizeHint() {
    int size = 1;
    size = size + const _i3.MultiAssetsCodec().sizeHint(value0);
    return size;
  }

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      1,
      output,
    );
    const _i1.SequenceCodec<_i6.MultiAsset>(_i6.MultiAsset.codec).encodeTo(
      value0,
      output,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(
        this,
        other,
      ) ||
      other is V2 &&
          _i7.listsEqual(
            other.value0,
            value0,
          );

  @override
  int get hashCode => value0.hashCode;
}

class V3 extends VersionedAssets {
  const V3(this.value0);

  factory V3._decode(_i1.Input input) {
    return V3(const _i1.SequenceCodec<_i8.MultiAsset>(_i8.MultiAsset.codec)
        .decode(input));
  }

  /// v3::MultiAssets
  final _i4.MultiAssets value0;

  @override
  Map<String, List<Map<String, Map<String, dynamic>>>> toJson() =>
      {'V3': value0.map((value) => value.toJson()).toList()};

  int _sizeHint() {
    int size = 1;
    size = size + const _i4.MultiAssetsCodec().sizeHint(value0);
    return size;
  }

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      3,
      output,
    );
    const _i1.SequenceCodec<_i8.MultiAsset>(_i8.MultiAsset.codec).encodeTo(
      value0,
      output,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(
        this,
        other,
      ) ||
      other is V3 &&
          _i7.listsEqual(
            other.value0,
            value0,
          );

  @override
  int get hashCode => value0.hashCode;
}

class V4 extends VersionedAssets {
  const V4(this.value0);

  factory V4._decode(_i1.Input input) {
    return V4(
        const _i1.SequenceCodec<_i9.Asset>(_i9.Asset.codec).decode(input));
  }

  /// v4::Assets
  final _i5.Assets value0;

  @override
  Map<String, List<Map<String, Map<String, dynamic>>>> toJson() =>
      {'V4': value0.map((value) => value.toJson()).toList()};

  int _sizeHint() {
    int size = 1;
    size = size + const _i5.AssetsCodec().sizeHint(value0);
    return size;
  }

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      4,
      output,
    );
    const _i1.SequenceCodec<_i9.Asset>(_i9.Asset.codec).encodeTo(
      value0,
      output,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(
        this,
        other,
      ) ||
      other is V4 &&
          _i7.listsEqual(
            other.value0,
            value0,
          );

  @override
  int get hashCode => value0.hashCode;
}
