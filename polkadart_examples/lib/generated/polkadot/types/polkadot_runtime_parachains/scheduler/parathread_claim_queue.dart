// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:typed_data' as _i3;

import 'package:polkadart/scale_codec.dart' as _i1;
import 'package:quiver/collection.dart' as _i4;

import 'queued_parathread.dart' as _i2;

class ParathreadClaimQueue {
  const ParathreadClaimQueue({
    required this.queue,
    required this.nextCoreOffset,
  });

  factory ParathreadClaimQueue.decode(_i1.Input input) {
    return codec.decode(input);
  }

  /// Vec<QueuedParathread>
  final List<_i2.QueuedParathread> queue;

  /// u32
  final int nextCoreOffset;

  static const $ParathreadClaimQueueCodec codec = $ParathreadClaimQueueCodec();

  _i3.Uint8List encode() {
    return codec.encode(this);
  }

  Map<String, dynamic> toJson() => {
        'queue': queue.map((value) => value.toJson()).toList(),
        'nextCoreOffset': nextCoreOffset,
      };

  @override
  bool operator ==(Object other) =>
      identical(
        this,
        other,
      ) ||
      other is ParathreadClaimQueue &&
          _i4.listsEqual(
            other.queue,
            queue,
          ) &&
          other.nextCoreOffset == nextCoreOffset;

  @override
  int get hashCode => Object.hash(
        queue,
        nextCoreOffset,
      );
}

class $ParathreadClaimQueueCodec with _i1.Codec<ParathreadClaimQueue> {
  const $ParathreadClaimQueueCodec();

  @override
  void encodeTo(
    ParathreadClaimQueue obj,
    _i1.Output output,
  ) {
    const _i1.SequenceCodec<_i2.QueuedParathread>(_i2.QueuedParathread.codec)
        .encodeTo(
      obj.queue,
      output,
    );
    _i1.U32Codec.codec.encodeTo(
      obj.nextCoreOffset,
      output,
    );
  }

  @override
  ParathreadClaimQueue decode(_i1.Input input) {
    return ParathreadClaimQueue(
      queue: const _i1.SequenceCodec<_i2.QueuedParathread>(
              _i2.QueuedParathread.codec)
          .decode(input),
      nextCoreOffset: _i1.U32Codec.codec.decode(input),
    );
  }

  @override
  int sizeHint(ParathreadClaimQueue obj) {
    int size = 0;
    size = size +
        const _i1.SequenceCodec<_i2.QueuedParathread>(
                _i2.QueuedParathread.codec)
            .sizeHint(obj.queue);
    size = size + _i1.U32Codec.codec.sizeHint(obj.nextCoreOffset);
    return size;
  }
}
