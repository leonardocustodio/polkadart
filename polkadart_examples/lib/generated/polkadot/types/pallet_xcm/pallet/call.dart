// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:typed_data' as _i2;

import 'package:polkadart/scale_codec.dart' as _i1;

import '../../sp_weights/weight_v2/weight.dart' as _i7;
import '../../xcm/v3/multilocation/multi_location.dart' as _i8;
import '../../xcm/v3/weight_limit.dart' as _i9;
import '../../xcm/versioned_multi_assets.dart' as _i5;
import '../../xcm/versioned_multi_location.dart' as _i3;
import '../../xcm/versioned_xcm_1.dart' as _i4;
import '../../xcm/versioned_xcm_2.dart' as _i6;

/// Contains one variant per dispatchable that can be called by an extrinsic.
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

  Send send({
    required _i3.VersionedMultiLocation dest,
    required _i4.VersionedXcm message,
  }) {
    return Send(
      dest: dest,
      message: message,
    );
  }

  TeleportAssets teleportAssets({
    required _i3.VersionedMultiLocation dest,
    required _i3.VersionedMultiLocation beneficiary,
    required _i5.VersionedMultiAssets assets,
    required int feeAssetItem,
  }) {
    return TeleportAssets(
      dest: dest,
      beneficiary: beneficiary,
      assets: assets,
      feeAssetItem: feeAssetItem,
    );
  }

  ReserveTransferAssets reserveTransferAssets({
    required _i3.VersionedMultiLocation dest,
    required _i3.VersionedMultiLocation beneficiary,
    required _i5.VersionedMultiAssets assets,
    required int feeAssetItem,
  }) {
    return ReserveTransferAssets(
      dest: dest,
      beneficiary: beneficiary,
      assets: assets,
      feeAssetItem: feeAssetItem,
    );
  }

  Execute execute({
    required _i6.VersionedXcm message,
    required _i7.Weight maxWeight,
  }) {
    return Execute(
      message: message,
      maxWeight: maxWeight,
    );
  }

  ForceXcmVersion forceXcmVersion({
    required _i8.MultiLocation location,
    required int xcmVersion,
  }) {
    return ForceXcmVersion(
      location: location,
      xcmVersion: xcmVersion,
    );
  }

  ForceDefaultXcmVersion forceDefaultXcmVersion({int? maybeXcmVersion}) {
    return ForceDefaultXcmVersion(maybeXcmVersion: maybeXcmVersion);
  }

  ForceSubscribeVersionNotify forceSubscribeVersionNotify(
      {required _i3.VersionedMultiLocation location}) {
    return ForceSubscribeVersionNotify(location: location);
  }

  ForceUnsubscribeVersionNotify forceUnsubscribeVersionNotify(
      {required _i3.VersionedMultiLocation location}) {
    return ForceUnsubscribeVersionNotify(location: location);
  }

  LimitedReserveTransferAssets limitedReserveTransferAssets({
    required _i3.VersionedMultiLocation dest,
    required _i3.VersionedMultiLocation beneficiary,
    required _i5.VersionedMultiAssets assets,
    required int feeAssetItem,
    required _i9.WeightLimit weightLimit,
  }) {
    return LimitedReserveTransferAssets(
      dest: dest,
      beneficiary: beneficiary,
      assets: assets,
      feeAssetItem: feeAssetItem,
      weightLimit: weightLimit,
    );
  }

  LimitedTeleportAssets limitedTeleportAssets({
    required _i3.VersionedMultiLocation dest,
    required _i3.VersionedMultiLocation beneficiary,
    required _i5.VersionedMultiAssets assets,
    required int feeAssetItem,
    required _i9.WeightLimit weightLimit,
  }) {
    return LimitedTeleportAssets(
      dest: dest,
      beneficiary: beneficiary,
      assets: assets,
      feeAssetItem: feeAssetItem,
      weightLimit: weightLimit,
    );
  }

  ForceSuspension forceSuspension({required bool suspended}) {
    return ForceSuspension(suspended: suspended);
  }
}

