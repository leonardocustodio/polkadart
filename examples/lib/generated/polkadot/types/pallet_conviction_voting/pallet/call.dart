// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:typed_data' as _i2;

import 'package:polkadart/scale_codec.dart' as _i1;

import '../../sp_runtime/multiaddress/multi_address.dart' as _i4;
import '../conviction/conviction.dart' as _i5;
import '../vote/account_vote.dart' as _i3;

/// Contains a variant per dispatchable extrinsic that this pallet has.
abstract class Call {
  const Call();

  factory Call.decode(_i1.Input input) {
    return codec.decode(input);
  }

  static const $CallCodec codec = $CallCodec();

  static const $Call values = $Call();

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

class $Call {
  const $Call();

  Vote vote({
    required BigInt pollIndex,
    required _i3.AccountVote vote,
  }) {
    return Vote(
      pollIndex: pollIndex,
      vote: vote,
    );
  }

  Delegate delegate({
    required int class_,
    required _i4.MultiAddress to,
    required _i5.Conviction conviction,
    required BigInt balance,
  }) {
    return Delegate(
      class_: class_,
      to: to,
      conviction: conviction,
      balance: balance,
    );
  }

  Undelegate undelegate({required int class_}) {
    return Undelegate(class_: class_);
  }

  Unlock unlock({
    required int class_,
    required _i4.MultiAddress target,
  }) {
    return Unlock(
      class_: class_,
      target: target,
    );
  }

  RemoveVote removeVote({
    int? class_,
    required int index,
  }) {
    return RemoveVote(
      class_: class_,
      index: index,
    );
  }

  RemoveOtherVote removeOtherVote({
    required _i4.MultiAddress target,
    required int class_,
    required int index,
  }) {
    return RemoveOtherVote(
      target: target,
      class_: class_,
      index: index,
    );
  }
}

class $CallCodec with _i1.Codec<Call> {
  const $CallCodec();

  @override
  Call decode(_i1.Input input) {
    final index = _i1.U8Codec.codec.decode(input);
    switch (index) {
      case 0:
        return Vote._decode(input);
      case 1:
        return Delegate._decode(input);
      case 2:
        return Undelegate._decode(input);
      case 3:
        return Unlock._decode(input);
      case 4:
        return RemoveVote._decode(input);
      case 5:
        return RemoveOtherVote._decode(input);
      default:
        throw Exception('Call: Invalid variant index: "$index"');
    }
  }

  @override
  void encodeTo(
    Call value,
    _i1.Output output,
  ) {
    switch (value.runtimeType) {
      case Vote:
        (value as Vote).encodeTo(output);
        break;
      case Delegate:
        (value as Delegate).encodeTo(output);
        break;
      case Undelegate:
        (value as Undelegate).encodeTo(output);
        break;
      case Unlock:
        (value as Unlock).encodeTo(output);
        break;
      case RemoveVote:
        (value as RemoveVote).encodeTo(output);
        break;
      case RemoveOtherVote:
        (value as RemoveOtherVote).encodeTo(output);
        break;
      default:
        throw Exception(
            'Call: Unsupported "$value" of type "${value.runtimeType}"');
    }
  }

  @override
  int sizeHint(Call value) {
    switch (value.runtimeType) {
      case Vote:
        return (value as Vote)._sizeHint();
      case Delegate:
        return (value as Delegate)._sizeHint();
      case Undelegate:
        return (value as Undelegate)._sizeHint();
      case Unlock:
        return (value as Unlock)._sizeHint();
      case RemoveVote:
        return (value as RemoveVote)._sizeHint();
      case RemoveOtherVote:
        return (value as RemoveOtherVote)._sizeHint();
      default:
        throw Exception(
            'Call: Unsupported "$value" of type "${value.runtimeType}"');
    }
  }
}

/// Vote in a poll. If `vote.is_aye()`, the vote is to enact the proposal;
/// otherwise it is a vote to keep the status quo.
///
/// The dispatch origin of this call must be _Signed_.
///
/// - `poll_index`: The index of the poll to vote for.
/// - `vote`: The vote configuration.
///
/// Weight: `O(R)` where R is the number of polls the voter has voted on.
class Vote extends Call {
  const Vote({
    required this.pollIndex,
    required this.vote,
  });

