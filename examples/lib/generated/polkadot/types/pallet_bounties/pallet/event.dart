// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:typed_data' as _i2;

import 'package:polkadart/scale_codec.dart' as _i1;
import 'package:quiver/collection.dart' as _i4;

import '../../sp_core/crypto/account_id32.dart' as _i3;

/// The `Event` enum of this pallet
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

  Map<String, Map<String, dynamic>> toJson();
}

class $Event {
  const $Event();

  BountyProposed bountyProposed({required int index}) {
    return BountyProposed(index: index);
  }

  BountyRejected bountyRejected({
    required int index,
    required BigInt bond,
  }) {
    return BountyRejected(
      index: index,
      bond: bond,
    );
  }

  BountyBecameActive bountyBecameActive({required int index}) {
    return BountyBecameActive(index: index);
  }

  BountyAwarded bountyAwarded({
    required int index,
    required _i3.AccountId32 beneficiary,
  }) {
    return BountyAwarded(
      index: index,
      beneficiary: beneficiary,
    );
  }

  BountyClaimed bountyClaimed({
    required int index,
    required BigInt payout,
    required _i3.AccountId32 beneficiary,
  }) {
    return BountyClaimed(
      index: index,
      payout: payout,
      beneficiary: beneficiary,
    );
  }

  BountyCanceled bountyCanceled({required int index}) {
    return BountyCanceled(index: index);
  }

  BountyExtended bountyExtended({required int index}) {
    return BountyExtended(index: index);
  }

  BountyApproved bountyApproved({required int index}) {
    return BountyApproved(index: index);
  }

  CuratorProposed curatorProposed({
    required int bountyId,
    required _i3.AccountId32 curator,
  }) {
    return CuratorProposed(
      bountyId: bountyId,
      curator: curator,
    );
  }

  CuratorUnassigned curatorUnassigned({required int bountyId}) {
    return CuratorUnassigned(bountyId: bountyId);
  }

  CuratorAccepted curatorAccepted({
    required int bountyId,
    required _i3.AccountId32 curator,
  }) {
    return CuratorAccepted(
      bountyId: bountyId,
      curator: curator,
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
        return BountyProposed._decode(input);
      case 1:
        return BountyRejected._decode(input);
      case 2:
        return BountyBecameActive._decode(input);
      case 3:
        return BountyAwarded._decode(input);
      case 4:
        return BountyClaimed._decode(input);
      case 5:
        return BountyCanceled._decode(input);
      case 6:
        return BountyExtended._decode(input);
      case 7:
        return BountyApproved._decode(input);
      case 8:
        return CuratorProposed._decode(input);
      case 9:
        return CuratorUnassigned._decode(input);
      case 10:
        return CuratorAccepted._decode(input);
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
      case BountyProposed:
        (value as BountyProposed).encodeTo(output);
        break;
      case BountyRejected:
        (value as BountyRejected).encodeTo(output);
        break;
      case BountyBecameActive:
        (value as BountyBecameActive).encodeTo(output);
        break;
      case BountyAwarded:
        (value as BountyAwarded).encodeTo(output);
        break;
      case BountyClaimed:
        (value as BountyClaimed).encodeTo(output);
        break;
      case BountyCanceled:
        (value as BountyCanceled).encodeTo(output);
        break;
      case BountyExtended:
        (value as BountyExtended).encodeTo(output);
        break;
      case BountyApproved:
        (value as BountyApproved).encodeTo(output);
        break;
      case CuratorProposed:
        (value as CuratorProposed).encodeTo(output);
        break;
      case CuratorUnassigned:
        (value as CuratorUnassigned).encodeTo(output);
        break;
      case CuratorAccepted:
        (value as CuratorAccepted).encodeTo(output);
        break;
      default:
        throw Exception(
            'Event: Unsupported "$value" of type "${value.runtimeType}"');
    }
  }