class $CallCodec with _i1.Codec<Call> {
  const $CallCodec();

  @override
  Call decode(_i1.Input input) {
    final index = _i1.U8Codec.codec.decode(input);
    switch (index) {
      case 0:
        return Send._decode(input);
      case 1:
        return TeleportAssets._decode(input);
      case 2:
        return ReserveTransferAssets._decode(input);
      case 3:
        return Execute._decode(input);
      case 4:
        return ForceXcmVersion._decode(input);
      case 5:
        return ForceDefaultXcmVersion._decode(input);
      case 6:
        return ForceSubscribeVersionNotify._decode(input);
      case 7:
        return ForceUnsubscribeVersionNotify._decode(input);
      case 8:
        return LimitedReserveTransferAssets._decode(input);
      case 9:
        return LimitedTeleportAssets._decode(input);
      case 10:
        return ForceSuspension._decode(input);
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
      case Send:
        (value as Send).encodeTo(output);
        break;
      case TeleportAssets:
        (value as TeleportAssets).encodeTo(output);
        break;
      case ReserveTransferAssets:
        (value as ReserveTransferAssets).encodeTo(output);
        break;
      case Execute:
        (value as Execute).encodeTo(output);
        break;
      case ForceXcmVersion:
        (value as ForceXcmVersion).encodeTo(output);
        break;
      case ForceDefaultXcmVersion:
        (value as ForceDefaultXcmVersion).encodeTo(output);
        break;
      case ForceSubscribeVersionNotify:
        (value as ForceSubscribeVersionNotify).encodeTo(output);
        break;
      case ForceUnsubscribeVersionNotify:
        (value as ForceUnsubscribeVersionNotify).encodeTo(output);
        break;
      case LimitedReserveTransferAssets:
        (value as LimitedReserveTransferAssets).encodeTo(output);
        break;
      case LimitedTeleportAssets:
        (value as LimitedTeleportAssets).encodeTo(output);
        break;
      case ForceSuspension:
        (value as ForceSuspension).encodeTo(output);
        break;
      default:
        throw Exception(
            'Call: Unsupported "$value" of type "${value.runtimeType}"');
    }
  }

  @override
  int sizeHint(Call value) {
    switch (value.runtimeType) {
      case Send:
        return (value as Send)._sizeHint();
      case TeleportAssets:
        return (value as TeleportAssets)._sizeHint();
      case ReserveTransferAssets:
        return (value as ReserveTransferAssets)._sizeHint();
      case Execute:
        return (value as Execute)._sizeHint();
      case ForceXcmVersion:
        return (value as ForceXcmVersion)._sizeHint();
      case ForceDefaultXcmVersion:
        return (value as ForceDefaultXcmVersion)._sizeHint();
      case ForceSubscribeVersionNotify:
        return (value as ForceSubscribeVersionNotify)._sizeHint();
      case ForceUnsubscribeVersionNotify:
        return (value as ForceUnsubscribeVersionNotify)._sizeHint();
      case LimitedReserveTransferAssets:
        return (value as LimitedReserveTransferAssets)._sizeHint();
      case LimitedTeleportAssets:
        return (value as LimitedTeleportAssets)._sizeHint();
      case ForceSuspension:
        return (value as ForceSuspension)._sizeHint();
      default:
        throw Exception(
            'Call: Unsupported "$value" of type "${value.runtimeType}"');
    }
  }
}

class Send extends Call {
  const Send({
    required this.dest,
    required this.message,
  });

  factory Send._decode(_i1.Input input) {
    return Send(
      dest: _i3.VersionedMultiLocation.codec.decode(input),
      message: _i4.VersionedXcm.codec.decode(input),
    );
  }

  /// Box<VersionedMultiLocation>
  final _i3.VersionedMultiLocation dest;

  /// Box<VersionedXcm<()>>
  final _i4.VersionedXcm message;

