// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:typed_data' as _i2;

import 'package:polkadart/scale_codec.dart' as _i1;

class ReplacementTimes {
  const ReplacementTimes({
    required this.expectedAt,
    required this.activatedAt,
  });

  factory ReplacementTimes.decode(_i1.Input input) {
    return codec.decode(input);
  }

  /// N
  final int expectedAt;

  /// N
  final int activatedAt;

  static const $ReplacementTimesCodec codec = $ReplacementTimesCodec();

  _i2.Uint8List encode() {
    return codec.encode(this);
  }

  Map<String, int> toJson() => {
        'expectedAt': expectedAt,
        'activatedAt': activatedAt,
      };

  @override
  bool operator ==(Object other) =>
      identical(
        this,
        other,
      ) ||
      other is ReplacementTimes &&
          other.expectedAt == expectedAt &&
          other.activatedAt == activatedAt;

  @override
  int get hashCode => Object.hash(
        expectedAt,
        activatedAt,
      );
}

class $ReplacementTimesCodec with _i1.Codec<ReplacementTimes> {
  const $ReplacementTimesCodec();

  @override
  void encodeTo(
    ReplacementTimes obj,
    _i1.Output output,
  ) {
    _i1.U32Codec.codec.encodeTo(
      obj.expectedAt,
      output,
    );
    _i1.U32Codec.codec.encodeTo(
      obj.activatedAt,
      output,
    );
  }

  @override
  ReplacementTimes decode(_i1.Input input) {
    return ReplacementTimes(
      expectedAt: _i1.U32Codec.codec.decode(input),
      activatedAt: _i1.U32Codec.codec.decode(input),
    );
  }

  @override
  int sizeHint(ReplacementTimes obj) {
    int size = 0;
    size = size + _i1.U32Codec.codec.sizeHint(obj.expectedAt);
    size = size + _i1.U32Codec.codec.sizeHint(obj.activatedAt);
    return size;
  }
}
