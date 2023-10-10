// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:typed_data' as _i2;

import 'package:polkadart/scale_codec.dart' as _i1;
import 'package:quiver/collection.dart' as _i8;

import '../../primitive_types/h256.dart' as _i5;
import '../../sp_core/crypto/account_id32.dart' as _i4;
import '../types/metadata_owner.dart' as _i7;
import '../vote/account_vote.dart' as _i6;
import '../vote_threshold/vote_threshold.dart' as _i3;

///
///			The [event](https://docs.substrate.io/main-docs/build/events-errors/) emitted
///			by this pallet.
///
abstract class Event {
  const Event();

  factory Event.decode(_i1.Input input) {
    return codec.decode(input);
  }

  static const $EventCodec codec = $EventCodec();

  static const $Event values = $Event();

  _i2.Uint8List encode() {
    final output = _i1.ByteOutput(codec.sizeHint(this));
    codec.encodeTo(this, output);
    return output.toBytes();
  }

  int sizeHint() {
    return codec.sizeHint(this);
  }

  Map<String, dynamic> toJson();
}

class $Event {
  const $Event();

  Proposed proposed({
    required int proposalIndex,
    required BigInt deposit,
  }) {
    return Proposed(
      proposalIndex: proposalIndex,
      deposit: deposit,
    );
  }

  Tabled tabled({
    required int proposalIndex,
    required BigInt deposit,
  }) {
    return Tabled(
      proposalIndex: proposalIndex,
      deposit: deposit,
    );
  }

  ExternalTabled externalTabled() {
    return ExternalTabled();
  }

  Started started({
    required int refIndex,
    required _i3.VoteThreshold threshold,
  }) {
    return Started(
      refIndex: refIndex,
      threshold: threshold,
    );
  }

  Passed passed({required int refIndex}) {
    return Passed(refIndex: refIndex);
  }

  NotPassed notPassed({required int refIndex}) {
    return NotPassed(refIndex: refIndex);
  }

  Cancelled cancelled({required int refIndex}) {
    return Cancelled(refIndex: refIndex);
  }

  Delegated delegated({
    required _i4.AccountId32 who,
    required _i4.AccountId32 target,
  }) {
    return Delegated(
      who: who,
      target: target,
    );
  }

  Undelegated undelegated({required _i4.AccountId32 account}) {
    return Undelegated(account: account);
  }

  Vetoed vetoed({
    required _i4.AccountId32 who,
    required _i5.H256 proposalHash,
    required int until,
  }) {
    return Vetoed(
      who: who,
      proposalHash: proposalHash,
      until: until,
    );
  }

  Blacklisted blacklisted({required _i5.H256 proposalHash}) {
    return Blacklisted(proposalHash: proposalHash);
  }

  Voted voted({
    required _i4.AccountId32 voter,
    required int refIndex,
    required _i6.AccountVote vote,
  }) {
    return Voted(
      voter: voter,
      refIndex: refIndex,
      vote: vote,
    );
  }

  Seconded seconded({
    required _i4.AccountId32 seconder,
    required int propIndex,
  }) {
    return Seconded(
      seconder: seconder,
      propIndex: propIndex,
    );
  }

  ProposalCanceled proposalCanceled({required int propIndex}) {
    return ProposalCanceled(propIndex: propIndex);
  }

  MetadataSet metadataSet({
    required _i7.MetadataOwner owner,
    required _i5.H256 hash,
  }) {
    return MetadataSet(
      owner: owner,
      hash: hash,
    );
  }

  MetadataCleared metadataCleared({
    required _i7.MetadataOwner owner,
    required _i5.H256 hash,
  }) {
    return MetadataCleared(
      owner: owner,
      hash: hash,
    );
  }

  MetadataTransferred metadataTransferred({
    required _i7.MetadataOwner prevOwner,
    required _i7.MetadataOwner owner,
    required _i5.H256 hash,
  }) {
    return MetadataTransferred(
      prevOwner: prevOwner,
      owner: owner,
      hash: hash,
    );
  }
}

class $EventCodec with _i1.Codec<Event> {
  const $EventCodec();

