// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:typed_data' as _i2;

import 'package:polkadart/scale_codec.dart' as _i1;

class ApprovalVotingParams {
  const ApprovalVotingParams({required this.maxApprovalCoalesceCount});

  factory ApprovalVotingParams.decode(_i1.Input input) {
    return codec.decode(input);
  }

  /// u32
  final int maxApprovalCoalesceCount;

  static const $ApprovalVotingParamsCodec codec = $ApprovalVotingParamsCodec();

  _i2.Uint8List encode() {
    return codec.encode(this);
  }

  Map<String, int> toJson() =>
      {'maxApprovalCoalesceCount': maxApprovalCoalesceCount};

  @override
  bool operator ==(Object other) =>
      identical(
        this,
        other,
      ) ||
      other is ApprovalVotingParams &&
          other.maxApprovalCoalesceCount == maxApprovalCoalesceCount;

  @override
  int get hashCode => maxApprovalCoalesceCount.hashCode;
}

class $ApprovalVotingParamsCodec with _i1.Codec<ApprovalVotingParams> {
  const $ApprovalVotingParamsCodec();

  @override
  void encodeTo(
    ApprovalVotingParams obj,
    _i1.Output output,
  ) {
    _i1.U32Codec.codec.encodeTo(
      obj.maxApprovalCoalesceCount,
      output,
    );
  }

  @override
  ApprovalVotingParams decode(_i1.Input input) {
    return ApprovalVotingParams(
        maxApprovalCoalesceCount: _i1.U32Codec.codec.decode(input));
  }

  @override
  int sizeHint(ApprovalVotingParams obj) {
    int size = 0;
    size = size + _i1.U32Codec.codec.sizeHint(obj.maxApprovalCoalesceCount);
    return size;
  }
}
