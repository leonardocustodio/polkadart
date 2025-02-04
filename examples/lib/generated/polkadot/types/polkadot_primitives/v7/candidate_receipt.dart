// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:typed_data' as _i4;

import 'package:polkadart/scale_codec.dart' as _i1;
import 'package:quiver/collection.dart' as _i5;

import '../../primitive_types/h256.dart' as _i3;
import 'candidate_descriptor.dart' as _i2;

class CandidateReceipt {
  const CandidateReceipt({
    required this.descriptor,
    required this.commitmentsHash,
  });

  factory CandidateReceipt.decode(_i1.Input input) {
    return codec.decode(input);
  }

  /// CandidateDescriptor<H>
  final _i2.CandidateDescriptor descriptor;

  /// Hash
  final _i3.H256 commitmentsHash;

  static const $CandidateReceiptCodec codec = $CandidateReceiptCodec();

  _i4.Uint8List encode() {
    return codec.encode(this);
  }

  Map<String, dynamic> toJson() => {
        'descriptor': descriptor.toJson(),
        'commitmentsHash': commitmentsHash.toList(),
      };

  @override
  bool operator ==(Object other) =>
      identical(
        this,
        other,
      ) ||
      other is CandidateReceipt &&
          other.descriptor == descriptor &&
          _i5.listsEqual(
            other.commitmentsHash,
            commitmentsHash,
          );

  @override
  int get hashCode => Object.hash(
        descriptor,
        commitmentsHash,
      );
}

class $CandidateReceiptCodec with _i1.Codec<CandidateReceipt> {
  const $CandidateReceiptCodec();

  @override
  void encodeTo(
    CandidateReceipt obj,
    _i1.Output output,
  ) {
    _i2.CandidateDescriptor.codec.encodeTo(
      obj.descriptor,
      output,
    );
    const _i1.U8ArrayCodec(32).encodeTo(
      obj.commitmentsHash,
      output,
    );
  }

  @override
  CandidateReceipt decode(_i1.Input input) {
    return CandidateReceipt(
      descriptor: _i2.CandidateDescriptor.codec.decode(input),
      commitmentsHash: const _i1.U8ArrayCodec(32).decode(input),
    );
  }

  @override
  int sizeHint(CandidateReceipt obj) {
    int size = 0;
    size = size + _i2.CandidateDescriptor.codec.sizeHint(obj.descriptor);
    size = size + const _i3.H256Codec().sizeHint(obj.commitmentsHash);
    return size;
  }
}
