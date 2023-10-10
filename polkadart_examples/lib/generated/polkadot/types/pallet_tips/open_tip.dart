// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:typed_data' as _i5;

import 'package:polkadart/scale_codec.dart' as _i1;
import 'package:quiver/collection.dart' as _i6;

import '../primitive_types/h256.dart' as _i2;
import '../sp_core/crypto/account_id32.dart' as _i3;
import '../tuples.dart' as _i4;

class OpenTip {
  const OpenTip({
    required this.reason,
    required this.who,
    required this.finder,
    required this.deposit,
    this.closes,
    required this.tips,
    required this.findersFee,
  });

  factory OpenTip.decode(_i1.Input input) {
    return codec.decode(input);
  }

  /// Hash
  final _i2.H256 reason;

  /// AccountId
  final _i3.AccountId32 who;

  /// AccountId
  final _i3.AccountId32 finder;

  /// Balance
  final BigInt deposit;

  /// Option<BlockNumber>
  final int? closes;

  /// Vec<(AccountId, Balance)>
  final List<_i4.Tuple2<_i3.AccountId32, BigInt>> tips;

  /// bool
  final bool findersFee;

  static const $OpenTipCodec codec = $OpenTipCodec();

  _i5.Uint8List encode() {
    return codec.encode(this);
  }

  Map<String, dynamic> toJson() => {
        'reason': reason.toList(),
        'who': who.toList(),
        'finder': finder.toList(),
        'deposit': deposit,
        'closes': closes,
        'tips': tips
            .map((value) => [
                  value.value0.toList(),
                  value.value1,
                ])
            .toList(),
        'findersFee': findersFee,
      };

  @override
  bool operator ==(Object other) =>
      identical(
        this,
        other,
      ) ||
      other is OpenTip &&
          _i6.listsEqual(
            other.reason,
            reason,
          ) &&
          _i6.listsEqual(
            other.who,
            who,
          ) &&
          _i6.listsEqual(
            other.finder,
            finder,
          ) &&
          other.deposit == deposit &&
          other.closes == closes &&
          _i6.listsEqual(
            other.tips,
            tips,
          ) &&
          other.findersFee == findersFee;

  @override
  int get hashCode => Object.hash(
        reason,
        who,
        finder,
        deposit,
        closes,
        tips,
        findersFee,
      );
}

class $OpenTipCodec with _i1.Codec<OpenTip> {
  const $OpenTipCodec();

  @override
  void encodeTo(
    OpenTip obj,
    _i1.Output output,
  ) {
    const _i1.U8ArrayCodec(32).encodeTo(
      obj.reason,
      output,
    );
    const _i1.U8ArrayCodec(32).encodeTo(
      obj.who,
      output,
    );
    const _i1.U8ArrayCodec(32).encodeTo(
      obj.finder,
      output,
    );
    _i1.U128Codec.codec.encodeTo(
      obj.deposit,
      output,
    );
    const _i1.OptionCodec<int>(_i1.U32Codec.codec).encodeTo(
      obj.closes,
      output,
    );
    const _i1.SequenceCodec<_i4.Tuple2<_i3.AccountId32, BigInt>>(
        _i4.Tuple2Codec<_i3.AccountId32, BigInt>(
      _i3.AccountId32Codec(),
      _i1.U128Codec.codec,
    )).encodeTo(
      obj.tips,
      output,
    );
    _i1.BoolCodec.codec.encodeTo(
      obj.findersFee,
      output,
    );
  }

  @override
  OpenTip decode(_i1.Input input) {
    return OpenTip(
      reason: const _i1.U8ArrayCodec(32).decode(input),
      who: const _i1.U8ArrayCodec(32).decode(input),
      finder: const _i1.U8ArrayCodec(32).decode(input),
      deposit: _i1.U128Codec.codec.decode(input),
      closes: const _i1.OptionCodec<int>(_i1.U32Codec.codec).decode(input),
      tips: const _i1.SequenceCodec<_i4.Tuple2<_i3.AccountId32, BigInt>>(
          _i4.Tuple2Codec<_i3.AccountId32, BigInt>(
        _i3.AccountId32Codec(),
        _i1.U128Codec.codec,
      )).decode(input),
      findersFee: _i1.BoolCodec.codec.decode(input),
    );
  }

  @override
  int sizeHint(OpenTip obj) {
    int size = 0;
    size = size + const _i2.H256Codec().sizeHint(obj.reason);
    size = size + const _i3.AccountId32Codec().sizeHint(obj.who);
    size = size + const _i3.AccountId32Codec().sizeHint(obj.finder);
    size = size + _i1.U128Codec.codec.sizeHint(obj.deposit);
    size = size +
        const _i1.OptionCodec<int>(_i1.U32Codec.codec).sizeHint(obj.closes);
    size = size +
        const _i1.SequenceCodec<_i4.Tuple2<_i3.AccountId32, BigInt>>(
            _i4.Tuple2Codec<_i3.AccountId32, BigInt>(
          _i3.AccountId32Codec(),
          _i1.U128Codec.codec,
        )).sizeHint(obj.tips);
    size = size + _i1.BoolCodec.codec.sizeHint(obj.findersFee);
    return size;
  }
}
