// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:typed_data' as _i2;

import 'package:polkadart/scale_codec.dart' as _i1;

import '../../polkadot_runtime_common/impls/versioned_locatable_asset.dart'
    as _i4;
import '../../sp_runtime/multiaddress/multi_address.dart' as _i3;
import '../../xcm/versioned_location.dart' as _i5;

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

  SpendLocal spendLocal({
    required BigInt amount,
    required _i3.MultiAddress beneficiary,
  }) {
    return SpendLocal(
      amount: amount,
      beneficiary: beneficiary,
    );
  }

  RemoveApproval removeApproval({required BigInt proposalId}) {
    return RemoveApproval(proposalId: proposalId);
  }

  Spend spend({
    required _i4.VersionedLocatableAsset assetKind,
    required BigInt amount,
    required _i5.VersionedLocation beneficiary,
    int? validFrom,
  }) {
    return Spend(
      assetKind: assetKind,
      amount: amount,
      beneficiary: beneficiary,
      validFrom: validFrom,
    );
  }

  Payout payout({required int index}) {
    return Payout(index: index);
  }

  CheckStatus checkStatus({required int index}) {
    return CheckStatus(index: index);
  }

  VoidSpend voidSpend({required int index}) {
    return VoidSpend(index: index);
  }
}

class $CallCodec with _i1.Codec<Call> {
  const $CallCodec();

  @override
  Call decode(_i1.Input input) {
    final index = _i1.U8Codec.codec.decode(input);
    switch (index) {
      case 3:
        return SpendLocal._decode(input);
      case 4:
        return RemoveApproval._decode(input);
      case 5:
        return Spend._decode(input);
      case 6:
        return Payout._decode(input);
      case 7:
        return CheckStatus._decode(input);
      case 8:
        return VoidSpend._decode(input);
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
      case SpendLocal:
        (value as SpendLocal).encodeTo(output);
        break;
      case RemoveApproval:
        (value as RemoveApproval).encodeTo(output);
        break;
      case Spend:
        (value as Spend).encodeTo(output);
        break;
      case Payout:
        (value as Payout).encodeTo(output);
        break;
      case CheckStatus:
        (value as CheckStatus).encodeTo(output);
        break;
      case VoidSpend:
        (value as VoidSpend).encodeTo(output);
        break;
      default:
        throw Exception(
            'Call: Unsupported "$value" of type "${value.runtimeType}"');
    }
  }

  @override
  int sizeHint(Call value) {
    switch (value.runtimeType) {
      case SpendLocal:
        return (value as SpendLocal)._sizeHint();
      case RemoveApproval:
        return (value as RemoveApproval)._sizeHint();
      case Spend:
        return (value as Spend)._sizeHint();
      case Payout:
        return (value as Payout)._sizeHint();
      case CheckStatus:
        return (value as CheckStatus)._sizeHint();
      case VoidSpend:
        return (value as VoidSpend)._sizeHint();
      default:
        throw Exception(
            'Call: Unsupported "$value" of type "${value.runtimeType}"');
    }
  }
}

/// Propose and approve a spend of treasury funds.
///
/// ## Dispatch Origin
///
/// Must be [`Config::SpendOrigin`] with the `Success` value being at least `amount`.
///
/// ### Details
/// NOTE: For record-keeping purposes, the proposer is deemed to be equivalent to the
/// beneficiary.
///
/// ### Parameters
/// - `amount`: The amount to be transferred from the treasury to the `beneficiary`.
/// - `beneficiary`: The destination account for the transfer.
///
/// ## Events
///
/// Emits [`Event::SpendApproved`] if successful.
class SpendLocal extends Call {
  const SpendLocal({
    required this.amount,
    required this.beneficiary,
  });

  factory SpendLocal._decode(_i1.Input input) {
    return SpendLocal(
      amount: _i1.CompactBigIntCodec.codec.decode(input),
      beneficiary: _i3.MultiAddress.codec.decode(input),
    );
  }

  /// BalanceOf<T, I>
  final BigInt amount;

  /// AccountIdLookupOf<T>
  final _i3.MultiAddress beneficiary;

  @override
  Map<String, Map<String, dynamic>> toJson() => {
        'spend_local': {
          'amount': amount,
          'beneficiary': beneficiary.toJson(),
        }
      };