  @override
  Map<String, Map<String, Map<String, dynamic>>> toJson() => {
        'send': {
          'dest': dest.toJson(),
          'message': message.toJson(),
        }
      };

  int _sizeHint() {
    int size = 1;
    size = size + _i3.VersionedMultiLocation.codec.sizeHint(dest);
    size = size + _i4.VersionedXcm.codec.sizeHint(message);
    return size;
  }

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      0,
      output,
    );
    _i3.VersionedMultiLocation.codec.encodeTo(
      dest,
      output,
    );
    _i4.VersionedXcm.codec.encodeTo(
      message,
      output,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(
        this,
        other,
      ) ||
      other is Send && other.dest == dest && other.message == message;

  @override
  int get hashCode => Object.hash(
        dest,
        message,
      );
}

/// Teleport some assets from the local chain to some destination chain.
///
/// Fee payment on the destination side is made from the asset in the `assets` vector of
/// index `fee_asset_item`. The weight limit for fees is not provided and thus is unlimited,
/// with all fees taken as needed from the asset.
///
/// - `origin`: Must be capable of withdrawing the `assets` and executing XCM.
/// - `dest`: Destination context for the assets. Will typically be `X2(Parent, Parachain(..))` to send
///  from parachain to parachain, or `X1(Parachain(..))` to send from relay to parachain.
/// - `beneficiary`: A beneficiary location for the assets in the context of `dest`. Will generally be
///  an `AccountId32` value.
/// - `assets`: The assets to be withdrawn. The first item should be the currency used to to pay the fee on the
///  `dest` side. May not be empty.
/// - `fee_asset_item`: The index into `assets` of the item which should be used to pay
///  fees.
class TeleportAssets extends Call {
  const TeleportAssets({
    required this.dest,
    required this.beneficiary,
    required this.assets,
    required this.feeAssetItem,
  });

  factory TeleportAssets._decode(_i1.Input input) {
    return TeleportAssets(
      dest: _i3.VersionedMultiLocation.codec.decode(input),
      beneficiary: _i3.VersionedMultiLocation.codec.decode(input),
      assets: _i5.VersionedMultiAssets.codec.decode(input),
      feeAssetItem: _i1.U32Codec.codec.decode(input),
    );
  }

  /// Box<VersionedMultiLocation>
  final _i3.VersionedMultiLocation dest;

  /// Box<VersionedMultiLocation>
  final _i3.VersionedMultiLocation beneficiary;

  /// Box<VersionedMultiAssets>
  final _i5.VersionedMultiAssets assets;

  /// u32
  final int feeAssetItem;

  @override
  Map<String, Map<String, dynamic>> toJson() => {
        'teleport_assets': {
          'dest': dest.toJson(),
          'beneficiary': beneficiary.toJson(),
          'assets': assets.toJson(),
          'feeAssetItem': feeAssetItem,
        }
      };

  int _sizeHint() {
    int size = 1;
    size = size + _i3.VersionedMultiLocation.codec.sizeHint(dest);
    size = size + _i3.VersionedMultiLocation.codec.sizeHint(beneficiary);
    size = size + _i5.VersionedMultiAssets.codec.sizeHint(assets);
    size = size + _i1.U32Codec.codec.sizeHint(feeAssetItem);
    return size;
  }

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      1,
      output,
    );
    _i3.VersionedMultiLocation.codec.encodeTo(
      dest,
      output,
    );
    _i3.VersionedMultiLocation.codec.encodeTo(
      beneficiary,
      output,
    );
    _i5.VersionedMultiAssets.codec.encodeTo(
      assets,
      output,
    );
    _i1.U32Codec.codec.encodeTo(
      feeAssetItem,
      output,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(
        this,
        other,
      ) ||
      other is TeleportAssets &&
          other.dest == dest &&
          other.beneficiary == beneficiary &&
          other.assets == assets &&
          other.feeAssetItem == feeAssetItem;

  @override
  int get hashCode => Object.hash(
        dest,
        beneficiary,
        assets,
        feeAssetItem,
      );
}

