// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:typed_data' as _i3;

import 'package:polkadart/scale_codec.dart' as _i1;

import 'parts_of57600.dart' as _i2;

class AssignmentState {
  const AssignmentState({
    required this.ratio,
    required this.remaining,
  });

  factory AssignmentState.decode(_i1.Input input) {
    return codec.decode(input);
  }

  /// PartsOf57600
  final _i2.PartsOf57600 ratio;

  /// PartsOf57600
  final _i2.PartsOf57600 remaining;

  static const $AssignmentStateCodec codec = $AssignmentStateCodec();

  _i3.Uint8List encode() {
    return codec.encode(this);
  }

  Map<String, int> toJson() => {
        'ratio': ratio,
        'remaining': remaining,
      };

  @override
  bool operator ==(Object other) =>
      identical(
        this,
        other,
      ) ||
      other is AssignmentState &&
          other.ratio == ratio &&
          other.remaining == remaining;

  @override
  int get hashCode => Object.hash(
        ratio,
        remaining,
      );
}

class $AssignmentStateCodec with _i1.Codec<AssignmentState> {
  const $AssignmentStateCodec();

  @override
  void encodeTo(
    AssignmentState obj,
    _i1.Output output,
  ) {
    _i1.U16Codec.codec.encodeTo(
      obj.ratio,
      output,
    );
    _i1.U16Codec.codec.encodeTo(
      obj.remaining,
      output,
    );
  }

  @override
  AssignmentState decode(_i1.Input input) {
    return AssignmentState(
      ratio: _i1.U16Codec.codec.decode(input),
      remaining: _i1.U16Codec.codec.decode(input),
    );
  }

  @override
  int sizeHint(AssignmentState obj) {
    int size = 0;
    size = size + const _i2.PartsOf57600Codec().sizeHint(obj.ratio);
    size = size + const _i2.PartsOf57600Codec().sizeHint(obj.remaining);
    return size;
  }
}
