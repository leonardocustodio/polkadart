// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:typed_data' as _i2;

import 'package:polkadart/scale_codec.dart' as _i1;

import '../../frame_support/traits/preimages/bounded.dart' as _i4;
import '../../frame_support/traits/schedule/dispatch_time.dart' as _i5;
import '../../polkadot_runtime/origin_caller.dart' as _i3;
import '../../primitive_types/h256.dart' as _i6;

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

  Submit submit({
    required _i3.OriginCaller proposalOrigin,
    required _i4.Bounded proposal,
    required _i5.DispatchTime enactmentMoment,
  }) {
    return Submit(
      proposalOrigin: proposalOrigin,
      proposal: proposal,
      enactmentMoment: enactmentMoment,
    );
  }

  PlaceDecisionDeposit placeDecisionDeposit({required int index}) {
    return PlaceDecisionDeposit(index: index);
  }

  RefundDecisionDeposit refundDecisionDeposit({required int index}) {
    return RefundDecisionDeposit(index: index);
  }

  Cancel cancel({required int index}) {
    return Cancel(index: index);
  }

  Kill kill({required int index}) {
    return Kill(index: index);
  }

  NudgeReferendum nudgeReferendum({required int index}) {
    return NudgeReferendum(index: index);
  }

  OneFewerDeciding oneFewerDeciding({required int track}) {
    return OneFewerDeciding(track: track);
  }

  RefundSubmissionDeposit refundSubmissionDeposit({required int index}) {
    return RefundSubmissionDeposit(index: index);
  }

  SetMetadata setMetadata({
    required int index,
    _i6.H256? maybeHash,
  }) {
    return SetMetadata(
      index: index,
      maybeHash: maybeHash,
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
        return Submit._decode(input);
      case 1:
        return PlaceDecisionDeposit._decode(input);
      case 2:
        return RefundDecisionDeposit._decode(input);
      case 3:
        return Cancel._decode(input);
      case 4:
        return Kill._decode(input);
      case 5:
        return NudgeReferendum._decode(input);
      case 6:
        return OneFewerDeciding._decode(input);
      case 7:
        return RefundSubmissionDeposit._decode(input);
      case 8:
        return SetMetadata._decode(input);
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
      case Submit:
        (value as Submit).encodeTo(output);
        break;
      case PlaceDecisionDeposit:
        (value as PlaceDecisionDeposit).encodeTo(output);
        break;
      case RefundDecisionDeposit:
        (value as RefundDecisionDeposit).encodeTo(output);
        break;
      case Cancel:
        (value as Cancel).encodeTo(output);
        break;
      case Kill:
        (value as Kill).encodeTo(output);
        break;
      case NudgeReferendum:
        (value as NudgeReferendum).encodeTo(output);
        break;
      case OneFewerDeciding:
        (value as OneFewerDeciding).encodeTo(output);
        break;
      case RefundSubmissionDeposit:
        (value as RefundSubmissionDeposit).encodeTo(output);
        break;
      case SetMetadata:
        (value as SetMetadata).encodeTo(output);
        break;
      default:
        throw Exception(
            'Call: Unsupported "$value" of type "${value.runtimeType}"');
    }
  }

  @override
  int sizeHint(Call value) {
    switch (value.runtimeType) {
      case Submit:
        return (value as Submit)._sizeHint();
      case PlaceDecisionDeposit:
        return (value as PlaceDecisionDeposit)._sizeHint();
      case RefundDecisionDeposit:
        return (value as RefundDecisionDeposit)._sizeHint();
      case Cancel:
        return (value as Cancel)._sizeHint();
      case Kill:
        return (value as Kill)._sizeHint();
      case NudgeReferendum:
        return (value as NudgeReferendum)._sizeHint();
      case OneFewerDeciding:
        return (value as OneFewerDeciding)._sizeHint();
      case RefundSubmissionDeposit:
        return (value as RefundSubmissionDeposit)._sizeHint();
      case SetMetadata:
        return (value as SetMetadata)._sizeHint();
      default:
        throw Exception(
            'Call: Unsupported "$value" of type "${value.runtimeType}"');
    }
  }
}

/// Propose a referendum on a privileged action.
///
/// - `origin`: must be `SubmitOrigin` and the account must have `SubmissionDeposit` funds
///  available.
/// - `proposal_origin`: The origin from which the proposal should be executed.
/// - `proposal`: The proposal.
/// - `enactment_moment`: The moment that the proposal should be enacted.
///
/// Emits `Submitted`.
class Submit extends Call {
  const Submit({
    required this.proposalOrigin,
    required this.proposal,
    required this.enactmentMoment,
  });

  factory Submit._decode(_i1.Input input) {
    return Submit(
      proposalOrigin: _i3.OriginCaller.codec.decode(input),
      proposal: _i4.Bounded.codec.decode(input),
      enactmentMoment: _i5.DispatchTime.codec.decode(input),
    );
  }