/// Transfer some assets from the local chain to the sovereign account of a destination
/// chain and forward a notification XCM.
///
/// Fee payment on the destination side is made from the asset in the `assets` vector of
/// index `fee_asset_item`. The weight limit for fees is not provided and thus is unlimited,
/// with all fees taken as needed from the asset.
///
/// - `origin`: Must be capable of withdrawing the `assets` and executing XCM.
/// - `dest`: Destination context for the assets. Will typically be `X2(Parent, Parachain(..))` to send
///  from parachain to parachain, or `X1(Parachain(..))` to send from relay to parachain.
/// - `beneficiary`: A beneficiary location for the assets in the context of `dest`. Will generally be
///  an `AccountId32` value.
/// - `assets`: The assets to be withdrawn. This should include the assets used to pay the fee on the
///  `dest` side.
/// - `fee_asset_item`: The index into `assets` of the item which should be used to pay
///  fees.
class ReserveTransferAssets extends Call {
  const ReserveTransferAssets({
    required this.dest,
    required this.beneficiary,
    required this.assets,
    required this.feeAssetItem,
  });

  factory ReserveTransferAssets._decode(_i1.Input input) {
    return ReserveTransferAssets(
      dest: _i3.VersionedMultiLocation.codec.decode(input),
      beneficiary: _i3.VersionedMultiLocation.codec.decode(input),
      assets: _i5.VersionedMultiAssets.codec.decode(input),
      feeAssetItem: _i1.U32Codec.codec.decode(input),
    );
  }

  /// Box<VersionedMultiLocation>
  final _i3.VersionedMultiLocation dest;

  /// Box<VersionedMultiLocation>
  final _i3.VersionedMultiLocation beneficiary;

  /// Box<VersionedMultiAssets>
  final _i5.VersionedMultiAssets assets;

  /// u32
  final int feeAssetItem;

  @override
  Map<String, Map<String, dynamic>> toJson() => {
        'reserve_transfer_assets': {
          'dest': dest.toJson(),
          'beneficiary': beneficiary.toJson(),
          'assets': assets.toJson(),
          'feeAssetItem': feeAssetItem,
        }
      };

  int _sizeHint() {
    int size = 1;
    size = size + _i3.VersionedMultiLocation.codec.sizeHint(dest);
    size = size + _i3.VersionedMultiLocation.codec.sizeHint(beneficiary);
    size = size + _i5.VersionedMultiAssets.codec.sizeHint(assets);
    size = size + _i1.U32Codec.codec.sizeHint(feeAssetItem);
    return size;
  }

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      2,
      output,
    );
    _i3.VersionedMultiLocation.codec.encodeTo(
      dest,
      output,
    );
    _i3.VersionedMultiLocation.codec.encodeTo(
      beneficiary,
      output,
    );
    _i5.VersionedMultiAssets.codec.encodeTo(
      assets,
      output,
    );
    _i1.U32Codec.codec.encodeTo(
      feeAssetItem,
      output,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(
        this,
        other,
      ) ||
      other is ReserveTransferAssets &&
          other.dest == dest &&
          other.beneficiary == beneficiary &&
          other.assets == assets &&
          other.feeAssetItem == feeAssetItem;

  @override
  int get hashCode => Object.hash(
        dest,
        beneficiary,
        assets,
        feeAssetItem,
      );
}

/// Execute an XCM message from a local, signed, origin.
///
/// An event is deposited indicating whether `msg` could be executed completely or only
/// partially.
///
/// No more than `max_weight` will be used in its attempted execution. If this is less than the
/// maximum amount of weight that the message could take to be executed, then no execution
/// attempt will be made.
///
/// NOTE: A successful return to this does *not* imply that the `msg` was executed successfully
/// to completion; only that *some* of it was executed.
class Execute extends Call {
  const Execute({
    required this.message,
    required this.maxWeight,
  });

