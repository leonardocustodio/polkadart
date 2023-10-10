// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:typed_data' as _i2;

import 'package:polkadart/scale_codec.dart' as _i1;

class Timepoint {
  const Timepoint({
    required this.height,
    required this.index,
  });

  factory Timepoint.decode(_i1.Input input) {
    return codec.decode(input);
  }

  /// BlockNumber
  final int height;

  /// u32
  final int index;

  static const $TimepointCodec codec = $TimepointCodec();

  _i2.Uint8List encode() {
    return codec.encode(this);
  }

  Map<String, int> toJson() => {
        'height': height,
        'index': index,
      };

  @override
  bool operator ==(Object other) =>
      identical(
        this,
        other,
      ) ||
      other is Timepoint && other.height == height && other.index == index;

  @override
  int get hashCode => Object.hash(
        height,
        index,
      );
}

class $TimepointCodec with _i1.Codec<Timepoint> {
  const $TimepointCodec();

  @override
  void encodeTo(
    Timepoint obj,
    _i1.Output output,
  ) {
    _i1.U32Codec.codec.encodeTo(
      obj.height,
      output,
    );
    _i1.U32Codec.codec.encodeTo(
      obj.index,
      output,
    );
  }

  @override
  Timepoint decode(_i1.Input input) {
    return Timepoint(
      height: _i1.U32Codec.codec.decode(input),
      index: _i1.U32Codec.codec.decode(input),
    );
  }

  @override
  int sizeHint(Timepoint obj) {
    int size = 0;
    size = size + _i1.U32Codec.codec.sizeHint(obj.height);
    size = size + _i1.U32Codec.codec.sizeHint(obj.index);
    return size;
  }
}
