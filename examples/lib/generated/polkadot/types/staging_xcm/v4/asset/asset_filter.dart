// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:typed_data' as _i2;

import 'package:polkadart/scale_codec.dart' as _i1;
import 'package:quiver/collection.dart' as _i6;

import 'asset.dart' as _i5;
import 'assets.dart' as _i3;
import 'wild_asset.dart' as _i4;

abstract class AssetFilter {
  const AssetFilter();

  factory AssetFilter.decode(_i1.Input input) {
    return codec.decode(input);
  }

  static const $AssetFilterCodec codec = $AssetFilterCodec();

  static const $AssetFilter values = $AssetFilter();

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

class $AssetFilter {
  const $AssetFilter();

  Definite definite(_i3.Assets value0) {
    return Definite(value0);
  }

  Wild wild(_i4.WildAsset value0) {
    return Wild(value0);
  }
}

class $AssetFilterCodec with _i1.Codec<AssetFilter> {
  const $AssetFilterCodec();

  @override
  AssetFilter decode(_i1.Input input) {
    final index = _i1.U8Codec.codec.decode(input);
    switch (index) {
      case 0:
        return Definite._decode(input);
      case 1:
        return Wild._decode(input);
      default:
        throw Exception('AssetFilter: Invalid variant index: "$index"');
    }
  }

  @override
  void encodeTo(
    AssetFilter value,
    _i1.Output output,
  ) {
    switch (value.runtimeType) {
      case Definite:
        (value as Definite).encodeTo(output);
        break;
      case Wild:
        (value as Wild).encodeTo(output);
        break;
      default:
        throw Exception(
            'AssetFilter: Unsupported "$value" of type "${value.runtimeType}"');
    }
  }

  @override
  int sizeHint(AssetFilter value) {
    switch (value.runtimeType) {
      case Definite:
        return (value as Definite)._sizeHint();
      case Wild:
        return (value as Wild)._sizeHint();
      default:
        throw Exception(
            'AssetFilter: Unsupported "$value" of type "${value.runtimeType}"');
    }
  }
}

class Definite extends AssetFilter {
  const Definite(this.value0);

  factory Definite._decode(_i1.Input input) {
    return Definite(
        const _i1.SequenceCodec<_i5.Asset>(_i5.Asset.codec).decode(input));
  }

  /// Assets
  final _i3.Assets value0;

  @override
  Map<String, List<Map<String, Map<String, dynamic>>>> toJson() =>
      {'Definite': value0.map((value) => value.toJson()).toList()};

  int _sizeHint() {
    int size = 1;
    size = size + const _i3.AssetsCodec().sizeHint(value0);
    return size;
  }

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      0,
      output,
    );
    const _i1.SequenceCodec<_i5.Asset>(_i5.Asset.codec).encodeTo(
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
      other is Definite &&
          _i6.listsEqual(
            other.value0,
            value0,
          );

  @override
  int get hashCode => value0.hashCode;
}

class Wild extends AssetFilter {
  const Wild(this.value0);

  factory Wild._decode(_i1.Input input) {
    return Wild(_i4.WildAsset.codec.decode(input));
  }

  /// WildAsset
  final _i4.WildAsset value0;

  @override
  Map<String, Map<String, dynamic>> toJson() => {'Wild': value0.toJson()};

  int _sizeHint() {
    int size = 1;
    size = size + _i4.WildAsset.codec.sizeHint(value0);
    return size;
  }

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      1,
      output,
    );
    _i4.WildAsset.codec.encodeTo(
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
      other is Wild && other.value0 == value0;

  @override
  int get hashCode => value0.hashCode;
}
