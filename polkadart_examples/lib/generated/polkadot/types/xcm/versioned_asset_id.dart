// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:typed_data' as _i2;

import 'package:polkadart/scale_codec.dart' as _i1;

import 'v3/multiasset/asset_id.dart' as _i3;

abstract class VersionedAssetId {
  const VersionedAssetId();

  factory VersionedAssetId.decode(_i1.Input input) {
    return codec.decode(input);
  }

  static const $VersionedAssetIdCodec codec = $VersionedAssetIdCodec();

  static const $VersionedAssetId values = $VersionedAssetId();

  _i2.Uint8List encode() {
    final output = _i1.ByteOutput(codec.sizeHint(this));
    codec.encodeTo(this, output);
    return output.toBytes();
  }

  int sizeHint() {
    return codec.sizeHint(this);
  }

  Map<String, Map<String, dynamic>> toJson();
}

class $VersionedAssetId {
  const $VersionedAssetId();

  V3 v3(_i3.AssetId value0) {
    return V3(value0);
  }
}

class $VersionedAssetIdCodec with _i1.Codec<VersionedAssetId> {
  const $VersionedAssetIdCodec();

  @override
  VersionedAssetId decode(_i1.Input input) {
    final index = _i1.U8Codec.codec.decode(input);
    switch (index) {
      case 3:
        return V3._decode(input);
      default:
        throw Exception('VersionedAssetId: Invalid variant index: "$index"');
    }
  }

  @override
  void encodeTo(
    VersionedAssetId value,
    _i1.Output output,
  ) {
    switch (value.runtimeType) {
      case V3:
        (value as V3).encodeTo(output);
        break;
      default:
        throw Exception(
            'VersionedAssetId: Unsupported "$value" of type "${value.runtimeType}"');
    }
  }

  @override
  int sizeHint(VersionedAssetId value) {
    switch (value.runtimeType) {
      case V3:
        return (value as V3)._sizeHint();
      default:
        throw Exception(
            'VersionedAssetId: Unsupported "$value" of type "${value.runtimeType}"');
    }
  }
}

class V3 extends VersionedAssetId {
  const V3(this.value0);

  factory V3._decode(_i1.Input input) {
    return V3(_i3.AssetId.codec.decode(input));
  }

  /// v3::AssetId
  final _i3.AssetId value0;

  @override
  Map<String, Map<String, dynamic>> toJson() => {'V3': value0.toJson()};

  int _sizeHint() {
    int size = 1;
    size = size + _i3.AssetId.codec.sizeHint(value0);
    return size;
  }

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      3,
      output,
    );
    _i3.AssetId.codec.encodeTo(
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
      other is V3 && other.value0 == value0;

  @override
  int get hashCode => value0.hashCode;
}
