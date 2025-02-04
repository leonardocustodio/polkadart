// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:typed_data' as _i2;

import 'package:polkadart/scale_codec.dart' as _i1;
import 'package:quiver/collection.dart' as _i4;

import '../../sp_runtime/multiaddress/multi_address.dart' as _i3;

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

  ProposeBounty proposeBounty({
    required BigInt value,
    required List<int> description,
  }) {
    return ProposeBounty(
      value: value,
      description: description,
    );
  }

  ApproveBounty approveBounty({required BigInt bountyId}) {
    return ApproveBounty(bountyId: bountyId);
  }

  ProposeCurator proposeCurator({
    required BigInt bountyId,
    required _i3.MultiAddress curator,
    required BigInt fee,
  }) {
    return ProposeCurator(
      bountyId: bountyId,
      curator: curator,
      fee: fee,
    );
  }

  UnassignCurator unassignCurator({required BigInt bountyId}) {
    return UnassignCurator(bountyId: bountyId);
  }

  AcceptCurator acceptCurator({required BigInt bountyId}) {
    return AcceptCurator(bountyId: bountyId);
  }

  AwardBounty awardBounty({
    required BigInt bountyId,
    required _i3.MultiAddress beneficiary,
  }) {
    return AwardBounty(
      bountyId: bountyId,
      beneficiary: beneficiary,
    );
  }

  ClaimBounty claimBounty({required BigInt bountyId}) {
    return ClaimBounty(bountyId: bountyId);
  }

  CloseBounty closeBounty({required BigInt bountyId}) {
    return CloseBounty(bountyId: bountyId);
  }

  ExtendBountyExpiry extendBountyExpiry({
    required BigInt bountyId,
    required List<int> remark,
  }) {
    return ExtendBountyExpiry(
      bountyId: bountyId,
      remark: remark,
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
        return ProposeBounty._decode(input);
      case 1:
        return ApproveBounty._decode(input);
      case 2:
        return ProposeCurator._decode(input);
      case 3:
        return UnassignCurator._decode(input);
      case 4:
        return AcceptCurator._decode(input);
      case 5:
        return AwardBounty._decode(input);
      case 6:
        return ClaimBounty._decode(input);
      case 7:
        return CloseBounty._decode(input);
      case 8:
        return ExtendBountyExpiry._decode(input);
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
      case ProposeBounty:
        (value as ProposeBounty).encodeTo(output);
        break;
      case ApproveBounty:
        (value as ApproveBounty).encodeTo(output);
        break;
      case ProposeCurator:
        (value as ProposeCurator).encodeTo(output);
        break;
      case UnassignCurator:
        (value as UnassignCurator).encodeTo(output);
        break;
      case AcceptCurator:
        (value as AcceptCurator).encodeTo(output);
        break;
      case AwardBounty:
        (value as AwardBounty).encodeTo(output);
        break;
      case ClaimBounty:
        (value as ClaimBounty).encodeTo(output);
        break;
      case CloseBounty:
        (value as CloseBounty).encodeTo(output);
        break;
      case ExtendBountyExpiry:
        (value as ExtendBountyExpiry).encodeTo(output);
        break;
      default:
        throw Exception(
            'Call: Unsupported "$value" of type "${value.runtimeType}"');
    }
  }

  @override
  int sizeHint(Call value) {
    switch (value.runtimeType) {
      case ProposeBounty:
        return (value as ProposeBounty)._sizeHint();
      case ApproveBounty:
        return (value as ApproveBounty)._sizeHint();
      case ProposeCurator:
        return (value as ProposeCurator)._sizeHint();
      case UnassignCurator:
        return (value as UnassignCurator)._sizeHint();
      case AcceptCurator:
        return (value as AcceptCurator)._sizeHint();
      case AwardBounty:
        return (value as AwardBounty)._sizeHint();
      case ClaimBounty:
        return (value as ClaimBounty)._sizeHint();
      case CloseBounty:
        return (value as CloseBounty)._sizeHint();
      case ExtendBountyExpiry:
        return (value as ExtendBountyExpiry)._sizeHint();
      default:
        throw Exception(
            'Call: Unsupported "$value" of type "${value.runtimeType}"');
    }
  }
}