  @override
  Event decode(_i1.Input input) {
    final index = _i1.U8Codec.codec.decode(input);
    switch (index) {
      case 0:
        return Proposed._decode(input);
      case 1:
        return Tabled._decode(input);
      case 2:
        return const ExternalTabled();
      case 3:
        return Started._decode(input);
      case 4:
        return Passed._decode(input);
      case 5:
        return NotPassed._decode(input);
      case 6:
        return Cancelled._decode(input);
      case 7:
        return Delegated._decode(input);
      case 8:
        return Undelegated._decode(input);
      case 9:
        return Vetoed._decode(input);
      case 10:
        return Blacklisted._decode(input);
      case 11:
        return Voted._decode(input);
      case 12:
        return Seconded._decode(input);
      case 13:
        return ProposalCanceled._decode(input);
      case 14:
        return MetadataSet._decode(input);
      case 15:
        return MetadataCleared._decode(input);
      case 16:
        return MetadataTransferred._decode(input);
      default:
        throw Exception('Event: Invalid variant index: "$index"');
    }
  }

  @override
  void encodeTo(
    Event value,
    _i1.Output output,
  ) {
    switch (value.runtimeType) {
      case Proposed:
        (value as Proposed).encodeTo(output);
        break;
      case Tabled:
        (value as Tabled).encodeTo(output);
        break;
      case ExternalTabled:
        (value as ExternalTabled).encodeTo(output);
        break;
      case Started:
        (value as Started).encodeTo(output);
        break;
      case Passed:
        (value as Passed).encodeTo(output);
        break;
      case NotPassed:
        (value as NotPassed).encodeTo(output);
        break;
      case Cancelled:
        (value as Cancelled).encodeTo(output);
        break;
      case Delegated:
        (value as Delegated).encodeTo(output);
        break;
      case Undelegated:
        (value as Undelegated).encodeTo(output);
        break;
      case Vetoed:
        (value as Vetoed).encodeTo(output);
        break;
      case Blacklisted:
        (value as Blacklisted).encodeTo(output);
        break;
      case Voted:
        (value as Voted).encodeTo(output);
        break;
      case Seconded:
        (value as Seconded).encodeTo(output);
        break;
      case ProposalCanceled:
        (value as ProposalCanceled).encodeTo(output);
        break;
      case MetadataSet:
        (value as MetadataSet).encodeTo(output);
        break;
      case MetadataCleared:
        (value as MetadataCleared).encodeTo(output);
        break;
      case MetadataTransferred:
        (value as MetadataTransferred).encodeTo(output);
        break;
      default:
        throw Exception(
            'Event: Unsupported "$value" of type "${value.runtimeType}"');
    }
  }

  @override
  int sizeHint(Event value) {
    switch (value.runtimeType) {
      case Proposed:
        return (value as Proposed)._sizeHint();
      case Tabled:
        return (value as Tabled)._sizeHint();
      case ExternalTabled:
        return 1;
      case Started:
        return (value as Started)._sizeHint();
      case Passed:
        return (value as Passed)._sizeHint();
      case NotPassed:
        return (value as NotPassed)._sizeHint();
      case Cancelled:
        return (value as Cancelled)._sizeHint();
      case Delegated:
        return (value as Delegated)._sizeHint();
      case Undelegated:
        return (value as Undelegated)._sizeHint();
      case Vetoed:
        return (value as Vetoed)._sizeHint();
      case Blacklisted:
        return (value as Blacklisted)._sizeHint();
      case Voted:
        return (value as Voted)._sizeHint();
      case Seconded:
        return (value as Seconded)._sizeHint();
      case ProposalCanceled:
        return (value as ProposalCanceled)._sizeHint();
      case MetadataSet:
        return (value as MetadataSet)._sizeHint();
      case MetadataCleared:
        return (value as MetadataCleared)._sizeHint();
      case MetadataTransferred:
        return (value as MetadataTransferred)._sizeHint();
      default:
        throw Exception(
            'Event: Unsupported "$value" of type "${value.runtimeType}"');
    }
  }
}

