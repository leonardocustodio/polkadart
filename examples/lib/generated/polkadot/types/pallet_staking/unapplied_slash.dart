// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:typed_data' as _i4;

import 'package:polkadart/scale_codec.dart' as _i1;
import 'package:quiver/collection.dart' as _i5;

import '../sp_core/crypto/account_id32.dart' as _i2;
import '../tuples.dart' as _i3;

class UnappliedSlash {
  const UnappliedSlash({
    required this.validator,
    required this.own,
    required this.others,
    required this.reporters,
    required this.payout,
  });

  factory UnappliedSlash.decode(_i1.Input input) {
    return codec.decode(input);
  }

  /// AccountId
  final _i2.AccountId32 validator;

  /// Balance
  final BigInt own;

  /// Vec<(AccountId, Balance)>
  final List<_i3.Tuple2<_i2.AccountId32, BigInt>> others;

  /// Vec<AccountId>
  final List<_i2.AccountId32> reporters;

  /// Balance
  final BigInt payout;

  static const $UnappliedSlashCodec codec = $UnappliedSlashCodec();

  _i4.Uint8List encode() {
    return codec.encode(this);
  }

  Map<String, dynamic> toJson() => {
        'validator': validator.toList(),
        'own': own,
        'others': others
            .map((value) => [
                  value.value0.toList(),
                  value.value1,
                ])
            .toList(),
        'reporters': reporters.map((value) => value.toList()).toList(),
        'payout': payout,
      };

  @override
  bool operator ==(Object other) =>
      identical(
        this,
        other,
      ) ||
      other is UnappliedSlash &&
          _i5.listsEqual(
            other.validator,
            validator,
          ) &&
          other.own == own &&
          _i5.listsEqual(
            other.others,
            others,
          ) &&
          _i5.listsEqual(
            other.reporters,
            reporters,
          ) &&
          other.payout == payout;

  @override
  int get hashCode => Object.hash(
        validator,
        own,
        others,
        reporters,
        payout,
      );
}

class $UnappliedSlashCodec with _i1.Codec<UnappliedSlash> {
  const $UnappliedSlashCodec();

  @override
  void encodeTo(
    UnappliedSlash obj,
    _i1.Output output,
  ) {
    const _i1.U8ArrayCodec(32).encodeTo(
      obj.validator,
      output,
    );
    _i1.U128Codec.codec.encodeTo(
      obj.own,
      output,
    );
    const _i1.SequenceCodec<_i3.Tuple2<_i2.AccountId32, BigInt>>(
        _i3.Tuple2Codec<_i2.AccountId32, BigInt>(
      _i2.AccountId32Codec(),
      _i1.U128Codec.codec,
    )).encodeTo(
      obj.others,
      output,
    );
    const _i1.SequenceCodec<_i2.AccountId32>(_i2.AccountId32Codec()).encodeTo(
      obj.reporters,
      output,
    );
    _i1.U128Codec.codec.encodeTo(
      obj.payout,
      output,
    );
  }

  @override
  UnappliedSlash decode(_i1.Input input) {
    return UnappliedSlash(
      validator: const _i1.U8ArrayCodec(32).decode(input),
      own: _i1.U128Codec.codec.decode(input),
      others: const _i1.SequenceCodec<_i3.Tuple2<_i2.AccountId32, BigInt>>(
          _i3.Tuple2Codec<_i2.AccountId32, BigInt>(
        _i2.AccountId32Codec(),
        _i1.U128Codec.codec,
      )).decode(input),
      reporters:
          const _i1.SequenceCodec<_i2.AccountId32>(_i2.AccountId32Codec())
              .decode(input),
      payout: _i1.U128Codec.codec.decode(input),
    );
  }

  @override
  int sizeHint(UnappliedSlash obj) {
    int size = 0;
    size = size + const _i2.AccountId32Codec().sizeHint(obj.validator);
    size = size + _i1.U128Codec.codec.sizeHint(obj.own);
    size = size +
        const _i1.SequenceCodec<_i3.Tuple2<_i2.AccountId32, BigInt>>(
            _i3.Tuple2Codec<_i2.AccountId32, BigInt>(
          _i2.AccountId32Codec(),
          _i1.U128Codec.codec,
        )).sizeHint(obj.others);
    size = size +
        const _i1.SequenceCodec<_i2.AccountId32>(_i2.AccountId32Codec())
            .sizeHint(obj.reporters);
    size = size + _i1.U128Codec.codec.sizeHint(obj.payout);
    return size;
  }
}
