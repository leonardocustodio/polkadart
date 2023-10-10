// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:typed_data' as _i2;

import 'package:polkadart/scale_codec.dart' as _i1;
import 'package:quiver/collection.dart' as _i4;

import '../../primitive_types/h256.dart' as _i3;

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

  Map<String, Map<String, List<int>>> toJson();
}

class $Event {
  const $Event();

  Noted noted({required _i3.H256 hash}) {
    return Noted(hash: hash);
  }

  Requested requested({required _i3.H256 hash}) {
    return Requested(hash: hash);
  }

  Cleared cleared({required _i3.H256 hash}) {
    return Cleared(hash: hash);
  }
}

class $EventCodec with _i1.Codec<Event> {
  const $EventCodec();

  @override
  Event decode(_i1.Input input) {
    final index = _i1.U8Codec.codec.decode(input);
    switch (index) {
      case 0:
        return Noted._decode(input);
      case 1:
        return Requested._decode(input);
      case 2:
        return Cleared._decode(input);
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
      case Noted:
        (value as Noted).encodeTo(output);
        break;
      case Requested:
        (value as Requested).encodeTo(output);
        break;
      case Cleared:
        (value as Cleared).encodeTo(output);
        break;
      default:
        throw Exception(
            'Event: Unsupported "$value" of type "${value.runtimeType}"');
    }
  }

  @override
  int sizeHint(Event value) {
    switch (value.runtimeType) {
      case Noted:
        return (value as Noted)._sizeHint();
      case Requested:
        return (value as Requested)._sizeHint();
      case Cleared:
        return (value as Cleared)._sizeHint();
      default:
        throw Exception(
            'Event: Unsupported "$value" of type "${value.runtimeType}"');
    }
  }
}

/// A preimage has been noted.
class Noted extends Event {
  const Noted({required this.hash});

  factory Noted._decode(_i1.Input input) {
    return Noted(hash: const _i1.U8ArrayCodec(32).decode(input));
  }

  /// T::Hash
  final _i3.H256 hash;

  @override
  Map<String, Map<String, List<int>>> toJson() => {
        'Noted': {'hash': hash.toList()}
      };

  int _sizeHint() {
    int size = 1;
    size = size + const _i3.H256Codec().sizeHint(hash);
    return size;
  }

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      0,
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
      other is Noted &&
          _i4.listsEqual(
            other.hash,
            hash,
          );

  @override
  int get hashCode => hash.hashCode;
}

/// A preimage has been requested.
class Requested extends Event {
  const Requested({required this.hash});

  factory Requested._decode(_i1.Input input) {
    return Requested(hash: const _i1.U8ArrayCodec(32).decode(input));
  }

  /// T::Hash
  final _i3.H256 hash;

  @override
  Map<String, Map<String, List<int>>> toJson() => {
        'Requested': {'hash': hash.toList()}
      };

  int _sizeHint() {
    int size = 1;
    size = size + const _i3.H256Codec().sizeHint(hash);
    return size;
  }

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      1,
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
      other is Requested &&
          _i4.listsEqual(
            other.hash,
            hash,
          );

  @override
  int get hashCode => hash.hashCode;
}

/// A preimage has ben cleared.
class Cleared extends Event {
  const Cleared({required this.hash});

  factory Cleared._decode(_i1.Input input) {
    return Cleared(hash: const _i1.U8ArrayCodec(32).decode(input));
  }

  /// T::Hash
  final _i3.H256 hash;

  @override
  Map<String, Map<String, List<int>>> toJson() => {
        'Cleared': {'hash': hash.toList()}
      };

  int _sizeHint() {
    int size = 1;
    size = size + const _i3.H256Codec().sizeHint(hash);
    return size;
  }

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      2,
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
      other is Cleared &&
          _i4.listsEqual(
            other.hash,
            hash,
          );

  @override
  int get hashCode => hash.hashCode;
}