/// A motion has been proposed by a public account.
class Proposed extends Event {
  const Proposed({
    required this.proposalIndex,
    required this.deposit,
  });

  factory Proposed._decode(_i1.Input input) {
    return Proposed(
      proposalIndex: _i1.U32Codec.codec.decode(input),
      deposit: _i1.U128Codec.codec.decode(input),
    );
  }

  /// PropIndex
  final int proposalIndex;

  /// BalanceOf<T>
  final BigInt deposit;

  @override
  Map<String, Map<String, dynamic>> toJson() => {
        'Proposed': {
          'proposalIndex': proposalIndex,
          'deposit': deposit,
        }
      };

  int _sizeHint() {
    int size = 1;
    size = size + _i1.U32Codec.codec.sizeHint(proposalIndex);
    size = size + _i1.U128Codec.codec.sizeHint(deposit);
    return size;
  }

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      0,
      output,
    );
    _i1.U32Codec.codec.encodeTo(
      proposalIndex,
      output,
    );
    _i1.U128Codec.codec.encodeTo(
      deposit,
      output,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(
        this,
        other,
      ) ||
      other is Proposed &&
          other.proposalIndex == proposalIndex &&
          other.deposit == deposit;

  @override
  int get hashCode => Object.hash(
        proposalIndex,
        deposit,
      );
}

/// A public proposal has been tabled for referendum vote.
class Tabled extends Event {
  const Tabled({
    required this.proposalIndex,
    required this.deposit,
  });

  factory Tabled._decode(_i1.Input input) {
    return Tabled(
      proposalIndex: _i1.U32Codec.codec.decode(input),
      deposit: _i1.U128Codec.codec.decode(input),
    );
  }

  /// PropIndex
  final int proposalIndex;

  /// BalanceOf<T>
  final BigInt deposit;

  @override
  Map<String, Map<String, dynamic>> toJson() => {
        'Tabled': {
          'proposalIndex': proposalIndex,
          'deposit': deposit,
        }
      };

  int _sizeHint() {
    int size = 1;
    size = size + _i1.U32Codec.codec.sizeHint(proposalIndex);
    size = size + _i1.U128Codec.codec.sizeHint(deposit);
    return size;
  }

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      1,
      output,
    );
    _i1.U32Codec.codec.encodeTo(
      proposalIndex,
      output,
    );
    _i1.U128Codec.codec.encodeTo(
      deposit,
      output,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(
        this,
        other,
      ) ||
      other is Tabled &&
          other.proposalIndex == proposalIndex &&
          other.deposit == deposit;

  @override
  int get hashCode => Object.hash(
        proposalIndex,
        deposit,
      );
}

/// An external proposal has been tabled.
class ExternalTabled extends Event {
  const ExternalTabled();

  @override
  Map<String, dynamic> toJson() => {'ExternalTabled': null};

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      2,
      output,
    );
  }

  @override
  bool operator ==(Object other) => other is ExternalTabled;

  @override
  int get hashCode => runtimeType.hashCode;
}

/// A referendum has begun.
class Started extends Event {
  const Started({
    required this.refIndex,
    required this.threshold,
  });

  factory Started._decode(_i1.Input input) {
    return Started(
      refIndex: _i1.U32Codec.codec.decode(input),
      threshold: _i3.VoteThreshold.codec.decode(input),
    );
  }

  /// ReferendumIndex
  final int refIndex;

  /// VoteThreshold
  final _i3.VoteThreshold threshold;

  @override
  Map<String, Map<String, dynamic>> toJson() => {
        'Started': {
          'refIndex': refIndex,
          'threshold': threshold.toJson(),
        }
      };

  int _sizeHint() {
    int size = 1;
    size = size + _i1.U32Codec.codec.sizeHint(refIndex);
    size = size + _i3.VoteThreshold.codec.sizeHint(threshold);
    return size;
  }

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      3,
      output,
    );
    _i1.U32Codec.codec.encodeTo(
      refIndex,
      output,
    );
    _i3.VoteThreshold.codec.encodeTo(
      threshold,
      output,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(
        this,
        other,
      ) ||
      other is Started &&
          other.refIndex == refIndex &&
          other.threshold == threshold;

  @override
  int get hashCode => Object.hash(
        refIndex,
        threshold,
      );
}

