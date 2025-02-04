// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:typed_data' as _i7;

import 'package:polkadart/scale_codec.dart' as _i1;

import '../../polkadot_core_primitives/candidate_hash.dart' as _i3;
import '../../polkadot_primitives/v7/candidate_commitments.dart' as _i5;
import '../../polkadot_primitives/v7/candidate_descriptor.dart' as _i4;
import '../../polkadot_primitives/v7/core_index.dart' as _i2;
import '../../polkadot_primitives/v7/group_index.dart' as _i6;

class CandidatePendingAvailability {
  const CandidatePendingAvailability({
    required this.core,
    required this.hash,
    required this.descriptor,
    required this.commitments,
    required this.availabilityVotes,
    required this.backers,
    required this.relayParentNumber,
    required this.backedInNumber,
    required this.backingGroup,
  });

  factory CandidatePendingAvailability.decode(_i1.Input input) {
    return codec.decode(input);
  }

  /// CoreIndex
  final _i2.CoreIndex core;

  /// CandidateHash
  final _i3.CandidateHash hash;

  /// CandidateDescriptor<H>
  final _i4.CandidateDescriptor descriptor;

  /// CandidateCommitments
  final _i5.CandidateCommitments commitments;

  /// BitVec<u8, BitOrderLsb0>
  final _i1.BitArray availabilityVotes;

  /// BitVec<u8, BitOrderLsb0>
  final _i1.BitArray backers;

  /// N
  final int relayParentNumber;

  /// N
  final int backedInNumber;

  /// GroupIndex
  final _i6.GroupIndex backingGroup;

  static const $CandidatePendingAvailabilityCodec codec =
      $CandidatePendingAvailabilityCodec();

  _i7.Uint8List encode() {
    return codec.encode(this);
  }

  Map<String, dynamic> toJson() => {
        'core': core,
        'hash': hash.toList(),
        'descriptor': descriptor.toJson(),
        'commitments': commitments.toJson(),
        'availabilityVotes': availabilityVotes.toJson(),
        'backers': backers.toJson(),
        'relayParentNumber': relayParentNumber,
        'backedInNumber': backedInNumber,
        'backingGroup': backingGroup,
      };

  @override
  bool operator ==(Object other) =>
      identical(
        this,
        other,
      ) ||
      other is CandidatePendingAvailability &&
          other.core == core &&
          other.hash == hash &&
          other.descriptor == descriptor &&
          other.commitments == commitments &&
          other.availabilityVotes == availabilityVotes &&
          other.backers == backers &&
          other.relayParentNumber == relayParentNumber &&
          other.backedInNumber == backedInNumber &&
          other.backingGroup == backingGroup;

  @override
  int get hashCode => Object.hash(
        core,
        hash,
        descriptor,
        commitments,
        availabilityVotes,
        backers,
        relayParentNumber,
        backedInNumber,
        backingGroup,
      );
}

class $CandidatePendingAvailabilityCodec
    with _i1.Codec<CandidatePendingAvailability> {
  const $CandidatePendingAvailabilityCodec();

  @override
  void encodeTo(
    CandidatePendingAvailability obj,
    _i1.Output output,
  ) {
    _i1.U32Codec.codec.encodeTo(
      obj.core,
      output,
    );
    const _i1.U8ArrayCodec(32).encodeTo(
      obj.hash,
      output,
    );
    _i4.CandidateDescriptor.codec.encodeTo(
      obj.descriptor,
      output,
    );
    _i5.CandidateCommitments.codec.encodeTo(
      obj.commitments,
      output,
    );
    const _i1.BitSequenceCodec(
      _i1.BitStore.U8,
      _i1.BitOrder.LSB,
    ).encodeTo(
      obj.availabilityVotes,
      output,
    );
    const _i1.BitSequenceCodec(
      _i1.BitStore.U8,
      _i1.BitOrder.LSB,
    ).encodeTo(
      obj.backers,
      output,
    );
    _i1.U32Codec.codec.encodeTo(
      obj.relayParentNumber,
      output,
    );
    _i1.U32Codec.codec.encodeTo(
      obj.backedInNumber,
      output,
    );
    _i1.U32Codec.codec.encodeTo(
      obj.backingGroup,
      output,
    );
  }

  @override
  CandidatePendingAvailability decode(_i1.Input input) {
    return CandidatePendingAvailability(
      core: _i1.U32Codec.codec.decode(input),
      hash: const _i1.U8ArrayCodec(32).decode(input),
      descriptor: _i4.CandidateDescriptor.codec.decode(input),
      commitments: _i5.CandidateCommitments.codec.decode(input),
      availabilityVotes: const _i1.BitSequenceCodec(
        _i1.BitStore.U8,
        _i1.BitOrder.LSB,
      ).decode(input),
      backers: const _i1.BitSequenceCodec(
        _i1.BitStore.U8,
        _i1.BitOrder.LSB,
      ).decode(input),
      relayParentNumber: _i1.U32Codec.codec.decode(input),
      backedInNumber: _i1.U32Codec.codec.decode(input),
      backingGroup: _i1.U32Codec.codec.decode(input),
    );
  }

  @override
  int sizeHint(CandidatePendingAvailability obj) {
    int size = 0;
    size = size + const _i2.CoreIndexCodec().sizeHint(obj.core);
    size = size + const _i3.CandidateHashCodec().sizeHint(obj.hash);
    size = size + _i4.CandidateDescriptor.codec.sizeHint(obj.descriptor);
    size = size + _i5.CandidateCommitments.codec.sizeHint(obj.commitments);
    size = size +
        const _i1.BitSequenceCodec(
          _i1.BitStore.U8,
          _i1.BitOrder.LSB,
        ).sizeHint(obj.availabilityVotes);
    size = size +
        const _i1.BitSequenceCodec(
          _i1.BitStore.U8,
          _i1.BitOrder.LSB,
        ).sizeHint(obj.backers);
    size = size + _i1.U32Codec.codec.sizeHint(obj.relayParentNumber);
    size = size + _i1.U32Codec.codec.sizeHint(obj.backedInNumber);
    size = size + const _i6.GroupIndexCodec().sizeHint(obj.backingGroup);
    return size;
  }
}