  factory Vote._decode(_i1.Input input) {
    return Vote(
      pollIndex: _i1.CompactBigIntCodec.codec.decode(input),
      vote: _i3.AccountVote.codec.decode(input),
    );
  }

  /// PollIndexOf<T, I>
  final BigInt pollIndex;

  /// AccountVote<BalanceOf<T, I>>
  final _i3.AccountVote vote;

  @override
  Map<String, Map<String, dynamic>> toJson() => {
        'vote': {
          'pollIndex': pollIndex,
          'vote': vote.toJson(),
        }
      };

  int _sizeHint() {
    int size = 1;
    size = size + _i1.CompactBigIntCodec.codec.sizeHint(pollIndex);
    size = size + _i3.AccountVote.codec.sizeHint(vote);
    return size;
  }

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      0,
      output,
    );
    _i1.CompactBigIntCodec.codec.encodeTo(
      pollIndex,
      output,
    );
    _i3.AccountVote.codec.encodeTo(
      vote,
      output,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(
        this,
        other,
      ) ||
      other is Vote && other.pollIndex == pollIndex && other.vote == vote;

  @override
  int get hashCode => Object.hash(
        pollIndex,
        vote,
      );
}

/// Delegate the voting power (with some given conviction) of the sending account for a
/// particular class of polls.
///
/// The balance delegated is locked for as long as it's delegated, and thereafter for the
/// time appropriate for the conviction's lock period.
///
/// The dispatch origin of this call must be _Signed_, and the signing account must either:
///  - be delegating already; or
///  - have no voting activity (if there is, then it will need to be removed through
///    `remove_vote`).
///
/// - `to`: The account whose voting the `target` account's voting power will follow.
/// - `class`: The class of polls to delegate. To delegate multiple classes, multiple calls
///  to this function are required.
/// - `conviction`: The conviction that will be attached to the delegated votes. When the
///  account is undelegated, the funds will be locked for the corresponding period.
/// - `balance`: The amount of the account's balance to be used in delegating. This must not
///  be more than the account's current balance.
///
/// Emits `Delegated`.
///
/// Weight: `O(R)` where R is the number of polls the voter delegating to has
///  voted on. Weight is initially charged as if maximum votes, but is refunded later.
class Delegate extends Call {
  const Delegate({
    required this.class_,
    required this.to,
    required this.conviction,
    required this.balance,
  });

  factory Delegate._decode(_i1.Input input) {
    return Delegate(
      class_: _i1.U16Codec.codec.decode(input),
      to: _i4.MultiAddress.codec.decode(input),
      conviction: _i5.Conviction.codec.decode(input),
      balance: _i1.U128Codec.codec.decode(input),
    );
  }

  /// ClassOf<T, I>
  final int class_;

  /// AccountIdLookupOf<T>
  final _i4.MultiAddress to;

  /// Conviction
  final _i5.Conviction conviction;

  /// BalanceOf<T, I>
  final BigInt balance;

  @override
  Map<String, Map<String, dynamic>> toJson() => {
        'delegate': {
          'class': class_,
          'to': to.toJson(),
          'conviction': conviction.toJson(),
          'balance': balance,
        }
      };

