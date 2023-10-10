// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:typed_data' as _i4;

import 'package:polkadart/scale_codec.dart' as _i1;
import 'package:quiver/collection.dart' as _i5;

import '../sp_core/crypto/account_id32.dart' as _i3;
import '../tuples.dart' as _i2;

class Support {
  const Support({
    required this.total,
    required this.voters,
  });

  factory Support.decode(_i1.Input input) {
    return codec.decode(input);
  }

  /// ExtendedBalance
  final BigInt total;

  /// Vec<(AccountId, ExtendedBalance)>
  final List<_i2.Tuple2<_i3.AccountId32, BigInt>> voters;

  static const $SupportCodec codec = $SupportCodec();

  _i4.Uint8List encode() {
    return codec.encode(this);
  }

  Map<String, dynamic> toJson() => {
        'total': total,
        'voters': voters
            .map((value) => [
                  value.value0.toList(),
                  value.value1,
                ])
            .toList(),
      };

  @override
  bool operator ==(Object other) =>
      identical(
        this,
        other,
      ) ||
      other is Support &&
          other.total == total &&
          _i5.listsEqual(
            other.voters,
            voters,
          );

  @override
  int get hashCode => Object.hash(
        total,
        voters,
      );
}

class $SupportCodec with _i1.Codec<Support> {
  const $SupportCodec();

  @override
  void encodeTo(
    Support obj,
    _i1.Output output,
  ) {
    _i1.U128Codec.codec.encodeTo(
      obj.total,
      output,
    );
    const _i1.SequenceCodec<_i2.Tuple2<_i3.AccountId32, BigInt>>(
        _i2.Tuple2Codec<_i3.AccountId32, BigInt>(
      _i3.AccountId32Codec(),
      _i1.U128Codec.codec,
    )).encodeTo(
      obj.voters,
      output,
    );
  }

  @override
  Support decode(_i1.Input input) {
    return Support(
      total: _i1.U128Codec.codec.decode(input),
      voters: const _i1.SequenceCodec<_i2.Tuple2<_i3.AccountId32, BigInt>>(
          _i2.Tuple2Codec<_i3.AccountId32, BigInt>(
        _i3.AccountId32Codec(),
        _i1.U128Codec.codec,
      )).decode(input),
    );
  }

  @override
  int sizeHint(Support obj) {
    int size = 0;
    size = size + _i1.U128Codec.codec.sizeHint(obj.total);
    size = size +
        const _i1.SequenceCodec<_i2.Tuple2<_i3.AccountId32, BigInt>>(
            _i2.Tuple2Codec<_i3.AccountId32, BigInt>(
          _i3.AccountId32Codec(),
          _i1.U128Codec.codec,
        )).sizeHint(obj.voters);
    return size;
  }
}
