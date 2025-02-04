// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:typed_data' as _i2;

import 'package:polkadart/scale_codec.dart' as _i1;
import 'package:quiver/collection.dart' as _i3;

class MembershipProof {
  const MembershipProof({
    required this.session,
    required this.trieNodes,
    required this.validatorCount,
  });

  factory MembershipProof.decode(_i1.Input input) {
    return codec.decode(input);
  }

  /// SessionIndex
  final int session;

  /// Vec<Vec<u8>>
  final List<List<int>> trieNodes;

  /// ValidatorCount
  final int validatorCount;

  static const $MembershipProofCodec codec = $MembershipProofCodec();

  _i2.Uint8List encode() {
    return codec.encode(this);
  }

  Map<String, dynamic> toJson() => {
        'session': session,
        'trieNodes': trieNodes.map((value) => value).toList(),
        'validatorCount': validatorCount,
      };

  @override
  bool operator ==(Object other) =>
      identical(
        this,
        other,
      ) ||
      other is MembershipProof &&
          other.session == session &&
          _i3.listsEqual(
            other.trieNodes,
            trieNodes,
          ) &&
          other.validatorCount == validatorCount;

  @override
  int get hashCode => Object.hash(
        session,
        trieNodes,
        validatorCount,
      );
}

class $MembershipProofCodec with _i1.Codec<MembershipProof> {
  const $MembershipProofCodec();

  @override
  void encodeTo(
    MembershipProof obj,
    _i1.Output output,
  ) {
    _i1.U32Codec.codec.encodeTo(
      obj.session,
      output,
    );
    const _i1.SequenceCodec<List<int>>(_i1.U8SequenceCodec.codec).encodeTo(
      obj.trieNodes,
      output,
    );
    _i1.U32Codec.codec.encodeTo(
      obj.validatorCount,
      output,
    );
  }

  @override
  MembershipProof decode(_i1.Input input) {
    return MembershipProof(
      session: _i1.U32Codec.codec.decode(input),
      trieNodes: const _i1.SequenceCodec<List<int>>(_i1.U8SequenceCodec.codec)
          .decode(input),
      validatorCount: _i1.U32Codec.codec.decode(input),
    );
  }

  @override
  int sizeHint(MembershipProof obj) {
    int size = 0;
    size = size + _i1.U32Codec.codec.sizeHint(obj.session);
    size = size +
        const _i1.SequenceCodec<List<int>>(_i1.U8SequenceCodec.codec)
            .sizeHint(obj.trieNodes);
    size = size + _i1.U32Codec.codec.sizeHint(obj.validatorCount);
    return size;
  }
}
