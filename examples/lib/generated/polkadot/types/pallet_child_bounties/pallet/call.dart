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

  AddChildBounty addChildBounty({
    required BigInt parentBountyId,
    required BigInt value,
    required List<int> description,
  }) {
    return AddChildBounty(
      parentBountyId: parentBountyId,
      value: value,
      description: description,
    );
  }

  ProposeCurator proposeCurator({
    required BigInt parentBountyId,
    required BigInt childBountyId,
    required _i3.MultiAddress curator,
    required BigInt fee,
  }) {
    return ProposeCurator(
      parentBountyId: parentBountyId,
      childBountyId: childBountyId,
      curator: curator,
      fee: fee,
    );
  }

  AcceptCurator acceptCurator({
    required BigInt parentBountyId,
    required BigInt childBountyId,
  }) {
    return AcceptCurator(
      parentBountyId: parentBountyId,
      childBountyId: childBountyId,
    );
  }

  UnassignCurator unassignCurator({
    required BigInt parentBountyId,
    required BigInt childBountyId,
  }) {
    return UnassignCurator(
      parentBountyId: parentBountyId,
      childBountyId: childBountyId,
    );
  }

  AwardChildBounty awardChildBounty({
    required BigInt parentBountyId,
    required BigInt childBountyId,
    required _i3.MultiAddress beneficiary,
  }) {
    return AwardChildBounty(
      parentBountyId: parentBountyId,
      childBountyId: childBountyId,
      beneficiary: beneficiary,
    );
  }

  ClaimChildBounty claimChildBounty({
    required BigInt parentBountyId,
    required BigInt childBountyId,
  }) {
    return ClaimChildBounty(
      parentBountyId: parentBountyId,
      childBountyId: childBountyId,
    );
  }

  CloseChildBounty closeChildBounty({
    required BigInt parentBountyId,
    required BigInt childBountyId,
  }) {
    return CloseChildBounty(
      parentBountyId: parentBountyId,
      childBountyId: childBountyId,
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
        return AddChildBounty._decode(input);
      case 1:
        return ProposeCurator._decode(input);
      case 2:
        return AcceptCurator._decode(input);
      case 3:
        return UnassignCurator._decode(input);
      case 4:
        return AwardChildBounty._decode(input);
      case 5:
        return ClaimChildBounty._decode(input);
      case 6:
        return CloseChildBounty._decode(input);
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
      case AddChildBounty:
        (value as AddChildBounty).encodeTo(output);
        break;
      case ProposeCurator:
        (value as ProposeCurator).encodeTo(output);
        break;
      case AcceptCurator:
        (value as AcceptCurator).encodeTo(output);
        break;
      case UnassignCurator:
        (value as UnassignCurator).encodeTo(output);
        break;
      case AwardChildBounty:
        (value as AwardChildBounty).encodeTo(output);
        break;
      case ClaimChildBounty:
        (value as ClaimChildBounty).encodeTo(output);
        break;
      case CloseChildBounty:
        (value as CloseChildBounty).encodeTo(output);
        break;
      default:
        throw Exception(
            'Call: Unsupported "$value" of type "${value.runtimeType}"');
    }
  }

  @override
  int sizeHint(Call value) {
    switch (value.runtimeType) {
      case AddChildBounty:
        return (value as AddChildBounty)._sizeHint();
      case ProposeCurator:
        return (value as ProposeCurator)._sizeHint();
      case AcceptCurator:
        return (value as AcceptCurator)._sizeHint();
      case UnassignCurator:
        return (value as UnassignCurator)._sizeHint();
      case AwardChildBounty:
        return (value as AwardChildBounty)._sizeHint();
      case ClaimChildBounty:
        return (value as ClaimChildBounty)._sizeHint();
      case CloseChildBounty:
        return (value as CloseChildBounty)._sizeHint();
      default:
        throw Exception(
            'Call: Unsupported "$value" of type "${value.runtimeType}"');
    }
  }
}