  factory Execute._decode(_i1.Input input) {
    return Execute(
      message: _i6.VersionedXcm.codec.decode(input),
      maxWeight: _i7.Weight.codec.decode(input),
    );
  }

  /// Box<VersionedXcm<<T as SysConfig>::RuntimeCall>>
  final _i6.VersionedXcm message;

  /// Weight
  final _i7.Weight maxWeight;

  @override
  Map<String, Map<String, Map<String, dynamic>>> toJson() => {
        'execute': {
          'message': message.toJson(),
          'maxWeight': maxWeight.toJson(),
        }
      };

  int _sizeHint() {
    int size = 1;
    size = size + _i6.VersionedXcm.codec.sizeHint(message);
    size = size + _i7.Weight.codec.sizeHint(maxWeight);
    return size;
  }

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      3,
      output,
    );
    _i6.VersionedXcm.codec.encodeTo(
      message,
      output,
    );
    _i7.Weight.codec.encodeTo(
      maxWeight,
      output,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(
        this,
        other,
      ) ||
      other is Execute &&
          other.message == message &&
          other.maxWeight == maxWeight;

  @override
  int get hashCode => Object.hash(
        message,
        maxWeight,
      );
}

/// Extoll that a particular destination can be communicated with through a particular
/// version of XCM.
///
/// - `origin`: Must be an origin specified by AdminOrigin.
/// - `location`: The destination that is being described.
/// - `xcm_version`: The latest version of XCM that `location` supports.
class ForceXcmVersion extends Call {
  const ForceXcmVersion({
    required this.location,
    required this.xcmVersion,
  });

  factory ForceXcmVersion._decode(_i1.Input input) {
    return ForceXcmVersion(
      location: _i8.MultiLocation.codec.decode(input),
      xcmVersion: _i1.U32Codec.codec.decode(input),
    );
  }

  /// Box<MultiLocation>
  final _i8.MultiLocation location;

  /// XcmVersion
  final int xcmVersion;

  @override
  Map<String, Map<String, dynamic>> toJson() => {
        'force_xcm_version': {
          'location': location.toJson(),
          'xcmVersion': xcmVersion,
        }
      };

  int _sizeHint() {
    int size = 1;
    size = size + _i8.MultiLocation.codec.sizeHint(location);
    size = size + _i1.U32Codec.codec.sizeHint(xcmVersion);
    return size;
  }

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      4,
      output,
    );
    _i8.MultiLocation.codec.encodeTo(
      location,
      output,
    );
    _i1.U32Codec.codec.encodeTo(
      xcmVersion,
      output,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(
        this,
        other,
      ) ||
      other is ForceXcmVersion &&
          other.location == location &&
          other.xcmVersion == xcmVersion;

  @override
  int get hashCode => Object.hash(
        location,
        xcmVersion,
      );
}

/// Set a safe XCM version (the version that XCM should be encoded with if the most recent
/// version a destination can accept is unknown).
///
/// - `origin`: Must be an origin specified by AdminOrigin.
/// - `maybe_xcm_version`: The default XCM encoding version, or `None` to disable.
class ForceDefaultXcmVersion extends Call {
  const ForceDefaultXcmVersion({this.maybeXcmVersion});

  factory ForceDefaultXcmVersion._decode(_i1.Input input) {
    return ForceDefaultXcmVersion(
        maybeXcmVersion:
            const _i1.OptionCodec<int>(_i1.U32Codec.codec).decode(input));
  }

  /// Option<XcmVersion>
  final int? maybeXcmVersion;

  @override
  Map<String, Map<String, int?>> toJson() => {
        'force_default_xcm_version': {'maybeXcmVersion': maybeXcmVersion}
      };

