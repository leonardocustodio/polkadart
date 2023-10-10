// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:typed_data' as _i2;

import 'package:polkadart/scale_codec.dart' as _i1;
import 'package:quiver/collection.dart' as _i4;

import '../../sp_core/crypto/account_id32.dart' as _i3;

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

  Map<String, Map<String, dynamic>> toJson();
}

class $Event {
  const $Event();

  Added added({
    required int index,
    required int childIndex,
  }) {
    return Added(
      index: index,
      childIndex: childIndex,
    );
  }

  Awarded awarded({
    required int index,
    required int childIndex,
    required _i3.AccountId32 beneficiary,
  }) {
    return Awarded(
      index: index,
      childIndex: childIndex,
      beneficiary: beneficiary,
    );
  }

  Claimed claimed({
    required int index,
    required int childIndex,
    required BigInt payout,
    required _i3.AccountId32 beneficiary,
  }) {
    return Claimed(
      index: index,
      childIndex: childIndex,
      payout: payout,
      beneficiary: beneficiary,
    );
  }

  Canceled canceled({
    required int index,
    required int childIndex,
  }) {
    return Canceled(
      index: index,
      childIndex: childIndex,
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
        return Added._decode(input);
      case 1:
        return Awarded._decode(input);
      case 2:
        return Claimed._decode(input);
      case 3:
        return Canceled._decode(input);
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
      case Added:
        (value as Added).encodeTo(output);
        break;
      case Awarded:
        (value as Awarded).encodeTo(output);
        break;
      case Claimed:
        (value as Claimed).encodeTo(output);
        break;
      case Canceled:
        (value as Canceled).encodeTo(output);
        break;
      default:
        throw Exception(
            'Event: Unsupported "$value" of type "${value.runtimeType}"');
    }
  }

  @override
  int sizeHint(Event value) {
    switch (value.runtimeType) {
      case Added:
        return (value as Added)._sizeHint();
      case Awarded:
        return (value as Awarded)._sizeHint();
      case Claimed:
        return (value as Claimed)._sizeHint();
      case Canceled:
        return (value as Canceled)._sizeHint();
      default:
        throw Exception(
            'Event: Unsupported "$value" of type "${value.runtimeType}"');
    }
  }
}

/// A child-bounty is added.
class Added extends Event {
  const Added({
    required this.index,
    required this.childIndex,
  });

  factory Added._decode(_i1.Input input) {
    return Added(
      index: _i1.U32Codec.codec.decode(input),
      childIndex: _i1.U32Codec.codec.decode(input),
    );
  }

  /// BountyIndex
  final int index;

  /// BountyIndex
  final int childIndex;

  @override
  Map<String, Map<String, int>> toJson() => {
        'Added': {
          'index': index,
          'childIndex': childIndex,
        }
      };

  int _sizeHint() {
    int size = 1;
    size = size + _i1.U32Codec.codec.sizeHint(index);
    size = size + _i1.U32Codec.codec.sizeHint(childIndex);
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
    _i1.U32Codec.codec.encodeTo(
      childIndex,
      output,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(
        this,
        other,
      ) ||
      other is Added && other.index == index && other.childIndex == childIndex;

  @override
  int get hashCode => Object.hash(
        index,
        childIndex,
      );
}

/// A child-bounty is awarded to a beneficiary.
class Awarded extends Event {
  const Awarded({
    required this.index,
    required this.childIndex,
    required this.beneficiary,
  });

  factory Awarded._decode(_i1.Input input) {
    return Awarded(
      index: _i1.U32Codec.codec.decode(input),
      childIndex: _i1.U32Codec.codec.decode(input),
      beneficiary: const _i1.U8ArrayCodec(32).decode(input),
    );
  }

  /// BountyIndex
  final int index;

  /// BountyIndex
  final int childIndex;

  /// T::AccountId
  final _i3.AccountId32 beneficiary;

  @override
  Map<String, Map<String, dynamic>> toJson() => {
        'Awarded': {
          'index': index,
          'childIndex': childIndex,
          'beneficiary': beneficiary.toList(),
        }
      };

  int _sizeHint() {
    int size = 1;
    size = size + _i1.U32Codec.codec.sizeHint(index);
    size = size + _i1.U32Codec.codec.sizeHint(childIndex);
    size = size + const _i3.AccountId32Codec().sizeHint(beneficiary);
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
    _i1.U32Codec.codec.encodeTo(
      childIndex,
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
      other is Awarded &&
          other.index == index &&
          other.childIndex == childIndex &&
          _i4.listsEqual(
            other.beneficiary,
            beneficiary,
          );

  @override
  int get hashCode => Object.hash(
        index,
        childIndex,
        beneficiary,
      );
}

/// A child-bounty is claimed by beneficiary.
class Claimed extends Event {
  const Claimed({
    required this.index,
    required this.childIndex,
    required this.payout,
    required this.beneficiary,
  });

  factory Claimed._decode(_i1.Input input) {
    return Claimed(
      index: _i1.U32Codec.codec.decode(input),
      childIndex: _i1.U32Codec.codec.decode(input),
      payout: _i1.U128Codec.codec.decode(input),
      beneficiary: const _i1.U8ArrayCodec(32).decode(input),
    );
  }

  /// BountyIndex
  final int index;

  /// BountyIndex
  final int childIndex;

  /// BalanceOf<T>
  final BigInt payout;

  /// T::AccountId
  final _i3.AccountId32 beneficiary;

  @override
  Map<String, Map<String, dynamic>> toJson() => {
        'Claimed': {
          'index': index,
          'childIndex': childIndex,
          'payout': payout,
          'beneficiary': beneficiary.toList(),
        }
      };

  int _sizeHint() {
    int size = 1;
    size = size + _i1.U32Codec.codec.sizeHint(index);
    size = size + _i1.U32Codec.codec.sizeHint(childIndex);
    size = size + _i1.U128Codec.codec.sizeHint(payout);
    size = size + const _i3.AccountId32Codec().sizeHint(beneficiary);
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
    _i1.U32Codec.codec.encodeTo(
      childIndex,
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
      other is Claimed &&
          other.index == index &&
          other.childIndex == childIndex &&
          other.payout == payout &&
          _i4.listsEqual(
            other.beneficiary,
            beneficiary,
          );

  @override
  int get hashCode => Object.hash(
        index,
        childIndex,
        payout,
        beneficiary,
      );
}

/// A child-bounty is cancelled.
class Canceled extends Event {
  const Canceled({
    required this.index,
    required this.childIndex,
  });

  factory Canceled._decode(_i1.Input input) {
    return Canceled(
      index: _i1.U32Codec.codec.decode(input),
      childIndex: _i1.U32Codec.codec.decode(input),
    );
  }

  /// BountyIndex
  final int index;

  /// BountyIndex
  final int childIndex;

  @override
  Map<String, Map<String, int>> toJson() => {
        'Canceled': {
          'index': index,
          'childIndex': childIndex,
        }
      };

  int _sizeHint() {
    int size = 1;
    size = size + _i1.U32Codec.codec.sizeHint(index);
    size = size + _i1.U32Codec.codec.sizeHint(childIndex);
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
    _i1.U32Codec.codec.encodeTo(
      childIndex,
      output,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(
        this,
        other,
      ) ||
      other is Canceled &&
          other.index == index &&
          other.childIndex == childIndex;

  @override
  int get hashCode => Object.hash(
        index,
        childIndex,
      );
}
