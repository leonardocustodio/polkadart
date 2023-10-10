// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:typed_data' as _i4;

import 'package:polkadart/scale_codec.dart' as _i1;
import 'package:quiver/collection.dart' as _i5;

import 'committed_candidate_receipt.dart' as _i2;
import 'validity_attestation.dart' as _i3;

class BackedCandidate {
  const BackedCandidate({
    required this.candidate,
    required this.validityVotes,
    required this.validatorIndices,
  });

  factory BackedCandidate.decode(_i1.Input input) {
    return codec.decode(input);
  }

  /// CommittedCandidateReceipt<H>
  final _i2.CommittedCandidateReceipt candidate;

  /// Vec<ValidityAttestation>
  final List<_i3.ValidityAttestation> validityVotes;

  /// BitVec<u8, bitvec::order::Lsb0>
  final _i1.BitArray validatorIndices;

  static const $BackedCandidateCodec codec = $BackedCandidateCodec();

  _i4.Uint8List encode() {
    return codec.encode(this);
  }

  Map<String, dynamic> toJson() => {
        'candidate': candidate.toJson(),
        'validityVotes': validityVotes.map((value) => value.toJson()).toList(),
        'validatorIndices': validatorIndices.toJson(),
      };

  @override
  bool operator ==(Object other) =>
      identical(
        this,
        other,
      ) ||
      other is BackedCandidate &&
          other.candidate == candidate &&
          _i5.listsEqual(
            other.validityVotes,
            validityVotes,
          ) &&
          other.validatorIndices == validatorIndices;

  @override
  int get hashCode => Object.hash(
        candidate,
        validityVotes,
        validatorIndices,
      );
}

class $BackedCandidateCodec with _i1.Codec<BackedCandidate> {
  const $BackedCandidateCodec();

  @override
  void encodeTo(
    BackedCandidate obj,
    _i1.Output output,
  ) {
    _i2.CommittedCandidateReceipt.codec.encodeTo(
      obj.candidate,
      output,
    );
    const _i1.SequenceCodec<_i3.ValidityAttestation>(
            _i3.ValidityAttestation.codec)
        .encodeTo(
      obj.validityVotes,
      output,
    );
    const _i1.BitSequenceCodec(
      _i1.BitStore.U8,
      _i1.BitOrder.LSB,
    ).encodeTo(
      obj.validatorIndices,
      output,
    );
  }

  @override
  BackedCandidate decode(_i1.Input input) {
    return BackedCandidate(
      candidate: _i2.CommittedCandidateReceipt.codec.decode(input),
      validityVotes: const _i1.SequenceCodec<_i3.ValidityAttestation>(
              _i3.ValidityAttestation.codec)
          .decode(input),
      validatorIndices: const _i1.BitSequenceCodec(
        _i1.BitStore.U8,
        _i1.BitOrder.LSB,
      ).decode(input),
    );
  }

  @override
  int sizeHint(BackedCandidate obj) {
    int size = 0;
    size = size + _i2.CommittedCandidateReceipt.codec.sizeHint(obj.candidate);
    size = size +
        const _i1.SequenceCodec<_i3.ValidityAttestation>(
                _i3.ValidityAttestation.codec)
            .sizeHint(obj.validityVotes);
    size = size +
        const _i1.BitSequenceCodec(
          _i1.BitStore.U8,
          _i1.BitOrder.LSB,
        ).sizeHint(obj.validatorIndices);
    return size;
  }
}
