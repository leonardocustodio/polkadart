// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:typed_data' as _i2;

import 'package:polkadart/scale_codec.dart' as _i1;
import 'package:quiver/collection.dart' as _i3;

/// Events type.
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

  Offence offence({
    required List<int> kind,
    required List<int> timeslot,
  }) {
    return Offence(
      kind: kind,
      timeslot: timeslot,
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
        return Offence._decode(input);
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
      case Offence:
        (value as Offence).encodeTo(output);
        break;
      default:
        throw Exception(
            'Event: Unsupported "$value" of type "${value.runtimeType}"');
    }
  }

  @override
  int sizeHint(Event value) {
    switch (value.runtimeType) {
      case Offence:
        return (value as Offence)._sizeHint();
      default:
        throw Exception(
            'Event: Unsupported "$value" of type "${value.runtimeType}"');
    }
  }
}

/// There is an offence reported of the given `kind` happened at the `session_index` and
/// (kind-specific) time slot. This event is not deposited for duplicate slashes.
/// \[kind, timeslot\].
class Offence extends Event {
  const Offence({
    required this.kind,
    required this.timeslot,
  });

  factory Offence._decode(_i1.Input input) {
    return Offence(
      kind: const _i1.U8ArrayCodec(16).decode(input),
      timeslot: _i1.U8SequenceCodec.codec.decode(input),
    );
  }

  /// Kind
  final List<int> kind;

  /// OpaqueTimeSlot
  final List<int> timeslot;

  @override
  Map<String, Map<String, List<int>>> toJson() => {
        'Offence': {
          'kind': kind.toList(),
          'timeslot': timeslot,
        }
      };

  int _sizeHint() {
    int size = 1;
    size = size + const _i1.U8ArrayCodec(16).sizeHint(kind);
    size = size + _i1.U8SequenceCodec.codec.sizeHint(timeslot);
    return size;
  }

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      0,
      output,
    );
    const _i1.U8ArrayCodec(16).encodeTo(
      kind,
      output,
    );
    _i1.U8SequenceCodec.codec.encodeTo(
      timeslot,
      output,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(
        this,
        other,
      ) ||
      other is Offence &&
          _i3.listsEqual(
            other.kind,
            kind,
          ) &&
          _i3.listsEqual(
            other.timeslot,
            timeslot,
          );

  @override
  int get hashCode => Object.hash(
        kind,
        timeslot,
      );
}
