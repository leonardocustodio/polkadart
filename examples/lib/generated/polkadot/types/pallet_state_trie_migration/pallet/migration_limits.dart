// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:typed_data' as _i2;

import 'package:polkadart/scale_codec.dart' as _i1;

class MigrationLimits {
  const MigrationLimits({
    required this.size,
    required this.item,
  });

  factory MigrationLimits.decode(_i1.Input input) {
    return codec.decode(input);
  }

  /// u32
  final int size;

  /// u32
  final int item;

  static const $MigrationLimitsCodec codec = $MigrationLimitsCodec();

  _i2.Uint8List encode() {
    return codec.encode(this);
  }

  Map<String, int> toJson() => {
        'size': size,
        'item': item,
      };

  @override
  bool operator ==(Object other) =>
      identical(
        this,
        other,
      ) ||
      other is MigrationLimits && other.size == size && other.item == item;

  @override
  int get hashCode => Object.hash(
        size,
        item,
      );
}

class $MigrationLimitsCodec with _i1.Codec<MigrationLimits> {
  const $MigrationLimitsCodec();

  @override
  void encodeTo(
    MigrationLimits obj,
    _i1.Output output,
  ) {
    _i1.U32Codec.codec.encodeTo(
      obj.size,
      output,
    );
    _i1.U32Codec.codec.encodeTo(
      obj.item,
      output,
    );
  }

  @override
  MigrationLimits decode(_i1.Input input) {
    return MigrationLimits(
      size: _i1.U32Codec.codec.decode(input),
      item: _i1.U32Codec.codec.decode(input),
    );
  }

  @override
  int sizeHint(MigrationLimits obj) {
    int size = 0;
    size = size + _i1.U32Codec.codec.sizeHint(obj.size);
    size = size + _i1.U32Codec.codec.sizeHint(obj.item);
    return size;
  }
}
