// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:typed_data' as _i2;

import 'package:polkadart/scale_codec.dart' as _i1;

import '../../sp_consensus_grandpa/equivocation_proof.dart' as _i3;
import '../../sp_session/membership_proof.dart' as _i4;

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

  ReportEquivocation reportEquivocation({
    required _i3.EquivocationProof equivocationProof,
    required _i4.MembershipProof keyOwnerProof,
  }) {
    return ReportEquivocation(
      equivocationProof: equivocationProof,
      keyOwnerProof: keyOwnerProof,
    );
  }

  ReportEquivocationUnsigned reportEquivocationUnsigned({
    required _i3.EquivocationProof equivocationProof,
    required _i4.MembershipProof keyOwnerProof,
  }) {
    return ReportEquivocationUnsigned(
      equivocationProof: equivocationProof,
      keyOwnerProof: keyOwnerProof,
    );
  }

  NoteStalled noteStalled({
    required int delay,
    required int bestFinalizedBlockNumber,
  }) {
    return NoteStalled(
      delay: delay,
      bestFinalizedBlockNumber: bestFinalizedBlockNumber,
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
        return ReportEquivocation._decode(input);
      case 1:
        return ReportEquivocationUnsigned._decode(input);
      case 2:
        return NoteStalled._decode(input);
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
      case ReportEquivocation:
        (value as ReportEquivocation).encodeTo(output);
        break;
      case ReportEquivocationUnsigned:
        (value as ReportEquivocationUnsigned).encodeTo(output);
        break;
      case NoteStalled:
        (value as NoteStalled).encodeTo(output);
        break;
      default:
        throw Exception(
            'Call: Unsupported "$value" of type "${value.runtimeType}"');
    }
  }

  @override
  int sizeHint(Call value) {
    switch (value.runtimeType) {
      case ReportEquivocation:
        return (value as ReportEquivocation)._sizeHint();
      case ReportEquivocationUnsigned:
        return (value as ReportEquivocationUnsigned)._sizeHint();
      case NoteStalled:
        return (value as NoteStalled)._sizeHint();
      default:
        throw Exception(
            'Call: Unsupported "$value" of type "${value.runtimeType}"');
    }
  }
}

/// Report voter equivocation/misbehavior. This method will verify the
/// equivocation proof and validate the given key ownership proof
/// against the extracted offender. If both are valid, the offence
/// will be reported.
class ReportEquivocation extends Call {
  const ReportEquivocation({
    required this.equivocationProof,
    required this.keyOwnerProof,
  });

  factory ReportEquivocation._decode(_i1.Input input) {
    return ReportEquivocation(
      equivocationProof: _i3.EquivocationProof.codec.decode(input),
      keyOwnerProof: _i4.MembershipProof.codec.decode(input),
    );
  }

  /// Box<EquivocationProof<T::Hash, BlockNumberFor<T>>>
  final _i3.EquivocationProof equivocationProof;

  /// T::KeyOwnerProof
  final _i4.MembershipProof keyOwnerProof;

  @override
  Map<String, Map<String, Map<String, dynamic>>> toJson() => {
        'report_equivocation': {
          'equivocationProof': equivocationProof.toJson(),
          'keyOwnerProof': keyOwnerProof.toJson(),
        }
      };

  int _sizeHint() {
    int size = 1;
    size = size + _i3.EquivocationProof.codec.sizeHint(equivocationProof);
    size = size + _i4.MembershipProof.codec.sizeHint(keyOwnerProof);
    return size;
  }

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      0,
      output,
    );
    _i3.EquivocationProof.codec.encodeTo(
      equivocationProof,
      output,
    );
    _i4.MembershipProof.codec.encodeTo(
      keyOwnerProof,
      output,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(
        this,
        other,
      ) ||
      other is ReportEquivocation &&
          other.equivocationProof == equivocationProof &&
          other.keyOwnerProof == keyOwnerProof;

  @override
  int get hashCode => Object.hash(
        equivocationProof,
        keyOwnerProof,
      );
}