/// Add a new child-bounty.
///
/// The dispatch origin for this call must be the curator of parent
/// bounty and the parent bounty must be in "active" state.
///
/// Child-bounty gets added successfully & fund gets transferred from
/// parent bounty to child-bounty account, if parent bounty has enough
/// funds, else the call fails.
///
/// Upper bound to maximum number of active  child bounties that can be
/// added are managed via runtime trait config
/// [`Config::MaxActiveChildBountyCount`].
///
/// If the call is success, the status of child-bounty is updated to
/// "Added".
///
/// - `parent_bounty_id`: Index of parent bounty for which child-bounty is being added.
/// - `value`: Value for executing the proposal.
/// - `description`: Text description for the child-bounty.
class AddChildBounty extends Call {
  const AddChildBounty({
    required this.parentBountyId,
    required this.value,
    required this.description,
  });

  factory AddChildBounty._decode(_i1.Input input) {
    return AddChildBounty(
      parentBountyId: _i1.CompactBigIntCodec.codec.decode(input),
      value: _i1.CompactBigIntCodec.codec.decode(input),
      description: _i1.U8SequenceCodec.codec.decode(input),
    );
  }

  /// BountyIndex
  final BigInt parentBountyId;

  /// BalanceOf<T>
  final BigInt value;

  /// Vec<u8>
  final List<int> description;

  @override
  Map<String, Map<String, dynamic>> toJson() => {
        'add_child_bounty': {
          'parentBountyId': parentBountyId,
          'value': value,
          'description': description,
        }
      };

  int _sizeHint() {
    int size = 1;
    size = size + _i1.CompactBigIntCodec.codec.sizeHint(parentBountyId);
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
      parentBountyId,
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
      other is AddChildBounty &&
          other.parentBountyId == parentBountyId &&
          other.value == value &&
          _i4.listsEqual(
            other.description,
            description,
          );

  @override
  int get hashCode => Object.hash(
        parentBountyId,
        value,
        description,
      );
}

/// Propose curator for funded child-bounty.
///
/// The dispatch origin for this call must be curator of parent bounty.
///
/// Parent bounty must be in active state, for this child-bounty call to
/// work.
///
/// Child-bounty must be in "Added" state, for processing the call. And
/// state of child-bounty is moved to "CuratorProposed" on successful
/// call completion.
///
/// - `parent_bounty_id`: Index of parent bounty.
/// - `child_bounty_id`: Index of child bounty.
/// - `curator`: Address of child-bounty curator.
/// - `fee`: payment fee to child-bounty curator for execution.
class ProposeCurator extends Call {
  const ProposeCurator({
    required this.parentBountyId,
    required this.childBountyId,
    required this.curator,
    required this.fee,
  });

  factory ProposeCurator._decode(_i1.Input input) {
    return ProposeCurator(
      parentBountyId: _i1.CompactBigIntCodec.codec.decode(input),
      childBountyId: _i1.CompactBigIntCodec.codec.decode(input),
      curator: _i3.MultiAddress.codec.decode(input),
      fee: _i1.CompactBigIntCodec.codec.decode(input),
    );
  }

  /// BountyIndex
  final BigInt parentBountyId;

  /// BountyIndex
  final BigInt childBountyId;

  /// AccountIdLookupOf<T>
  final _i3.MultiAddress curator;

  /// BalanceOf<T>
  final BigInt fee;

  @override
  Map<String, Map<String, dynamic>> toJson() => {
        'propose_curator': {
          'parentBountyId': parentBountyId,
          'childBountyId': childBountyId,
          'curator': curator.toJson(),
          'fee': fee,
        }
      };