  int _sizeHint() {
    int size = 1;
    size = size + _i1.U16Codec.codec.sizeHint(class_);
    size = size + _i4.MultiAddress.codec.sizeHint(to);
    size = size + _i5.Conviction.codec.sizeHint(conviction);
    size = size + _i1.U128Codec.codec.sizeHint(balance);
    return size;
  }

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      1,
      output,
    );
    _i1.U16Codec.codec.encodeTo(
      class_,
      output,
    );
    _i4.MultiAddress.codec.encodeTo(
      to,
      output,
    );
    _i5.Conviction.codec.encodeTo(
      conviction,
      output,
    );
    _i1.U128Codec.codec.encodeTo(
      balance,
      output,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(
        this,
        other,
      ) ||
      other is Delegate &&
          other.class_ == class_ &&
          other.to == to &&
          other.conviction == conviction &&
          other.balance == balance;

  @override
  int get hashCode => Object.hash(
        class_,
        to,
        conviction,
        balance,
      );
}

/// Undelegate the voting power of the sending account for a particular class of polls.
///
/// Tokens may be unlocked following once an amount of time consistent with the lock period
/// of the conviction with which the delegation was issued has passed.
///
/// The dispatch origin of this call must be _Signed_ and the signing account must be
/// currently delegating.
///
/// - `class`: The class of polls to remove the delegation from.
///
/// Emits `Undelegated`.
///
/// Weight: `O(R)` where R is the number of polls the voter delegating to has
///  voted on. Weight is initially charged as if maximum votes, but is refunded later.
class Undelegate extends Call {
  const Undelegate({required this.class_});

  factory Undelegate._decode(_i1.Input input) {
    return Undelegate(class_: _i1.U16Codec.codec.decode(input));
  }

  /// ClassOf<T, I>
  final int class_;

  @override
  Map<String, Map<String, int>> toJson() => {
        'undelegate': {'class': class_}
      };

  int _sizeHint() {
    int size = 1;
    size = size + _i1.U16Codec.codec.sizeHint(class_);
    return size;
  }

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      2,
      output,
    );
    _i1.U16Codec.codec.encodeTo(
      class_,
      output,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(
        this,
        other,
      ) ||
      other is Undelegate && other.class_ == class_;

  @override
  int get hashCode => class_.hashCode;
}

/// Remove the lock caused by prior voting/delegating which has expired within a particular
/// class.
///
/// The dispatch origin of this call must be _Signed_.
///
/// - `class`: The class of polls to unlock.
/// - `target`: The account to remove the lock on.
///
/// Weight: `O(R)` with R number of vote of target.
class Unlock extends Call {
  const Unlock({
    required this.class_,
    required this.target,
  });

  factory Unlock._decode(_i1.Input input) {
    return Unlock(
      class_: _i1.U16Codec.codec.decode(input),
      target: _i4.MultiAddress.codec.decode(input),
    );
  }

  /// ClassOf<T, I>
  final int class_;

  /// AccountIdLookupOf<T>
  final _i4.MultiAddress target;

  @override
  Map<String, Map<String, dynamic>> toJson() => {
        'unlock': {
          'class': class_,
          'target': target.toJson(),
        }
      };

  int _sizeHint() {
    int size = 1;
    size = size + _i1.U16Codec.codec.sizeHint(class_);
    size = size + _i4.MultiAddress.codec.sizeHint(target);
    return size;
  }

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      3,
      output,
    );
    _i1.U16Codec.codec.encodeTo(
      class_,
      output,
    );
    _i4.MultiAddress.codec.encodeTo(
      target,
      output,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(
        this,
        other,
      ) ||
      other is Unlock && other.class_ == class_ && other.target == target;

  @override
  int get hashCode => Object.hash(
        class_,
        target,
      );
}

/// Remove a vote for a poll.
///
/// If:
/// - the poll was cancelled, or
/// - the poll is ongoing, or
/// - the poll has ended such that
///  - the vote of the account was in opposition to the result; or
///  - there was no conviction to the account's vote; or
///  - the account made a split vote
/// ...then the vote is removed cleanly and a following call to `unlock` may result in more
/// funds being available.
///
/// If, however, the poll has ended and:
/// - it finished corresponding to the vote of the account, and
/// - the account made a standard vote with conviction, and
/// - the lock period of the conviction is not over
/// ...then the lock will be aggregated into the overall account's lock, which may involve
/// *overlocking* (where the two locks are combined into a single lock that is the maximum
/// of both the amount locked and the time is it locked for).
///
/// The dispatch origin of this call must be _Signed_, and the signer must have a vote
/// registered for poll `index`.
///
/// - `index`: The index of poll of the vote to be removed.
/// - `class`: Optional parameter, if given it indicates the class of the poll. For polls
///  which have finished or are cancelled, this must be `Some`.
///
/// Weight: `O(R + log R)` where R is the number of polls that `target` has voted on.
///  Weight is calculated for the maximum number of vote.
class RemoveVote extends Call {
  const RemoveVote({
    this.class_,
    required this.index,
  });