  int _sizeHint() {
    int size = 1;
    size = size +
        const _i1.OptionCodec<int>(_i1.U32Codec.codec)
            .sizeHint(maybeXcmVersion);
    return size;
  }

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      5,
      output,
    );
    const _i1.OptionCodec<int>(_i1.U32Codec.codec).encodeTo(
      maybeXcmVersion,
      output,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(
        this,
        other,
      ) ||
      other is ForceDefaultXcmVersion &&
          other.maybeXcmVersion == maybeXcmVersion;

  @override
  int get hashCode => maybeXcmVersion.hashCode;
}

/// Ask a location to notify us regarding their XCM version and any changes to it.
///
/// - `origin`: Must be an origin specified by AdminOrigin.
/// - `location`: The location to which we should subscribe for XCM version notifications.
class ForceSubscribeVersionNotify extends Call {
  const ForceSubscribeVersionNotify({required this.location});

  factory ForceSubscribeVersionNotify._decode(_i1.Input input) {
    return ForceSubscribeVersionNotify(
        location: _i3.VersionedMultiLocation.codec.decode(input));
  }

  /// Box<VersionedMultiLocation>
  final _i3.VersionedMultiLocation location;

  @override
  Map<String, Map<String, Map<String, Map<String, dynamic>>>> toJson() => {
        'force_subscribe_version_notify': {'location': location.toJson()}
      };

  int _sizeHint() {
    int size = 1;
    size = size + _i3.VersionedMultiLocation.codec.sizeHint(location);
    return size;
  }

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      6,
      output,
    );
    _i3.VersionedMultiLocation.codec.encodeTo(
      location,
      output,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(
        this,
        other,
      ) ||
      other is ForceSubscribeVersionNotify && other.location == location;

  @override
  int get hashCode => location.hashCode;
}

/// Require that a particular destination should no longer notify us regarding any XCM
/// version changes.
///
/// - `origin`: Must be an origin specified by AdminOrigin.
/// - `location`: The location to which we are currently subscribed for XCM version
///  notifications which we no longer desire.
class ForceUnsubscribeVersionNotify extends Call {
  const ForceUnsubscribeVersionNotify({required this.location});

  factory ForceUnsubscribeVersionNotify._decode(_i1.Input input) {
    return ForceUnsubscribeVersionNotify(
        location: _i3.VersionedMultiLocation.codec.decode(input));
  }

  /// Box<VersionedMultiLocation>
  final _i3.VersionedMultiLocation location;

  @override
  Map<String, Map<String, Map<String, Map<String, dynamic>>>> toJson() => {
        'force_unsubscribe_version_notify': {'location': location.toJson()}
      };

  int _sizeHint() {
    int size = 1;
    size = size + _i3.VersionedMultiLocation.codec.sizeHint(location);
    return size;
  }

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      7,
      output,
    );
    _i3.VersionedMultiLocation.codec.encodeTo(
      location,
      output,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(
        this,
        other,
      ) ||
      other is ForceUnsubscribeVersionNotify && other.location == location;

  @override
  int get hashCode => location.hashCode;
}

/// Transfer some assets from the local chain to the sovereign account of a destination
/// chain and forward a notification XCM.
///
/// Fee payment on the destination side is made from the asset in the `assets` vector of
/// index `fee_asset_item`, up to enough to pay for `weight_limit` of weight. If more weight
/// is needed than `weight_limit`, then the operation will fail and the assets send may be
/// at risk.
///
/// - `origin`: Must be capable of withdrawing the `assets` and executing XCM.
/// - `dest`: Destination context for the assets. Will typically be `X2(Parent, Parachain(..))` to send
///  from parachain to parachain, or `X1(Parachain(..))` to send from relay to parachain.
/// - `beneficiary`: A beneficiary location for the assets in the context of `dest`. Will generally be
///  an `AccountId32` value.
/// - `assets`: The assets to be withdrawn. This should include the assets used to pay the fee on the
///  `dest` side.
/// - `fee_asset_item`: The index into `assets` of the item which should be used to pay
///  fees.
/// - `weight_limit`: The remote-side weight limit, if any, for the XCM fee purchase.
class LimitedReserveTransferAssets extends Call {
  const LimitedReserveTransferAssets({
    required this.dest,
    required this.beneficiary,
    required this.assets,
    required this.feeAssetItem,
    required this.weightLimit,
  });

