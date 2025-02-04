// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:typed_data' as _i3;

import 'package:polkadart/scale_codec.dart' as _i1;

import 'progress.dart' as _i2;

class MigrationTask {
  const MigrationTask({
    required this.progressTop,
    required this.progressChild,
    required this.size,
    required this.topItems,
    required this.childItems,
  });

  factory MigrationTask.decode(_i1.Input input) {
    return codec.decode(input);
  }

  /// ProgressOf<T>
  final _i2.Progress progressTop;

  /// ProgressOf<T>
  final _i2.Progress progressChild;

  /// u32
  final int size;

  /// u32
  final int topItems;

  /// u32
  final int childItems;

  static const $MigrationTaskCodec codec = $MigrationTaskCodec();

  _i3.Uint8List encode() {
    return codec.encode(this);
  }

  Map<String, dynamic> toJson() => {
        'progressTop': progressTop.toJson(),
        'progressChild': progressChild.toJson(),
        'size': size,
        'topItems': topItems,
        'childItems': childItems,
      };

  @override
  bool operator ==(Object other) =>
      identical(
        this,
        other,
      ) ||
      other is MigrationTask &&
          other.progressTop == progressTop &&
          other.progressChild == progressChild &&
          other.size == size &&
          other.topItems == topItems &&
          other.childItems == childItems;

  @override
  int get hashCode => Object.hash(
        progressTop,
        progressChild,
        size,
        topItems,
        childItems,
      );
}

class $MigrationTaskCodec with _i1.Codec<MigrationTask> {
  const $MigrationTaskCodec();

  @override
  void encodeTo(
    MigrationTask obj,
    _i1.Output output,
  ) {
    _i2.Progress.codec.encodeTo(
      obj.progressTop,
      output,
    );
    _i2.Progress.codec.encodeTo(
      obj.progressChild,
      output,
    );
    _i1.U32Codec.codec.encodeTo(
      obj.size,
      output,
    );
    _i1.U32Codec.codec.encodeTo(
      obj.topItems,
      output,
    );
    _i1.U32Codec.codec.encodeTo(
      obj.childItems,
      output,
    );
  }

  @override
  MigrationTask decode(_i1.Input input) {
    return MigrationTask(
      progressTop: _i2.Progress.codec.decode(input),
      progressChild: _i2.Progress.codec.decode(input),
      size: _i1.U32Codec.codec.decode(input),
      topItems: _i1.U32Codec.codec.decode(input),
      childItems: _i1.U32Codec.codec.decode(input),
    );
  }

  @override
  int sizeHint(MigrationTask obj) {
    int size = 0;
    size = size + _i2.Progress.codec.sizeHint(obj.progressTop);
    size = size + _i2.Progress.codec.sizeHint(obj.progressChild);
    size = size + _i1.U32Codec.codec.sizeHint(obj.size);
    size = size + _i1.U32Codec.codec.sizeHint(obj.topItems);
    size = size + _i1.U32Codec.codec.sizeHint(obj.childItems);
    return size;
  }
}
