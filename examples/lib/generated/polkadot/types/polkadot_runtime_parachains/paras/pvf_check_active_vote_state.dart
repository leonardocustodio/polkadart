// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:typed_data' as _i3;

import 'package:polkadart/scale_codec.dart' as _i1;
import 'package:quiver/collection.dart' as _i4;

import 'pvf_check_cause.dart' as _i2;

class PvfCheckActiveVoteState {
  const PvfCheckActiveVoteState({
    required this.votesAccept,
    required this.votesReject,
    required this.age,
    required this.createdAt,
    required this.causes,
  });

  factory PvfCheckActiveVoteState.decode(_i1.Input input) {
    return codec.decode(input);
  }

  /// BitVec<u8, BitOrderLsb0>
  final _i1.BitArray votesAccept;

  /// BitVec<u8, BitOrderLsb0>
  final _i1.BitArray votesReject;

  /// SessionIndex
  final int age;

  /// BlockNumber
  final int createdAt;

  /// Vec<PvfCheckCause<BlockNumber>>
  final List<_i2.PvfCheckCause> causes;

  static const $PvfCheckActiveVoteStateCodec codec =
      $PvfCheckActiveVoteStateCodec();

  _i3.Uint8List encode() {
    return codec.encode(this);
  }

  Map<String, dynamic> toJson() => {
        'votesAccept': votesAccept.toJson(),
        'votesReject': votesReject.toJson(),
        'age': age,
        'createdAt': createdAt,
        'causes': causes.map((value) => value.toJson()).toList(),
      };

  @override
  bool operator ==(Object other) =>
      identical(
        this,
        other,
      ) ||
      other is PvfCheckActiveVoteState &&
          other.votesAccept == votesAccept &&
          other.votesReject == votesReject &&
          other.age == age &&
          other.createdAt == createdAt &&
          _i4.listsEqual(
            other.causes,
            causes,
          );

  @override
  int get hashCode => Object.hash(
        votesAccept,
        votesReject,
        age,
        createdAt,
        causes,
      );
}

class $PvfCheckActiveVoteStateCodec with _i1.Codec<PvfCheckActiveVoteState> {
  const $PvfCheckActiveVoteStateCodec();

  @override
  void encodeTo(
    PvfCheckActiveVoteState obj,
    _i1.Output output,
  ) {
    const _i1.BitSequenceCodec(
      _i1.BitStore.U8,
      _i1.BitOrder.LSB,
    ).encodeTo(
      obj.votesAccept,
      output,
    );
    const _i1.BitSequenceCodec(
      _i1.BitStore.U8,
      _i1.BitOrder.LSB,
    ).encodeTo(
      obj.votesReject,
      output,
    );
    _i1.U32Codec.codec.encodeTo(
      obj.age,
      output,
    );
    _i1.U32Codec.codec.encodeTo(
      obj.createdAt,
      output,
    );
    const _i1.SequenceCodec<_i2.PvfCheckCause>(_i2.PvfCheckCause.codec)
        .encodeTo(
      obj.causes,
      output,
    );
  }

  @override
  PvfCheckActiveVoteState decode(_i1.Input input) {
    return PvfCheckActiveVoteState(
      votesAccept: const _i1.BitSequenceCodec(
        _i1.BitStore.U8,
        _i1.BitOrder.LSB,
      ).decode(input),
      votesReject: const _i1.BitSequenceCodec(
        _i1.BitStore.U8,
        _i1.BitOrder.LSB,
      ).decode(input),
      age: _i1.U32Codec.codec.decode(input),
      createdAt: _i1.U32Codec.codec.decode(input),
      causes:
          const _i1.SequenceCodec<_i2.PvfCheckCause>(_i2.PvfCheckCause.codec)
              .decode(input),
    );
  }

  @override
  int sizeHint(PvfCheckActiveVoteState obj) {
    int size = 0;
    size = size +
        const _i1.BitSequenceCodec(
          _i1.BitStore.U8,
          _i1.BitOrder.LSB,
        ).sizeHint(obj.votesAccept);
    size = size +
        const _i1.BitSequenceCodec(
          _i1.BitStore.U8,
          _i1.BitOrder.LSB,
        ).sizeHint(obj.votesReject);
    size = size + _i1.U32Codec.codec.sizeHint(obj.age);
    size = size + _i1.U32Codec.codec.sizeHint(obj.createdAt);
    size = size +
        const _i1.SequenceCodec<_i2.PvfCheckCause>(_i2.PvfCheckCause.codec)
            .sizeHint(obj.causes);
    return size;
  }
}
