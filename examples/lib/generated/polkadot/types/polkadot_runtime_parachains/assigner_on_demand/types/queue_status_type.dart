// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:typed_data' as _i5;

import 'package:polkadart/scale_codec.dart' as _i1;
import 'package:quiver/collection.dart' as _i6;

import '../../../binary_heap_1.dart' as _i4;
import '../../../sp_arithmetic/fixed_point/fixed_u128.dart' as _i2;
import 'queue_index.dart' as _i3;
import 'reverse_queue_index.dart' as _i7;

class QueueStatusType {
  const QueueStatusType({
    required this.traffic,
    required this.nextIndex,
    required this.smallestIndex,
    required this.freedIndices,
  });

  factory QueueStatusType.decode(_i1.Input input) {
    return codec.decode(input);
  }

  /// FixedU128
  final _i2.FixedU128 traffic;

  /// QueueIndex
  final _i3.QueueIndex nextIndex;

  /// QueueIndex
  final _i3.QueueIndex smallestIndex;

  /// BinaryHeap<ReverseQueueIndex>
  final _i4.BinaryHeap freedIndices;

  static const $QueueStatusTypeCodec codec = $QueueStatusTypeCodec();

  _i5.Uint8List encode() {
    return codec.encode(this);
  }

  Map<String, dynamic> toJson() => {
        'traffic': traffic,
        'nextIndex': nextIndex,
        'smallestIndex': smallestIndex,
        'freedIndices': freedIndices.map((value) => value).toList(),
      };

  @override
  bool operator ==(Object other) =>
      identical(
        this,
        other,
      ) ||
      other is QueueStatusType &&
          other.traffic == traffic &&
          other.nextIndex == nextIndex &&
          other.smallestIndex == smallestIndex &&
          _i6.listsEqual(
            other.freedIndices,
            freedIndices,
          );

  @override
  int get hashCode => Object.hash(
        traffic,
        nextIndex,
        smallestIndex,
        freedIndices,
      );
}

class $QueueStatusTypeCodec with _i1.Codec<QueueStatusType> {
  const $QueueStatusTypeCodec();

  @override
  void encodeTo(
    QueueStatusType obj,
    _i1.Output output,
  ) {
    _i1.U128Codec.codec.encodeTo(
      obj.traffic,
      output,
    );
    _i1.U32Codec.codec.encodeTo(
      obj.nextIndex,
      output,
    );
    _i1.U32Codec.codec.encodeTo(
      obj.smallestIndex,
      output,
    );
    const _i1.SequenceCodec<_i7.ReverseQueueIndex>(_i7.ReverseQueueIndexCodec())
        .encodeTo(
      obj.freedIndices,
      output,
    );
  }

  @override
  QueueStatusType decode(_i1.Input input) {
    return QueueStatusType(
      traffic: _i1.U128Codec.codec.decode(input),
      nextIndex: _i1.U32Codec.codec.decode(input),
      smallestIndex: _i1.U32Codec.codec.decode(input),
      freedIndices: const _i1.SequenceCodec<_i7.ReverseQueueIndex>(
              _i7.ReverseQueueIndexCodec())
          .decode(input),
    );
  }

  @override
  int sizeHint(QueueStatusType obj) {
    int size = 0;
    size = size + const _i2.FixedU128Codec().sizeHint(obj.traffic);
    size = size + const _i3.QueueIndexCodec().sizeHint(obj.nextIndex);
    size = size + const _i3.QueueIndexCodec().sizeHint(obj.smallestIndex);
    size = size + const _i4.BinaryHeapCodec().sizeHint(obj.freedIndices);
    return size;
  }
}
