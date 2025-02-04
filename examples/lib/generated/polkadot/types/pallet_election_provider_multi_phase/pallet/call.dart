// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:typed_data' as _i2;

import 'package:polkadart/scale_codec.dart' as _i1;
import 'package:quiver/collection.dart' as _i9;

import '../../sp_core/crypto/account_id32.dart' as _i7;
import '../../sp_npos_elections/election_score.dart' as _i5;
import '../../sp_npos_elections/support.dart' as _i8;
import '../../tuples.dart' as _i6;
import '../raw_solution.dart' as _i3;
import '../solution_or_snapshot_size.dart' as _i4;

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

  SubmitUnsigned submitUnsigned({
    required _i3.RawSolution rawSolution,
    required _i4.SolutionOrSnapshotSize witness,
  }) {
    return SubmitUnsigned(
      rawSolution: rawSolution,
      witness: witness,
    );
  }

  SetMinimumUntrustedScore setMinimumUntrustedScore(
      {_i5.ElectionScore? maybeNextScore}) {
    return SetMinimumUntrustedScore(maybeNextScore: maybeNextScore);
  }

  SetEmergencyElectionResult setEmergencyElectionResult(
      {required List<_i6.Tuple2<_i7.AccountId32, _i8.Support>> supports}) {
    return SetEmergencyElectionResult(supports: supports);
  }

  Submit submit({required _i3.RawSolution rawSolution}) {
    return Submit(rawSolution: rawSolution);
  }

  GovernanceFallback governanceFallback({
    int? maybeMaxVoters,
    int? maybeMaxTargets,
  }) {
    return GovernanceFallback(
      maybeMaxVoters: maybeMaxVoters,
      maybeMaxTargets: maybeMaxTargets,
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
        return SubmitUnsigned._decode(input);
      case 1:
        return SetMinimumUntrustedScore._decode(input);
      case 2:
        return SetEmergencyElectionResult._decode(input);
      case 3:
        return Submit._decode(input);
      case 4:
        return GovernanceFallback._decode(input);
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
      case SubmitUnsigned:
        (value as SubmitUnsigned).encodeTo(output);
        break;
      case SetMinimumUntrustedScore:
        (value as SetMinimumUntrustedScore).encodeTo(output);
        break;
      case SetEmergencyElectionResult:
        (value as SetEmergencyElectionResult).encodeTo(output);
        break;
      case Submit:
        (value as Submit).encodeTo(output);
        break;
      case GovernanceFallback:
        (value as GovernanceFallback).encodeTo(output);
        break;
      default:
        throw Exception(
            'Call: Unsupported "$value" of type "${value.runtimeType}"');
    }
  }

  @override
  int sizeHint(Call value) {
    switch (value.runtimeType) {
      case SubmitUnsigned:
        return (value as SubmitUnsigned)._sizeHint();
      case SetMinimumUntrustedScore:
        return (value as SetMinimumUntrustedScore)._sizeHint();
      case SetEmergencyElectionResult:
        return (value as SetEmergencyElectionResult)._sizeHint();
      case Submit:
        return (value as Submit)._sizeHint();
      case GovernanceFallback:
        return (value as GovernanceFallback)._sizeHint();
      default:
        throw Exception(
            'Call: Unsupported "$value" of type "${value.runtimeType}"');
    }
  }
}

/// Submit a solution for the unsigned phase.
///
/// The dispatch origin fo this call must be __none__.
///
/// This submission is checked on the fly. Moreover, this unsigned solution is only
/// validated when submitted to the pool from the **local** node. Effectively, this means
/// that only active validators can submit this transaction when authoring a block (similar
/// to an inherent).
///
/// To prevent any incorrect solution (and thus wasted time/weight), this transaction will
/// panic if the solution submitted by the validator is invalid in any way, effectively
/// putting their authoring reward at risk.
///
/// No deposit or reward is associated with this submission.
class SubmitUnsigned extends Call {
  const SubmitUnsigned({
    required this.rawSolution,
    required this.witness,
  });

