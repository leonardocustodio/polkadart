// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:typed_data' as _i3;

import 'package:polkadart/scale_codec.dart' as _i1;
import 'package:quiver/collection.dart' as _i4;

import '../sp_core/crypto/account_id32.dart' as _i2;

class SeatHolder {
  const SeatHolder({
    required this.who,
    required this.stake,
    required this.deposit,
  });

  factory SeatHolder.decode(_i1.Input input) {
    return codec.decode(input);
  }

  /// AccountId
  final _i2.AccountId32 who;

  /// Balance
  final BigInt stake;

  /// Balance
  final BigInt deposit;

  static const $SeatHolderCodec codec = $SeatHolderCodec();

  _i3.Uint8List encode() {
    return codec.encode(this);
  }

  Map<String, dynamic> toJson() => {
        'who': who.toList(),
        'stake': stake,
        'deposit': deposit,
      };

  @override
  bool operator ==(Object other) =>
      identical(
        this,
        other,
      ) ||
      other is SeatHolder &&
          _i4.listsEqual(
            other.who,
            who,
          ) &&
          other.stake == stake &&
          other.deposit == deposit;

  @override
  int get hashCode => Object.hash(
        who,
        stake,
        deposit,
      );
}

class $SeatHolderCodec with _i1.Codec<SeatHolder> {
  const $SeatHolderCodec();

  @override
  void encodeTo(
    SeatHolder obj,
    _i1.Output output,
  ) {
    const _i1.U8ArrayCodec(32).encodeTo(
      obj.who,
      output,
    );
    _i1.U128Codec.codec.encodeTo(
      obj.stake,
      output,
    );
    _i1.U128Codec.codec.encodeTo(
      obj.deposit,
      output,
    );
  }

  @override
  SeatHolder decode(_i1.Input input) {
    return SeatHolder(
      who: const _i1.U8ArrayCodec(32).decode(input),
      stake: _i1.U128Codec.codec.decode(input),
      deposit: _i1.U128Codec.codec.decode(input),
    );
  }

  @override
  int sizeHint(SeatHolder obj) {
    int size = 0;
    size = size + const _i2.AccountId32Codec().sizeHint(obj.who);
    size = size + _i1.U128Codec.codec.sizeHint(obj.stake);
    size = size + _i1.U128Codec.codec.sizeHint(obj.deposit);
    return size;
  }
}
