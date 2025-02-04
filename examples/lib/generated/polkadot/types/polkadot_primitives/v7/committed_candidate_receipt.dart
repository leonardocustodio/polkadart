// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:typed_data' as _i4;

import 'package:polkadart/scale_codec.dart' as _i1;

import 'candidate_commitments.dart' as _i3;
import 'candidate_descriptor.dart' as _i2;

class CommittedCandidateReceipt {
  const CommittedCandidateReceipt({
    required this.descriptor,
    required this.commitments,
  });

  factory CommittedCandidateReceipt.decode(_i1.Input input) {
    return codec.decode(input);
  }

  /// CandidateDescriptor<H>
  final _i2.CandidateDescriptor descriptor;

  /// CandidateCommitments
  final _i3.CandidateCommitments commitments;

  static const $CommittedCandidateReceiptCodec codec =
      $CommittedCandidateReceiptCodec();

  _i4.Uint8List encode() {
    return codec.encode(this);
  }

  Map<String, Map<String, dynamic>> toJson() => {
        'descriptor': descriptor.toJson(),
        'commitments': commitments.toJson(),
      };

  @override
  bool operator ==(Object other) =>
      identical(
        this,
        other,
      ) ||
      other is CommittedCandidateReceipt &&
          other.descriptor == descriptor &&
          other.commitments == commitments;

  @override
  int get hashCode => Object.hash(
        descriptor,
        commitments,
      );
}

class $CommittedCandidateReceiptCodec
    with _i1.Codec<CommittedCandidateReceipt> {
  const $CommittedCandidateReceiptCodec();

  @override
  void encodeTo(
    CommittedCandidateReceipt obj,
    _i1.Output output,
  ) {
    _i2.CandidateDescriptor.codec.encodeTo(
      obj.descriptor,
      output,
    );
    _i3.CandidateCommitments.codec.encodeTo(
      obj.commitments,
      output,
    );
  }

  @override
  CommittedCandidateReceipt decode(_i1.Input input) {
    return CommittedCandidateReceipt(
      descriptor: _i2.CandidateDescriptor.codec.decode(input),
      commitments: _i3.CandidateCommitments.codec.decode(input),
    );
  }

  @override
  int sizeHint(CommittedCandidateReceipt obj) {
    int size = 0;
    size = size + _i2.CandidateDescriptor.codec.sizeHint(obj.descriptor);
    size = size + _i3.CandidateCommitments.codec.sizeHint(obj.commitments);
    return size;
  }
}