/// Report voter equivocation/misbehavior. This method will verify the
/// equivocation proof and validate the given key ownership proof
/// against the extracted offender. If both are valid, the offence
/// will be reported.
///
/// This extrinsic must be called unsigned and it is expected that only
/// block authors will call it (validated in `ValidateUnsigned`), as such
/// if the block author is defined it will be defined as the equivocation
/// reporter.
class ReportEquivocationUnsigned extends Call {
  const ReportEquivocationUnsigned({
    required this.equivocationProof,
    required this.keyOwnerProof,
  });

  factory ReportEquivocationUnsigned._decode(_i1.Input input) {
    return ReportEquivocationUnsigned(
      equivocationProof: _i3.EquivocationProof.codec.decode(input),
      keyOwnerProof: _i4.MembershipProof.codec.decode(input),
    );
  }

  /// Box<EquivocationProof<T::Hash, BlockNumberFor<T>>>
  final _i3.EquivocationProof equivocationProof;

  /// T::KeyOwnerProof
  final _i4.MembershipProof keyOwnerProof;

  @override
  Map<String, Map<String, Map<String, dynamic>>> toJson() => {
        'report_equivocation_unsigned': {
          'equivocationProof': equivocationProof.toJson(),
          'keyOwnerProof': keyOwnerProof.toJson(),
        }
      };

  int _sizeHint() {
    int size = 1;
    size = size + _i3.EquivocationProof.codec.sizeHint(equivocationProof);
    size = size + _i4.MembershipProof.codec.sizeHint(keyOwnerProof);
    return size;
  }

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      1,
      output,
    );
    _i3.EquivocationProof.codec.encodeTo(
      equivocationProof,
      output,
    );
    _i4.MembershipProof.codec.encodeTo(
      keyOwnerProof,
      output,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(
        this,
        other,
      ) ||
      other is ReportEquivocationUnsigned &&
          other.equivocationProof == equivocationProof &&
          other.keyOwnerProof == keyOwnerProof;

  @override
  int get hashCode => Object.hash(
        equivocationProof,
        keyOwnerProof,
      );
}

/// Note that the current authority set of the GRANDPA finality gadget has stalled.
///
/// This will trigger a forced authority set change at the beginning of the next session, to
/// be enacted `delay` blocks after that. The `delay` should be high enough to safely assume
/// that the block signalling the forced change will not be re-orged e.g. 1000 blocks.
/// The block production rate (which may be slowed down because of finality lagging) should
/// be taken into account when choosing the `delay`. The GRANDPA voters based on the new
/// authority will start voting on top of `best_finalized_block_number` for new finalized
/// blocks. `best_finalized_block_number` should be the highest of the latest finalized
/// block of all validators of the new authority set.
///
/// Only callable by root.
class NoteStalled extends Call {
  const NoteStalled({
    required this.delay,
    required this.bestFinalizedBlockNumber,
  });

  factory NoteStalled._decode(_i1.Input input) {
    return NoteStalled(
      delay: _i1.U32Codec.codec.decode(input),
      bestFinalizedBlockNumber: _i1.U32Codec.codec.decode(input),
    );
  }

  /// BlockNumberFor<T>
  final int delay;

  /// BlockNumberFor<T>
  final int bestFinalizedBlockNumber;

  @override
  Map<String, Map<String, int>> toJson() => {
        'note_stalled': {
          'delay': delay,
          'bestFinalizedBlockNumber': bestFinalizedBlockNumber,
        }
      };

  int _sizeHint() {
    int size = 1;
    size = size + _i1.U32Codec.codec.sizeHint(delay);
    size = size + _i1.U32Codec.codec.sizeHint(bestFinalizedBlockNumber);
    return size;
  }

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      2,
      output,
    );
    _i1.U32Codec.codec.encodeTo(
      delay,
      output,
    );
    _i1.U32Codec.codec.encodeTo(
      bestFinalizedBlockNumber,
      output,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(
        this,
        other,
      ) ||
      other is NoteStalled &&
          other.delay == delay &&
          other.bestFinalizedBlockNumber == bestFinalizedBlockNumber;

  @override
  int get hashCode => Object.hash(
        delay,
        bestFinalizedBlockNumber,
      );
}