  int _sizeHint() {
    int size = 1;
    size = size + _i1.CompactBigIntCodec.codec.sizeHint(amount);
    size = size + _i3.MultiAddress.codec.sizeHint(beneficiary);
    return size;
  }

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      3,
      output,
    );
    _i1.CompactBigIntCodec.codec.encodeTo(
      amount,
      output,
    );
    _i3.MultiAddress.codec.encodeTo(
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
      other is SpendLocal &&
          other.amount == amount &&
          other.beneficiary == beneficiary;

  @override
  int get hashCode => Object.hash(
        amount,
        beneficiary,
      );
}

/// Force a previously approved proposal to be removed from the approval queue.
///
/// ## Dispatch Origin
///
/// Must be [`Config::RejectOrigin`].
///
/// ## Details
///
/// The original deposit will no longer be returned.
///
/// ### Parameters
/// - `proposal_id`: The index of a proposal
///
/// ### Complexity
/// - O(A) where `A` is the number of approvals
///
/// ### Errors
/// - [`Error::ProposalNotApproved`]: The `proposal_id` supplied was not found in the
///  approval queue, i.e., the proposal has not been approved. This could also mean the
///  proposal does not exist altogether, thus there is no way it would have been approved
///  in the first place.
class RemoveApproval extends Call {
  const RemoveApproval({required this.proposalId});

  factory RemoveApproval._decode(_i1.Input input) {
    return RemoveApproval(
        proposalId: _i1.CompactBigIntCodec.codec.decode(input));
  }

  /// ProposalIndex
  final BigInt proposalId;

  @override
  Map<String, Map<String, BigInt>> toJson() => {
        'remove_approval': {'proposalId': proposalId}
      };

  int _sizeHint() {
    int size = 1;
    size = size + _i1.CompactBigIntCodec.codec.sizeHint(proposalId);
    return size;
  }

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      4,
      output,
    );
    _i1.CompactBigIntCodec.codec.encodeTo(
      proposalId,
      output,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(
        this,
        other,
      ) ||
      other is RemoveApproval && other.proposalId == proposalId;

  @override
  int get hashCode => proposalId.hashCode;
}

/// Propose and approve a spend of treasury funds.
///
/// ## Dispatch Origin
///
/// Must be [`Config::SpendOrigin`] with the `Success` value being at least
/// `amount` of `asset_kind` in the native asset. The amount of `asset_kind` is converted
/// for assertion using the [`Config::BalanceConverter`].
///
/// ## Details
///
/// Create an approved spend for transferring a specific `amount` of `asset_kind` to a
/// designated beneficiary. The spend must be claimed using the `payout` dispatchable within
/// the [`Config::PayoutPeriod`].
///
/// ### Parameters
/// - `asset_kind`: An indicator of the specific asset class to be spent.
/// - `amount`: The amount to be transferred from the treasury to the `beneficiary`.
/// - `beneficiary`: The beneficiary of the spend.
/// - `valid_from`: The block number from which the spend can be claimed. It can refer to
///  the past if the resulting spend has not yet expired according to the
///  [`Config::PayoutPeriod`]. If `None`, the spend can be claimed immediately after
///  approval.
///
/// ## Events
///
/// Emits [`Event::AssetSpendApproved`] if successful.
class Spend extends Call {
  const Spend({
    required this.assetKind,
    required this.amount,
    required this.beneficiary,
    this.validFrom,
  });

  factory Spend._decode(_i1.Input input) {
    return Spend(
      assetKind: _i4.VersionedLocatableAsset.codec.decode(input),
      amount: _i1.CompactBigIntCodec.codec.decode(input),
      beneficiary: _i5.VersionedLocation.codec.decode(input),
      validFrom: const _i1.OptionCodec<int>(_i1.U32Codec.codec).decode(input),
    );
  }

  /// Box<T::AssetKind>
  final _i4.VersionedLocatableAsset assetKind;

  /// AssetBalanceOf<T, I>
  final BigInt amount;

  /// Box<BeneficiaryLookupOf<T, I>>
  final _i5.VersionedLocation beneficiary;

  /// Option<BlockNumberFor<T>>
  final int? validFrom;

  @override
  Map<String, Map<String, dynamic>> toJson() => {
        'spend': {
          'assetKind': assetKind.toJson(),
          'amount': amount,
          'beneficiary': beneficiary.toJson(),
          'validFrom': validFrom,
        }
      };