  factory LimitedReserveTransferAssets._decode(_i1.Input input) {
    return LimitedReserveTransferAssets(
      dest: _i3.VersionedMultiLocation.codec.decode(input),
      beneficiary: _i3.VersionedMultiLocation.codec.decode(input),
      assets: _i5.VersionedMultiAssets.codec.decode(input),
      feeAssetItem: _i1.U32Codec.codec.decode(input),
      weightLimit: _i9.WeightLimit.codec.decode(input),
    );
  }

  /// Box<VersionedMultiLocation>
  final _i3.VersionedMultiLocation dest;

  /// Box<VersionedMultiLocation>
  final _i3.VersionedMultiLocation beneficiary;

  /// Box<VersionedMultiAssets>
  final _i5.VersionedMultiAssets assets;

  /// u32
  final int feeAssetItem;

  /// WeightLimit
  final _i9.WeightLimit weightLimit;

  @override
  Map<String, Map<String, dynamic>> toJson() => {
        'limited_reserve_transfer_assets': {
          'dest': dest.toJson(),
          'beneficiary': beneficiary.toJson(),
          'assets': assets.toJson(),
          'feeAssetItem': feeAssetItem,
          'weightLimit': weightLimit.toJson(),
        }
      };

  int _sizeHint() {
    int size = 1;
    size = size + _i3.VersionedMultiLocation.codec.sizeHint(dest);
    size = size + _i3.VersionedMultiLocation.codec.sizeHint(beneficiary);
    size = size + _i5.VersionedMultiAssets.codec.sizeHint(assets);
    size = size + _i1.U32Codec.codec.sizeHint(feeAssetItem);
    size = size + _i9.WeightLimit.codec.sizeHint(weightLimit);
    return size;
  }

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      8,
      output,
    );
    _i3.VersionedMultiLocation.codec.encodeTo(
      dest,
      output,
    );
    _i3.VersionedMultiLocation.codec.encodeTo(
      beneficiary,
      output,
    );
    _i5.VersionedMultiAssets.codec.encodeTo(
      assets,
      output,
    );
    _i1.U32Codec.codec.encodeTo(
      feeAssetItem,
      output,
    );
    _i9.WeightLimit.codec.encodeTo(
      weightLimit,
      output,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(
        this,
        other,
      ) ||
      other is LimitedReserveTransferAssets &&
          other.dest == dest &&
          other.beneficiary == beneficiary &&
          other.assets == assets &&
          other.feeAssetItem == feeAssetItem &&
          other.weightLimit == weightLimit;

  @override
  int get hashCode => Object.hash(
        dest,
        beneficiary,
        assets,
        feeAssetItem,
        weightLimit,
      );
}

/// Teleport some assets from the local chain to some destination chain.
///
/// Fee payment on the destination side is made from the asset in the `assets` vector of
/// index `fee_asset_item`, up to enough to pay for `weight_limit` of weight. If more weight
/// is needed than `weight_limit`, then the operation will fail and the assets send may be
/// at risk.
///
/// - `origin`: Must be capable of withdrawing the `assets` and executing XCM.
/// - `dest`: Destination context for the assets. Will typically be `X2(Parent, Parachain(..))` to send
///  from parachain to parachain, or `X1(Parachain(..))` to send from relay to parachain.
/// - `beneficiary`: A beneficiary location for the assets in the context of `dest`. Will generally be
///  an `AccountId32` value.
/// - `assets`: The assets to be withdrawn. The first item should be the currency used to to pay the fee on the
///  `dest` side. May not be empty.
/// - `fee_asset_item`: The index into `assets` of the item which should be used to pay
///  fees.
/// - `weight_limit`: The remote-side weight limit, if any, for the XCM fee purchase.
class LimitedTeleportAssets extends Call {
  const LimitedTeleportAssets({
    required this.dest,
    required this.beneficiary,
    required this.assets,
    required this.feeAssetItem,
    required this.weightLimit,
  });

