// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:typed_data' as _i2;

import 'package:polkadart/scale_codec.dart' as _i1;

import 'asset_id.dart' as _i3;
import 'wild_fungibility.dart' as _i4;

abstract class WildMultiAsset {
  const WildMultiAsset();

  factory WildMultiAsset.decode(_i1.Input input) {
    return codec.decode(input);
  }

  static const $WildMultiAssetCodec codec = $WildMultiAssetCodec();

  static const $WildMultiAsset values = $WildMultiAsset();

  _i2.Uint8List encode() {
    final output = _i1.ByteOutput(codec.sizeHint(this));
    codec.encodeTo(this, output);
    return output.toBytes();
  }

  int sizeHint() {
    return codec.sizeHint(this);
  }

  Map<String, dynamic> toJson();
}

class $WildMultiAsset {
  const $WildMultiAsset();

  All all() {
    return All();
  }

  AllOf allOf({
    required _i3.AssetId id,
    required _i4.WildFungibility fun,
  }) {
    return AllOf(
      id: id,
      fun: fun,
    );
  }
}

class $WildMultiAssetCodec with _i1.Codec<WildMultiAsset> {
  const $WildMultiAssetCodec();

  @override
  WildMultiAsset decode(_i1.Input input) {
    final index = _i1.U8Codec.codec.decode(input);
    switch (index) {
      case 0:
        return const All();
      case 1:
        return AllOf._decode(input);
      default:
        throw Exception('WildMultiAsset: Invalid variant index: "$index"');
    }
  }

  @override
  void encodeTo(
    WildMultiAsset value,
    _i1.Output output,
  ) {
    switch (value.runtimeType) {
      case All:
        (value as All).encodeTo(output);
        break;
      case AllOf:
        (value as AllOf).encodeTo(output);
        break;
      default:
        throw Exception(
            'WildMultiAsset: Unsupported "$value" of type "${value.runtimeType}"');
    }
  }

  @override
  int sizeHint(WildMultiAsset value) {
    switch (value.runtimeType) {
      case All:
        return 1;
      case AllOf:
        return (value as AllOf)._sizeHint();
      default:
        throw Exception(
            'WildMultiAsset: Unsupported "$value" of type "${value.runtimeType}"');
    }
  }
}

class All extends WildMultiAsset {
  const All();

  @override
  Map<String, dynamic> toJson() => {'All': null};

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      0,
      output,
    );
  }

  @override
  bool operator ==(Object other) => other is All;

  @override
  int get hashCode => runtimeType.hashCode;
}

class AllOf extends WildMultiAsset {
  const AllOf({
    required this.id,
    required this.fun,
  });

  factory AllOf._decode(_i1.Input input) {
    return AllOf(
      id: _i3.AssetId.codec.decode(input),
      fun: _i4.WildFungibility.codec.decode(input),
    );
  }

  /// AssetId
  final _i3.AssetId id;

  /// WildFungibility
  final _i4.WildFungibility fun;

  @override
  Map<String, Map<String, dynamic>> toJson() => {
        'AllOf': {
          'id': id.toJson(),
          'fun': fun.toJson(),
        }
      };

  int _sizeHint() {
    int size = 1;
    size = size + _i3.AssetId.codec.sizeHint(id);
    size = size + _i4.WildFungibility.codec.sizeHint(fun);
    return size;
  }

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      1,
      output,
    );
    _i3.AssetId.codec.encodeTo(
      id,
      output,
    );
    _i4.WildFungibility.codec.encodeTo(
      fun,
      output,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(
        this,
        other,
      ) ||
      other is AllOf && other.id == id && other.fun == fun;

  @override
  int get hashCode => Object.hash(
        id,
        fun,
      );
}
