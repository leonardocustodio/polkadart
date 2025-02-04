// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:typed_data' as _i3;

import 'package:polkadart/scale_codec.dart' as _i1;

import '../../../polkadot_core_primitives/candidate_hash.dart' as _i2;

class DisputesTimeSlot {
  const DisputesTimeSlot({
    required this.sessionIndex,
    required this.candidateHash,
  });

  factory DisputesTimeSlot.decode(_i1.Input input) {
    return codec.decode(input);
  }

  /// SessionIndex
  final int sessionIndex;

  /// CandidateHash
  final _i2.CandidateHash candidateHash;

  static const $DisputesTimeSlotCodec codec = $DisputesTimeSlotCodec();

  _i3.Uint8List encode() {
    return codec.encode(this);
  }

  Map<String, dynamic> toJson() => {
        'sessionIndex': sessionIndex,
        'candidateHash': candidateHash.toList(),
      };

  @override
  bool operator ==(Object other) =>
      identical(
        this,
        other,
      ) ||
      other is DisputesTimeSlot &&
          other.sessionIndex == sessionIndex &&
          other.candidateHash == candidateHash;

  @override
  int get hashCode => Object.hash(
        sessionIndex,
        candidateHash,
      );
}

class $DisputesTimeSlotCodec with _i1.Codec<DisputesTimeSlot> {
  const $DisputesTimeSlotCodec();

  @override
  void encodeTo(
    DisputesTimeSlot obj,
    _i1.Output output,
  ) {
    _i1.U32Codec.codec.encodeTo(
      obj.sessionIndex,
      output,
    );
    const _i1.U8ArrayCodec(32).encodeTo(
      obj.candidateHash,
      output,
    );
  }

  @override
  DisputesTimeSlot decode(_i1.Input input) {
    return DisputesTimeSlot(
      sessionIndex: _i1.U32Codec.codec.decode(input),
      candidateHash: const _i1.U8ArrayCodec(32).decode(input),
    );
  }

  @override
  int sizeHint(DisputesTimeSlot obj) {
    int size = 0;
    size = size + _i1.U32Codec.codec.sizeHint(obj.sessionIndex);
    size = size + const _i2.CandidateHashCodec().sizeHint(obj.candidateHash);
    return size;
  }
}
