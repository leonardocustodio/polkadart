// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:typed_data' as _i6;

import 'package:polkadart/scale_codec.dart' as _i1;

import '../../../polkadot_primitives/v4/validator_app/public.dart' as _i5;
import '../../../polkadot_primitives/v4/validator_index.dart' as _i4;
import 'disputes_time_slot.dart' as _i2;
import 'slashing_offence_kind.dart' as _i3;

class DisputeProof {
  const DisputeProof({
    required this.timeSlot,
    required this.kind,
    required this.validatorIndex,
    required this.validatorId,
  });

  factory DisputeProof.decode(_i1.Input input) {
    return codec.decode(input);
  }

  /// DisputesTimeSlot
  final _i2.DisputesTimeSlot timeSlot;

  /// SlashingOffenceKind
  final _i3.SlashingOffenceKind kind;

  /// ValidatorIndex
  final _i4.ValidatorIndex validatorIndex;

  /// ValidatorId
  final _i5.Public validatorId;

  static const $DisputeProofCodec codec = $DisputeProofCodec();

  _i6.Uint8List encode() {
    return codec.encode(this);
  }

  Map<String, dynamic> toJson() => {
        'timeSlot': timeSlot.toJson(),
        'kind': kind.toJson(),
        'validatorIndex': validatorIndex,
        'validatorId': validatorId.toList(),
      };

  @override
  bool operator ==(Object other) =>
      identical(
        this,
        other,
      ) ||
      other is DisputeProof &&
          other.timeSlot == timeSlot &&
          other.kind == kind &&
          other.validatorIndex == validatorIndex &&
          other.validatorId == validatorId;

  @override
  int get hashCode => Object.hash(
        timeSlot,
        kind,
        validatorIndex,
        validatorId,
      );
}

class $DisputeProofCodec with _i1.Codec<DisputeProof> {
  const $DisputeProofCodec();

  @override
  void encodeTo(
    DisputeProof obj,
    _i1.Output output,
  ) {
    _i2.DisputesTimeSlot.codec.encodeTo(
      obj.timeSlot,
      output,
    );
    _i3.SlashingOffenceKind.codec.encodeTo(
      obj.kind,
      output,
    );
    _i1.U32Codec.codec.encodeTo(
      obj.validatorIndex,
      output,
    );
    const _i1.U8ArrayCodec(32).encodeTo(
      obj.validatorId,
      output,
    );
  }

  @override
  DisputeProof decode(_i1.Input input) {
    return DisputeProof(
      timeSlot: _i2.DisputesTimeSlot.codec.decode(input),
      kind: _i3.SlashingOffenceKind.codec.decode(input),
      validatorIndex: _i1.U32Codec.codec.decode(input),
      validatorId: const _i1.U8ArrayCodec(32).decode(input),
    );
  }

  @override
  int sizeHint(DisputeProof obj) {
    int size = 0;
    size = size + _i2.DisputesTimeSlot.codec.sizeHint(obj.timeSlot);
    size = size + _i3.SlashingOffenceKind.codec.sizeHint(obj.kind);
    size = size + const _i4.ValidatorIndexCodec().sizeHint(obj.validatorIndex);
    size = size + const _i5.PublicCodec().sizeHint(obj.validatorId);
    return size;
  }
}
