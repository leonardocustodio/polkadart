// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:typed_data' as _i2;

import 'package:polkadart/scale_codec.dart' as _i1;

import '../../sp_consensus_beefy/double_voting_proof.dart' as _i3;
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
    required _i3.DoubleVotingProof equivocationProof,
    required _i4.MembershipProof keyOwnerProof,
  }) {
    return ReportEquivocation(
      equivocationProof: equivocationProof,
      keyOwnerProof: keyOwnerProof,
    );
  }

  ReportEquivocationUnsigned reportEquivocationUnsigned({
    required _i3.DoubleVotingProof equivocationProof,
    required _i4.MembershipProof keyOwnerProof,
  }) {
    return ReportEquivocationUnsigned(
      equivocationProof: equivocationProof,
      keyOwnerProof: keyOwnerProof,
    );
  }

  SetNewGenesis setNewGenesis({required int delayInBlocks}) {
    return SetNewGenesis(delayInBlocks: delayInBlocks);
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
        return SetNewGenesis._decode(input);
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
      case SetNewGenesis:
        (value as SetNewGenesis).encodeTo(output);
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
      case SetNewGenesis:
        return (value as SetNewGenesis)._sizeHint();
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
      equivocationProof: _i3.DoubleVotingProof.codec.decode(input),
      keyOwnerProof: _i4.MembershipProof.codec.decode(input),
    );
  }

  /// Box<DoubleVotingProof<BlockNumberFor<T>, T::BeefyId,<T::BeefyId
  ///as RuntimeAppPublic>::Signature,>,>
  final _i3.DoubleVotingProof equivocationProof;

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
    size = size + _i3.DoubleVotingProof.codec.sizeHint(equivocationProof);
    size = size + _i4.MembershipProof.codec.sizeHint(keyOwnerProof);
    return size;
  }

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      0,
      output,
    );
    _i3.DoubleVotingProof.codec.encodeTo(
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
      equivocationProof: _i3.DoubleVotingProof.codec.decode(input),
      keyOwnerProof: _i4.MembershipProof.codec.decode(input),
    );
  }

  /// Box<DoubleVotingProof<BlockNumberFor<T>, T::BeefyId,<T::BeefyId
  ///as RuntimeAppPublic>::Signature,>,>
  final _i3.DoubleVotingProof equivocationProof;

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
    size = size + _i3.DoubleVotingProof.codec.sizeHint(equivocationProof);
    size = size + _i4.MembershipProof.codec.sizeHint(keyOwnerProof);
    return size;
  }

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      1,
      output,
    );
    _i3.DoubleVotingProof.codec.encodeTo(
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

/// Reset BEEFY consensus by setting a new BEEFY genesis at `delay_in_blocks` blocks in the
/// future.
///
/// Note: `delay_in_blocks` has to be at least 1.
class SetNewGenesis extends Call {
  const SetNewGenesis({required this.delayInBlocks});

  factory SetNewGenesis._decode(_i1.Input input) {
    return SetNewGenesis(delayInBlocks: _i1.U32Codec.codec.decode(input));
  }

  /// BlockNumberFor<T>
  final int delayInBlocks;

  @override
  Map<String, Map<String, int>> toJson() => {
        'set_new_genesis': {'delayInBlocks': delayInBlocks}
      };

  int _sizeHint() {
    int size = 1;
    size = size + _i1.U32Codec.codec.sizeHint(delayInBlocks);
    return size;
  }

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      2,
      output,
    );
    _i1.U32Codec.codec.encodeTo(
      delayInBlocks,
      output,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(
        this,
        other,
      ) ||
      other is SetNewGenesis && other.delayInBlocks == delayInBlocks;

  @override
  int get hashCode => delayInBlocks.hashCode;
}
