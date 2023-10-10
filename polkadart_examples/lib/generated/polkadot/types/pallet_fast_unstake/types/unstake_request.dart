// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:typed_data' as _i4;

import 'package:polkadart/scale_codec.dart' as _i1;
import 'package:quiver/collection.dart' as _i5;

import '../../sp_core/crypto/account_id32.dart' as _i3;
import '../../tuples.dart' as _i2;

class UnstakeRequest {
  const UnstakeRequest({
    required this.stashes,
    required this.checked,
  });

  factory UnstakeRequest.decode(_i1.Input input) {
    return codec.decode(input);
  }

  /// BoundedVec<(T::AccountId, BalanceOf<T>), T::BatchSize>
  final List<_i2.Tuple2<_i3.AccountId32, BigInt>> stashes;

  /// BoundedVec<EraIndex, MaxChecking<T>>
  final List<int> checked;

  static const $UnstakeRequestCodec codec = $UnstakeRequestCodec();

  _i4.Uint8List encode() {
    return codec.encode(this);
  }

  Map<String, List<dynamic>> toJson() => {
        'stashes': stashes
            .map((value) => [
                  value.value0.toList(),
                  value.value1,
                ])
            .toList(),
        'checked': checked,
      };

  @override
  bool operator ==(Object other) =>
      identical(
        this,
        other,
      ) ||
      other is UnstakeRequest &&
          _i5.listsEqual(
            other.stashes,
            stashes,
          ) &&
          _i5.listsEqual(
            other.checked,
            checked,
          );

  @override
  int get hashCode => Object.hash(
        stashes,
        checked,
      );
}

class $UnstakeRequestCodec with _i1.Codec<UnstakeRequest> {
  const $UnstakeRequestCodec();

  @override
  void encodeTo(
    UnstakeRequest obj,
    _i1.Output output,
  ) {
    const _i1.SequenceCodec<_i2.Tuple2<_i3.AccountId32, BigInt>>(
        _i2.Tuple2Codec<_i3.AccountId32, BigInt>(
      _i3.AccountId32Codec(),
      _i1.U128Codec.codec,
    )).encodeTo(
      obj.stashes,
      output,
    );
    _i1.U32SequenceCodec.codec.encodeTo(
      obj.checked,
      output,
    );
  }

  @override
  UnstakeRequest decode(_i1.Input input) {
    return UnstakeRequest(
      stashes: const _i1.SequenceCodec<_i2.Tuple2<_i3.AccountId32, BigInt>>(
          _i2.Tuple2Codec<_i3.AccountId32, BigInt>(
        _i3.AccountId32Codec(),
        _i1.U128Codec.codec,
      )).decode(input),
      checked: _i1.U32SequenceCodec.codec.decode(input),
    );
  }

  @override
  int sizeHint(UnstakeRequest obj) {
    int size = 0;
    size = size +
        const _i1.SequenceCodec<_i2.Tuple2<_i3.AccountId32, BigInt>>(
            _i2.Tuple2Codec<_i3.AccountId32, BigInt>(
          _i3.AccountId32Codec(),
          _i1.U128Codec.codec,
        )).sizeHint(obj.stashes);
    size = size + _i1.U32SequenceCodec.codec.sizeHint(obj.checked);
    return size;
  }
}
