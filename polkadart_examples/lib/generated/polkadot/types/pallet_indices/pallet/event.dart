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

  IndexAssigned indexAssigned({
    required _i3.AccountId32 who,
    required int index,
  }) {
    return IndexAssigned(
      who: who,
      index: index,
    );
  }

  IndexFreed indexFreed({required int index}) {
    return IndexFreed(index: index);
  }

  IndexFrozen indexFrozen({
    required int index,
    required _i3.AccountId32 who,
  }) {
    return IndexFrozen(
      index: index,
      who: who,
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
        return IndexAssigned._decode(input);
      case 1:
        return IndexFreed._decode(input);
      case 2:
        return IndexFrozen._decode(input);
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
      case IndexAssigned:
        (value as IndexAssigned).encodeTo(output);
        break;
      case IndexFreed:
        (value as IndexFreed).encodeTo(output);
        break;
      case IndexFrozen:
        (value as IndexFrozen).encodeTo(output);
        break;
      default:
        throw Exception(
            'Event: Unsupported "$value" of type "${value.runtimeType}"');
    }
  }

  @override
  int sizeHint(Event value) {
    switch (value.runtimeType) {
      case IndexAssigned:
        return (value as IndexAssigned)._sizeHint();
      case IndexFreed:
        return (value as IndexFreed)._sizeHint();
      case IndexFrozen:
        return (value as IndexFrozen)._sizeHint();
      default:
        throw Exception(
            'Event: Unsupported "$value" of type "${value.runtimeType}"');
    }
  }
}

/// A account index was assigned.
class IndexAssigned extends Event {
  const IndexAssigned({
    required this.who,
    required this.index,
  });

  factory IndexAssigned._decode(_i1.Input input) {
    return IndexAssigned(
      who: const _i1.U8ArrayCodec(32).decode(input),
      index: _i1.U32Codec.codec.decode(input),
    );
  }

  /// T::AccountId
  final _i3.AccountId32 who;

  /// T::AccountIndex
  final int index;

  @override
  Map<String, Map<String, dynamic>> toJson() => {
        'IndexAssigned': {
          'who': who.toList(),
          'index': index,
        }
      };

  int _sizeHint() {
    int size = 1;
    size = size + const _i3.AccountId32Codec().sizeHint(who);
    size = size + _i1.U32Codec.codec.sizeHint(index);
    return size;
  }

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      0,
      output,
    );
    const _i1.U8ArrayCodec(32).encodeTo(
      who,
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
      other is IndexAssigned &&
          _i4.listsEqual(
            other.who,
            who,
          ) &&
          other.index == index;

  @override
  int get hashCode => Object.hash(
        who,
        index,
      );
}

/// A account index has been freed up (unassigned).
class IndexFreed extends Event {
  const IndexFreed({required this.index});

  factory IndexFreed._decode(_i1.Input input) {
    return IndexFreed(index: _i1.U32Codec.codec.decode(input));
  }

  /// T::AccountIndex
  final int index;

  @override
  Map<String, Map<String, int>> toJson() => {
        'IndexFreed': {'index': index}
      };

  int _sizeHint() {
    int size = 1;
    size = size + _i1.U32Codec.codec.sizeHint(index);
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
  }

  @override
  bool operator ==(Object other) =>
      identical(
        this,
        other,
      ) ||
      other is IndexFreed && other.index == index;

  @override
  int get hashCode => index.hashCode;
}

/// A account index has been frozen to its current account ID.
class IndexFrozen extends Event {
  const IndexFrozen({
    required this.index,
    required this.who,
  });

  factory IndexFrozen._decode(_i1.Input input) {
    return IndexFrozen(
      index: _i1.U32Codec.codec.decode(input),
      who: const _i1.U8ArrayCodec(32).decode(input),
    );
  }

  /// T::AccountIndex
  final int index;

  /// T::AccountId
  final _i3.AccountId32 who;

  @override
  Map<String, Map<String, dynamic>> toJson() => {
        'IndexFrozen': {
          'index': index,
          'who': who.toList(),
        }
      };

  int _sizeHint() {
    int size = 1;
    size = size + _i1.U32Codec.codec.sizeHint(index);
    size = size + const _i3.AccountId32Codec().sizeHint(who);
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
    const _i1.U8ArrayCodec(32).encodeTo(
      who,
      output,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(
        this,
        other,
      ) ||
      other is IndexFrozen &&
          other.index == index &&
          _i4.listsEqual(
            other.who,
            who,
          );

  @override
  int get hashCode => Object.hash(
        index,
        who,
      );
}
