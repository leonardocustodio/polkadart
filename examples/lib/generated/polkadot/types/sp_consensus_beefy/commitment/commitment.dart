// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:typed_data' as _i3;

import 'package:polkadart/scale_codec.dart' as _i1;
import 'package:quiver/collection.dart' as _i4;

import '../../tuples.dart' as _i5;
import '../payload/payload.dart' as _i2;

class Commitment {
  const Commitment({
    required this.payload,
    required this.blockNumber,
    required this.validatorSetId,
  });

  factory Commitment.decode(_i1.Input input) {
    return codec.decode(input);
  }

  /// Payload
  final _i2.Payload payload;

  /// TBlockNumber
  final int blockNumber;

  /// ValidatorSetId
  final BigInt validatorSetId;

  static const $CommitmentCodec codec = $CommitmentCodec();

  _i3.Uint8List encode() {
    return codec.encode(this);
  }

  Map<String, dynamic> toJson() => {
        'payload': payload
            .map((value) => [
                  value.value0.toList(),
                  value.value1,
                ])
            .toList(),
        'blockNumber': blockNumber,
        'validatorSetId': validatorSetId,
      };

  @override
  bool operator ==(Object other) =>
      identical(
        this,
        other,
      ) ||
      other is Commitment &&
          _i4.listsEqual(
            other.payload,
            payload,
          ) &&
          other.blockNumber == blockNumber &&
          other.validatorSetId == validatorSetId;

  @override
  int get hashCode => Object.hash(
        payload,
        blockNumber,
        validatorSetId,
      );
}

class $CommitmentCodec with _i1.Codec<Commitment> {
  const $CommitmentCodec();

  @override
  void encodeTo(
    Commitment obj,
    _i1.Output output,
  ) {
    const _i1.SequenceCodec<_i5.Tuple2<List<int>, List<int>>>(
        _i5.Tuple2Codec<List<int>, List<int>>(
      _i1.U8ArrayCodec(2),
      _i1.U8SequenceCodec.codec,
    )).encodeTo(
      obj.payload,
      output,
    );
    _i1.U32Codec.codec.encodeTo(
      obj.blockNumber,
      output,
    );
    _i1.U64Codec.codec.encodeTo(
      obj.validatorSetId,
      output,
    );
  }

  @override
  Commitment decode(_i1.Input input) {
    return Commitment(
      payload: const _i1.SequenceCodec<_i5.Tuple2<List<int>, List<int>>>(
          _i5.Tuple2Codec<List<int>, List<int>>(
        _i1.U8ArrayCodec(2),
        _i1.U8SequenceCodec.codec,
      )).decode(input),
      blockNumber: _i1.U32Codec.codec.decode(input),
      validatorSetId: _i1.U64Codec.codec.decode(input),
    );
  }

  @override
  int sizeHint(Commitment obj) {
    int size = 0;
    size = size + const _i2.PayloadCodec().sizeHint(obj.payload);
    size = size + _i1.U32Codec.codec.sizeHint(obj.blockNumber);
    size = size + _i1.U64Codec.codec.sizeHint(obj.validatorSetId);
    return size;
  }
}
