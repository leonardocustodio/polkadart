// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:typed_data' as _i2;

import 'package:polkadart/scale_codec.dart' as _i1;

class UnlockChunk {
  const UnlockChunk({
    required this.value,
    required this.era,
  });

  factory UnlockChunk.decode(_i1.Input input) {
    return codec.decode(input);
  }

  /// Balance
  final BigInt value;

  /// EraIndex
  final BigInt era;

  static const $UnlockChunkCodec codec = $UnlockChunkCodec();

  _i2.Uint8List encode() {
    return codec.encode(this);
  }

  Map<String, BigInt> toJson() => {
        'value': value,
        'era': era,
      };

  @override
  bool operator ==(Object other) =>
      identical(
        this,
        other,
      ) ||
      other is UnlockChunk && other.value == value && other.era == era;

  @override
  int get hashCode => Object.hash(
        value,
        era,
      );
}

class $UnlockChunkCodec with _i1.Codec<UnlockChunk> {
  const $UnlockChunkCodec();

  @override
  void encodeTo(
    UnlockChunk obj,
    _i1.Output output,
  ) {
    _i1.CompactBigIntCodec.codec.encodeTo(
      obj.value,
      output,
    );
    _i1.CompactBigIntCodec.codec.encodeTo(
      obj.era,
      output,
    );
  }

  @override
  UnlockChunk decode(_i1.Input input) {
    return UnlockChunk(
      value: _i1.CompactBigIntCodec.codec.decode(input),
      era: _i1.CompactBigIntCodec.codec.decode(input),
    );
  }

  @override
  int sizeHint(UnlockChunk obj) {
    int size = 0;
    size = size + _i1.CompactBigIntCodec.codec.sizeHint(obj.value);
    size = size + _i1.CompactBigIntCodec.codec.sizeHint(obj.era);
    return size;
  }
}
