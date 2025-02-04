// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:typed_data' as _i4;

import 'package:polkadart/scale_codec.dart' as _i1;

import 'queue_descriptor.dart' as _i2;
import 'work_state.dart' as _i3;

class CoreDescriptor {
  const CoreDescriptor({
    this.queue,
    this.currentWork,
  });

  factory CoreDescriptor.decode(_i1.Input input) {
    return codec.decode(input);
  }

  /// Option<QueueDescriptor<N>>
  final _i2.QueueDescriptor? queue;

  /// Option<WorkState<N>>
  final _i3.WorkState? currentWork;

  static const $CoreDescriptorCodec codec = $CoreDescriptorCodec();

  _i4.Uint8List encode() {
    return codec.encode(this);
  }

  Map<String, Map<String, dynamic>?> toJson() => {
        'queue': queue?.toJson(),
        'currentWork': currentWork?.toJson(),
      };

  @override
  bool operator ==(Object other) =>
      identical(
        this,
        other,
      ) ||
      other is CoreDescriptor &&
          other.queue == queue &&
          other.currentWork == currentWork;

  @override
  int get hashCode => Object.hash(
        queue,
        currentWork,
      );
}

class $CoreDescriptorCodec with _i1.Codec<CoreDescriptor> {
  const $CoreDescriptorCodec();

  @override
  void encodeTo(
    CoreDescriptor obj,
    _i1.Output output,
  ) {
    const _i1.OptionCodec<_i2.QueueDescriptor>(_i2.QueueDescriptor.codec)
        .encodeTo(
      obj.queue,
      output,
    );
    const _i1.OptionCodec<_i3.WorkState>(_i3.WorkState.codec).encodeTo(
      obj.currentWork,
      output,
    );
  }

  @override
  CoreDescriptor decode(_i1.Input input) {
    return CoreDescriptor(
      queue:
          const _i1.OptionCodec<_i2.QueueDescriptor>(_i2.QueueDescriptor.codec)
              .decode(input),
      currentWork: const _i1.OptionCodec<_i3.WorkState>(_i3.WorkState.codec)
          .decode(input),
    );
  }

  @override
  int sizeHint(CoreDescriptor obj) {
    int size = 0;
    size = size +
        const _i1.OptionCodec<_i2.QueueDescriptor>(_i2.QueueDescriptor.codec)
            .sizeHint(obj.queue);
    size = size +
        const _i1.OptionCodec<_i3.WorkState>(_i3.WorkState.codec)
            .sizeHint(obj.currentWork);
    return size;
  }
}