  factory SubmitUnsigned._decode(_i1.Input input) {
    return SubmitUnsigned(
      rawSolution: _i3.RawSolution.codec.decode(input),
      witness: _i4.SolutionOrSnapshotSize.codec.decode(input),
    );
  }

  /// Box<RawSolution<SolutionOf<T::MinerConfig>>>
  final _i3.RawSolution rawSolution;

  /// SolutionOrSnapshotSize
  final _i4.SolutionOrSnapshotSize witness;

  @override
  Map<String, Map<String, Map<String, dynamic>>> toJson() => {
        'submit_unsigned': {
          'rawSolution': rawSolution.toJson(),
          'witness': witness.toJson(),
        }
      };

  int _sizeHint() {
    int size = 1;
    size = size + _i3.RawSolution.codec.sizeHint(rawSolution);
    size = size + _i4.SolutionOrSnapshotSize.codec.sizeHint(witness);
    return size;
  }

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      0,
      output,
    );
    _i3.RawSolution.codec.encodeTo(
      rawSolution,
      output,
    );
    _i4.SolutionOrSnapshotSize.codec.encodeTo(
      witness,
      output,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(
        this,
        other,
      ) ||
      other is SubmitUnsigned &&
          other.rawSolution == rawSolution &&
          other.witness == witness;

  @override
  int get hashCode => Object.hash(
        rawSolution,
        witness,
      );
}

/// Set a new value for `MinimumUntrustedScore`.
///
/// Dispatch origin must be aligned with `T::ForceOrigin`.
///
/// This check can be turned off by setting the value to `None`.
class SetMinimumUntrustedScore extends Call {
  const SetMinimumUntrustedScore({this.maybeNextScore});

  factory SetMinimumUntrustedScore._decode(_i1.Input input) {
    return SetMinimumUntrustedScore(
        maybeNextScore:
            const _i1.OptionCodec<_i5.ElectionScore>(_i5.ElectionScore.codec)
                .decode(input));
  }

  /// Option<ElectionScore>
  final _i5.ElectionScore? maybeNextScore;

  @override
  Map<String, Map<String, Map<String, BigInt>?>> toJson() => {
        'set_minimum_untrusted_score': {
          'maybeNextScore': maybeNextScore?.toJson()
        }
      };

  int _sizeHint() {
    int size = 1;
    size = size +
        const _i1.OptionCodec<_i5.ElectionScore>(_i5.ElectionScore.codec)
            .sizeHint(maybeNextScore);
    return size;
  }

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      1,
      output,
    );
    const _i1.OptionCodec<_i5.ElectionScore>(_i5.ElectionScore.codec).encodeTo(
      maybeNextScore,
      output,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(
        this,
        other,
      ) ||
      other is SetMinimumUntrustedScore &&
          other.maybeNextScore == maybeNextScore;

  @override
  int get hashCode => maybeNextScore.hashCode;
}

/// Set a solution in the queue, to be handed out to the client of this pallet in the next
/// call to `ElectionProvider::elect`.
///
/// This can only be set by `T::ForceOrigin`, and only when the phase is `Emergency`.
///
/// The solution is not checked for any feasibility and is assumed to be trustworthy, as any
/// feasibility check itself can in principle cause the election process to fail (due to
/// memory/weight constrains).
class SetEmergencyElectionResult extends Call {
  const SetEmergencyElectionResult({required this.supports});

  factory SetEmergencyElectionResult._decode(_i1.Input input) {
    return SetEmergencyElectionResult(
        supports:
            const _i1.SequenceCodec<_i6.Tuple2<_i7.AccountId32, _i8.Support>>(
                _i6.Tuple2Codec<_i7.AccountId32, _i8.Support>(
      _i7.AccountId32Codec(),
      _i8.Support.codec,
    )).decode(input));
  }

  /// Supports<T::AccountId>
  final List<_i6.Tuple2<_i7.AccountId32, _i8.Support>> supports;

  @override
  Map<String, Map<String, List<List<dynamic>>>> toJson() => {
        'set_emergency_election_result': {
          'supports': supports
              .map((value) => [
                    value.value0.toList(),
                    value.value1.toJson(),
                  ])
              .toList()
        }
      };

