// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:typed_data' as _i2;

import 'package:polkadart/scale_codec.dart' as _i1;

///
///			Custom [dispatch errors](https://docs.substrate.io/main-docs/build/events-errors/)
///			of this pallet.
///
enum Error {
  /// Poll is not ongoing.
  notOngoing('NotOngoing', 0),

  /// The given account did not vote on the poll.
  notVoter('NotVoter', 1),

  /// The actor has no permission to conduct the action.
  noPermission('NoPermission', 2),

  /// The actor has no permission to conduct the action right now but will do in the future.
  noPermissionYet('NoPermissionYet', 3),

  /// The account is already delegating.
  alreadyDelegating('AlreadyDelegating', 4),

  /// The account currently has votes attached to it and the operation cannot succeed until
  /// these are removed, either through `unvote` or `reap_vote`.
  alreadyVoting('AlreadyVoting', 5),

  /// Too high a balance was provided that the account cannot afford.
  insufficientFunds('InsufficientFunds', 6),

  /// The account is not currently delegating.
  notDelegating('NotDelegating', 7),

  /// Delegation to oneself makes no sense.
  nonsense('Nonsense', 8),

  /// Maximum number of votes reached.
  maxVotesReached('MaxVotesReached', 9),

  /// The class must be supplied since it is not easily determinable from the state.
  classNeeded('ClassNeeded', 10),

  /// The class ID supplied is invalid.
  badClass('BadClass', 11);

  const Error(
    this.variantName,
    this.codecIndex,
  );

  factory Error.decode(_i1.Input input) {
    return codec.decode(input);
  }

  final String variantName;

  final int codecIndex;

  static const $ErrorCodec codec = $ErrorCodec();

  String toJson() => variantName;
  _i2.Uint8List encode() {
    return codec.encode(this);
  }
}

class $ErrorCodec with _i1.Codec<Error> {
  const $ErrorCodec();

  @override
  Error decode(_i1.Input input) {
    final index = _i1.U8Codec.codec.decode(input);
    switch (index) {
      case 0:
        return Error.notOngoing;
      case 1:
        return Error.notVoter;
      case 2:
        return Error.noPermission;
      case 3:
        return Error.noPermissionYet;
      case 4:
        return Error.alreadyDelegating;
      case 5:
        return Error.alreadyVoting;
      case 6:
        return Error.insufficientFunds;
      case 7:
        return Error.notDelegating;
      case 8:
        return Error.nonsense;
      case 9:
        return Error.maxVotesReached;
      case 10:
        return Error.classNeeded;
      case 11:
        return Error.badClass;
      default:
        throw Exception('Error: Invalid variant index: "$index"');
    }
  }

  @override
  void encodeTo(
    Error value,
    _i1.Output output,
  ) {
    _i1.U8Codec.codec.encodeTo(
      value.codecIndex,
      output,
    );
  }
}
