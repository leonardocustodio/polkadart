// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:typed_data' as _i2;

import 'package:polkadart/scale_codec.dart' as _i1;

class UnbondPool {
  const UnbondPool({
    required this.points,
    required this.balance,
  });

  factory UnbondPool.decode(_i1.Input input) {
    return codec.decode(input);
  }

  /// BalanceOf<T>
  final BigInt points;

  /// BalanceOf<T>
  final BigInt balance;

  static const $UnbondPoolCodec codec = $UnbondPoolCodec();

  _i2.Uint8List encode() {
    return codec.encode(this);
  }

  Map<String, BigInt> toJson() => {
        'points': points,
        'balance': balance,
      };

  @override
  bool operator ==(Object other) =>
      identical(
        this,
        other,
      ) ||
      other is UnbondPool && other.points == points && other.balance == balance;

  @override
  int get hashCode => Object.hash(
        points,
        balance,
      );
}

class $UnbondPoolCodec with _i1.Codec<UnbondPool> {
  const $UnbondPoolCodec();

  @override
  void encodeTo(
    UnbondPool obj,
    _i1.Output output,
  ) {
    _i1.U128Codec.codec.encodeTo(
      obj.points,
      output,
    );
    _i1.U128Codec.codec.encodeTo(
      obj.balance,
      output,
    );
  }

  @override
  UnbondPool decode(_i1.Input input) {
    return UnbondPool(
      points: _i1.U128Codec.codec.decode(input),
      balance: _i1.U128Codec.codec.decode(input),
    );
  }

  @override
  int sizeHint(UnbondPool obj) {
    int size = 0;
    size = size + _i1.U128Codec.codec.sizeHint(obj.points);
    size = size + _i1.U128Codec.codec.sizeHint(obj.balance);
    return size;
  }
}