  int _sizeHint() {
    int size = 1;
    size = size +
        const _i1.SequenceCodec<_i6.Tuple2<_i7.AccountId32, _i8.Support>>(
            _i6.Tuple2Codec<_i7.AccountId32, _i8.Support>(
          _i7.AccountId32Codec(),
          _i8.Support.codec,
        )).sizeHint(supports);
    return size;
  }

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      2,
      output,
    );
    const _i1.SequenceCodec<_i6.Tuple2<_i7.AccountId32, _i8.Support>>(
        _i6.Tuple2Codec<_i7.AccountId32, _i8.Support>(
      _i7.AccountId32Codec(),
      _i8.Support.codec,
    )).encodeTo(
      supports,
      output,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(
        this,
        other,
      ) ||
      other is SetEmergencyElectionResult &&
          _i9.listsEqual(
            other.supports,
            supports,
          );

  @override
  int get hashCode => supports.hashCode;
}

/// Submit a solution for the signed phase.
///
/// The dispatch origin fo this call must be __signed__.
///
/// The solution is potentially queued, based on the claimed score and processed at the end
/// of the signed phase.
///
/// A deposit is reserved and recorded for the solution. Based on the outcome, the solution
/// might be rewarded, slashed, or get all or a part of the deposit back.
class Submit extends Call {
  const Submit({required this.rawSolution});

  factory Submit._decode(_i1.Input input) {
    return Submit(rawSolution: _i3.RawSolution.codec.decode(input));
  }

  /// Box<RawSolution<SolutionOf<T::MinerConfig>>>
  final _i3.RawSolution rawSolution;

  @override
  Map<String, Map<String, Map<String, dynamic>>> toJson() => {
        'submit': {'rawSolution': rawSolution.toJson()}
      };

  int _sizeHint() {
    int size = 1;
    size = size + _i3.RawSolution.codec.sizeHint(rawSolution);
    return size;
  }

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      3,
      output,
    );
    _i3.RawSolution.codec.encodeTo(
      rawSolution,
      output,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(
        this,
        other,
      ) ||
      other is Submit && other.rawSolution == rawSolution;

  @override
  int get hashCode => rawSolution.hashCode;
}

/// Trigger the governance fallback.
///
/// This can only be called when [`Phase::Emergency`] is enabled, as an alternative to
/// calling [`Call::set_emergency_election_result`].
class GovernanceFallback extends Call {
  const GovernanceFallback({
    this.maybeMaxVoters,
    this.maybeMaxTargets,
  });

  factory GovernanceFallback._decode(_i1.Input input) {
    return GovernanceFallback(
      maybeMaxVoters:
          const _i1.OptionCodec<int>(_i1.U32Codec.codec).decode(input),
      maybeMaxTargets:
          const _i1.OptionCodec<int>(_i1.U32Codec.codec).decode(input),
    );
  }

  /// Option<u32>
  final int? maybeMaxVoters;

  /// Option<u32>
  final int? maybeMaxTargets;

  @override
  Map<String, Map<String, int?>> toJson() => {
        'governance_fallback': {
          'maybeMaxVoters': maybeMaxVoters,
          'maybeMaxTargets': maybeMaxTargets,
        }
      };

  int _sizeHint() {
    int size = 1;
    size = size +
        const _i1.OptionCodec<int>(_i1.U32Codec.codec).sizeHint(maybeMaxVoters);
    size = size +
        const _i1.OptionCodec<int>(_i1.U32Codec.codec)
            .sizeHint(maybeMaxTargets);
    return size;
  }

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      4,
      output,
    );
    const _i1.OptionCodec<int>(_i1.U32Codec.codec).encodeTo(
      maybeMaxVoters,
      output,
    );
    const _i1.OptionCodec<int>(_i1.U32Codec.codec).encodeTo(
      maybeMaxTargets,
      output,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(
        this,
        other,
      ) ||
      other is GovernanceFallback &&
          other.maybeMaxVoters == maybeMaxVoters &&
          other.maybeMaxTargets == maybeMaxTargets;

  @override
  int get hashCode => Object.hash(
        maybeMaxVoters,
        maybeMaxTargets,
      );
}