  @override
  int sizeHint(Event value) {
    switch (value.runtimeType) {
      case BountyProposed:
        return (value as BountyProposed)._sizeHint();
      case BountyRejected:
        return (value as BountyRejected)._sizeHint();
      case BountyBecameActive:
        return (value as BountyBecameActive)._sizeHint();
      case BountyAwarded:
        return (value as BountyAwarded)._sizeHint();
      case BountyClaimed:
        return (value as BountyClaimed)._sizeHint();
      case BountyCanceled:
        return (value as BountyCanceled)._sizeHint();
      case BountyExtended:
        return (value as BountyExtended)._sizeHint();
      case BountyApproved:
        return (value as BountyApproved)._sizeHint();
      case CuratorProposed:
        return (value as CuratorProposed)._sizeHint();
      case CuratorUnassigned:
        return (value as CuratorUnassigned)._sizeHint();
      case CuratorAccepted:
        return (value as CuratorAccepted)._sizeHint();
      default:
        throw Exception(
            'Event: Unsupported "$value" of type "${value.runtimeType}"');
    }
  }
}

/// New bounty proposal.
class BountyProposed extends Event {
  const BountyProposed({required this.index});

  factory BountyProposed._decode(_i1.Input input) {
    return BountyProposed(index: _i1.U32Codec.codec.decode(input));
  }

  /// BountyIndex
  final int index;

  @override
  Map<String, Map<String, int>> toJson() => {
        'BountyProposed': {'index': index}
      };

  int _sizeHint() {
    int size = 1;
    size = size + _i1.U32Codec.codec.sizeHint(index);
    return size;
  }

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      0,
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
      other is BountyProposed && other.index == index;

  @override
  int get hashCode => index.hashCode;
}

/// A bounty proposal was rejected; funds were slashed.
class BountyRejected extends Event {
  const BountyRejected({
    required this.index,
    required this.bond,
  });

  factory BountyRejected._decode(_i1.Input input) {
    return BountyRejected(
      index: _i1.U32Codec.codec.decode(input),
      bond: _i1.U128Codec.codec.decode(input),
    );
  }

  /// BountyIndex
  final int index;

  /// BalanceOf<T, I>
  final BigInt bond;

  @override
  Map<String, Map<String, dynamic>> toJson() => {
        'BountyRejected': {
          'index': index,
          'bond': bond,
        }
      };

  int _sizeHint() {
    int size = 1;
    size = size + _i1.U32Codec.codec.sizeHint(index);
    size = size + _i1.U128Codec.codec.sizeHint(bond);
    return size;
  }

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      1,
      output,
    );
    _i1.U32Codec.codec.encodeTo(
      index,
      output,
    );
    _i1.U128Codec.codec.encodeTo(
      bond,
      output,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(
        this,
        other,
      ) ||
      other is BountyRejected && other.index == index && other.bond == bond;

  @override
  int get hashCode => Object.hash(
        index,
        bond,
      );
}

/// A bounty proposal is funded and became active.
class BountyBecameActive extends Event {
  const BountyBecameActive({required this.index});

  factory BountyBecameActive._decode(_i1.Input input) {
    return BountyBecameActive(index: _i1.U32Codec.codec.decode(input));
  }

  /// BountyIndex
  final int index;

  @override
  Map<String, Map<String, int>> toJson() => {
        'BountyBecameActive': {'index': index}
      };

  int _sizeHint() {
    int size = 1;
    size = size + _i1.U32Codec.codec.sizeHint(index);
    return size;
  }

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      2,
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
      other is BountyBecameActive && other.index == index;

  @override
  int get hashCode => index.hashCode;
}

/// A bounty is awarded to a beneficiary.
class BountyAwarded extends Event {
  const BountyAwarded({
    required this.index,
    required this.beneficiary,
  });

  factory BountyAwarded._decode(_i1.Input input) {
    return BountyAwarded(
      index: _i1.U32Codec.codec.decode(input),
      beneficiary: const _i1.U8ArrayCodec(32).decode(input),
    );
  }

  /// BountyIndex
  final int index;

  /// T::AccountId
  final _i3.AccountId32 beneficiary;

  @override
  Map<String, Map<String, dynamic>> toJson() => {
        'BountyAwarded': {
          'index': index,
          'beneficiary': beneficiary.toList(),
        }
      };

