// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:typed_data' as _i2;

import 'package:polkadart/scale_codec.dart' as _i1;

class DisputeState {
  const DisputeState({
    required this.validatorsFor,
    required this.validatorsAgainst,
    required this.start,
    this.concludedAt,
  });

  factory DisputeState.decode(_i1.Input input) {
    return codec.decode(input);
  }

  /// BitVec<u8, bitvec::order::Lsb0>
  final _i1.BitArray validatorsFor;

  /// BitVec<u8, bitvec::order::Lsb0>
  final _i1.BitArray validatorsAgainst;

  /// N
  final int start;

  /// Option<N>
  final int? concludedAt;

  static const $DisputeStateCodec codec = $DisputeStateCodec();

  _i2.Uint8List encode() {
    return codec.encode(this);
  }

  Map<String, dynamic> toJson() => {
        'validatorsFor': validatorsFor.toJson(),
        'validatorsAgainst': validatorsAgainst.toJson(),
        'start': start,
        'concludedAt': concludedAt,
      };

  @override
  bool operator ==(Object other) =>
      identical(
        this,
        other,
      ) ||
      other is DisputeState &&
          other.validatorsFor == validatorsFor &&
          other.validatorsAgainst == validatorsAgainst &&
          other.start == start &&
          other.concludedAt == concludedAt;

  @override
  int get hashCode => Object.hash(
        validatorsFor,
        validatorsAgainst,
        start,
        concludedAt,
      );
}

class $DisputeStateCodec with _i1.Codec<DisputeState> {
  const $DisputeStateCodec();

  @override
  void encodeTo(
    DisputeState obj,
    _i1.Output output,
  ) {
    const _i1.BitSequenceCodec(
      _i1.BitStore.U8,
      _i1.BitOrder.LSB,
    ).encodeTo(
      obj.validatorsFor,
      output,
    );
    const _i1.BitSequenceCodec(
      _i1.BitStore.U8,
      _i1.BitOrder.LSB,
    ).encodeTo(
      obj.validatorsAgainst,
      output,
    );
    _i1.U32Codec.codec.encodeTo(
      obj.start,
      output,
    );
    const _i1.OptionCodec<int>(_i1.U32Codec.codec).encodeTo(
      obj.concludedAt,
      output,
    );
  }

  @override
  DisputeState decode(_i1.Input input) {
    return DisputeState(
      validatorsFor: const _i1.BitSequenceCodec(
        _i1.BitStore.U8,
        _i1.BitOrder.LSB,
      ).decode(input),
      validatorsAgainst: const _i1.BitSequenceCodec(
        _i1.BitStore.U8,
        _i1.BitOrder.LSB,
      ).decode(input),
      start: _i1.U32Codec.codec.decode(input),
      concludedAt: const _i1.OptionCodec<int>(_i1.U32Codec.codec).decode(input),
    );
  }

  @override
  int sizeHint(DisputeState obj) {
    int size = 0;
    size = size +
        const _i1.BitSequenceCodec(
          _i1.BitStore.U8,
          _i1.BitOrder.LSB,
        ).sizeHint(obj.validatorsFor);
    size = size +
        const _i1.BitSequenceCodec(
          _i1.BitStore.U8,
          _i1.BitOrder.LSB,
        ).sizeHint(obj.validatorsAgainst);
    size = size + _i1.U32Codec.codec.sizeHint(obj.start);
    size = size +
        const _i1.OptionCodec<int>(_i1.U32Codec.codec)
            .sizeHint(obj.concludedAt);
    return size;
  }
}
