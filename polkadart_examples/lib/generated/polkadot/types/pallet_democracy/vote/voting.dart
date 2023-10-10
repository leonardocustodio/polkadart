// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:typed_data' as _i2;

import 'package:polkadart/scale_codec.dart' as _i1;
import 'package:quiver/collection.dart' as _i9;

import '../../sp_core/crypto/account_id32.dart' as _i7;
import '../../tuples.dart' as _i3;
import '../conviction/conviction.dart' as _i8;
import '../types/delegations.dart' as _i5;
import 'account_vote.dart' as _i4;
import 'prior_lock.dart' as _i6;

abstract class Voting {
  const Voting();

  factory Voting.decode(_i1.Input input) {
    return codec.decode(input);
  }

  static const $VotingCodec codec = $VotingCodec();

  static const $Voting values = $Voting();

  _i2.Uint8List encode() {
    final output = _i1.ByteOutput(codec.sizeHint(this));
    codec.encodeTo(this, output);
    return output.toBytes();
  }

  int sizeHint() {
    return codec.sizeHint(this);
  }

  Map<String, Map<String, dynamic>> toJson();
}

class $Voting {
  const $Voting();

  Direct direct({
    required List<_i3.Tuple2<int, _i4.AccountVote>> votes,
    required _i5.Delegations delegations,
    required _i6.PriorLock prior,
  }) {
    return Direct(
      votes: votes,
      delegations: delegations,
      prior: prior,
    );
  }

  Delegating delegating({
    required BigInt balance,
    required _i7.AccountId32 target,
    required _i8.Conviction conviction,
    required _i5.Delegations delegations,
    required _i6.PriorLock prior,
  }) {
    return Delegating(
      balance: balance,
      target: target,
      conviction: conviction,
      delegations: delegations,
      prior: prior,
    );
  }
}

class $VotingCodec with _i1.Codec<Voting> {
  const $VotingCodec();

  @override
  Voting decode(_i1.Input input) {
    final index = _i1.U8Codec.codec.decode(input);
    switch (index) {
      case 0:
        return Direct._decode(input);
      case 1:
        return Delegating._decode(input);
      default:
        throw Exception('Voting: Invalid variant index: "$index"');
    }
  }

  @override
  void encodeTo(
    Voting value,
    _i1.Output output,
  ) {
    switch (value.runtimeType) {
      case Direct:
        (value as Direct).encodeTo(output);
        break;
      case Delegating:
        (value as Delegating).encodeTo(output);
        break;
      default:
        throw Exception(
            'Voting: Unsupported "$value" of type "${value.runtimeType}"');
    }
  }

  @override
  int sizeHint(Voting value) {
    switch (value.runtimeType) {
      case Direct:
        return (value as Direct)._sizeHint();
      case Delegating:
        return (value as Delegating)._sizeHint();
      default:
        throw Exception(
            'Voting: Unsupported "$value" of type "${value.runtimeType}"');
    }
  }
}

class Direct extends Voting {
  const Direct({
    required this.votes,
    required this.delegations,
    required this.prior,
  });

  factory Direct._decode(_i1.Input input) {
    return Direct(
      votes: const _i1.SequenceCodec<_i3.Tuple2<int, _i4.AccountVote>>(
          _i3.Tuple2Codec<int, _i4.AccountVote>(
        _i1.U32Codec.codec,
        _i4.AccountVote.codec,
      )).decode(input),
      delegations: _i5.Delegations.codec.decode(input),
      prior: _i6.PriorLock.codec.decode(input),
    );
  }

  /// BoundedVec<(ReferendumIndex, AccountVote<Balance>), MaxVotes>
  final List<_i3.Tuple2<int, _i4.AccountVote>> votes;

  /// Delegations<Balance>
  final _i5.Delegations delegations;

  /// PriorLock<BlockNumber, Balance>
  final _i6.PriorLock prior;

  @override
  Map<String, Map<String, dynamic>> toJson() => {
        'Direct': {
          'votes': votes
              .map((value) => [
                    value.value0,
                    value.value1.toJson(),
                  ])
              .toList(),
          'delegations': delegations.toJson(),
          'prior': prior.toJson(),
        }
      };

  int _sizeHint() {
    int size = 1;
    size = size +
        const _i1.SequenceCodec<_i3.Tuple2<int, _i4.AccountVote>>(
            _i3.Tuple2Codec<int, _i4.AccountVote>(
          _i1.U32Codec.codec,
          _i4.AccountVote.codec,
        )).sizeHint(votes);
    size = size + _i5.Delegations.codec.sizeHint(delegations);
    size = size + _i6.PriorLock.codec.sizeHint(prior);
    return size;
  }

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      0,
      output,
    );
    const _i1.SequenceCodec<_i3.Tuple2<int, _i4.AccountVote>>(
        _i3.Tuple2Codec<int, _i4.AccountVote>(
      _i1.U32Codec.codec,
      _i4.AccountVote.codec,
    )).encodeTo(
      votes,
      output,
    );
    _i5.Delegations.codec.encodeTo(
      delegations,
      output,
    );
    _i6.PriorLock.codec.encodeTo(
      prior,
      output,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(
        this,
        other,
      ) ||
      other is Direct &&
          _i9.listsEqual(
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

class Delegating extends Voting {
  const Delegating({
    required this.balance,
    required this.target,
    required this.conviction,
    required this.delegations,
    required this.prior,
  });

  factory Delegating._decode(_i1.Input input) {
    return Delegating(
      balance: _i1.U128Codec.codec.decode(input),
      target: const _i1.U8ArrayCodec(32).decode(input),
      conviction: _i8.Conviction.codec.decode(input),
      delegations: _i5.Delegations.codec.decode(input),
      prior: _i6.PriorLock.codec.decode(input),
    );
  }

  /// Balance
  final BigInt balance;

  /// AccountId
  final _i7.AccountId32 target;

  /// Conviction
  final _i8.Conviction conviction;

  /// Delegations<Balance>
  final _i5.Delegations delegations;

  /// PriorLock<BlockNumber, Balance>
  final _i6.PriorLock prior;

  @override
  Map<String, Map<String, dynamic>> toJson() => {
        'Delegating': {
          'balance': balance,
          'target': target.toList(),
          'conviction': conviction.toJson(),
          'delegations': delegations.toJson(),
          'prior': prior.toJson(),
        }
      };

  int _sizeHint() {
    int size = 1;
    size = size + _i1.U128Codec.codec.sizeHint(balance);
    size = size + const _i7.AccountId32Codec().sizeHint(target);
    size = size + _i8.Conviction.codec.sizeHint(conviction);
    size = size + _i5.Delegations.codec.sizeHint(delegations);
    size = size + _i6.PriorLock.codec.sizeHint(prior);
    return size;
  }

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      1,
      output,
    );
    _i1.U128Codec.codec.encodeTo(
      balance,
      output,
    );
    const _i1.U8ArrayCodec(32).encodeTo(
      target,
      output,
    );
    _i8.Conviction.codec.encodeTo(
      conviction,
      output,
    );
    _i5.Delegations.codec.encodeTo(
      delegations,
      output,
    );
    _i6.PriorLock.codec.encodeTo(
      prior,
      output,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(
        this,
        other,
      ) ||
      other is Delegating &&
          other.balance == balance &&
          _i9.listsEqual(
            other.target,
            target,
          ) &&
          other.conviction == conviction &&
          other.delegations == delegations &&
          other.prior == prior;

  @override
  int get hashCode => Object.hash(
        balance,
        target,
        conviction,
        delegations,
        prior,
      );
}
