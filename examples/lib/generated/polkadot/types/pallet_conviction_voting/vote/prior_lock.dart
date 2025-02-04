// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:typed_data' as _i2;

import 'package:polkadart/scale_codec.dart' as _i1;

class PriorLock {
  const PriorLock(
    this.value0,
    this.value1,
  );

  factory PriorLock.decode(_i1.Input input) {
    return codec.decode(input);
  }

  /// BlockNumber
  final int value0;

  /// Balance
  final BigInt value1;

  static const $PriorLockCodec codec = $PriorLockCodec();

  _i2.Uint8List encode() {
    return codec.encode(this);
  }

  List<dynamic> toJson() => [
        value0,
        value1,
      ];

  @override
  bool operator ==(Object other) =>
      identical(
        this,
        other,
      ) ||
      other is PriorLock && other.value0 == value0 && other.value1 == value1;

  @override
  int get hashCode => Object.hash(
        value0,
        value1,
      );
}

class $PriorLockCodec with _i1.Codec<PriorLock> {
  const $PriorLockCodec();

  @override
  void encodeTo(
    PriorLock obj,
    _i1.Output output,
  ) {
    _i1.U32Codec.codec.encodeTo(
      obj.value0,
      output,
    );
    _i1.U128Codec.codec.encodeTo(
      obj.value1,
      output,
    );
  }

  @override
  PriorLock decode(_i1.Input input) {
    return PriorLock(
      _i1.U32Codec.codec.decode(input),
      _i1.U128Codec.codec.decode(input),
    );
  }

  @override
  int sizeHint(PriorLock obj) {
    int size = 0;
    size = size + _i1.U32Codec.codec.sizeHint(obj.value0);
    size = size + _i1.U128Codec.codec.sizeHint(obj.value1);
    return size;
  }
}
