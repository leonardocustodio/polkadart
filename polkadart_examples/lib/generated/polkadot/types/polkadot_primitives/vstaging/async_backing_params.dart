// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:typed_data' as _i2;

import 'package:polkadart/scale_codec.dart' as _i1;

class AsyncBackingParams {
  const AsyncBackingParams({
    required this.maxCandidateDepth,
    required this.allowedAncestryLen,
  });

  factory AsyncBackingParams.decode(_i1.Input input) {
    return codec.decode(input);
  }

  /// u32
  final int maxCandidateDepth;

  /// u32
  final int allowedAncestryLen;

  static const $AsyncBackingParamsCodec codec = $AsyncBackingParamsCodec();

  _i2.Uint8List encode() {
    return codec.encode(this);
  }

  Map<String, int> toJson() => {
        'maxCandidateDepth': maxCandidateDepth,
        'allowedAncestryLen': allowedAncestryLen,
      };

  @override
  bool operator ==(Object other) =>
      identical(
        this,
        other,
      ) ||
      other is AsyncBackingParams &&
          other.maxCandidateDepth == maxCandidateDepth &&
          other.allowedAncestryLen == allowedAncestryLen;

  @override
  int get hashCode => Object.hash(
        maxCandidateDepth,
        allowedAncestryLen,
      );
}

class $AsyncBackingParamsCodec with _i1.Codec<AsyncBackingParams> {
  const $AsyncBackingParamsCodec();

  @override
  void encodeTo(
    AsyncBackingParams obj,
    _i1.Output output,
  ) {
    _i1.U32Codec.codec.encodeTo(
      obj.maxCandidateDepth,
      output,
    );
    _i1.U32Codec.codec.encodeTo(
      obj.allowedAncestryLen,
      output,
    );
  }

  @override
  AsyncBackingParams decode(_i1.Input input) {
    return AsyncBackingParams(
      maxCandidateDepth: _i1.U32Codec.codec.decode(input),
      allowedAncestryLen: _i1.U32Codec.codec.decode(input),
    );
  }

  @override
  int sizeHint(AsyncBackingParams obj) {
    int size = 0;
    size = size + _i1.U32Codec.codec.sizeHint(obj.maxCandidateDepth);
    size = size + _i1.U32Codec.codec.sizeHint(obj.allowedAncestryLen);
    return size;
  }
}
