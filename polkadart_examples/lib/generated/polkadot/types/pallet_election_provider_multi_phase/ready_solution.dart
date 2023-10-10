// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:typed_data' as _i7;

import 'package:polkadart/scale_codec.dart' as _i1;
import 'package:quiver/collection.dart' as _i8;

import '../sp_core/crypto/account_id32.dart' as _i3;
import '../sp_npos_elections/election_score.dart' as _i5;
import '../sp_npos_elections/support.dart' as _i4;
import '../tuples.dart' as _i2;
import 'election_compute.dart' as _i6;

class ReadySolution {
  const ReadySolution({
    required this.supports,
    required this.score,
    required this.compute,
  });

  factory ReadySolution.decode(_i1.Input input) {
    return codec.decode(input);
  }

  /// BoundedSupports<AccountId, MaxWinners>
  final List<_i2.Tuple2<_i3.AccountId32, _i4.Support>> supports;

  /// ElectionScore
  final _i5.ElectionScore score;

  /// ElectionCompute
  final _i6.ElectionCompute compute;

  static const $ReadySolutionCodec codec = $ReadySolutionCodec();

  _i7.Uint8List encode() {
    return codec.encode(this);
  }

  Map<String, dynamic> toJson() => {
        'supports': supports
            .map((value) => [
                  value.value0.toList(),
                  value.value1.toJson(),
                ])
            .toList(),
        'score': score.toJson(),
        'compute': compute.toJson(),
      };

  @override
  bool operator ==(Object other) =>
      identical(
        this,
        other,
      ) ||
      other is ReadySolution &&
          _i8.listsEqual(
            other.supports,
            supports,
          ) &&
          other.score == score &&
          other.compute == compute;

  @override
  int get hashCode => Object.hash(
        supports,
        score,
        compute,
      );
}

class $ReadySolutionCodec with _i1.Codec<ReadySolution> {
  const $ReadySolutionCodec();

  @override
  void encodeTo(
    ReadySolution obj,
    _i1.Output output,
  ) {
    const _i1.SequenceCodec<_i2.Tuple2<_i3.AccountId32, _i4.Support>>(
        _i2.Tuple2Codec<_i3.AccountId32, _i4.Support>(
      _i3.AccountId32Codec(),
      _i4.Support.codec,
    )).encodeTo(
      obj.supports,
      output,
    );
    _i5.ElectionScore.codec.encodeTo(
      obj.score,
      output,
    );
    _i6.ElectionCompute.codec.encodeTo(
      obj.compute,
      output,
    );
  }

  @override
  ReadySolution decode(_i1.Input input) {
    return ReadySolution(
      supports:
          const _i1.SequenceCodec<_i2.Tuple2<_i3.AccountId32, _i4.Support>>(
              _i2.Tuple2Codec<_i3.AccountId32, _i4.Support>(
        _i3.AccountId32Codec(),
        _i4.Support.codec,
      )).decode(input),
      score: _i5.ElectionScore.codec.decode(input),
      compute: _i6.ElectionCompute.codec.decode(input),
    );
  }

  @override
  int sizeHint(ReadySolution obj) {
    int size = 0;
    size = size +
        const _i1.SequenceCodec<_i2.Tuple2<_i3.AccountId32, _i4.Support>>(
            _i2.Tuple2Codec<_i3.AccountId32, _i4.Support>(
          _i3.AccountId32Codec(),
          _i4.Support.codec,
        )).sizeHint(obj.supports);
    size = size + _i5.ElectionScore.codec.sizeHint(obj.score);
    size = size + _i6.ElectionCompute.codec.sizeHint(obj.compute);
    return size;
  }
}
