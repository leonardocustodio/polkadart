// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:typed_data' as _i6;

import 'package:polkadart/scale_codec.dart' as _i1;
import 'package:quiver/collection.dart' as _i7;

import '../../tuples.dart' as _i2;
import '../types/delegations.dart' as _i4;
import 'account_vote.dart' as _i3;
import 'prior_lock.dart' as _i5;

class Casting {
  const Casting({
    required this.votes,
    required this.delegations,
    required this.prior,
  });

  factory Casting.decode(_i1.Input input) {
    return codec.decode(input);
  }

  /// BoundedVec<(PollIndex, AccountVote<Balance>), MaxVotes>
  final List<_i2.Tuple2<int, _i3.AccountVote>> votes;

  /// Delegations<Balance>
  final _i4.Delegations delegations;

  /// PriorLock<BlockNumber, Balance>
  final _i5.PriorLock prior;

  static const $CastingCodec codec = $CastingCodec();

  _i6.Uint8List encode() {
    return codec.encode(this);
  }

  Map<String, dynamic> toJson() => {
        'votes': votes
            .map((value) => [
                  value.value0,
                  value.value1.toJson(),
                ])
            .toList(),
        'delegations': delegations.toJson(),
        'prior': prior.toJson(),
      };

  @override
  bool operator ==(Object other) =>
      identical(
        this,
        other,
      ) ||
      other is Casting &&
          _i7.listsEqual(
            other.votes,
            votes,
          ) &&
          other.delegations == delegations &&
          other.prior == prior;

  @override
  int get hashCode => Object.hash(
        votes,
        delegations,
        prior,
      );
}

class $CastingCodec with _i1.Codec<Casting> {
  const $CastingCodec();

  @override
  void encodeTo(
    Casting obj,
    _i1.Output output,
  ) {
    const _i1.SequenceCodec<_i2.Tuple2<int, _i3.AccountVote>>(
        _i2.Tuple2Codec<int, _i3.AccountVote>(
      _i1.U32Codec.codec,
      _i3.AccountVote.codec,
    )).encodeTo(
      obj.votes,
      output,
    );
    _i4.Delegations.codec.encodeTo(
      obj.delegations,
      output,
    );
    _i5.PriorLock.codec.encodeTo(
      obj.prior,
      output,
    );
  }

  @override
  Casting decode(_i1.Input input) {
    return Casting(
      votes: const _i1.SequenceCodec<_i2.Tuple2<int, _i3.AccountVote>>(
          _i2.Tuple2Codec<int, _i3.AccountVote>(
        _i1.U32Codec.codec,
        _i3.AccountVote.codec,
      )).decode(input),
      delegations: _i4.Delegations.codec.decode(input),
      prior: _i5.PriorLock.codec.decode(input),
    );
  }

  @override
  int sizeHint(Casting obj) {
    int size = 0;
    size = size +
        const _i1.SequenceCodec<_i2.Tuple2<int, _i3.AccountVote>>(
            _i2.Tuple2Codec<int, _i3.AccountVote>(
          _i1.U32Codec.codec,
          _i3.AccountVote.codec,
        )).sizeHint(obj.votes);
    size = size + _i4.Delegations.codec.sizeHint(obj.delegations);
    size = size + _i5.PriorLock.codec.sizeHint(obj.prior);
    return size;
  }
}
