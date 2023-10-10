// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:typed_data' as _i4;

import 'package:polkadart/scale_codec.dart' as _i1;
import 'package:quiver/collection.dart' as _i5;

import '../sp_core/crypto/account_id32.dart' as _i3;
import '../tuples.dart' as _i2;

class RoundSnapshot {
  const RoundSnapshot({
    required this.voters,
    required this.targets,
  });

  factory RoundSnapshot.decode(_i1.Input input) {
    return codec.decode(input);
  }

  /// Vec<DataProvider>
  final List<_i2.Tuple3<_i3.AccountId32, BigInt, List<_i3.AccountId32>>> voters;

  /// Vec<AccountId>
  final List<_i3.AccountId32> targets;

  static const $RoundSnapshotCodec codec = $RoundSnapshotCodec();

  _i4.Uint8List encode() {
    return codec.encode(this);
  }

  Map<String, List<List<dynamic>>> toJson() => {
        'voters': voters
            .map((value) => [
                  value.value0.toList(),
                  value.value1,
                  value.value2.map((value) => value.toList()).toList(),
                ])
            .toList(),
        'targets': targets.map((value) => value.toList()).toList(),
      };

  @override
  bool operator ==(Object other) =>
      identical(
        this,
        other,
      ) ||
      other is RoundSnapshot &&
          _i5.listsEqual(
            other.voters,
            voters,
          ) &&
          _i5.listsEqual(
            other.targets,
            targets,
          );

  @override
  int get hashCode => Object.hash(
        voters,
        targets,
      );
}

class $RoundSnapshotCodec with _i1.Codec<RoundSnapshot> {
  const $RoundSnapshotCodec();

  @override
  void encodeTo(
    RoundSnapshot obj,
    _i1.Output output,
  ) {
    const _i1.SequenceCodec<
            _i2.Tuple3<_i3.AccountId32, BigInt, List<_i3.AccountId32>>>(
        _i2.Tuple3Codec<_i3.AccountId32, BigInt, List<_i3.AccountId32>>(
      _i3.AccountId32Codec(),
      _i1.U64Codec.codec,
      _i1.SequenceCodec<_i3.AccountId32>(_i3.AccountId32Codec()),
    )).encodeTo(
      obj.voters,
      output,
    );
    const _i1.SequenceCodec<_i3.AccountId32>(_i3.AccountId32Codec()).encodeTo(
      obj.targets,
      output,
    );
  }

  @override
  RoundSnapshot decode(_i1.Input input) {
    return RoundSnapshot(
      voters: const _i1.SequenceCodec<
              _i2.Tuple3<_i3.AccountId32, BigInt, List<_i3.AccountId32>>>(
          _i2.Tuple3Codec<_i3.AccountId32, BigInt, List<_i3.AccountId32>>(
        _i3.AccountId32Codec(),
        _i1.U64Codec.codec,
        _i1.SequenceCodec<_i3.AccountId32>(_i3.AccountId32Codec()),
      )).decode(input),
      targets: const _i1.SequenceCodec<_i3.AccountId32>(_i3.AccountId32Codec())
          .decode(input),
    );
  }

  @override
  int sizeHint(RoundSnapshot obj) {
    int size = 0;
    size = size +
        const _i1.SequenceCodec<
                _i2.Tuple3<_i3.AccountId32, BigInt, List<_i3.AccountId32>>>(
            _i2.Tuple3Codec<_i3.AccountId32, BigInt, List<_i3.AccountId32>>(
          _i3.AccountId32Codec(),
          _i1.U64Codec.codec,
          _i1.SequenceCodec<_i3.AccountId32>(_i3.AccountId32Codec()),
        )).sizeHint(obj.voters);
    size = size +
        const _i1.SequenceCodec<_i3.AccountId32>(_i3.AccountId32Codec())
            .sizeHint(obj.targets);
    return size;
  }
}