/// Propose a new bounty.
///
/// The dispatch origin for this call must be _Signed_.
///
/// Payment: `TipReportDepositBase` will be reserved from the origin account, as well as
/// `DataDepositPerByte` for each byte in `reason`. It will be unreserved upon approval,
/// or slashed when rejected.
///
/// - `curator`: The curator account whom will manage this bounty.
/// - `fee`: The curator fee.
/// - `value`: The total payment amount of this bounty, curator fee included.
/// - `description`: The description of this bounty.
class ProposeBounty extends Call {
  const ProposeBounty({
    required this.value,
    required this.description,
  });

  factory ProposeBounty._decode(_i1.Input input) {
    return ProposeBounty(
      value: _i1.CompactBigIntCodec.codec.decode(input),
      description: _i1.U8SequenceCodec.codec.decode(input),
    );
  }

  /// BalanceOf<T, I>
  final BigInt value;

  /// Vec<u8>
  final List<int> description;

  @override
  Map<String, Map<String, dynamic>> toJson() => {
        'propose_bounty': {
          'value': value,
          'description': description,
        }
      };

  int _sizeHint() {
    int size = 1;
    size = size + _i1.CompactBigIntCodec.codec.sizeHint(value);
    size = size + _i1.U8SequenceCodec.codec.sizeHint(description);
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
    _i1.U8SequenceCodec.codec.encodeTo(
      description,
      output,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(
        this,
        other,
      ) ||
      other is ProposeBounty &&
          other.value == value &&
          _i4.listsEqual(
            other.description,
            description,
          );

  @override
  int get hashCode => Object.hash(
        value,
        description,
      );
}

/// Approve a bounty proposal. At a later time, the bounty will be funded and become active
/// and the original deposit will be returned.
///
/// May only be called from `T::SpendOrigin`.
///
/// ## Complexity
/// - O(1).
class ApproveBounty extends Call {
  const ApproveBounty({required this.bountyId});

  factory ApproveBounty._decode(_i1.Input input) {
    return ApproveBounty(bountyId: _i1.CompactBigIntCodec.codec.decode(input));
  }

  /// BountyIndex
  final BigInt bountyId;

  @override
  Map<String, Map<String, BigInt>> toJson() => {
        'approve_bounty': {'bountyId': bountyId}
      };

  int _sizeHint() {
    int size = 1;
    size = size + _i1.CompactBigIntCodec.codec.sizeHint(bountyId);
    return size;
  }

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      1,
      output,
    );
    _i1.CompactBigIntCodec.codec.encodeTo(
      bountyId,
      output,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(
        this,
        other,
      ) ||
      other is ApproveBounty && other.bountyId == bountyId;

  @override
  int get hashCode => bountyId.hashCode;
}

/// Propose a curator to a funded bounty.
///
/// May only be called from `T::SpendOrigin`.
///
/// ## Complexity
/// - O(1).
class ProposeCurator extends Call {
  const ProposeCurator({
    required this.bountyId,
    required this.curator,
    required this.fee,
  });

  factory ProposeCurator._decode(_i1.Input input) {
    return ProposeCurator(
      bountyId: _i1.CompactBigIntCodec.codec.decode(input),
      curator: _i3.MultiAddress.codec.decode(input),
      fee: _i1.CompactBigIntCodec.codec.decode(input),
    );
  }

  /// BountyIndex
  final BigInt bountyId;

  /// AccountIdLookupOf<T>
  final _i3.MultiAddress curator;

  /// BalanceOf<T, I>
  final BigInt fee;

  @override
  Map<String, Map<String, dynamic>> toJson() => {
        'propose_curator': {
          'bountyId': bountyId,
          'curator': curator.toJson(),
          'fee': fee,
        }
      };

  int _sizeHint() {
    int size = 1;
    size = size + _i1.CompactBigIntCodec.codec.sizeHint(bountyId);
    size = size + _i3.MultiAddress.codec.sizeHint(curator);
    size = size + _i1.CompactBigIntCodec.codec.sizeHint(fee);
    return size;
  }

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      2,
      output,
    );
    _i1.CompactBigIntCodec.codec.encodeTo(
      bountyId,
      output,
    );
    _i3.MultiAddress.codec.encodeTo(
      curator,
      output,
    );
    _i1.CompactBigIntCodec.codec.encodeTo(
      fee,
      output,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(
        this,
        other,
      ) ||
      other is ProposeCurator &&
          other.bountyId == bountyId &&
          other.curator == curator &&
          other.fee == fee;

  @override
  int get hashCode => Object.hash(
        bountyId,
        curator,
        fee,
      );
}

/// Unassign curator from a bounty.
///
/// This function can only be called by the `RejectOrigin` a signed origin.
///
/// If this function is called by the `RejectOrigin`, we assume that the curator is
/// malicious or inactive. As a result, we will slash the curator when possible.
///
/// If the origin is the curator, we take this as a sign they are unable to do their job and
/// they willingly give up. We could slash them, but for now we allow them to recover their
/// deposit and exit without issue. (We may want to change this if it is abused.)
///
/// Finally, the origin can be anyone if and only if the curator is "inactive". This allows
/// anyone in the community to call out that a curator is not doing their due diligence, and
/// we should pick a new curator. In this case the curator should also be slashed.
///
/// ## Complexity
/// - O(1).
class UnassignCurator extends Call {
  const UnassignCurator({required this.bountyId});

  factory UnassignCurator._decode(_i1.Input input) {
    return UnassignCurator(
        bountyId: _i1.CompactBigIntCodec.codec.decode(input));
  }

  /// BountyIndex
  final BigInt bountyId;

  @override
  Map<String, Map<String, BigInt>> toJson() => {
        'unassign_curator': {'bountyId': bountyId}
      };

  int _sizeHint() {
    int size = 1;
    size = size + _i1.CompactBigIntCodec.codec.sizeHint(bountyId);
    return size;
  }

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      3,
      output,
    );
    _i1.CompactBigIntCodec.codec.encodeTo(
      bountyId,
      output,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(
        this,
        other,
      ) ||
      other is UnassignCurator && other.bountyId == bountyId;

  @override
  int get hashCode => bountyId.hashCode;
}

/// Accept the curator role for a bounty.
/// A deposit will be reserved from curator and refund upon successful payout.
///
/// May only be called from the curator.
///
/// ## Complexity
/// - O(1).
class AcceptCurator extends Call {
  const AcceptCurator({required this.bountyId});

  factory AcceptCurator._decode(_i1.Input input) {
    return AcceptCurator(bountyId: _i1.CompactBigIntCodec.codec.decode(input));
  }

  /// BountyIndex
  final BigInt bountyId;

  @override
  Map<String, Map<String, BigInt>> toJson() => {
        'accept_curator': {'bountyId': bountyId}
      };

  int _sizeHint() {
    int size = 1;
    size = size + _i1.CompactBigIntCodec.codec.sizeHint(bountyId);
    return size;
  }

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      4,
      output,
    );
    _i1.CompactBigIntCodec.codec.encodeTo(
      bountyId,
      output,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(
        this,
        other,
      ) ||
      other is AcceptCurator && other.bountyId == bountyId;

  @override
  int get hashCode => bountyId.hashCode;
}

/// Award bounty to a beneficiary account. The beneficiary will be able to claim the funds
/// after a delay.
///
/// The dispatch origin for this call must be the curator of this bounty.
///
/// - `bounty_id`: Bounty ID to award.
/// - `beneficiary`: The beneficiary account whom will receive the payout.
///
/// ## Complexity
/// - O(1).
class AwardBounty extends Call {
  const AwardBounty({
    required this.bountyId,
    required this.beneficiary,
  });

  factory AwardBounty._decode(_i1.Input input) {
    return AwardBounty(
      bountyId: _i1.CompactBigIntCodec.codec.decode(input),
      beneficiary: _i3.MultiAddress.codec.decode(input),
    );
  }

  /// BountyIndex
  final BigInt bountyId;

  /// AccountIdLookupOf<T>
  final _i3.MultiAddress beneficiary;

  @override
  Map<String, Map<String, dynamic>> toJson() => {
        'award_bounty': {
          'bountyId': bountyId,
          'beneficiary': beneficiary.toJson(),
        }
      };

  int _sizeHint() {
    int size = 1;
    size = size + _i1.CompactBigIntCodec.codec.sizeHint(bountyId);
    size = size + _i3.MultiAddress.codec.sizeHint(beneficiary);
    return size;
  }

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      5,
      output,
    );
    _i1.CompactBigIntCodec.codec.encodeTo(
      bountyId,
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
      other is AwardBounty &&
          other.bountyId == bountyId &&
          other.beneficiary == beneficiary;

  @override
  int get hashCode => Object.hash(
        bountyId,
        beneficiary,
      );
}

/// Claim the payout from an awarded bounty after payout delay.
///
/// The dispatch origin for this call must be the beneficiary of this bounty.
///
/// - `bounty_id`: Bounty ID to claim.
///
/// ## Complexity
/// - O(1).
class ClaimBounty extends Call {
  const ClaimBounty({required this.bountyId});

  factory ClaimBounty._decode(_i1.Input input) {
    return ClaimBounty(bountyId: _i1.CompactBigIntCodec.codec.decode(input));
  }

  /// BountyIndex
  final BigInt bountyId;

  @override
  Map<String, Map<String, BigInt>> toJson() => {
        'claim_bounty': {'bountyId': bountyId}
      };

  int _sizeHint() {
    int size = 1;
    size = size + _i1.CompactBigIntCodec.codec.sizeHint(bountyId);
    return size;
  }

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      6,
      output,
    );
    _i1.CompactBigIntCodec.codec.encodeTo(
      bountyId,
      output,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(
        this,
        other,
      ) ||
      other is ClaimBounty && other.bountyId == bountyId;

  @override
  int get hashCode => bountyId.hashCode;
}

/// Cancel a proposed or active bounty. All the funds will be sent to treasury and
/// the curator deposit will be unreserved if possible.
///
/// Only `T::RejectOrigin` is able to cancel a bounty.
///
/// - `bounty_id`: Bounty ID to cancel.
///
/// ## Complexity
/// - O(1).
class CloseBounty extends Call {
  const CloseBounty({required this.bountyId});

  factory CloseBounty._decode(_i1.Input input) {
    return CloseBounty(bountyId: _i1.CompactBigIntCodec.codec.decode(input));
  }

  /// BountyIndex
  final BigInt bountyId;

  @override
  Map<String, Map<String, BigInt>> toJson() => {
        'close_bounty': {'bountyId': bountyId}
      };

  int _sizeHint() {
    int size = 1;
    size = size + _i1.CompactBigIntCodec.codec.sizeHint(bountyId);
    return size;
  }

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      7,
      output,
    );
    _i1.CompactBigIntCodec.codec.encodeTo(
      bountyId,
      output,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(
        this,
        other,
      ) ||
      other is CloseBounty && other.bountyId == bountyId;

  @override
  int get hashCode => bountyId.hashCode;
}

/// Extend the expiry time of an active bounty.
///
/// The dispatch origin for this call must be the curator of this bounty.
///
/// - `bounty_id`: Bounty ID to extend.
/// - `remark`: additional information.
///
/// ## Complexity
/// - O(1).
class ExtendBountyExpiry extends Call {
  const ExtendBountyExpiry({
    required this.bountyId,
    required this.remark,
  });

  factory ExtendBountyExpiry._decode(_i1.Input input) {
    return ExtendBountyExpiry(
      bountyId: _i1.CompactBigIntCodec.codec.decode(input),
      remark: _i1.U8SequenceCodec.codec.decode(input),
    );
  }

  /// BountyIndex
  final BigInt bountyId;

  /// Vec<u8>
  final List<int> remark;

  @override
  Map<String, Map<String, dynamic>> toJson() => {
        'extend_bounty_expiry': {
          'bountyId': bountyId,
          'remark': remark,
        }
      };

  int _sizeHint() {
    int size = 1;
    size = size + _i1.CompactBigIntCodec.codec.sizeHint(bountyId);
    size = size + _i1.U8SequenceCodec.codec.sizeHint(remark);
    return size;
  }

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      8,
      output,
    );
    _i1.CompactBigIntCodec.codec.encodeTo(
      bountyId,
      output,
    );
    _i1.U8SequenceCodec.codec.encodeTo(
      remark,
      output,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(
        this,
        other,
      ) ||
      other is ExtendBountyExpiry &&
          other.bountyId == bountyId &&
          _i4.listsEqual(
            other.remark,
            remark,
          );

  @override
  int get hashCode => Object.hash(
        bountyId,
        remark,
      );
}