  int _sizeHint() {
    int size = 1;
    size = size + _i1.U32Codec.codec.sizeHint(index);
    size = size + const _i3.AccountId32Codec().sizeHint(beneficiary);
    return size;
  }

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      3,
      output,
    );
    _i1.U32Codec.codec.encodeTo(
      index,
      output,
    );
    const _i1.U8ArrayCodec(32).encodeTo(
      beneficiary,
      output,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(
        this,
        other,
      ) ||
      other is BountyAwarded &&
          other.index == index &&
          _i4.listsEqual(
            other.beneficiary,
            beneficiary,
          );

  @override
  int get hashCode => Object.hash(
        index,
        beneficiary,
      );
}

/// A bounty is claimed by beneficiary.
class BountyClaimed extends Event {
  const BountyClaimed({
    required this.index,
    required this.payout,
    required this.beneficiary,
  });

  factory BountyClaimed._decode(_i1.Input input) {
    return BountyClaimed(
      index: _i1.U32Codec.codec.decode(input),
      payout: _i1.U128Codec.codec.decode(input),
      beneficiary: const _i1.U8ArrayCodec(32).decode(input),
    );
  }

  /// BountyIndex
  final int index;

  /// BalanceOf<T, I>
  final BigInt payout;

  /// T::AccountId
  final _i3.AccountId32 beneficiary;

  @override
  Map<String, Map<String, dynamic>> toJson() => {
        'BountyClaimed': {
          'index': index,
          'payout': payout,
          'beneficiary': beneficiary.toList(),
        }
      };

  int _sizeHint() {
    int size = 1;
    size = size + _i1.U32Codec.codec.sizeHint(index);
    size = size + _i1.U128Codec.codec.sizeHint(payout);
    size = size + const _i3.AccountId32Codec().sizeHint(beneficiary);
    return size;
  }

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      4,
      output,
    );
    _i1.U32Codec.codec.encodeTo(
      index,
      output,
    );
    _i1.U128Codec.codec.encodeTo(
      payout,
      output,
    );
    const _i1.U8ArrayCodec(32).encodeTo(
      beneficiary,
      output,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(
        this,
        other,
      ) ||
      other is BountyClaimed &&
          other.index == index &&
          other.payout == payout &&
          _i4.listsEqual(
            other.beneficiary,
            beneficiary,
          );

  @override
  int get hashCode => Object.hash(
        index,
        payout,
        beneficiary,
      );
}

/// A bounty is cancelled.
class BountyCanceled extends Event {
  const BountyCanceled({required this.index});

  factory BountyCanceled._decode(_i1.Input input) {
    return BountyCanceled(index: _i1.U32Codec.codec.decode(input));
  }

  /// BountyIndex
  final int index;

  @override
  Map<String, Map<String, int>> toJson() => {
        'BountyCanceled': {'index': index}
      };

  int _sizeHint() {
    int size = 1;
    size = size + _i1.U32Codec.codec.sizeHint(index);
    return size;
  }

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      5,
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
      other is BountyCanceled && other.index == index;

  @override
  int get hashCode => index.hashCode;
}

/// A bounty expiry is extended.
class BountyExtended extends Event {
  const BountyExtended({required this.index});

  factory BountyExtended._decode(_i1.Input input) {
    return BountyExtended(index: _i1.U32Codec.codec.decode(input));
  }

  /// BountyIndex
  final int index;

  @override
  Map<String, Map<String, int>> toJson() => {
        'BountyExtended': {'index': index}
      };

  int _sizeHint() {
    int size = 1;
    size = size + _i1.U32Codec.codec.sizeHint(index);
    return size;
  }

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      6,
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
      other is BountyExtended && other.index == index;

  @override
  int get hashCode => index.hashCode;
}

/// A bounty is approved.
class BountyApproved extends Event {
  const BountyApproved({required this.index});

  factory BountyApproved._decode(_i1.Input input) {
    return BountyApproved(index: _i1.U32Codec.codec.decode(input));
  }

