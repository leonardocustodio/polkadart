// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:typed_data' as _i4;

import 'package:polkadart/scale_codec.dart' as _i1;
import 'package:quiver/collection.dart' as _i5;

import '../sp_core/crypto/account_id32.dart' as _i2;
import 'bounty_status.dart' as _i3;

class Bounty {
  const Bounty({
    required this.proposer,
    required this.value,
    required this.fee,
    required this.curatorDeposit,
    required this.bond,
    required this.status,
  });

  factory Bounty.decode(_i1.Input input) {
    return codec.decode(input);
  }

  /// AccountId
  final _i2.AccountId32 proposer;

  /// Balance
  final BigInt value;

  /// Balance
  final BigInt fee;

  /// Balance
  final BigInt curatorDeposit;

  /// Balance
  final BigInt bond;

  /// BountyStatus<AccountId, BlockNumber>
  final _i3.BountyStatus status;

  static const $BountyCodec codec = $BountyCodec();

  _i4.Uint8List encode() {
    return codec.encode(this);
  }

  Map<String, dynamic> toJson() => {
        'proposer': proposer.toList(),
        'value': value,
        'fee': fee,
        'curatorDeposit': curatorDeposit,
        'bond': bond,
        'status': status.toJson(),
      };

  @override
  bool operator ==(Object other) =>
      identical(
        this,
        other,
      ) ||
      other is Bounty &&
          _i5.listsEqual(
            other.proposer,
            proposer,
          ) &&
          other.value == value &&
          other.fee == fee &&
          other.curatorDeposit == curatorDeposit &&
          other.bond == bond &&
          other.status == status;

  @override
  int get hashCode => Object.hash(
        proposer,
        value,
        fee,
        curatorDeposit,
        bond,
        status,
      );
}

class $BountyCodec with _i1.Codec<Bounty> {
  const $BountyCodec();

  @override
  void encodeTo(
    Bounty obj,
    _i1.Output output,
  ) {
    const _i1.U8ArrayCodec(32).encodeTo(
      obj.proposer,
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
    _i1.U128Codec.codec.encodeTo(
      obj.bond,
      output,
    );
    _i3.BountyStatus.codec.encodeTo(
      obj.status,
      output,
    );
  }

  @override
  Bounty decode(_i1.Input input) {
    return Bounty(
      proposer: const _i1.U8ArrayCodec(32).decode(input),
      value: _i1.U128Codec.codec.decode(input),
      fee: _i1.U128Codec.codec.decode(input),
      curatorDeposit: _i1.U128Codec.codec.decode(input),
      bond: _i1.U128Codec.codec.decode(input),
      status: _i3.BountyStatus.codec.decode(input),
    );
  }

  @override
  int sizeHint(Bounty obj) {
    int size = 0;
    size = size + const _i2.AccountId32Codec().sizeHint(obj.proposer);
    size = size + _i1.U128Codec.codec.sizeHint(obj.value);
    size = size + _i1.U128Codec.codec.sizeHint(obj.fee);
    size = size + _i1.U128Codec.codec.sizeHint(obj.curatorDeposit);
    size = size + _i1.U128Codec.codec.sizeHint(obj.bond);
    size = size + _i3.BountyStatus.codec.sizeHint(obj.status);
    return size;
  }
}