/// A proposal has been approved by referendum.
class Passed extends Event {
  const Passed({required this.refIndex});

  factory Passed._decode(_i1.Input input) {
    return Passed(refIndex: _i1.U32Codec.codec.decode(input));
  }

  /// ReferendumIndex
  final int refIndex;

  @override
  Map<String, Map<String, int>> toJson() => {
        'Passed': {'refIndex': refIndex}
      };

  int _sizeHint() {
    int size = 1;
    size = size + _i1.U32Codec.codec.sizeHint(refIndex);
    return size;
  }

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      4,
      output,
    );
    _i1.U32Codec.codec.encodeTo(
      refIndex,
      output,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(
        this,
        other,
      ) ||
      other is Passed && other.refIndex == refIndex;

  @override
  int get hashCode => refIndex.hashCode;
}

/// A proposal has been rejected by referendum.
class NotPassed extends Event {
  const NotPassed({required this.refIndex});

  factory NotPassed._decode(_i1.Input input) {
    return NotPassed(refIndex: _i1.U32Codec.codec.decode(input));
  }

  /// ReferendumIndex
  final int refIndex;

  @override
  Map<String, Map<String, int>> toJson() => {
        'NotPassed': {'refIndex': refIndex}
      };

  int _sizeHint() {
    int size = 1;
    size = size + _i1.U32Codec.codec.sizeHint(refIndex);
    return size;
  }

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      5,
      output,
    );
    _i1.U32Codec.codec.encodeTo(
      refIndex,
      output,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(
        this,
        other,
      ) ||
      other is NotPassed && other.refIndex == refIndex;

  @override
  int get hashCode => refIndex.hashCode;
}

/// A referendum has been cancelled.
class Cancelled extends Event {
  const Cancelled({required this.refIndex});

  factory Cancelled._decode(_i1.Input input) {
    return Cancelled(refIndex: _i1.U32Codec.codec.decode(input));
  }

  /// ReferendumIndex
  final int refIndex;

  @override
  Map<String, Map<String, int>> toJson() => {
        'Cancelled': {'refIndex': refIndex}
      };

  int _sizeHint() {
    int size = 1;
    size = size + _i1.U32Codec.codec.sizeHint(refIndex);
    return size;
  }

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      6,
      output,
    );
    _i1.U32Codec.codec.encodeTo(
      refIndex,
      output,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(
        this,
        other,
      ) ||
      other is Cancelled && other.refIndex == refIndex;

  @override
  int get hashCode => refIndex.hashCode;
}

/// An account has delegated their vote to another account.
class Delegated extends Event {
  const Delegated({
    required this.who,
    required this.target,
  });

  factory Delegated._decode(_i1.Input input) {
    return Delegated(
      who: const _i1.U8ArrayCodec(32).decode(input),
      target: const _i1.U8ArrayCodec(32).decode(input),
    );
  }

  /// T::AccountId
  final _i4.AccountId32 who;

  /// T::AccountId
  final _i4.AccountId32 target;

  @override
  Map<String, Map<String, List<int>>> toJson() => {
        'Delegated': {
          'who': who.toList(),
          'target': target.toList(),
        }
      };

  int _sizeHint() {
    int size = 1;
    size = size + const _i4.AccountId32Codec().sizeHint(who);
    size = size + const _i4.AccountId32Codec().sizeHint(target);
    return size;
  }

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      7,
      output,
    );
    const _i1.U8ArrayCodec(32).encodeTo(
      who,
      output,
    );
    const _i1.U8ArrayCodec(32).encodeTo(
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
      other is Delegated &&
          _i8.listsEqual(
            other.who,
            who,
          ) &&
          _i8.listsEqual(
            other.target,
            target,
          );

  @override
  int get hashCode => Object.hash(
        who,
        target,
      );
}

/// An account has cancelled a previous delegation operation.
class Undelegated extends Event {
  const Undelegated({required this.account});