  /// Box<PalletsOriginOf<T>>
  final _i3.OriginCaller proposalOrigin;

  /// BoundedCallOf<T, I>
  final _i4.Bounded proposal;

  /// DispatchTime<T::BlockNumber>
  final _i5.DispatchTime enactmentMoment;

  @override
  Map<String, Map<String, Map<String, dynamic>>> toJson() => {
        'submit': {
          'proposalOrigin': proposalOrigin.toJson(),
          'proposal': proposal.toJson(),
          'enactmentMoment': enactmentMoment.toJson(),
        }
      };

  int _sizeHint() {
    int size = 1;
    size = size + _i3.OriginCaller.codec.sizeHint(proposalOrigin);
    size = size + _i4.Bounded.codec.sizeHint(proposal);
    size = size + _i5.DispatchTime.codec.sizeHint(enactmentMoment);
    return size;
  }

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      0,
      output,
    );
    _i3.OriginCaller.codec.encodeTo(
      proposalOrigin,
      output,
    );
    _i4.Bounded.codec.encodeTo(
      proposal,
      output,
    );
    _i5.DispatchTime.codec.encodeTo(
      enactmentMoment,
      output,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(
        this,
        other,
      ) ||
      other is Submit &&
          other.proposalOrigin == proposalOrigin &&
          other.proposal == proposal &&
          other.enactmentMoment == enactmentMoment;

  @override
  int get hashCode => Object.hash(
        proposalOrigin,
        proposal,
        enactmentMoment,
      );
}

/// Post the Decision Deposit for a referendum.
///
/// - `origin`: must be `Signed` and the account must have funds available for the
///  referendum's track's Decision Deposit.
/// - `index`: The index of the submitted referendum whose Decision Deposit is yet to be
///  posted.
///
/// Emits `DecisionDepositPlaced`.
class PlaceDecisionDeposit extends Call {
  const PlaceDecisionDeposit({required this.index});

  factory PlaceDecisionDeposit._decode(_i1.Input input) {
    return PlaceDecisionDeposit(index: _i1.U32Codec.codec.decode(input));
  }

  /// ReferendumIndex
  final int index;

  @override
  Map<String, Map<String, int>> toJson() => {
        'place_decision_deposit': {'index': index}
      };

  int _sizeHint() {
    int size = 1;
    size = size + _i1.U32Codec.codec.sizeHint(index);
    return size;
  }

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      1,
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
      other is PlaceDecisionDeposit && other.index == index;

  @override
  int get hashCode => index.hashCode;
}

/// Refund the Decision Deposit for a closed referendum back to the depositor.
///
/// - `origin`: must be `Signed` or `Root`.
/// - `index`: The index of a closed referendum whose Decision Deposit has not yet been
///  refunded.
///
/// Emits `DecisionDepositRefunded`.
class RefundDecisionDeposit extends Call {
  const RefundDecisionDeposit({required this.index});

  factory RefundDecisionDeposit._decode(_i1.Input input) {
    return RefundDecisionDeposit(index: _i1.U32Codec.codec.decode(input));
  }

  /// ReferendumIndex
  final int index;

  @override
  Map<String, Map<String, int>> toJson() => {
        'refund_decision_deposit': {'index': index}
      };

  int _sizeHint() {
    int size = 1;
    size = size + _i1.U32Codec.codec.sizeHint(index);
    return size;
  }

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      2,
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
      other is RefundDecisionDeposit && other.index == index;

  @override
  int get hashCode => index.hashCode;
}

/// Cancel an ongoing referendum.
///
/// - `origin`: must be the `CancelOrigin`.
/// - `index`: The index of the referendum to be cancelled.
///
/// Emits `Cancelled`.
class Cancel extends Call {
  const Cancel({required this.index});

  factory Cancel._decode(_i1.Input input) {
    return Cancel(index: _i1.U32Codec.codec.decode(input));
  }

  /// ReferendumIndex
  final int index;

  @override
  Map<String, Map<String, int>> toJson() => {
        'cancel': {'index': index}
      };

  int _sizeHint() {
    int size = 1;
    size = size + _i1.U32Codec.codec.sizeHint(index);
    return size;
  }

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      3,
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
      other is Cancel && other.index == index;

  @override
  int get hashCode => index.hashCode;
}

/// Cancel an ongoing referendum and slash the deposits.
///
/// - `origin`: must be the `KillOrigin`.
/// - `index`: The index of the referendum to be cancelled.
///
/// Emits `Killed` and `DepositSlashed`.
class Kill extends Call {
  const Kill({required this.index});

  factory Kill._decode(_i1.Input input) {
    return Kill(index: _i1.U32Codec.codec.decode(input));
  }

  /// ReferendumIndex
  final int index;

