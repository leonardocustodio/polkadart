// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:typed_data' as _i3;

import 'package:polkadart/scale_codec.dart' as _i1;

import 'child_bounty_status.dart' as _i2;

class ChildBounty {
  const ChildBounty({
    required this.parentBounty,
    required this.value,
    required this.fee,
    required this.curatorDeposit,
    required this.status,
  });

  factory ChildBounty.decode(_i1.Input input) {
    return codec.decode(input);
  }

  /// BountyIndex
  final int parentBounty;

  /// Balance
  final BigInt value;

  /// Balance
  final BigInt fee;

  /// Balance
  final BigInt curatorDeposit;

  /// ChildBountyStatus<AccountId, BlockNumber>
  final _i2.ChildBountyStatus status;

  static const $ChildBountyCodec codec = $ChildBountyCodec();

  _i3.Uint8List encode() {
    return codec.encode(this);
  }

  Map<String, dynamic> toJson() => {
        'parentBounty': parentBounty,
        'value': value,
        'fee': fee,
        'curatorDeposit': curatorDeposit,
        'status': status.toJson(),
      };

  @override
  bool operator ==(Object other) =>
      identical(
        this,
        other,
      ) ||
      other is ChildBounty &&
          other.parentBounty == parentBounty &&
          other.value == value &&
          other.fee == fee &&
          other.curatorDeposit == curatorDeposit &&
          other.status == status;

  @override
  int get hashCode => Object.hash(
        parentBounty,
        value,
        fee,
        curatorDeposit,
        status,
      );
}

class $ChildBountyCodec with _i1.Codec<ChildBounty> {
  const $ChildBountyCodec();

  @override
  void encodeTo(
    ChildBounty obj,
    _i1.Output output,
  ) {
    _i1.U32Codec.codec.encodeTo(
      obj.parentBounty,
      output,
    );
    _i1.U128Codec.codec.encodeTo(
      obj.value,
      output,
    );
    _i1.U128Codec.codec.encodeTo(
      obj.fee,
      output,
    );
    _i1.U128Codec.codec.encodeTo(
      obj.curatorDeposit,
      output,
    );
    _i2.ChildBountyStatus.codec.encodeTo(
      obj.status,
      output,
    );
  }

  @override
  ChildBounty decode(_i1.Input input) {
    return ChildBounty(
      parentBounty: _i1.U32Codec.codec.decode(input),
      value: _i1.U128Codec.codec.decode(input),
      fee: _i1.U128Codec.codec.decode(input),
      curatorDeposit: _i1.U128Codec.codec.decode(input),
      status: _i2.ChildBountyStatus.codec.decode(input),
    );
  }

  @override
  int sizeHint(ChildBounty obj) {
    int size = 0;
    size = size + _i1.U32Codec.codec.sizeHint(obj.parentBounty);
    size = size + _i1.U128Codec.codec.sizeHint(obj.value);
    size = size + _i1.U128Codec.codec.sizeHint(obj.fee);
    size = size + _i1.U128Codec.codec.sizeHint(obj.curatorDeposit);
    size = size + _i2.ChildBountyStatus.codec.sizeHint(obj.status);
    return size;
  }
}