  factory Undelegated._decode(_i1.Input input) {
    return Undelegated(account: const _i1.U8ArrayCodec(32).decode(input));
  }

  /// T::AccountId
  final _i4.AccountId32 account;

  @override
  Map<String, Map<String, List<int>>> toJson() => {
        'Undelegated': {'account': account.toList()}
      };

  int _sizeHint() {
    int size = 1;
    size = size + const _i4.AccountId32Codec().sizeHint(account);
    return size;
  }

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      8,
      output,
    );
    const _i1.U8ArrayCodec(32).encodeTo(
      account,
      output,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(
        this,
        other,
      ) ||
      other is Undelegated &&
          _i8.listsEqual(
            other.account,
            account,
          );

  @override
  int get hashCode => account.hashCode;
}

/// An external proposal has been vetoed.
class Vetoed extends Event {
  const Vetoed({
    required this.who,
    required this.proposalHash,
    required this.until,
  });

  factory Vetoed._decode(_i1.Input input) {
    return Vetoed(
      who: const _i1.U8ArrayCodec(32).decode(input),
      proposalHash: const _i1.U8ArrayCodec(32).decode(input),
      until: _i1.U32Codec.codec.decode(input),
    );
  }

  /// T::AccountId
  final _i4.AccountId32 who;

  /// H256
  final _i5.H256 proposalHash;

  /// T::BlockNumber
  final int until;

  @override
  Map<String, Map<String, dynamic>> toJson() => {
        'Vetoed': {
          'who': who.toList(),
          'proposalHash': proposalHash.toList(),
          'until': until,
        }
      };

  int _sizeHint() {
    int size = 1;
    size = size + const _i4.AccountId32Codec().sizeHint(who);
    size = size + const _i5.H256Codec().sizeHint(proposalHash);
    size = size + _i1.U32Codec.codec.sizeHint(until);
    return size;
  }

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      9,
      output,
    );
    const _i1.U8ArrayCodec(32).encodeTo(
      who,
      output,
    );
    const _i1.U8ArrayCodec(32).encodeTo(
      proposalHash,
      output,
    );
    _i1.U32Codec.codec.encodeTo(
      until,
      output,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(
        this,
        other,
      ) ||
      other is Vetoed &&
          _i8.listsEqual(
            other.who,
            who,
          ) &&
          _i8.listsEqual(
            other.proposalHash,
            proposalHash,
          ) &&
          other.until == until;

  @override
  int get hashCode => Object.hash(
        who,
        proposalHash,
        until,
      );
}

/// A proposal_hash has been blacklisted permanently.
class Blacklisted extends Event {
  const Blacklisted({required this.proposalHash});

  factory Blacklisted._decode(_i1.Input input) {
    return Blacklisted(proposalHash: const _i1.U8ArrayCodec(32).decode(input));
  }

  /// H256
  final _i5.H256 proposalHash;

  @override
  Map<String, Map<String, List<int>>> toJson() => {
        'Blacklisted': {'proposalHash': proposalHash.toList()}
      };

  int _sizeHint() {
    int size = 1;
    size = size + const _i5.H256Codec().sizeHint(proposalHash);
    return size;
  }

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      10,
      output,
    );
    const _i1.U8ArrayCodec(32).encodeTo(
      proposalHash,
      output,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(
        this,
        other,
      ) ||
      other is Blacklisted &&
          _i8.listsEqual(
            other.proposalHash,
            proposalHash,
          );

  @override
  int get hashCode => proposalHash.hashCode;
}

/// An account has voted in a referendum
class Voted extends Event {
  const Voted({
    required this.voter,
    required this.refIndex,
    required this.vote,
  });

  factory Voted._decode(_i1.Input input) {
    return Voted(
      voter: const _i1.U8ArrayCodec(32).decode(input),
      refIndex: _i1.U32Codec.codec.decode(input),
      vote: _i6.AccountVote.codec.decode(input),
    );
  }

  /// T::AccountId
  final _i4.AccountId32 voter;

  /// ReferendumIndex
  final int refIndex;

