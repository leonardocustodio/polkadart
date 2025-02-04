// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:typed_data' as _i2;

import 'package:polkadart/scale_codec.dart' as _i1;

import '../../sp_weights/weight_v2/weight.dart' as _i7;
import '../../staging_xcm/v4/location/location.dart' as _i8;
import '../../staging_xcm_executor/traits/asset_transfer/transfer_type.dart'
    as _i10;
import '../../xcm/v3/weight_limit.dart' as _i9;
import '../../xcm/versioned_asset_id.dart' as _i11;
import '../../xcm/versioned_assets.dart' as _i5;
import '../../xcm/versioned_location.dart' as _i3;
import '../../xcm/versioned_xcm_1.dart' as _i4;
import '../../xcm/versioned_xcm_2.dart' as _i6;

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

  Send send({
    required _i3.VersionedLocation dest,
    required _i4.VersionedXcm message,
  }) {
    return Send(
      dest: dest,
      message: message,
    );
  }

  TeleportAssets teleportAssets({
    required _i3.VersionedLocation dest,
    required _i3.VersionedLocation beneficiary,
    required _i5.VersionedAssets assets,
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
    required _i3.VersionedLocation dest,
    required _i3.VersionedLocation beneficiary,
    required _i5.VersionedAssets assets,
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
    required _i8.Location location,
    required int version,
  }) {
    return ForceXcmVersion(
      location: location,
      version: version,
    );
  }

  ForceDefaultXcmVersion forceDefaultXcmVersion({int? maybeXcmVersion}) {
    return ForceDefaultXcmVersion(maybeXcmVersion: maybeXcmVersion);
  }

  ForceSubscribeVersionNotify forceSubscribeVersionNotify(
      {required _i3.VersionedLocation location}) {
    return ForceSubscribeVersionNotify(location: location);
  }

  ForceUnsubscribeVersionNotify forceUnsubscribeVersionNotify(
      {required _i3.VersionedLocation location}) {
    return ForceUnsubscribeVersionNotify(location: location);
  }

  LimitedReserveTransferAssets limitedReserveTransferAssets({
    required _i3.VersionedLocation dest,
    required _i3.VersionedLocation beneficiary,
    required _i5.VersionedAssets assets,
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
    required _i3.VersionedLocation dest,
    required _i3.VersionedLocation beneficiary,
    required _i5.VersionedAssets assets,
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

  TransferAssets transferAssets({
    required _i3.VersionedLocation dest,
    required _i3.VersionedLocation beneficiary,
    required _i5.VersionedAssets assets,
    required int feeAssetItem,
    required _i9.WeightLimit weightLimit,
  }) {
    return TransferAssets(
      dest: dest,
      beneficiary: beneficiary,
      assets: assets,
      feeAssetItem: feeAssetItem,
      weightLimit: weightLimit,
    );
  }

  ClaimAssets claimAssets({
    required _i5.VersionedAssets assets,
    required _i3.VersionedLocation beneficiary,
  }) {
    return ClaimAssets(
      assets: assets,
      beneficiary: beneficiary,
    );
  }

  TransferAssetsUsingTypeAndThen transferAssetsUsingTypeAndThen({
    required _i3.VersionedLocation dest,
    required _i5.VersionedAssets assets,
    required _i10.TransferType assetsTransferType,
    required _i11.VersionedAssetId remoteFeesId,
    required _i10.TransferType feesTransferType,
    required _i4.VersionedXcm customXcmOnDest,
    required _i9.WeightLimit weightLimit,
  }) {
    return TransferAssetsUsingTypeAndThen(
      dest: dest,
      assets: assets,
      assetsTransferType: assetsTransferType,
      remoteFeesId: remoteFeesId,
      feesTransferType: feesTransferType,
      customXcmOnDest: customXcmOnDest,
      weightLimit: weightLimit,
    );
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
      case 11:
        return TransferAssets._decode(input);
      case 12:
        return ClaimAssets._decode(input);
      case 13:
        return TransferAssetsUsingTypeAndThen._decode(input);
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
      case TransferAssets:
        (value as TransferAssets).encodeTo(output);
        break;
      case ClaimAssets:
        (value as ClaimAssets).encodeTo(output);
        break;
      case TransferAssetsUsingTypeAndThen:
        (value as TransferAssetsUsingTypeAndThen).encodeTo(output);
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
      case TransferAssets:
        return (value as TransferAssets)._sizeHint();
      case ClaimAssets:
        return (value as ClaimAssets)._sizeHint();
      case TransferAssetsUsingTypeAndThen:
        return (value as TransferAssetsUsingTypeAndThen)._sizeHint();
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
      dest: _i3.VersionedLocation.codec.decode(input),
      message: _i4.VersionedXcm.codec.decode(input),
    );
  }

  /// Box<VersionedLocation>
  final _i3.VersionedLocation dest;

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
    size = size + _i3.VersionedLocation.codec.sizeHint(dest);
    size = size + _i4.VersionedXcm.codec.sizeHint(message);
    return size;
  }

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      0,
      output,
    );
    _i3.VersionedLocation.codec.encodeTo(
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
/// **This function is deprecated: Use `limited_teleport_assets` instead.**
///
/// Fee payment on the destination side is made from the asset in the `assets` vector of
/// index `fee_asset_item`. The weight limit for fees is not provided and thus is unlimited,
/// with all fees taken as needed from the asset.
///
/// - `origin`: Must be capable of withdrawing the `assets` and executing XCM.
/// - `dest`: Destination context for the assets. Will typically be `[Parent,
///  Parachain(..)]` to send from parachain to parachain, or `[Parachain(..)]` to send from
///  relay to parachain.
/// - `beneficiary`: A beneficiary location for the assets in the context of `dest`. Will
///  generally be an `AccountId32` value.
/// - `assets`: The assets to be withdrawn. This should include the assets used to pay the
///  fee on the `dest` chain.
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
      dest: _i3.VersionedLocation.codec.decode(input),
      beneficiary: _i3.VersionedLocation.codec.decode(input),
      assets: _i5.VersionedAssets.codec.decode(input),
      feeAssetItem: _i1.U32Codec.codec.decode(input),
    );
  }

  /// Box<VersionedLocation>
  final _i3.VersionedLocation dest;

  /// Box<VersionedLocation>
  final _i3.VersionedLocation beneficiary;

  /// Box<VersionedAssets>
  final _i5.VersionedAssets assets;

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
    size = size + _i3.VersionedLocation.codec.sizeHint(dest);
    size = size + _i3.VersionedLocation.codec.sizeHint(beneficiary);
    size = size + _i5.VersionedAssets.codec.sizeHint(assets);
    size = size + _i1.U32Codec.codec.sizeHint(feeAssetItem);
    return size;
  }

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      1,
      output,
    );
    _i3.VersionedLocation.codec.encodeTo(
      dest,
      output,
    );
    _i3.VersionedLocation.codec.encodeTo(
      beneficiary,
      output,
    );
    _i5.VersionedAssets.codec.encodeTo(
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

/// Transfer some assets from the local chain to the destination chain through their local,
/// destination or remote reserve.
///
/// `assets` must have same reserve location and may not be teleportable to `dest`.
/// - `assets` have local reserve: transfer assets to sovereign account of destination
///   chain and forward a notification XCM to `dest` to mint and deposit reserve-based
///   assets to `beneficiary`.
/// - `assets` have destination reserve: burn local assets and forward a notification to
///   `dest` chain to withdraw the reserve assets from this chain's sovereign account and
///   deposit them to `beneficiary`.
/// - `assets` have remote reserve: burn local assets, forward XCM to reserve chain to move
///   reserves from this chain's SA to `dest` chain's SA, and forward another XCM to `dest`
///   to mint and deposit reserve-based assets to `beneficiary`.
///
/// **This function is deprecated: Use `limited_reserve_transfer_assets` instead.**
///
/// Fee payment on the destination side is made from the asset in the `assets` vector of
/// index `fee_asset_item`. The weight limit for fees is not provided and thus is unlimited,
/// with all fees taken as needed from the asset.
///
/// - `origin`: Must be capable of withdrawing the `assets` and executing XCM.
/// - `dest`: Destination context for the assets. Will typically be `[Parent,
///  Parachain(..)]` to send from parachain to parachain, or `[Parachain(..)]` to send from
///  relay to parachain.
/// - `beneficiary`: A beneficiary location for the assets in the context of `dest`. Will
///  generally be an `AccountId32` value.
/// - `assets`: The assets to be withdrawn. This should include the assets used to pay the
///  fee on the `dest` (and possibly reserve) chains.
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
      dest: _i3.VersionedLocation.codec.decode(input),
      beneficiary: _i3.VersionedLocation.codec.decode(input),
      assets: _i5.VersionedAssets.codec.decode(input),
      feeAssetItem: _i1.U32Codec.codec.decode(input),
    );
  }

  /// Box<VersionedLocation>
  final _i3.VersionedLocation dest;

  /// Box<VersionedLocation>
  final _i3.VersionedLocation beneficiary;

  /// Box<VersionedAssets>
  final _i5.VersionedAssets assets;

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
    size = size + _i3.VersionedLocation.codec.sizeHint(dest);
    size = size + _i3.VersionedLocation.codec.sizeHint(beneficiary);
    size = size + _i5.VersionedAssets.codec.sizeHint(assets);
    size = size + _i1.U32Codec.codec.sizeHint(feeAssetItem);
    return size;
  }

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      2,
      output,
    );
    _i3.VersionedLocation.codec.encodeTo(
      dest,
      output,
    );
    _i3.VersionedLocation.codec.encodeTo(
      beneficiary,
      output,
    );
    _i5.VersionedAssets.codec.encodeTo(
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
/// No more than `max_weight` will be used in its attempted execution. If this is less than
/// the maximum amount of weight that the message could take to be executed, then no
/// execution attempt will be made.
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

  /// Box<VersionedXcm<<T as Config>::RuntimeCall>>
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
    required this.version,
  });

  factory ForceXcmVersion._decode(_i1.Input input) {
    return ForceXcmVersion(
      location: _i8.Location.codec.decode(input),
      version: _i1.U32Codec.codec.decode(input),
    );
  }

  /// Box<Location>
  final _i8.Location location;

  /// XcmVersion
  final int version;

  @override
  Map<String, Map<String, dynamic>> toJson() => {
        'force_xcm_version': {
          'location': location.toJson(),
          'version': version,
        }
      };

  int _sizeHint() {
    int size = 1;
    size = size + _i8.Location.codec.sizeHint(location);
    size = size + _i1.U32Codec.codec.sizeHint(version);
    return size;
  }

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      4,
      output,
    );
    _i8.Location.codec.encodeTo(
      location,
      output,
    );
    _i1.U32Codec.codec.encodeTo(
      version,
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
          other.version == version;

  @override
  int get hashCode => Object.hash(
        location,
        version,
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
        location: _i3.VersionedLocation.codec.decode(input));
  }

  /// Box<VersionedLocation>
  final _i3.VersionedLocation location;

  @override
  Map<String, Map<String, Map<String, Map<String, dynamic>>>> toJson() => {
        'force_subscribe_version_notify': {'location': location.toJson()}
      };

  int _sizeHint() {
    int size = 1;
    size = size + _i3.VersionedLocation.codec.sizeHint(location);
    return size;
  }

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      6,
      output,
    );
    _i3.VersionedLocation.codec.encodeTo(
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
        location: _i3.VersionedLocation.codec.decode(input));
  }

  /// Box<VersionedLocation>
  final _i3.VersionedLocation location;

  @override
  Map<String, Map<String, Map<String, Map<String, dynamic>>>> toJson() => {
        'force_unsubscribe_version_notify': {'location': location.toJson()}
      };

  int _sizeHint() {
    int size = 1;
    size = size + _i3.VersionedLocation.codec.sizeHint(location);
    return size;
  }

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      7,
      output,
    );
    _i3.VersionedLocation.codec.encodeTo(
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

/// Transfer some assets from the local chain to the destination chain through their local,
/// destination or remote reserve.
///
/// `assets` must have same reserve location and may not be teleportable to `dest`.
/// - `assets` have local reserve: transfer assets to sovereign account of destination
///   chain and forward a notification XCM to `dest` to mint and deposit reserve-based
///   assets to `beneficiary`.
/// - `assets` have destination reserve: burn local assets and forward a notification to
///   `dest` chain to withdraw the reserve assets from this chain's sovereign account and
///   deposit them to `beneficiary`.
/// - `assets` have remote reserve: burn local assets, forward XCM to reserve chain to move
///   reserves from this chain's SA to `dest` chain's SA, and forward another XCM to `dest`
///   to mint and deposit reserve-based assets to `beneficiary`.
///
/// Fee payment on the destination side is made from the asset in the `assets` vector of
/// index `fee_asset_item`, up to enough to pay for `weight_limit` of weight. If more weight
/// is needed than `weight_limit`, then the operation will fail and the sent assets may be
/// at risk.
///
/// - `origin`: Must be capable of withdrawing the `assets` and executing XCM.
/// - `dest`: Destination context for the assets. Will typically be `[Parent,
///  Parachain(..)]` to send from parachain to parachain, or `[Parachain(..)]` to send from
///  relay to parachain.
/// - `beneficiary`: A beneficiary location for the assets in the context of `dest`. Will
///  generally be an `AccountId32` value.
/// - `assets`: The assets to be withdrawn. This should include the assets used to pay the
///  fee on the `dest` (and possibly reserve) chains.
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
      dest: _i3.VersionedLocation.codec.decode(input),
      beneficiary: _i3.VersionedLocation.codec.decode(input),
      assets: _i5.VersionedAssets.codec.decode(input),
      feeAssetItem: _i1.U32Codec.codec.decode(input),
      weightLimit: _i9.WeightLimit.codec.decode(input),
    );
  }

  /// Box<VersionedLocation>
  final _i3.VersionedLocation dest;

  /// Box<VersionedLocation>
  final _i3.VersionedLocation beneficiary;

  /// Box<VersionedAssets>
  final _i5.VersionedAssets assets;

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
    size = size + _i3.VersionedLocation.codec.sizeHint(dest);
    size = size + _i3.VersionedLocation.codec.sizeHint(beneficiary);
    size = size + _i5.VersionedAssets.codec.sizeHint(assets);
    size = size + _i1.U32Codec.codec.sizeHint(feeAssetItem);
    size = size + _i9.WeightLimit.codec.sizeHint(weightLimit);
    return size;
  }

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      8,
      output,
    );
    _i3.VersionedLocation.codec.encodeTo(
      dest,
      output,
    );
    _i3.VersionedLocation.codec.encodeTo(
      beneficiary,
      output,
    );
    _i5.VersionedAssets.codec.encodeTo(
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
/// is needed than `weight_limit`, then the operation will fail and the sent assets may be
/// at risk.
///
/// - `origin`: Must be capable of withdrawing the `assets` and executing XCM.
/// - `dest`: Destination context for the assets. Will typically be `[Parent,
///  Parachain(..)]` to send from parachain to parachain, or `[Parachain(..)]` to send from
///  relay to parachain.
/// - `beneficiary`: A beneficiary location for the assets in the context of `dest`. Will
///  generally be an `AccountId32` value.
/// - `assets`: The assets to be withdrawn. This should include the assets used to pay the
///  fee on the `dest` chain.
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
      dest: _i3.VersionedLocation.codec.decode(input),
      beneficiary: _i3.VersionedLocation.codec.decode(input),
      assets: _i5.VersionedAssets.codec.decode(input),
      feeAssetItem: _i1.U32Codec.codec.decode(input),
      weightLimit: _i9.WeightLimit.codec.decode(input),
    );
  }

  /// Box<VersionedLocation>
  final _i3.VersionedLocation dest;

  /// Box<VersionedLocation>
  final _i3.VersionedLocation beneficiary;

  /// Box<VersionedAssets>
  final _i5.VersionedAssets assets;

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
    size = size + _i3.VersionedLocation.codec.sizeHint(dest);
    size = size + _i3.VersionedLocation.codec.sizeHint(beneficiary);
    size = size + _i5.VersionedAssets.codec.sizeHint(assets);
    size = size + _i1.U32Codec.codec.sizeHint(feeAssetItem);
    size = size + _i9.WeightLimit.codec.sizeHint(weightLimit);
    return size;
  }

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      9,
      output,
    );
    _i3.VersionedLocation.codec.encodeTo(
      dest,
      output,
    );
    _i3.VersionedLocation.codec.encodeTo(
      beneficiary,
      output,
    );
    _i5.VersionedAssets.codec.encodeTo(
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

/// Transfer some assets from the local chain to the destination chain through their local,
/// destination or remote reserve, or through teleports.
///
/// Fee payment on the destination side is made from the asset in the `assets` vector of
/// index `fee_asset_item` (hence referred to as `fees`), up to enough to pay for
/// `weight_limit` of weight. If more weight is needed than `weight_limit`, then the
/// operation will fail and the sent assets may be at risk.
///
/// `assets` (excluding `fees`) must have same reserve location or otherwise be teleportable
/// to `dest`, no limitations imposed on `fees`.
/// - for local reserve: transfer assets to sovereign account of destination chain and
///   forward a notification XCM to `dest` to mint and deposit reserve-based assets to
///   `beneficiary`.
/// - for destination reserve: burn local assets and forward a notification to `dest` chain
///   to withdraw the reserve assets from this chain's sovereign account and deposit them
///   to `beneficiary`.
/// - for remote reserve: burn local assets, forward XCM to reserve chain to move reserves
///   from this chain's SA to `dest` chain's SA, and forward another XCM to `dest` to mint
///   and deposit reserve-based assets to `beneficiary`.
/// - for teleports: burn local assets and forward XCM to `dest` chain to mint/teleport
///   assets and deposit them to `beneficiary`.
///
/// - `origin`: Must be capable of withdrawing the `assets` and executing XCM.
/// - `dest`: Destination context for the assets. Will typically be `X2(Parent,
///  Parachain(..))` to send from parachain to parachain, or `X1(Parachain(..))` to send
///  from relay to parachain.
/// - `beneficiary`: A beneficiary location for the assets in the context of `dest`. Will
///  generally be an `AccountId32` value.
/// - `assets`: The assets to be withdrawn. This should include the assets used to pay the
///  fee on the `dest` (and possibly reserve) chains.
/// - `fee_asset_item`: The index into `assets` of the item which should be used to pay
///  fees.
/// - `weight_limit`: The remote-side weight limit, if any, for the XCM fee purchase.
class TransferAssets extends Call {
  const TransferAssets({
    required this.dest,
    required this.beneficiary,
    required this.assets,
    required this.feeAssetItem,
    required this.weightLimit,
  });

  factory TransferAssets._decode(_i1.Input input) {
    return TransferAssets(
      dest: _i3.VersionedLocation.codec.decode(input),
      beneficiary: _i3.VersionedLocation.codec.decode(input),
      assets: _i5.VersionedAssets.codec.decode(input),
      feeAssetItem: _i1.U32Codec.codec.decode(input),
      weightLimit: _i9.WeightLimit.codec.decode(input),
    );
  }

  /// Box<VersionedLocation>
  final _i3.VersionedLocation dest;

  /// Box<VersionedLocation>
  final _i3.VersionedLocation beneficiary;

  /// Box<VersionedAssets>
  final _i5.VersionedAssets assets;

  /// u32
  final int feeAssetItem;

  /// WeightLimit
  final _i9.WeightLimit weightLimit;

  @override
  Map<String, Map<String, dynamic>> toJson() => {
        'transfer_assets': {
          'dest': dest.toJson(),
          'beneficiary': beneficiary.toJson(),
          'assets': assets.toJson(),
          'feeAssetItem': feeAssetItem,
          'weightLimit': weightLimit.toJson(),
        }
      };

  int _sizeHint() {
    int size = 1;
    size = size + _i3.VersionedLocation.codec.sizeHint(dest);
    size = size + _i3.VersionedLocation.codec.sizeHint(beneficiary);
    size = size + _i5.VersionedAssets.codec.sizeHint(assets);
    size = size + _i1.U32Codec.codec.sizeHint(feeAssetItem);
    size = size + _i9.WeightLimit.codec.sizeHint(weightLimit);
    return size;
  }

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      11,
      output,
    );
    _i3.VersionedLocation.codec.encodeTo(
      dest,
      output,
    );
    _i3.VersionedLocation.codec.encodeTo(
      beneficiary,
      output,
    );
    _i5.VersionedAssets.codec.encodeTo(
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
      other is TransferAssets &&
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

/// Claims assets trapped on this pallet because of leftover assets during XCM execution.
///
/// - `origin`: Anyone can call this extrinsic.
/// - `assets`: The exact assets that were trapped. Use the version to specify what version
/// was the latest when they were trapped.
/// - `beneficiary`: The location/account where the claimed assets will be deposited.
class ClaimAssets extends Call {
  const ClaimAssets({
    required this.assets,
    required this.beneficiary,
  });

  factory ClaimAssets._decode(_i1.Input input) {
    return ClaimAssets(
      assets: _i5.VersionedAssets.codec.decode(input),
      beneficiary: _i3.VersionedLocation.codec.decode(input),
    );
  }

  /// Box<VersionedAssets>
  final _i5.VersionedAssets assets;

  /// Box<VersionedLocation>
  final _i3.VersionedLocation beneficiary;

  @override
  Map<String, Map<String, Map<String, dynamic>>> toJson() => {
        'claim_assets': {
          'assets': assets.toJson(),
          'beneficiary': beneficiary.toJson(),
        }
      };

  int _sizeHint() {
    int size = 1;
    size = size + _i5.VersionedAssets.codec.sizeHint(assets);
    size = size + _i3.VersionedLocation.codec.sizeHint(beneficiary);
    return size;
  }

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      12,
      output,
    );
    _i5.VersionedAssets.codec.encodeTo(
      assets,
      output,
    );
    _i3.VersionedLocation.codec.encodeTo(
      beneficiary,
      output,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(
        this,
        other,
      ) ||
      other is ClaimAssets &&
          other.assets == assets &&
          other.beneficiary == beneficiary;

  @override
  int get hashCode => Object.hash(
        assets,
        beneficiary,
      );
}

/// Transfer assets from the local chain to the destination chain using explicit transfer
/// types for assets and fees.
///
/// `assets` must have same reserve location or may be teleportable to `dest`. Caller must
/// provide the `assets_transfer_type` to be used for `assets`:
/// - `TransferType::LocalReserve`: transfer assets to sovereign account of destination
///   chain and forward a notification XCM to `dest` to mint and deposit reserve-based
///   assets to `beneficiary`.
/// - `TransferType::DestinationReserve`: burn local assets and forward a notification to
///   `dest` chain to withdraw the reserve assets from this chain's sovereign account and
///   deposit them to `beneficiary`.
/// - `TransferType::RemoteReserve(reserve)`: burn local assets, forward XCM to `reserve`
///   chain to move reserves from this chain's SA to `dest` chain's SA, and forward another
///   XCM to `dest` to mint and deposit reserve-based assets to `beneficiary`. Typically
///   the remote `reserve` is Asset Hub.
/// - `TransferType::Teleport`: burn local assets and forward XCM to `dest` chain to
///   mint/teleport assets and deposit them to `beneficiary`.
///
/// On the destination chain, as well as any intermediary hops, `BuyExecution` is used to
/// buy execution using transferred `assets` identified by `remote_fees_id`.
/// Make sure enough of the specified `remote_fees_id` asset is included in the given list
/// of `assets`. `remote_fees_id` should be enough to pay for `weight_limit`. If more weight
/// is needed than `weight_limit`, then the operation will fail and the sent assets may be
/// at risk.
///
/// `remote_fees_id` may use different transfer type than rest of `assets` and can be
/// specified through `fees_transfer_type`.
///
/// The caller needs to specify what should happen to the transferred assets once they reach
/// the `dest` chain. This is done through the `custom_xcm_on_dest` parameter, which
/// contains the instructions to execute on `dest` as a final step.
///  This is usually as simple as:
///  `Xcm(vec![DepositAsset { assets: Wild(AllCounted(assets.len())), beneficiary }])`,
///  but could be something more exotic like sending the `assets` even further.
///
/// - `origin`: Must be capable of withdrawing the `assets` and executing XCM.
/// - `dest`: Destination context for the assets. Will typically be `[Parent,
///  Parachain(..)]` to send from parachain to parachain, or `[Parachain(..)]` to send from
///  relay to parachain, or `(parents: 2, (GlobalConsensus(..), ..))` to send from
///  parachain across a bridge to another ecosystem destination.
/// - `assets`: The assets to be withdrawn. This should include the assets used to pay the
///  fee on the `dest` (and possibly reserve) chains.
/// - `assets_transfer_type`: The XCM `TransferType` used to transfer the `assets`.
/// - `remote_fees_id`: One of the included `assets` to be used to pay fees.
/// - `fees_transfer_type`: The XCM `TransferType` used to transfer the `fees` assets.
/// - `custom_xcm_on_dest`: The XCM to be executed on `dest` chain as the last step of the
///  transfer, which also determines what happens to the assets on the destination chain.
/// - `weight_limit`: The remote-side weight limit, if any, for the XCM fee purchase.
class TransferAssetsUsingTypeAndThen extends Call {
  const TransferAssetsUsingTypeAndThen({
    required this.dest,
    required this.assets,
    required this.assetsTransferType,
    required this.remoteFeesId,
    required this.feesTransferType,
    required this.customXcmOnDest,
    required this.weightLimit,
  });

  factory TransferAssetsUsingTypeAndThen._decode(_i1.Input input) {
    return TransferAssetsUsingTypeAndThen(
      dest: _i3.VersionedLocation.codec.decode(input),
      assets: _i5.VersionedAssets.codec.decode(input),
      assetsTransferType: _i10.TransferType.codec.decode(input),
      remoteFeesId: _i11.VersionedAssetId.codec.decode(input),
      feesTransferType: _i10.TransferType.codec.decode(input),
      customXcmOnDest: _i4.VersionedXcm.codec.decode(input),
      weightLimit: _i9.WeightLimit.codec.decode(input),
    );
  }

  /// Box<VersionedLocation>
  final _i3.VersionedLocation dest;

  /// Box<VersionedAssets>
  final _i5.VersionedAssets assets;

  /// Box<TransferType>
  final _i10.TransferType assetsTransferType;

  /// Box<VersionedAssetId>
  final _i11.VersionedAssetId remoteFeesId;

  /// Box<TransferType>
  final _i10.TransferType feesTransferType;

  /// Box<VersionedXcm<()>>
  final _i4.VersionedXcm customXcmOnDest;

  /// WeightLimit
  final _i9.WeightLimit weightLimit;

  @override
  Map<String, Map<String, Map<String, dynamic>>> toJson() => {
        'transfer_assets_using_type_and_then': {
          'dest': dest.toJson(),
          'assets': assets.toJson(),
          'assetsTransferType': assetsTransferType.toJson(),
          'remoteFeesId': remoteFeesId.toJson(),
          'feesTransferType': feesTransferType.toJson(),
          'customXcmOnDest': customXcmOnDest.toJson(),
          'weightLimit': weightLimit.toJson(),
        }
      };

  int _sizeHint() {
    int size = 1;
    size = size + _i3.VersionedLocation.codec.sizeHint(dest);
    size = size + _i5.VersionedAssets.codec.sizeHint(assets);
    size = size + _i10.TransferType.codec.sizeHint(assetsTransferType);
    size = size + _i11.VersionedAssetId.codec.sizeHint(remoteFeesId);
    size = size + _i10.TransferType.codec.sizeHint(feesTransferType);
    size = size + _i4.VersionedXcm.codec.sizeHint(customXcmOnDest);
    size = size + _i9.WeightLimit.codec.sizeHint(weightLimit);
    return size;
  }

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      13,
      output,
    );
    _i3.VersionedLocation.codec.encodeTo(
      dest,
      output,
    );
    _i5.VersionedAssets.codec.encodeTo(
      assets,
      output,
    );
    _i10.TransferType.codec.encodeTo(
      assetsTransferType,
      output,
    );
    _i11.VersionedAssetId.codec.encodeTo(
      remoteFeesId,
      output,
    );
    _i10.TransferType.codec.encodeTo(
      feesTransferType,
      output,
    );
    _i4.VersionedXcm.codec.encodeTo(
      customXcmOnDest,
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
      other is TransferAssetsUsingTypeAndThen &&
          other.dest == dest &&
          other.assets == assets &&
          other.assetsTransferType == assetsTransferType &&
          other.remoteFeesId == remoteFeesId &&
          other.feesTransferType == feesTransferType &&
          other.customXcmOnDest == customXcmOnDest &&
          other.weightLimit == weightLimit;

  @override
  int get hashCode => Object.hash(
        dest,
        assets,
        assetsTransferType,
        remoteFeesId,
        feesTransferType,
        customXcmOnDest,
        weightLimit,
      );
}
