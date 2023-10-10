// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:typed_data' as _i3;

import 'package:polkadart/scale_codec.dart' as _i1;
import 'package:quiver/collection.dart' as _i4;

import '../../sp_core/crypto/account_id32.dart' as _i2;

class Deposit {
  const Deposit({
    required this.who,
    required this.amount,
  });

  factory Deposit.decode(_i1.Input input) {
    return codec.decode(input);
  }

  /// AccountId
  final _i2.AccountId32 who;

  /// Balance
  final BigInt amount;

  static const $DepositCodec codec = $DepositCodec();

  _i3.Uint8List encode() {
    return codec.encode(this);
  }

  Map<String, dynamic> toJson() => {
        'who': who.toList(),
        'amount': amount,
      };

  @override
  bool operator ==(Object other) =>
      identical(
        this,
        other,
      ) ||
      other is Deposit &&
          _i4.listsEqual(
            other.who,
            who,
          ) &&
          other.amount == amount;

  @override
  int get hashCode => Object.hash(
        who,
        amount,
      );
}

class $DepositCodec with _i1.Codec<Deposit> {
  const $DepositCodec();

  @override
  void encodeTo(
    Deposit obj,
    _i1.Output output,
  ) {
    const _i1.U8ArrayCodec(32).encodeTo(
      obj.who,
      output,
    );
    _i1.U128Codec.codec.encodeTo(
      obj.amount,
      output,
    );
  }

  @override
  Deposit decode(_i1.Input input) {
    return Deposit(
      who: const _i1.U8ArrayCodec(32).decode(input),
      amount: _i1.U128Codec.codec.decode(input),
    );
  }

  @override
  int sizeHint(Deposit obj) {
    int size = 0;
    size = size + const _i2.AccountId32Codec().sizeHint(obj.who);
    size = size + _i1.U128Codec.codec.sizeHint(obj.amount);
    return size;
  }
}
