// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:typed_data' as _i2;

import 'package:polkadart/scale_codec.dart' as _i1;
import 'package:quiver/collection.dart' as _i5;

import '../../../polkadot_parachain/primitives/id.dart' as _i3;
import '../../../sp_core/crypto/account_id32.dart' as _i4;

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

  Registered registered({
    required _i3.Id paraId,
    required _i4.AccountId32 manager,
  }) {
    return Registered(
      paraId: paraId,
      manager: manager,
    );
  }

  Deregistered deregistered({required _i3.Id paraId}) {
    return Deregistered(paraId: paraId);
  }

  Reserved reserved({
    required _i3.Id paraId,
    required _i4.AccountId32 who,
  }) {
    return Reserved(
      paraId: paraId,
      who: who,
    );
  }

  Swapped swapped({
    required _i3.Id paraId,
    required _i3.Id otherId,
  }) {
    return Swapped(
      paraId: paraId,
      otherId: otherId,
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
        return Registered._decode(input);
      case 1:
        return Deregistered._decode(input);
      case 2:
        return Reserved._decode(input);
      case 3:
        return Swapped._decode(input);
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
      case Registered:
        (value as Registered).encodeTo(output);
        break;
      case Deregistered:
        (value as Deregistered).encodeTo(output);
        break;
      case Reserved:
        (value as Reserved).encodeTo(output);
        break;
      case Swapped:
        (value as Swapped).encodeTo(output);
        break;
      default:
        throw Exception(
            'Event: Unsupported "$value" of type "${value.runtimeType}"');
    }
  }

  @override
  int sizeHint(Event value) {
    switch (value.runtimeType) {
      case Registered:
        return (value as Registered)._sizeHint();
      case Deregistered:
        return (value as Deregistered)._sizeHint();
      case Reserved:
        return (value as Reserved)._sizeHint();
      case Swapped:
        return (value as Swapped)._sizeHint();
      default:
        throw Exception(
            'Event: Unsupported "$value" of type "${value.runtimeType}"');
    }
  }
}

class Registered extends Event {
  const Registered({
    required this.paraId,
    required this.manager,
  });

  factory Registered._decode(_i1.Input input) {
    return Registered(
      paraId: _i1.U32Codec.codec.decode(input),
      manager: const _i1.U8ArrayCodec(32).decode(input),
    );
  }

  /// ParaId
  final _i3.Id paraId;

  /// T::AccountId
  final _i4.AccountId32 manager;

  @override
  Map<String, Map<String, dynamic>> toJson() => {
        'Registered': {
          'paraId': paraId,
          'manager': manager.toList(),
        }
      };

  int _sizeHint() {
    int size = 1;
    size = size + const _i3.IdCodec().sizeHint(paraId);
    size = size + const _i4.AccountId32Codec().sizeHint(manager);
    return size;
  }

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      0,
      output,
    );
    _i1.U32Codec.codec.encodeTo(
      paraId,
      output,
    );
    const _i1.U8ArrayCodec(32).encodeTo(
      manager,
      output,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(
        this,
        other,
      ) ||
      other is Registered &&
          other.paraId == paraId &&
          _i5.listsEqual(
            other.manager,
            manager,
          );

  @override
  int get hashCode => Object.hash(
        paraId,
        manager,
      );
}

class Deregistered extends Event {
  const Deregistered({required this.paraId});

  factory Deregistered._decode(_i1.Input input) {
    return Deregistered(paraId: _i1.U32Codec.codec.decode(input));
  }

  /// ParaId
  final _i3.Id paraId;

  @override
  Map<String, Map<String, int>> toJson() => {
        'Deregistered': {'paraId': paraId}
      };

  int _sizeHint() {
    int size = 1;
    size = size + const _i3.IdCodec().sizeHint(paraId);
    return size;
  }

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      1,
      output,
    );
    _i1.U32Codec.codec.encodeTo(
      paraId,
      output,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(
        this,
        other,
      ) ||
      other is Deregistered && other.paraId == paraId;

  @override
  int get hashCode => paraId.hashCode;
}

class Reserved extends Event {
  const Reserved({
    required this.paraId,
    required this.who,
  });

  factory Reserved._decode(_i1.Input input) {
    return Reserved(
      paraId: _i1.U32Codec.codec.decode(input),
      who: const _i1.U8ArrayCodec(32).decode(input),
    );
  }

  /// ParaId
  final _i3.Id paraId;

  /// T::AccountId
  final _i4.AccountId32 who;

  @override
  Map<String, Map<String, dynamic>> toJson() => {
        'Reserved': {
          'paraId': paraId,
          'who': who.toList(),
        }
      };

  int _sizeHint() {
    int size = 1;
    size = size + const _i3.IdCodec().sizeHint(paraId);
    size = size + const _i4.AccountId32Codec().sizeHint(who);
    return size;
  }

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      2,
      output,
    );
    _i1.U32Codec.codec.encodeTo(
      paraId,
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
      other is Reserved &&
          other.paraId == paraId &&
          _i5.listsEqual(
            other.who,
            who,
          );

  @override
  int get hashCode => Object.hash(
        paraId,
        who,
      );
}

class Swapped extends Event {
  const Swapped({
    required this.paraId,
    required this.otherId,
  });

  factory Swapped._decode(_i1.Input input) {
    return Swapped(
      paraId: _i1.U32Codec.codec.decode(input),
      otherId: _i1.U32Codec.codec.decode(input),
    );
  }

  /// ParaId
  final _i3.Id paraId;

  /// ParaId
  final _i3.Id otherId;

  @override
  Map<String, Map<String, int>> toJson() => {
        'Swapped': {
          'paraId': paraId,
          'otherId': otherId,
        }
      };

  int _sizeHint() {
    int size = 1;
    size = size + const _i3.IdCodec().sizeHint(paraId);
    size = size + const _i3.IdCodec().sizeHint(otherId);
    return size;
  }

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      3,
      output,
    );
    _i1.U32Codec.codec.encodeTo(
      paraId,
      output,
    );
    _i1.U32Codec.codec.encodeTo(
      otherId,
      output,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(
        this,
        other,
      ) ||
      other is Swapped && other.paraId == paraId && other.otherId == otherId;

  @override
  int get hashCode => Object.hash(
        paraId,
        otherId,
      );
}
