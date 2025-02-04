// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:typed_data' as _i2;

import 'package:polkadart/scale_codec.dart' as _i1;

class ActiveEraInfo {
  const ActiveEraInfo({
    required this.index,
    this.start,
  });

  factory ActiveEraInfo.decode(_i1.Input input) {
    return codec.decode(input);
  }

  /// EraIndex
  final int index;

  /// Option<u64>
  final BigInt? start;

  static const $ActiveEraInfoCodec codec = $ActiveEraInfoCodec();

  _i2.Uint8List encode() {
    return codec.encode(this);
  }

  Map<String, dynamic> toJson() => {
        'index': index,
        'start': start,
      };

  @override
  bool operator ==(Object other) =>
      identical(
        this,
        other,
      ) ||
      other is ActiveEraInfo && other.index == index && other.start == start;

  @override
  int get hashCode => Object.hash(
        index,
        start,
      );
}

class $ActiveEraInfoCodec with _i1.Codec<ActiveEraInfo> {
  const $ActiveEraInfoCodec();

  @override
  void encodeTo(
    ActiveEraInfo obj,
    _i1.Output output,
  ) {
    _i1.U32Codec.codec.encodeTo(
      obj.index,
      output,
    );
    const _i1.OptionCodec<BigInt>(_i1.U64Codec.codec).encodeTo(
      obj.start,
      output,
    );
  }

  @override
  ActiveEraInfo decode(_i1.Input input) {
    return ActiveEraInfo(
      index: _i1.U32Codec.codec.decode(input),
      start: const _i1.OptionCodec<BigInt>(_i1.U64Codec.codec).decode(input),
    );
  }

  @override
  int sizeHint(ActiveEraInfo obj) {
    int size = 0;
    size = size + _i1.U32Codec.codec.sizeHint(obj.index);
    size = size +
        const _i1.OptionCodec<BigInt>(_i1.U64Codec.codec).sizeHint(obj.start);
    return size;
  }
}