  factory RemoveVote._decode(_i1.Input input) {
    return RemoveVote(
      class_: const _i1.OptionCodec<int>(_i1.U16Codec.codec).decode(input),
      index: _i1.U32Codec.codec.decode(input),
    );
  }

  /// Option<ClassOf<T, I>>
  final int? class_;

  /// PollIndexOf<T, I>
  final int index;

  @override
  Map<String, Map<String, int?>> toJson() => {
        'remove_vote': {
          'class': class_,
          'index': index,
        }
      };

  int _sizeHint() {
    int size = 1;
    size =
        size + const _i1.OptionCodec<int>(_i1.U16Codec.codec).sizeHint(class_);
    size = size + _i1.U32Codec.codec.sizeHint(index);
    return size;
  }

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      4,
      output,
    );
    const _i1.OptionCodec<int>(_i1.U16Codec.codec).encodeTo(
      class_,
      output,
    );
    _i1.U32Codec.codec.encodeTo(
      index,
      output,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(
        this,
        other,
      ) ||
      other is RemoveVote && other.class_ == class_ && other.index == index;

  @override
  int get hashCode => Object.hash(
        class_,
        index,
      );
}

/// Remove a vote for a poll.
///
/// If the `target` is equal to the signer, then this function is exactly equivalent to
/// `remove_vote`. If not equal to the signer, then the vote must have expired,
/// either because the poll was cancelled, because the voter lost the poll or
/// because the conviction period is over.
///
/// The dispatch origin of this call must be _Signed_.
///
/// - `target`: The account of the vote to be removed; this account must have voted for poll
///  `index`.
/// - `index`: The index of poll of the vote to be removed.
/// - `class`: The class of the poll.
///
/// Weight: `O(R + log R)` where R is the number of polls that `target` has voted on.
///  Weight is calculated for the maximum number of vote.
class RemoveOtherVote extends Call {
  const RemoveOtherVote({
    required this.target,
    required this.class_,
    required this.index,
  });

  factory RemoveOtherVote._decode(_i1.Input input) {
    return RemoveOtherVote(
      target: _i4.MultiAddress.codec.decode(input),
      class_: _i1.U16Codec.codec.decode(input),
      index: _i1.U32Codec.codec.decode(input),
    );
  }

  /// AccountIdLookupOf<T>
  final _i4.MultiAddress target;

  /// ClassOf<T, I>
  final int class_;

  /// PollIndexOf<T, I>
  final int index;

  @override
  Map<String, Map<String, dynamic>> toJson() => {
        'remove_other_vote': {
          'target': target.toJson(),
          'class': class_,
          'index': index,
        }
      };

  int _sizeHint() {
    int size = 1;
    size = size + _i4.MultiAddress.codec.sizeHint(target);
    size = size + _i1.U16Codec.codec.sizeHint(class_);
    size = size + _i1.U32Codec.codec.sizeHint(index);
    return size;
  }

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      5,
      output,
    );
    _i4.MultiAddress.codec.encodeTo(
      target,
      output,
    );
    _i1.U16Codec.codec.encodeTo(
      class_,
      output,
    );
    _i1.U32Codec.codec.encodeTo(
      index,
      output,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(
        this,
        other,
      ) ||
      other is RemoveOtherVote &&
          other.target == target &&
          other.class_ == class_ &&
          other.index == index;

  @override
  int get hashCode => Object.hash(
        target,
        class_,
        index,
      );
}