  /// BountyIndex
  final int index;

  @override
  Map<String, Map<String, int>> toJson() => {
        'BountyApproved': {'index': index}
      };

  int _sizeHint() {
    int size = 1;
    size = size + _i1.U32Codec.codec.sizeHint(index);
    return size;
  }

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      7,
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
      other is BountyApproved && other.index == index;

  @override
  int get hashCode => index.hashCode;
}

/// A bounty curator is proposed.
class CuratorProposed extends Event {
  const CuratorProposed({
    required this.bountyId,
    required this.curator,
  });

  factory CuratorProposed._decode(_i1.Input input) {
    return CuratorProposed(
      bountyId: _i1.U32Codec.codec.decode(input),
      curator: const _i1.U8ArrayCodec(32).decode(input),
    );
  }

  /// BountyIndex
  final int bountyId;

  /// T::AccountId
  final _i3.AccountId32 curator;

  @override
  Map<String, Map<String, dynamic>> toJson() => {
        'CuratorProposed': {
          'bountyId': bountyId,
          'curator': curator.toList(),
        }
      };

  int _sizeHint() {
    int size = 1;
    size = size + _i1.U32Codec.codec.sizeHint(bountyId);
    size = size + const _i3.AccountId32Codec().sizeHint(curator);
    return size;
  }

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      8,
      output,
    );
    _i1.U32Codec.codec.encodeTo(
      bountyId,
      output,
    );
    const _i1.U8ArrayCodec(32).encodeTo(
      curator,
      output,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(
        this,
        other,
      ) ||
      other is CuratorProposed &&
          other.bountyId == bountyId &&
          _i4.listsEqual(
            other.curator,
            curator,
          );

  @override
  int get hashCode => Object.hash(
        bountyId,
        curator,
      );
}

/// A bounty curator is unassigned.
class CuratorUnassigned extends Event {
  const CuratorUnassigned({required this.bountyId});

  factory CuratorUnassigned._decode(_i1.Input input) {
    return CuratorUnassigned(bountyId: _i1.U32Codec.codec.decode(input));
  }

  /// BountyIndex
  final int bountyId;

  @override
  Map<String, Map<String, int>> toJson() => {
        'CuratorUnassigned': {'bountyId': bountyId}
      };

  int _sizeHint() {
    int size = 1;
    size = size + _i1.U32Codec.codec.sizeHint(bountyId);
    return size;
  }

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      9,
      output,
    );
    _i1.U32Codec.codec.encodeTo(
      bountyId,
      output,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(
        this,
        other,
      ) ||
      other is CuratorUnassigned && other.bountyId == bountyId;

  @override
  int get hashCode => bountyId.hashCode;
}

/// A bounty curator is accepted.
class CuratorAccepted extends Event {
  const CuratorAccepted({
    required this.bountyId,
    required this.curator,
  });

  factory CuratorAccepted._decode(_i1.Input input) {
    return CuratorAccepted(
      bountyId: _i1.U32Codec.codec.decode(input),
      curator: const _i1.U8ArrayCodec(32).decode(input),
    );
  }

  /// BountyIndex
  final int bountyId;

  /// T::AccountId
  final _i3.AccountId32 curator;

  @override
  Map<String, Map<String, dynamic>> toJson() => {
        'CuratorAccepted': {
          'bountyId': bountyId,
          'curator': curator.toList(),
        }
      };

  int _sizeHint() {
    int size = 1;
    size = size + _i1.U32Codec.codec.sizeHint(bountyId);
    size = size + const _i3.AccountId32Codec().sizeHint(curator);
    return size;
  }

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      10,
      output,
    );
    _i1.U32Codec.codec.encodeTo(
      bountyId,
      output,
    );
    const _i1.U8ArrayCodec(32).encodeTo(
      curator,
      output,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(
        this,
        other,
      ) ||
      other is CuratorAccepted &&
          other.bountyId == bountyId &&
          _i4.listsEqual(
            other.curator,
            curator,
          );

  @override
  int get hashCode => Object.hash(
        bountyId,
        curator,
      );
}