  /// AccountVote<BalanceOf<T>>
  final _i6.AccountVote vote;

  @override
  Map<String, Map<String, dynamic>> toJson() => {
        'Voted': {
          'voter': voter.toList(),
          'refIndex': refIndex,
          'vote': vote.toJson(),
        }
      };

  int _sizeHint() {
    int size = 1;
    size = size + const _i4.AccountId32Codec().sizeHint(voter);
    size = size + _i1.U32Codec.codec.sizeHint(refIndex);
    size = size + _i6.AccountVote.codec.sizeHint(vote);
    return size;
  }

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      11,
      output,
    );
    const _i1.U8ArrayCodec(32).encodeTo(
      voter,
      output,
    );
    _i1.U32Codec.codec.encodeTo(
      refIndex,
      output,
    );
    _i6.AccountVote.codec.encodeTo(
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
      other is Voted &&
          _i8.listsEqual(
            other.voter,
            voter,
          ) &&
          other.refIndex == refIndex &&
          other.vote == vote;

  @override
  int get hashCode => Object.hash(
        voter,
        refIndex,
        vote,
      );
}

/// An account has secconded a proposal
class Seconded extends Event {
  const Seconded({
    required this.seconder,
    required this.propIndex,
  });

  factory Seconded._decode(_i1.Input input) {
    return Seconded(
      seconder: const _i1.U8ArrayCodec(32).decode(input),
      propIndex: _i1.U32Codec.codec.decode(input),
    );
  }

  /// T::AccountId
  final _i4.AccountId32 seconder;

  /// PropIndex
  final int propIndex;

  @override
  Map<String, Map<String, dynamic>> toJson() => {
        'Seconded': {
          'seconder': seconder.toList(),
          'propIndex': propIndex,
        }
      };

  int _sizeHint() {
    int size = 1;
    size = size + const _i4.AccountId32Codec().sizeHint(seconder);
    size = size + _i1.U32Codec.codec.sizeHint(propIndex);
    return size;
  }

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      12,
      output,
    );
    const _i1.U8ArrayCodec(32).encodeTo(
      seconder,
      output,
    );
    _i1.U32Codec.codec.encodeTo(
      propIndex,
      output,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(
        this,
        other,
      ) ||
      other is Seconded &&
          _i8.listsEqual(
            other.seconder,
            seconder,
          ) &&
          other.propIndex == propIndex;

  @override
  int get hashCode => Object.hash(
        seconder,
        propIndex,
      );
}

/// A proposal got canceled.
class ProposalCanceled extends Event {
  const ProposalCanceled({required this.propIndex});

  factory ProposalCanceled._decode(_i1.Input input) {
    return ProposalCanceled(propIndex: _i1.U32Codec.codec.decode(input));
  }

  /// PropIndex
  final int propIndex;

  @override
  Map<String, Map<String, int>> toJson() => {
        'ProposalCanceled': {'propIndex': propIndex}
      };

  int _sizeHint() {
    int size = 1;
    size = size + _i1.U32Codec.codec.sizeHint(propIndex);
    return size;
  }

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      13,
      output,
    );
    _i1.U32Codec.codec.encodeTo(
      propIndex,
      output,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(
        this,
        other,
      ) ||
      other is ProposalCanceled && other.propIndex == propIndex;

  @override
  int get hashCode => propIndex.hashCode;
}

/// Metadata for a proposal or a referendum has been set.
class MetadataSet extends Event {
  const MetadataSet({
    required this.owner,
    required this.hash,
  });

  factory MetadataSet._decode(_i1.Input input) {
    return MetadataSet(
      owner: _i7.MetadataOwner.codec.decode(input),
      hash: const _i1.U8ArrayCodec(32).decode(input),
    );
  }

  /// MetadataOwner
  /// Metadata owner.
  final _i7.MetadataOwner owner;

  /// PreimageHash
  /// Preimage hash.
  final _i5.H256 hash;

  @override
  Map<String, Map<String, dynamic>> toJson() => {
        'MetadataSet': {
          'owner': owner.toJson(),
          'hash': hash.toList(),
        }
      };

