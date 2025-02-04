// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:typed_data' as _i2;

import 'package:polkadart/scale_codec.dart' as _i1;

import '../../polkadot_runtime_common/impls/versioned_locatable_asset.dart'
    as _i3;
import '../../sp_arithmetic/fixed_point/fixed_u128.dart' as _i4;

/// The `Event` enum of this pallet
abstract class Event {
  const Event();

  factory Event.decode(_i1.Input input) {
    return codec.decode(input);
  }

  static const $EventCodec codec = $EventCodec();

  static const $Event values = $Event();

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

class $Event {
  const $Event();

  AssetRateCreated assetRateCreated({
    required _i3.VersionedLocatableAsset assetKind,
    required _i4.FixedU128 rate,
  }) {
    return AssetRateCreated(
      assetKind: assetKind,
      rate: rate,
    );
  }

  AssetRateRemoved assetRateRemoved(
      {required _i3.VersionedLocatableAsset assetKind}) {
    return AssetRateRemoved(assetKind: assetKind);
  }

  AssetRateUpdated assetRateUpdated({
    required _i3.VersionedLocatableAsset assetKind,
    required _i4.FixedU128 old,
    required _i4.FixedU128 new_,
  }) {
    return AssetRateUpdated(
      assetKind: assetKind,
      old: old,
      new_: new_,
    );
  }
}

class $EventCodec with _i1.Codec<Event> {
  const $EventCodec();

  @override
  Event decode(_i1.Input input) {
    final index = _i1.U8Codec.codec.decode(input);
    switch (index) {
      case 0:
        return AssetRateCreated._decode(input);
      case 1:
        return AssetRateRemoved._decode(input);
      case 2:
        return AssetRateUpdated._decode(input);
      default:
        throw Exception('Event: Invalid variant index: "$index"');
    }
  }

  @override
  void encodeTo(
    Event value,
    _i1.Output output,
  ) {
    switch (value.runtimeType) {
      case AssetRateCreated:
        (value as AssetRateCreated).encodeTo(output);
        break;
      case AssetRateRemoved:
        (value as AssetRateRemoved).encodeTo(output);
        break;
      case AssetRateUpdated:
        (value as AssetRateUpdated).encodeTo(output);
        break;
      default:
        throw Exception(
            'Event: Unsupported "$value" of type "${value.runtimeType}"');
    }
  }

  @override
  int sizeHint(Event value) {
    switch (value.runtimeType) {
      case AssetRateCreated:
        return (value as AssetRateCreated)._sizeHint();
      case AssetRateRemoved:
        return (value as AssetRateRemoved)._sizeHint();
      case AssetRateUpdated:
        return (value as AssetRateUpdated)._sizeHint();
      default:
        throw Exception(
            'Event: Unsupported "$value" of type "${value.runtimeType}"');
    }
  }
}

class AssetRateCreated extends Event {
  const AssetRateCreated({
    required this.assetKind,
    required this.rate,
  });

  factory AssetRateCreated._decode(_i1.Input input) {
    return AssetRateCreated(
      assetKind: _i3.VersionedLocatableAsset.codec.decode(input),
      rate: _i1.U128Codec.codec.decode(input),
    );
  }

  /// T::AssetKind
  final _i3.VersionedLocatableAsset assetKind;

  /// FixedU128
  final _i4.FixedU128 rate;

  @override
  Map<String, Map<String, dynamic>> toJson() => {
        'AssetRateCreated': {
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
      other is AssetRateCreated &&
          other.assetKind == assetKind &&
          other.rate == rate;

  @override
  int get hashCode => Object.hash(
        assetKind,
        rate,
      );
}

class AssetRateRemoved extends Event {
  const AssetRateRemoved({required this.assetKind});

  factory AssetRateRemoved._decode(_i1.Input input) {
    return AssetRateRemoved(
        assetKind: _i3.VersionedLocatableAsset.codec.decode(input));
  }

  /// T::AssetKind
  final _i3.VersionedLocatableAsset assetKind;

  @override
  Map<String, Map<String, Map<String, Map<String, Map<String, dynamic>>>>>
      toJson() => {
            'AssetRateRemoved': {'assetKind': assetKind.toJson()}
          };

  int _sizeHint() {
    int size = 1;
    size = size + _i3.VersionedLocatableAsset.codec.sizeHint(assetKind);
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
  }

  @override
  bool operator ==(Object other) =>
      identical(
        this,
        other,
      ) ||
      other is AssetRateRemoved && other.assetKind == assetKind;

  @override
  int get hashCode => assetKind.hashCode;
}

class AssetRateUpdated extends Event {
  const AssetRateUpdated({
    required this.assetKind,
    required this.old,
    required this.new_,
  });

  factory AssetRateUpdated._decode(_i1.Input input) {
    return AssetRateUpdated(
      assetKind: _i3.VersionedLocatableAsset.codec.decode(input),
      old: _i1.U128Codec.codec.decode(input),
      new_: _i1.U128Codec.codec.decode(input),
    );
  }

  /// T::AssetKind
  final _i3.VersionedLocatableAsset assetKind;

  /// FixedU128
  final _i4.FixedU128 old;

  /// FixedU128
  final _i4.FixedU128 new_;

  @override
  Map<String, Map<String, dynamic>> toJson() => {
        'AssetRateUpdated': {
          'assetKind': assetKind.toJson(),
          'old': old,
          'new': new_,
        }
      };

  int _sizeHint() {
    int size = 1;
    size = size + _i3.VersionedLocatableAsset.codec.sizeHint(assetKind);
    size = size + const _i4.FixedU128Codec().sizeHint(old);
    size = size + const _i4.FixedU128Codec().sizeHint(new_);
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
    _i1.U128Codec.codec.encodeTo(
      old,
      output,
    );
    _i1.U128Codec.codec.encodeTo(
      new_,
      output,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(
        this,
        other,
      ) ||
      other is AssetRateUpdated &&
          other.assetKind == assetKind &&
          other.old == old &&
          other.new_ == new_;

  @override
  int get hashCode => Object.hash(
        assetKind,
        old,
        new_,
      );
}
