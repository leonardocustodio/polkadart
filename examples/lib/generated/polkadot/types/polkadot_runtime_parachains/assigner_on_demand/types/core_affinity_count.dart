// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:typed_data' as _i3;

import 'package:polkadart/scale_codec.dart' as _i1;

import '../../../polkadot_primitives/v7/core_index.dart' as _i2;

class CoreAffinityCount {
  const CoreAffinityCount({
    required this.coreIndex,
    required this.count,
  });

  factory CoreAffinityCount.decode(_i1.Input input) {
    return codec.decode(input);
  }

  /// CoreIndex
  final _i2.CoreIndex coreIndex;

  /// u32
  final int count;

  static const $CoreAffinityCountCodec codec = $CoreAffinityCountCodec();

  _i3.Uint8List encode() {
    return codec.encode(this);
  }

  Map<String, int> toJson() => {
        'coreIndex': coreIndex,
        'count': count,
      };

  @override
  bool operator ==(Object other) =>
      identical(
        this,
        other,
      ) ||
      other is CoreAffinityCount &&
          other.coreIndex == coreIndex &&
          other.count == count;

  @override
  int get hashCode => Object.hash(
        coreIndex,
        count,
      );
}

class $CoreAffinityCountCodec with _i1.Codec<CoreAffinityCount> {
  const $CoreAffinityCountCodec();

  @override
  void encodeTo(
    CoreAffinityCount obj,
    _i1.Output output,
  ) {
    _i1.U32Codec.codec.encodeTo(
      obj.coreIndex,
      output,
    );
    _i1.U32Codec.codec.encodeTo(
      obj.count,
      output,
    );
  }

  @override
  CoreAffinityCount decode(_i1.Input input) {
    return CoreAffinityCount(
      coreIndex: _i1.U32Codec.codec.decode(input),
      count: _i1.U32Codec.codec.decode(input),
    );
  }

  @override
  int sizeHint(CoreAffinityCount obj) {
    int size = 0;
    size = size + const _i2.CoreIndexCodec().sizeHint(obj.coreIndex);
    size = size + _i1.U32Codec.codec.sizeHint(obj.count);
    return size;
  }
}