  int _sizeHint() {
    int size = 1;
    size = size + _i1.CompactBigIntCodec.codec.sizeHint(parentBountyId);
    size = size + _i1.CompactBigIntCodec.codec.sizeHint(childBountyId);
    size = size + _i3.MultiAddress.codec.sizeHint(curator);
    size = size + _i1.CompactBigIntCodec.codec.sizeHint(fee);
    return size;
  }

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      1,
      output,
    );
    _i1.CompactBigIntCodec.codec.encodeTo(
      parentBountyId,
      output,
    );
    _i1.CompactBigIntCodec.codec.encodeTo(
      childBountyId,
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
          other.parentBountyId == parentBountyId &&
          other.childBountyId == childBountyId &&
          other.curator == curator &&
          other.fee == fee;

  @override
  int get hashCode => Object.hash(
        parentBountyId,
        childBountyId,
        curator,
        fee,
      );
}

/// Accept the curator role for the child-bounty.
///
/// The dispatch origin for this call must be the curator of this
/// child-bounty.
///
/// A deposit will be reserved from the curator and refund upon
/// successful payout or cancellation.
///
/// Fee for curator is deducted from curator fee of parent bounty.
///
/// Parent bounty must be in active state, for this child-bounty call to
/// work.
///
/// Child-bounty must be in "CuratorProposed" state, for processing the
/// call. And state of child-bounty is moved to "Active" on successful
/// call completion.
///
/// - `parent_bounty_id`: Index of parent bounty.
/// - `child_bounty_id`: Index of child bounty.
class AcceptCurator extends Call {
  const AcceptCurator({
    required this.parentBountyId,
    required this.childBountyId,
  });

  factory AcceptCurator._decode(_i1.Input input) {
    return AcceptCurator(
      parentBountyId: _i1.CompactBigIntCodec.codec.decode(input),
      childBountyId: _i1.CompactBigIntCodec.codec.decode(input),
    );
  }

  /// BountyIndex
  final BigInt parentBountyId;

  /// BountyIndex
  final BigInt childBountyId;

  @override
  Map<String, Map<String, BigInt>> toJson() => {
        'accept_curator': {
          'parentBountyId': parentBountyId,
          'childBountyId': childBountyId,
        }
      };

  int _sizeHint() {
    int size = 1;
    size = size + _i1.CompactBigIntCodec.codec.sizeHint(parentBountyId);
    size = size + _i1.CompactBigIntCodec.codec.sizeHint(childBountyId);
    return size;
  }

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      2,
      output,
    );
    _i1.CompactBigIntCodec.codec.encodeTo(
      parentBountyId,
      output,
    );
    _i1.CompactBigIntCodec.codec.encodeTo(
      childBountyId,
      output,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(
        this,
        other,
      ) ||
      other is AcceptCurator &&
          other.parentBountyId == parentBountyId &&
          other.childBountyId == childBountyId;

  @override
  int get hashCode => Object.hash(
        parentBountyId,
        childBountyId,
      );
}

/// Unassign curator from a child-bounty.
///
/// The dispatch origin for this call can be either `RejectOrigin`, or
/// the curator of the parent bounty, or any signed origin.
///
/// For the origin other than T::RejectOrigin and the child-bounty
/// curator, parent bounty must be in active state, for this call to
/// work. We allow child-bounty curator and T::RejectOrigin to execute
/// this call irrespective of the parent bounty state.
///
/// If this function is called by the `RejectOrigin` or the
/// parent bounty curator, we assume that the child-bounty curator is
/// malicious or inactive. As a result, child-bounty curator deposit is
/// slashed.
///
/// If the origin is the child-bounty curator, we take this as a sign
/// that they are unable to do their job, and are willingly giving up.
/// We could slash the deposit, but for now we allow them to unreserve
/// their deposit and exit without issue. (We may want to change this if
/// it is abused.)
///
/// Finally, the origin can be anyone iff the child-bounty curator is
/// "inactive". Expiry update due of parent bounty is used to estimate
/// inactive state of child-bounty curator.
///
/// This allows anyone in the community to call out that a child-bounty
/// curator is not doing their due diligence, and we should pick a new
/// one. In this case the child-bounty curator deposit is slashed.
///
/// State of child-bounty is moved to Added state on successful call
/// completion.
///
/// - `parent_bounty_id`: Index of parent bounty.
/// - `child_bounty_id`: Index of child bounty.
class UnassignCurator extends Call {
  const UnassignCurator({
    required this.parentBountyId,
    required this.childBountyId,
  });

