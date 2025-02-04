// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:typed_data' as _i2;

import 'package:polkadart/scale_codec.dart' as _i1;

class VestingInfo {
  const VestingInfo({
    required this.locked,
    required this.perBlock,
    required this.startingBlock,
  });

  factory VestingInfo.decode(_i1.Input input) {
    return codec.decode(input);
  }

  /// Balance
  final BigInt locked;

  /// Balance
  final BigInt perBlock;

  /// BlockNumber
  final int startingBlock;

  static const $VestingInfoCodec codec = $VestingInfoCodec();

  _i2.Uint8List encode() {
    return codec.encode(this);
  }

  Map<String, dynamic> toJson() => {
        'locked': locked,
        'perBlock': perBlock,
        'startingBlock': startingBlock,
      };

  @override
  bool operator ==(Object other) =>
      identical(
        this,
        other,
      ) ||
      other is VestingInfo &&
          other.locked == locked &&
          other.perBlock == perBlock &&
          other.startingBlock == startingBlock;

  @override
  int get hashCode => Object.hash(
        locked,
        perBlock,
        startingBlock,
      );
}

class $VestingInfoCodec with _i1.Codec<VestingInfo> {
  const $VestingInfoCodec();

  @override
  void encodeTo(
    VestingInfo obj,
    _i1.Output output,
  ) {
    _i1.U128Codec.codec.encodeTo(
      obj.locked,
      output,
    );
    _i1.U128Codec.codec.encodeTo(
      obj.perBlock,
      output,
    );
    _i1.U32Codec.codec.encodeTo(
      obj.startingBlock,
      output,
    );
  }

  @override
  VestingInfo decode(_i1.Input input) {
    return VestingInfo(
      locked: _i1.U128Codec.codec.decode(input),
      perBlock: _i1.U128Codec.codec.decode(input),
      startingBlock: _i1.U32Codec.codec.decode(input),
    );
  }

  @override
  int sizeHint(VestingInfo obj) {
    int size = 0;
    size = size + _i1.U128Codec.codec.sizeHint(obj.locked);
    size = size + _i1.U128Codec.codec.sizeHint(obj.perBlock);
    size = size + _i1.U32Codec.codec.sizeHint(obj.startingBlock);
    return size;
  }
}