  int _sizeHint() {
    int size = 1;
    size = size + _i4.VersionedLocatableAsset.codec.sizeHint(assetKind);
    size = size + _i1.CompactBigIntCodec.codec.sizeHint(amount);
    size = size + _i5.VersionedLocation.codec.sizeHint(beneficiary);
    size = size +
        const _i1.OptionCodec<int>(_i1.U32Codec.codec).sizeHint(validFrom);
    return size;
  }

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      5,
      output,
    );
    _i4.VersionedLocatableAsset.codec.encodeTo(
      assetKind,
      output,
    );
    _i1.CompactBigIntCodec.codec.encodeTo(
      amount,
      output,
    );
    _i5.VersionedLocation.codec.encodeTo(
      beneficiary,
      output,
    );
    const _i1.OptionCodec<int>(_i1.U32Codec.codec).encodeTo(
      validFrom,
      output,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(
        this,
        other,
      ) ||
      other is Spend &&
          other.assetKind == assetKind &&
          other.amount == amount &&
          other.beneficiary == beneficiary &&
          other.validFrom == validFrom;

  @override
  int get hashCode => Object.hash(
        assetKind,
        amount,
        beneficiary,
        validFrom,
      );
}

/// Claim a spend.
///
/// ## Dispatch Origin
///
/// Must be signed
///
/// ## Details
///
/// Spends must be claimed within some temporal bounds. A spend may be claimed within one
/// [`Config::PayoutPeriod`] from the `valid_from` block.
/// In case of a payout failure, the spend status must be updated with the `check_status`
/// dispatchable before retrying with the current function.
///
/// ### Parameters
/// - `index`: The spend index.
///
/// ## Events
///
/// Emits [`Event::Paid`] if successful.
class Payout extends Call {
  const Payout({required this.index});

  factory Payout._decode(_i1.Input input) {
    return Payout(index: _i1.U32Codec.codec.decode(input));
  }

  /// SpendIndex
  final int index;

  @override
  Map<String, Map<String, int>> toJson() => {
        'payout': {'index': index}
      };

  int _sizeHint() {
    int size = 1;
    size = size + _i1.U32Codec.codec.sizeHint(index);
    return size;
  }

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      6,
      output,
    );
    _i1.U32Codec.codec.encodeTo(
      index,
      output,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(
        this,
        other,
      ) ||
      other is Payout && other.index == index;

  @override
  int get hashCode => index.hashCode;
}

/// Check the status of the spend and remove it from the storage if processed.
///
/// ## Dispatch Origin
///
/// Must be signed.
///
/// ## Details
///
/// The status check is a prerequisite for retrying a failed payout.
/// If a spend has either succeeded or expired, it is removed from the storage by this
/// function. In such instances, transaction fees are refunded.
///
/// ### Parameters
/// - `index`: The spend index.
///
/// ## Events
///
/// Emits [`Event::PaymentFailed`] if the spend payout has failed.
/// Emits [`Event::SpendProcessed`] if the spend payout has succeed.
class CheckStatus extends Call {
  const CheckStatus({required this.index});

  factory CheckStatus._decode(_i1.Input input) {
    return CheckStatus(index: _i1.U32Codec.codec.decode(input));
  }

  /// SpendIndex
  final int index;

  @override
  Map<String, Map<String, int>> toJson() => {
        'check_status': {'index': index}
      };

  int _sizeHint() {
    int size = 1;
    size = size + _i1.U32Codec.codec.sizeHint(index);
    return size;
  }

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      7,
      output,
    );
    _i1.U32Codec.codec.encodeTo(
      index,
      output,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(
        this,
        other,
      ) ||
      other is CheckStatus && other.index == index;

  @override
  int get hashCode => index.hashCode;
}

/// Void previously approved spend.
///
/// ## Dispatch Origin
///
/// Must be [`Config::RejectOrigin`].
///
/// ## Details
///
/// A spend void is only possible if the payout has not been attempted yet.
///
/// ### Parameters
/// - `index`: The spend index.
///
/// ## Events
///
/// Emits [`Event::AssetSpendVoided`] if successful.
class VoidSpend extends Call {
  const VoidSpend({required this.index});

  factory VoidSpend._decode(_i1.Input input) {
    return VoidSpend(index: _i1.U32Codec.codec.decode(input));
  }

  /// SpendIndex
  final int index;

  @override
  Map<String, Map<String, int>> toJson() => {
        'void_spend': {'index': index}
      };

  int _sizeHint() {
    int size = 1;
    size = size + _i1.U32Codec.codec.sizeHint(index);
    return size;
  }

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      8,
      output,
    );
    _i1.U32Codec.codec.encodeTo(
      index,
      output,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(
        this,
        other,
      ) ||
      other is VoidSpend && other.index == index;

  @override
  int get hashCode => index.hashCode;
}
