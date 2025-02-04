// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:typed_data' as _i2;

import 'package:polkadart/scale_codec.dart' as _i1;

import '../../polkadot_runtime_common/impls/versioned_locatable_asset.dart'
    as _i3;
import '../../sp_arithmetic/fixed_point/fixed_u128.dart' as _i4;

/// Contains a variant per dispatchable extrinsic that this pallet has.
abstract class Call {
  const Call();

  factory Call.decode(_i1.Input input) {
    return codec.decode(input);
  }

  static const $CallCodec codec = $CallCodec();

  static const $Call values = $Call();

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

class $Call {
  const $Call();

  Create create({
    required _i3.VersionedLocatableAsset assetKind,
    required _i4.FixedU128 rate,
  }) {
    return Create(
      assetKind: assetKind,
      rate: rate,
    );
  }

  Update update({
    required _i3.VersionedLocatableAsset assetKind,
    required _i4.FixedU128 rate,
  }) {
    return Update(
      assetKind: assetKind,
      rate: rate,
    );
  }

  Remove remove({required _i3.VersionedLocatableAsset assetKind}) {
    return Remove(assetKind: assetKind);
  }
}

class $CallCodec with _i1.Codec<Call> {
  const $CallCodec();

  @override
  Call decode(_i1.Input input) {
    final index = _i1.U8Codec.codec.decode(input);
    switch (index) {
      case 0:
        return Create._decode(input);
      case 1:
        return Update._decode(input);
      case 2:
        return Remove._decode(input);
      default:
        throw Exception('Call: Invalid variant index: "$index"');
    }
  }

  @override
  void encodeTo(
    Call value,
    _i1.Output output,
  ) {
    switch (value.runtimeType) {
      case Create:
        (value as Create).encodeTo(output);
        break;
      case Update:
        (value as Update).encodeTo(output);
        break;
      case Remove:
        (value as Remove).encodeTo(output);
        break;
      default:
        throw Exception(
            'Call: Unsupported "$value" of type "${value.runtimeType}"');
    }
  }

  @override
  int sizeHint(Call value) {
    switch (value.runtimeType) {
      case Create:
        return (value as Create)._sizeHint();
      case Update:
        return (value as Update)._sizeHint();
      case Remove:
        return (value as Remove)._sizeHint();
      default:
        throw Exception(
            'Call: Unsupported "$value" of type "${value.runtimeType}"');
    }
  }
}

/// Initialize a conversion rate to native balance for the given asset.
///
/// ## Complexity
/// - O(1)
class Create extends Call {
  const Create({
    required this.assetKind,
    required this.rate,
  });

  factory Create._decode(_i1.Input input) {
    return Create(
      assetKind: _i3.VersionedLocatableAsset.codec.decode(input),
      rate: _i1.U128Codec.codec.decode(input),
    );
  }

  /// Box<T::AssetKind>
  final _i3.VersionedLocatableAsset assetKind;

  /// FixedU128
  final _i4.FixedU128 rate;

  @override
  Map<String, Map<String, dynamic>> toJson() => {
        'create': {
          'assetKind': assetKind.toJson(),
          'rate': rate,
        }
      };

  int _sizeHint() {
    int size = 1;
    size = size + _i3.VersionedLocatableAsset.codec.sizeHint(assetKind);
    size = size + const _i4.FixedU128Codec().sizeHint(rate);
    return size;
  }

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      0,
      output,
    );
    _i3.VersionedLocatableAsset.codec.encodeTo(
      assetKind,
      output,
    );
    _i1.U128Codec.codec.encodeTo(
      rate,
      output,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(
        this,
        other,
      ) ||
      other is Create && other.assetKind == assetKind && other.rate == rate;

  @override
  int get hashCode => Object.hash(
        assetKind,
        rate,
      );
}

/// Update the conversion rate to native balance for the given asset.
///
/// ## Complexity
/// - O(1)
class Update extends Call {
  const Update({
    required this.assetKind,
    required this.rate,
  });

  factory Update._decode(_i1.Input input) {
    return Update(
      assetKind: _i3.VersionedLocatableAsset.codec.decode(input),
      rate: _i1.U128Codec.codec.decode(input),
    );
  }

  /// Box<T::AssetKind>
  final _i3.VersionedLocatableAsset assetKind;

  /// FixedU128
  final _i4.FixedU128 rate;

  @override
  Map<String, Map<String, dynamic>> toJson() => {
        'update': {
          'assetKind': assetKind.toJson(),
          'rate': rate,
        }
      };

  int _sizeHint() {
    int size = 1;
    size = size + _i3.VersionedLocatableAsset.codec.sizeHint(assetKind);
    size = size + const _i4.FixedU128Codec().sizeHint(rate);
    return size;
  }

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      1,
      output,
    );
    _i3.VersionedLocatableAsset.codec.encodeTo(
      assetKind,
      output,
    );
    _i1.U128Codec.codec.encodeTo(
      rate,
      output,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(
        this,
        other,
      ) ||
      other is Update && other.assetKind == assetKind && other.rate == rate;

  @override
  int get hashCode => Object.hash(
        assetKind,
        rate,
      );
}

/// Remove an existing conversion rate to native balance for the given asset.
///
/// ## Complexity
/// - O(1)
class Remove extends Call {
  const Remove({required this.assetKind});

  factory Remove._decode(_i1.Input input) {
    return Remove(assetKind: _i3.VersionedLocatableAsset.codec.decode(input));
  }

  /// Box<T::AssetKind>
  final _i3.VersionedLocatableAsset assetKind;

  @override
  Map<String, Map<String, Map<String, Map<String, Map<String, dynamic>>>>>
      toJson() => {
            'remove': {'assetKind': assetKind.toJson()}
          };

  int _sizeHint() {
    int size = 1;
    size = size + _i3.VersionedLocatableAsset.codec.sizeHint(assetKind);
    return size;
  }

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      2,
      output,
    );
    _i3.VersionedLocatableAsset.codec.encodeTo(
      assetKind,
      output,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(
        this,
        other,
      ) ||
      other is Remove && other.assetKind == assetKind;

  @override
  int get hashCode => assetKind.hashCode;
}