  int _sizeHint() {
    int size = 1;
    size = size + _i7.MetadataOwner.codec.sizeHint(owner);
    size = size + const _i5.H256Codec().sizeHint(hash);
    return size;
  }

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      14,
      output,
    );
    _i7.MetadataOwner.codec.encodeTo(
      owner,
      output,
    );
    const _i1.U8ArrayCodec(32).encodeTo(
      hash,
      output,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(
        this,
        other,
      ) ||
      other is MetadataSet &&
          other.owner == owner &&
          _i8.listsEqual(
            other.hash,
            hash,
          );

  @override
  int get hashCode => Object.hash(
        owner,
        hash,
      );
}

/// Metadata for a proposal or a referendum has been cleared.
class MetadataCleared extends Event {
  const MetadataCleared({
    required this.owner,
    required this.hash,
  });

  factory MetadataCleared._decode(_i1.Input input) {
    return MetadataCleared(
      owner: _i7.MetadataOwner.codec.decode(input),
      hash: const _i1.U8ArrayCodec(32).decode(input),
    );
  }

  /// MetadataOwner
  /// Metadata owner.
  final _i7.MetadataOwner owner;

  /// PreimageHash
  /// Preimage hash.
  final _i5.H256 hash;

  @override
  Map<String, Map<String, dynamic>> toJson() => {
        'MetadataCleared': {
          'owner': owner.toJson(),
          'hash': hash.toList(),
        }
      };

  int _sizeHint() {
    int size = 1;
    size = size + _i7.MetadataOwner.codec.sizeHint(owner);
    size = size + const _i5.H256Codec().sizeHint(hash);
    return size;
  }

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      15,
      output,
    );
    _i7.MetadataOwner.codec.encodeTo(
      owner,
      output,
    );
    const _i1.U8ArrayCodec(32).encodeTo(
      hash,
      output,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(
        this,
        other,
      ) ||
      other is MetadataCleared &&
          other.owner == owner &&
          _i8.listsEqual(
            other.hash,
            hash,
          );

  @override
  int get hashCode => Object.hash(
        owner,
        hash,
      );
}

/// Metadata has been transferred to new owner.
class MetadataTransferred extends Event {
  const MetadataTransferred({
    required this.prevOwner,
    required this.owner,
    required this.hash,
  });

  factory MetadataTransferred._decode(_i1.Input input) {
    return MetadataTransferred(
      prevOwner: _i7.MetadataOwner.codec.decode(input),
      owner: _i7.MetadataOwner.codec.decode(input),
      hash: const _i1.U8ArrayCodec(32).decode(input),
    );
  }

  /// MetadataOwner
  /// Previous metadata owner.
  final _i7.MetadataOwner prevOwner;

  /// MetadataOwner
  /// New metadata owner.
  final _i7.MetadataOwner owner;

  /// PreimageHash
  /// Preimage hash.
  final _i5.H256 hash;

  @override
  Map<String, Map<String, dynamic>> toJson() => {
        'MetadataTransferred': {
          'prevOwner': prevOwner.toJson(),
          'owner': owner.toJson(),
          'hash': hash.toList(),
        }
      };

  int _sizeHint() {
    int size = 1;
    size = size + _i7.MetadataOwner.codec.sizeHint(prevOwner);
    size = size + _i7.MetadataOwner.codec.sizeHint(owner);
    size = size + const _i5.H256Codec().sizeHint(hash);
    return size;
  }

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      16,
      output,
    );
    _i7.MetadataOwner.codec.encodeTo(
      prevOwner,
      output,
    );
    _i7.MetadataOwner.codec.encodeTo(
      owner,
      output,
    );
    const _i1.U8ArrayCodec(32).encodeTo(
      hash,
      output,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(
        this,
        other,
      ) ||
      other is MetadataTransferred &&
          other.prevOwner == prevOwner &&
          other.owner == owner &&
          _i8.listsEqual(
            other.hash,
            hash,
          );

  @override
  int get hashCode => Object.hash(
        prevOwner,
        owner,
        hash,
      );
}
