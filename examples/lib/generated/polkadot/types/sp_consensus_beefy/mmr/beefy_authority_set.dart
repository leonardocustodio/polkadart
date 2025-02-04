// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:typed_data' as _i3;

import 'package:polkadart/scale_codec.dart' as _i1;
import 'package:quiver/collection.dart' as _i4;

import '../../primitive_types/h256.dart' as _i2;

class BeefyAuthoritySet {
  const BeefyAuthoritySet({
    required this.id,
    required this.len,
    required this.keysetCommitment,
  });

  factory BeefyAuthoritySet.decode(_i1.Input input) {
    return codec.decode(input);
  }

  /// crate::ValidatorSetId
  final BigInt id;

  /// u32
  final int len;

  /// AuthoritySetCommitment
  final _i2.H256 keysetCommitment;

  static const $BeefyAuthoritySetCodec codec = $BeefyAuthoritySetCodec();

  _i3.Uint8List encode() {
    return codec.encode(this);
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'len': len,
        'keysetCommitment': keysetCommitment.toList(),
      };

  @override
  bool operator ==(Object other) =>
      identical(
        this,
        other,
      ) ||
      other is BeefyAuthoritySet &&
          other.id == id &&
          other.len == len &&
          _i4.listsEqual(
            other.keysetCommitment,
            keysetCommitment,
          );

  @override
  int get hashCode => Object.hash(
        id,
        len,
        keysetCommitment,
      );
}

class $BeefyAuthoritySetCodec with _i1.Codec<BeefyAuthoritySet> {
  const $BeefyAuthoritySetCodec();

  @override
  void encodeTo(
    BeefyAuthoritySet obj,
    _i1.Output output,
  ) {
    _i1.U64Codec.codec.encodeTo(
      obj.id,
      output,
    );
    _i1.U32Codec.codec.encodeTo(
      obj.len,
      output,
    );
    const _i1.U8ArrayCodec(32).encodeTo(
      obj.keysetCommitment,
      output,
    );
  }

  @override
  BeefyAuthoritySet decode(_i1.Input input) {
    return BeefyAuthoritySet(
      id: _i1.U64Codec.codec.decode(input),
      len: _i1.U32Codec.codec.decode(input),
      keysetCommitment: const _i1.U8ArrayCodec(32).decode(input),
    );
  }

  @override
  int sizeHint(BeefyAuthoritySet obj) {
    int size = 0;
    size = size + _i1.U64Codec.codec.sizeHint(obj.id);
    size = size + _i1.U32Codec.codec.sizeHint(obj.len);
    size = size + const _i2.H256Codec().sizeHint(obj.keysetCommitment);
    return size;
  }
}
