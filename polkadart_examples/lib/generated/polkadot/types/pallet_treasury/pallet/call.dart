// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:typed_data' as _i2;

import 'package:polkadart/scale_codec.dart' as _i1;

import '../../sp_runtime/multiaddress/multi_address.dart' as _i3;

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

  ProposeSpend proposeSpend({
    required BigInt value,
    required _i3.MultiAddress beneficiary,
  }) {
    return ProposeSpend(
      value: value,
      beneficiary: beneficiary,
    );
  }

  RejectProposal rejectProposal({required BigInt proposalId}) {
    return RejectProposal(proposalId: proposalId);
  }

  ApproveProposal approveProposal({required BigInt proposalId}) {
    return ApproveProposal(proposalId: proposalId);
  }

  Spend spend({
    required BigInt amount,
    required _i3.MultiAddress beneficiary,
  }) {
    return Spend(
      amount: amount,
      beneficiary: beneficiary,
    );
  }

  RemoveApproval removeApproval({required BigInt proposalId}) {
    return RemoveApproval(proposalId: proposalId);
  }
}

class $CallCodec with _i1.Codec<Call> {
  const $CallCodec();

  @override
  Call decode(_i1.Input input) {
    final index = _i1.U8Codec.codec.decode(input);
    switch (index) {
      case 0:
        return ProposeSpend._decode(input);
      case 1:
        return RejectProposal._decode(input);
      case 2:
        return ApproveProposal._decode(input);
      case 3:
        return Spend._decode(input);
      case 4:
        return RemoveApproval._decode(input);
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
      case ProposeSpend:
        (value as ProposeSpend).encodeTo(output);
        break;
      case RejectProposal:
        (value as RejectProposal).encodeTo(output);
        break;
      case ApproveProposal:
        (value as ApproveProposal).encodeTo(output);
        break;
      case Spend:
        (value as Spend).encodeTo(output);
        break;
      case RemoveApproval:
        (value as RemoveApproval).encodeTo(output);
        break;
      default:
        throw Exception(
            'Call: Unsupported "$value" of type "${value.runtimeType}"');
    }
  }

  @override
  int sizeHint(Call value) {
    switch (value.runtimeType) {
      case ProposeSpend:
        return (value as ProposeSpend)._sizeHint();
      case RejectProposal:
        return (value as RejectProposal)._sizeHint();
      case ApproveProposal:
        return (value as ApproveProposal)._sizeHint();
      case Spend:
        return (value as Spend)._sizeHint();
      case RemoveApproval:
        return (value as RemoveApproval)._sizeHint();
      default:
        throw Exception(
            'Call: Unsupported "$value" of type "${value.runtimeType}"');
    }
  }
}

/// Put forward a suggestion for spending. A deposit proportional to the value
/// is reserved and slashed if the proposal is rejected. It is returned once the
/// proposal is awarded.
///
/// ## Complexity
/// - O(1)
class ProposeSpend extends Call {
  const ProposeSpend({
    required this.value,
    required this.beneficiary,
  });

  factory ProposeSpend._decode(_i1.Input input) {
    return ProposeSpend(
      value: _i1.CompactBigIntCodec.codec.decode(input),
      beneficiary: _i3.MultiAddress.codec.decode(input),
    );
  }

  /// BalanceOf<T, I>
  final BigInt value;

  /// AccountIdLookupOf<T>
  final _i3.MultiAddress beneficiary;

  @override
  Map<String, Map<String, dynamic>> toJson() => {
        'propose_spend': {
          'value': value,
          'beneficiary': beneficiary.toJson(),
        }
      };

  int _sizeHint() {
    int size = 1;
    size = size + _i1.CompactBigIntCodec.codec.sizeHint(value);
    size = size + _i3.MultiAddress.codec.sizeHint(beneficiary);
    return size;
  }

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      0,
      output,
    );
    _i1.CompactBigIntCodec.codec.encodeTo(
      value,
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
      other is ProposeSpend &&
          other.value == value &&
          other.beneficiary == beneficiary;

  @override
  int get hashCode => Object.hash(
        value,
        beneficiary,
      );
}

/// Reject a proposed spend. The original deposit will be slashed.
///
/// May only be called from `T::RejectOrigin`.
///
/// ## Complexity
/// - O(1)
class RejectProposal extends Call {
  const RejectProposal({required this.proposalId});

  factory RejectProposal._decode(_i1.Input input) {
    return RejectProposal(
        proposalId: _i1.CompactBigIntCodec.codec.decode(input));
  }

  /// ProposalIndex
  final BigInt proposalId;

  @override
  Map<String, Map<String, BigInt>> toJson() => {
        'reject_proposal': {'proposalId': proposalId}
      };

  int _sizeHint() {
    int size = 1;
    size = size + _i1.CompactBigIntCodec.codec.sizeHint(proposalId);
    return size;
  }

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      1,
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
      other is RejectProposal && other.proposalId == proposalId;

  @override
  int get hashCode => proposalId.hashCode;
}

/// Approve a proposal. At a later time, the proposal will be allocated to the beneficiary
/// and the original deposit will be returned.
///
/// May only be called from `T::ApproveOrigin`.
///
/// ## Complexity
/// - O(1).
class ApproveProposal extends Call {
  const ApproveProposal({required this.proposalId});

  factory ApproveProposal._decode(_i1.Input input) {
    return ApproveProposal(
        proposalId: _i1.CompactBigIntCodec.codec.decode(input));
  }

  /// ProposalIndex
  final BigInt proposalId;

  @override
  Map<String, Map<String, BigInt>> toJson() => {
        'approve_proposal': {'proposalId': proposalId}
      };

  int _sizeHint() {
    int size = 1;
    size = size + _i1.CompactBigIntCodec.codec.sizeHint(proposalId);
    return size;
  }

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      2,
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
      other is ApproveProposal && other.proposalId == proposalId;

  @override
  int get hashCode => proposalId.hashCode;
}

/// Propose and approve a spend of treasury funds.
///
/// - `origin`: Must be `SpendOrigin` with the `Success` value being at least `amount`.
/// - `amount`: The amount to be transferred from the treasury to the `beneficiary`.
/// - `beneficiary`: The destination account for the transfer.
///
/// NOTE: For record-keeping purposes, the proposer is deemed to be equivalent to the
/// beneficiary.
class Spend extends Call {
  const Spend({
    required this.amount,
    required this.beneficiary,
  });

  factory Spend._decode(_i1.Input input) {
    return Spend(
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
        'spend': {
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
      other is Spend &&
          other.amount == amount &&
          other.beneficiary == beneficiary;

  @override
  int get hashCode => Object.hash(
        amount,
        beneficiary,
      );
}

/// Force a previously approved proposal to be removed from the approval queue.
/// The original deposit will no longer be returned.
///
/// May only be called from `T::RejectOrigin`.
/// - `proposal_id`: The index of a proposal
///
/// ## Complexity
/// - O(A) where `A` is the number of approvals
///
/// Errors:
/// - `ProposalNotApproved`: The `proposal_id` supplied was not found in the approval queue,
/// i.e., the proposal has not been approved. This could also mean the proposal does not
/// exist altogether, thus there is no way it would have been approved in the first place.
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