  factory LimitedTeleportAssets._decode(_i1.Input input) {
    return LimitedTeleportAssets(
      dest: _i3.VersionedMultiLocation.codec.decode(input),
      beneficiary: _i3.VersionedMultiLocation.codec.decode(input),
      assets: _i5.VersionedMultiAssets.codec.decode(input),
      feeAssetItem: _i1.U32Codec.codec.decode(input),
      weightLimit: _i9.WeightLimit.codec.decode(input),
    );
  }

  /// Box<VersionedMultiLocation>
  final _i3.VersionedMultiLocation dest;

  /// Box<VersionedMultiLocation>
  final _i3.VersionedMultiLocation beneficiary;

  /// Box<VersionedMultiAssets>
  final _i5.VersionedMultiAssets assets;

  /// u32
  final int feeAssetItem;

  /// WeightLimit
  final _i9.WeightLimit weightLimit;

  @override
  Map<String, Map<String, dynamic>> toJson() => {
        'limited_teleport_assets': {
          'dest': dest.toJson(),
          'beneficiary': beneficiary.toJson(),
          'assets': assets.toJson(),
          'feeAssetItem': feeAssetItem,
          'weightLimit': weightLimit.toJson(),
        }
      };

  int _sizeHint() {
    int size = 1;
    size = size + _i3.VersionedMultiLocation.codec.sizeHint(dest);
    size = size + _i3.VersionedMultiLocation.codec.sizeHint(beneficiary);
    size = size + _i5.VersionedMultiAssets.codec.sizeHint(assets);
    size = size + _i1.U32Codec.codec.sizeHint(feeAssetItem);
    size = size + _i9.WeightLimit.codec.sizeHint(weightLimit);
    return size;
  }

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      9,
      output,
    );
    _i3.VersionedMultiLocation.codec.encodeTo(
      dest,
      output,
    );
    _i3.VersionedMultiLocation.codec.encodeTo(
      beneficiary,
      output,
    );
    _i5.VersionedMultiAssets.codec.encodeTo(
      assets,
      output,
    );
    _i1.U32Codec.codec.encodeTo(
      feeAssetItem,
      output,
    );
    _i9.WeightLimit.codec.encodeTo(
      weightLimit,
      output,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(
        this,
        other,
      ) ||
      other is LimitedTeleportAssets &&
          other.dest == dest &&
          other.beneficiary == beneficiary &&
          other.assets == assets &&
          other.feeAssetItem == feeAssetItem &&
          other.weightLimit == weightLimit;

  @override
  int get hashCode => Object.hash(
        dest,
        beneficiary,
        assets,
        feeAssetItem,
        weightLimit,
      );
}

/// Set or unset the global suspension state of the XCM executor.
///
/// - `origin`: Must be an origin specified by AdminOrigin.
/// - `suspended`: `true` to suspend, `false` to resume.
class ForceSuspension extends Call {
  const ForceSuspension({required this.suspended});

  factory ForceSuspension._decode(_i1.Input input) {
    return ForceSuspension(suspended: _i1.BoolCodec.codec.decode(input));
  }

  /// bool
  final bool suspended;

  @override
  Map<String, Map<String, bool>> toJson() => {
        'force_suspension': {'suspended': suspended}
      };

  int _sizeHint() {
    int size = 1;
    size = size + _i1.BoolCodec.codec.sizeHint(suspended);
    return size;
  }

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      10,
      output,
    );
    _i1.BoolCodec.codec.encodeTo(
      suspended,
      output,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(
        this,
        other,
      ) ||
      other is ForceSuspension && other.suspended == suspended;

  @override
  int get hashCode => suspended.hashCode;
}