  factory UnassignCurator._decode(_i1.Input input) {
    return UnassignCurator(
      parentBountyId: _i1.CompactBigIntCodec.codec.decode(input),
      childBountyId: _i1.CompactBigIntCodec.codec.decode(input),
    );
  }

  /// BountyIndex
  final BigInt parentBountyId;

  /// BountyIndex
  final BigInt childBountyId;

  @override
  Map<String, Map<String, BigInt>> toJson() => {
        'unassign_curator': {
          'parentBountyId': parentBountyId,
          'childBountyId': childBountyId,
        }
      };

  int _sizeHint() {
    int size = 1;
    size = size + _i1.CompactBigIntCodec.codec.sizeHint(parentBountyId);
    size = size + _i1.CompactBigIntCodec.codec.sizeHint(childBountyId);
    return size;
  }

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      3,
      output,
    );
    _i1.CompactBigIntCodec.codec.encodeTo(
      parentBountyId,
      output,
    );
    _i1.CompactBigIntCodec.codec.encodeTo(
      childBountyId,
      output,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(
        this,
        other,
      ) ||
      other is UnassignCurator &&
          other.parentBountyId == parentBountyId &&
          other.childBountyId == childBountyId;

  @override
  int get hashCode => Object.hash(
        parentBountyId,
        childBountyId,
      );
}

/// Award child-bounty to a beneficiary.
///
/// The beneficiary will be able to claim the funds after a delay.
///
/// The dispatch origin for this call must be the parent curator or
/// curator of this child-bounty.
///
/// Parent bounty must be in active state, for this child-bounty call to
/// work.
///
/// Child-bounty must be in active state, for processing the call. And
/// state of child-bounty is moved to "PendingPayout" on successful call
/// completion.
///
/// - `parent_bounty_id`: Index of parent bounty.
/// - `child_bounty_id`: Index of child bounty.
/// - `beneficiary`: Beneficiary account.
class AwardChildBounty extends Call {
  const AwardChildBounty({
    required this.parentBountyId,
    required this.childBountyId,
    required this.beneficiary,
  });

  factory AwardChildBounty._decode(_i1.Input input) {
    return AwardChildBounty(
      parentBountyId: _i1.CompactBigIntCodec.codec.decode(input),
      childBountyId: _i1.CompactBigIntCodec.codec.decode(input),
      beneficiary: _i3.MultiAddress.codec.decode(input),
    );
  }

  /// BountyIndex
  final BigInt parentBountyId;

  /// BountyIndex
  final BigInt childBountyId;

  /// AccountIdLookupOf<T>
  final _i3.MultiAddress beneficiary;

  @override
  Map<String, Map<String, dynamic>> toJson() => {
        'award_child_bounty': {
          'parentBountyId': parentBountyId,
          'childBountyId': childBountyId,
          'beneficiary': beneficiary.toJson(),
        }
      };

  int _sizeHint() {
    int size = 1;
    size = size + _i1.CompactBigIntCodec.codec.sizeHint(parentBountyId);
    size = size + _i1.CompactBigIntCodec.codec.sizeHint(childBountyId);
    size = size + _i3.MultiAddress.codec.sizeHint(beneficiary);
    return size;
  }

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      4,
      output,
    );
    _i1.CompactBigIntCodec.codec.encodeTo(
      parentBountyId,
      output,
    );
    _i1.CompactBigIntCodec.codec.encodeTo(
      childBountyId,
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
      other is AwardChildBounty &&
          other.parentBountyId == parentBountyId &&
          other.childBountyId == childBountyId &&
          other.beneficiary == beneficiary;

  @override
  int get hashCode => Object.hash(
        parentBountyId,
        childBountyId,
        beneficiary,
      );
}

/// Claim the payout from an awarded child-bounty after payout delay.
///
/// The dispatch origin for this call may be any signed origin.
///
/// Call works independent of parent bounty state, No need for parent
/// bounty to be in active state.
///
/// The Beneficiary is paid out with agreed bounty value. Curator fee is
/// paid & curator deposit is unreserved.
///
/// Child-bounty must be in "PendingPayout" state, for processing the
/// call. And instance of child-bounty is removed from the state on
/// successful call completion.
///
/// - `parent_bounty_id`: Index of parent bounty.
/// - `child_bounty_id`: Index of child bounty.
class ClaimChildBounty extends Call {
  const ClaimChildBounty({
    required this.parentBountyId,
    required this.childBountyId,
  });