  @override
  Map<String, Map<String, int>> toJson() => {
        'kill': {'index': index}
      };

  int _sizeHint() {
    int size = 1;
    size = size + _i1.U32Codec.codec.sizeHint(index);
    return size;
  }

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      4,
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
      other is Kill && other.index == index;

  @override
  int get hashCode => index.hashCode;
}

/// Advance a referendum onto its next logical state. Only used internally.
///
/// - `origin`: must be `Root`.
/// - `index`: the referendum to be advanced.
class NudgeReferendum extends Call {
  const NudgeReferendum({required this.index});

  factory NudgeReferendum._decode(_i1.Input input) {
    return NudgeReferendum(index: _i1.U32Codec.codec.decode(input));
  }

  /// ReferendumIndex
  final int index;

  @override
  Map<String, Map<String, int>> toJson() => {
        'nudge_referendum': {'index': index}
      };

  int _sizeHint() {
    int size = 1;
    size = size + _i1.U32Codec.codec.sizeHint(index);
    return size;
  }

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      5,
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
      other is NudgeReferendum && other.index == index;

  @override
  int get hashCode => index.hashCode;
}

/// Advance a track onto its next logical state. Only used internally.
///
/// - `origin`: must be `Root`.
/// - `track`: the track to be advanced.
///
/// Action item for when there is now one fewer referendum in the deciding phase and the
/// `DecidingCount` is not yet updated. This means that we should either:
/// - begin deciding another referendum (and leave `DecidingCount` alone); or
/// - decrement `DecidingCount`.
class OneFewerDeciding extends Call {
  const OneFewerDeciding({required this.track});

  factory OneFewerDeciding._decode(_i1.Input input) {
    return OneFewerDeciding(track: _i1.U16Codec.codec.decode(input));
  }

  /// TrackIdOf<T, I>
  final int track;

  @override
  Map<String, Map<String, int>> toJson() => {
        'one_fewer_deciding': {'track': track}
      };

  int _sizeHint() {
    int size = 1;
    size = size + _i1.U16Codec.codec.sizeHint(track);
    return size;
  }

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      6,
      output,
    );
    _i1.U16Codec.codec.encodeTo(
      track,
      output,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(
        this,
        other,
      ) ||
      other is OneFewerDeciding && other.track == track;

  @override
  int get hashCode => track.hashCode;
}

/// Refund the Submission Deposit for a closed referendum back to the depositor.
///
/// - `origin`: must be `Signed` or `Root`.
/// - `index`: The index of a closed referendum whose Submission Deposit has not yet been
///  refunded.
///
/// Emits `SubmissionDepositRefunded`.
class RefundSubmissionDeposit extends Call {
  const RefundSubmissionDeposit({required this.index});

  factory RefundSubmissionDeposit._decode(_i1.Input input) {
    return RefundSubmissionDeposit(index: _i1.U32Codec.codec.decode(input));
  }

  /// ReferendumIndex
  final int index;

  @override
  Map<String, Map<String, int>> toJson() => {
        'refund_submission_deposit': {'index': index}
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
      other is RefundSubmissionDeposit && other.index == index;

  @override
  int get hashCode => index.hashCode;
}

/// Set or clear metadata of a referendum.
///
/// Parameters:
/// - `origin`: Must be `Signed` by a creator of a referendum or by anyone to clear a
///  metadata of a finished referendum.
/// - `index`:  The index of a referendum to set or clear metadata for.
/// - `maybe_hash`: The hash of an on-chain stored preimage. `None` to clear a metadata.
class SetMetadata extends Call {
  const SetMetadata({
    required this.index,
    this.maybeHash,
  });

  factory SetMetadata._decode(_i1.Input input) {
    return SetMetadata(
      index: _i1.U32Codec.codec.decode(input),
      maybeHash: const _i1.OptionCodec<_i6.H256>(_i6.H256Codec()).decode(input),
    );
  }

  /// ReferendumIndex
  final int index;

  /// Option<PreimageHash>
  final _i6.H256? maybeHash;

  @override
  Map<String, Map<String, dynamic>> toJson() => {
        'set_metadata': {
          'index': index,
          'maybeHash': maybeHash?.toList(),
        }
      };

  int _sizeHint() {
    int size = 1;
    size = size + _i1.U32Codec.codec.sizeHint(index);
    size = size +
        const _i1.OptionCodec<_i6.H256>(_i6.H256Codec()).sizeHint(maybeHash);
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
    const _i1.OptionCodec<_i6.H256>(_i6.H256Codec()).encodeTo(
      maybeHash,
      output,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(
        this,
        other,
      ) ||
      other is SetMetadata &&
          other.index == index &&
          other.maybeHash == maybeHash;

  @override
  int get hashCode => Object.hash(
        index,
        maybeHash,
      );
}
