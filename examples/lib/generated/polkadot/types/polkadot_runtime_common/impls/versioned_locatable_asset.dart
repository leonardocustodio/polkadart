// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:typed_data' as _i2;

import 'package:polkadart/scale_codec.dart' as _i1;

import '../../staging_xcm/v3/multilocation/multi_location.dart' as _i3;
import '../../staging_xcm/v4/asset/asset_id.dart' as _i6;
import '../../staging_xcm/v4/location/location.dart' as _i5;
import '../../xcm/v3/multiasset/asset_id.dart' as _i4;

abstract class VersionedLocatableAsset {
  const VersionedLocatableAsset();

  factory VersionedLocatableAsset.decode(_i1.Input input) {
    return codec.decode(input);
  }

  static const $VersionedLocatableAssetCodec codec =
      $VersionedLocatableAssetCodec();

  static const $VersionedLocatableAsset values = $VersionedLocatableAsset();

  _i2.Uint8List encode() {
    final output = _i1.ByteOutput(codec.sizeHint(this));
    codec.encodeTo(this, output);
    return output.toBytes();
  }

  int sizeHint() {
    return codec.sizeHint(this);
  }

  Map<String, Map<String, Map<String, dynamic>>> toJson();
}

class $VersionedLocatableAsset {
  const $VersionedLocatableAsset();

  V3 v3({
    required _i3.MultiLocation location,
    required _i4.AssetId assetId,
  }) {
    return V3(
      location: location,
      assetId: assetId,
    );
  }

  V4 v4({
    required _i5.Location location,
    required _i6.AssetId assetId,
  }) {
    return V4(
      location: location,
      assetId: assetId,
    );
  }
}

class $VersionedLocatableAssetCodec with _i1.Codec<VersionedLocatableAsset> {
  const $VersionedLocatableAssetCodec();

  @override
  VersionedLocatableAsset decode(_i1.Input input) {
    final index = _i1.U8Codec.codec.decode(input);
    switch (index) {
      case 3:
        return V3._decode(input);
      case 4:
        return V4._decode(input);
      default:
        throw Exception(
            'VersionedLocatableAsset: Invalid variant index: "$index"');
    }
  }

  @override
  void encodeTo(
    VersionedLocatableAsset value,
    _i1.Output output,
  ) {
    switch (value.runtimeType) {
      case V3:
        (value as V3).encodeTo(output);
        break;
      case V4:
        (value as V4).encodeTo(output);
        break;
      default:
        throw Exception(
            'VersionedLocatableAsset: Unsupported "$value" of type "${value.runtimeType}"');
    }
  }

  @override
  int sizeHint(VersionedLocatableAsset value) {
    switch (value.runtimeType) {
      case V3:
        return (value as V3)._sizeHint();
      case V4:
        return (value as V4)._sizeHint();
      default:
        throw Exception(
            'VersionedLocatableAsset: Unsupported "$value" of type "${value.runtimeType}"');
    }
  }
}

class V3 extends VersionedLocatableAsset {
  const V3({
    required this.location,
    required this.assetId,
  });

  factory V3._decode(_i1.Input input) {
    return V3(
      location: _i3.MultiLocation.codec.decode(input),
      assetId: _i4.AssetId.codec.decode(input),
    );
  }

  /// xcm::v3::Location
  final _i3.MultiLocation location;

  /// xcm::v3::AssetId
  final _i4.AssetId assetId;

  @override
  Map<String, Map<String, Map<String, dynamic>>> toJson() => {
        'V3': {
          'location': location.toJson(),
          'assetId': assetId.toJson(),
        }
      };

  int _sizeHint() {
    int size = 1;
    size = size + _i3.MultiLocation.codec.sizeHint(location);
    size = size + _i4.AssetId.codec.sizeHint(assetId);
    return size;
  }

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      3,
      output,
    );
    _i3.MultiLocation.codec.encodeTo(
      location,
      output,
    );
    _i4.AssetId.codec.encodeTo(
      assetId,
      output,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(
        this,
        other,
      ) ||
      other is V3 && other.location == location && other.assetId == assetId;

  @override
  int get hashCode => Object.hash(
        location,
        assetId,
      );
}

class V4 extends VersionedLocatableAsset {
  const V4({
    required this.location,
    required this.assetId,
  });

  factory V4._decode(_i1.Input input) {
    return V4(
      location: _i5.Location.codec.decode(input),
      assetId: _i5.Location.codec.decode(input),
    );
  }

  /// xcm::v4::Location
  final _i5.Location location;

  /// xcm::v4::AssetId
  final _i6.AssetId assetId;

  @override
  Map<String, Map<String, Map<String, dynamic>>> toJson() => {
        'V4': {
          'location': location.toJson(),
          'assetId': assetId.toJson(),
        }
      };

  int _sizeHint() {
    int size = 1;
    size = size + _i5.Location.codec.sizeHint(location);
    size = size + const _i6.AssetIdCodec().sizeHint(assetId);
    return size;
  }

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      4,
      output,
    );
    _i5.Location.codec.encodeTo(
      location,
      output,
    );
    _i5.Location.codec.encodeTo(
      assetId,
      output,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(
        this,
        other,
      ) ||
      other is V4 && other.location == location && other.assetId == assetId;

  @override
  int get hashCode => Object.hash(
        location,
        assetId,
      );
}