  factory ClaimChildBounty._decode(_i1.Input input) {
    return ClaimChildBounty(
      parentBountyId: _i1.CompactBigIntCodec.codec.decode(input),
      childBountyId: _i1.CompactBigIntCodec.codec.decode(input),
    );
  }

  /// BountyIndex
  final BigInt parentBountyId;

  /// BountyIndex
  final BigInt childBountyId;

  @override
  Map<String, Map<String, BigInt>> toJson() => {
        'claim_child_bounty': {
          'parentBountyId': parentBountyId,
          'childBountyId': childBountyId,
        }
      };

  int _sizeHint() {
    int size = 1;
    size = size + _i1.CompactBigIntCodec.codec.sizeHint(parentBountyId);
    size = size + _i1.CompactBigIntCodec.codec.sizeHint(childBountyId);
    return size;
  }

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      5,
      output,
    );
    _i1.CompactBigIntCodec.codec.encodeTo(
      parentBountyId,
      output,
    );
    _i1.CompactBigIntCodec.codec.encodeTo(
      childBountyId,
      output,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(
        this,
        other,
      ) ||
      other is ClaimChildBounty &&
          other.parentBountyId == parentBountyId &&
          other.childBountyId == childBountyId;

  @override
  int get hashCode => Object.hash(
        parentBountyId,
        childBountyId,
      );
}

/// Cancel a proposed or active child-bounty. Child-bounty account funds
/// are transferred to parent bounty account. The child-bounty curator
/// deposit may be unreserved if possible.
///
/// The dispatch origin for this call must be either parent curator or
/// `T::RejectOrigin`.
///
/// If the state of child-bounty is `Active`, curator deposit is
/// unreserved.
///
/// If the state of child-bounty is `PendingPayout`, call fails &
/// returns `PendingPayout` error.
///
/// For the origin other than T::RejectOrigin, parent bounty must be in
/// active state, for this child-bounty call to work. For origin
/// T::RejectOrigin execution is forced.
///
/// Instance of child-bounty is removed from the state on successful
/// call completion.
///
/// - `parent_bounty_id`: Index of parent bounty.
/// - `child_bounty_id`: Index of child bounty.
class CloseChildBounty extends Call {
  const CloseChildBounty({
    required this.parentBountyId,
    required this.childBountyId,
  });

  factory CloseChildBounty._decode(_i1.Input input) {
    return CloseChildBounty(
      parentBountyId: _i1.CompactBigIntCodec.codec.decode(input),
      childBountyId: _i1.CompactBigIntCodec.codec.decode(input),
    );
  }

  /// BountyIndex
  final BigInt parentBountyId;

  /// BountyIndex
  final BigInt childBountyId;

  @override
  Map<String, Map<String, BigInt>> toJson() => {
        'close_child_bounty': {
          'parentBountyId': parentBountyId,
          'childBountyId': childBountyId,
        }
      };

  int _sizeHint() {
    int size = 1;
    size = size + _i1.CompactBigIntCodec.codec.sizeHint(parentBountyId);
    size = size + _i1.CompactBigIntCodec.codec.sizeHint(childBountyId);
    return size;
  }

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      6,
      output,
    );
    _i1.CompactBigIntCodec.codec.encodeTo(
      parentBountyId,
      output,
    );
    _i1.CompactBigIntCodec.codec.encodeTo(
      childBountyId,
      output,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(
        this,
        other,
      ) ||
      other is CloseChildBounty &&
          other.parentBountyId == parentBountyId &&
          other.childBountyId == childBountyId;

  @override
  int get hashCode => Object.hash(
        parentBountyId,
        childBountyId,
      );
}
