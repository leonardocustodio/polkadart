// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:typed_data' as _i2;

import 'package:polkadart/scale_codec.dart' as _i1;

import '../../../polkadot_primitives/v7/core_index.dart' as _i3;

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

  Map<String, Map<String, int>> toJson();
}

class $Event {
  const $Event();

  RevenueInfoRequested revenueInfoRequested({required int when}) {
    return RevenueInfoRequested(when: when);
  }

  CoreAssigned coreAssigned({required _i3.CoreIndex core}) {
    return CoreAssigned(core: core);
  }
}

class $EventCodec with _i1.Codec<Event> {
  const $EventCodec();

  @override
  Event decode(_i1.Input input) {
    final index = _i1.U8Codec.codec.decode(input);
    switch (index) {
      case 0:
        return RevenueInfoRequested._decode(input);
      case 1:
        return CoreAssigned._decode(input);
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
      case RevenueInfoRequested:
        (value as RevenueInfoRequested).encodeTo(output);
        break;
      case CoreAssigned:
        (value as CoreAssigned).encodeTo(output);
        break;
      default:
        throw Exception(
            'Event: Unsupported "$value" of type "${value.runtimeType}"');
    }
  }

  @override
  int sizeHint(Event value) {
    switch (value.runtimeType) {
      case RevenueInfoRequested:
        return (value as RevenueInfoRequested)._sizeHint();
      case CoreAssigned:
        return (value as CoreAssigned)._sizeHint();
      default:
        throw Exception(
            'Event: Unsupported "$value" of type "${value.runtimeType}"');
    }
  }
}

/// The broker chain has asked for revenue information for a specific block.
class RevenueInfoRequested extends Event {
  const RevenueInfoRequested({required this.when});

  factory RevenueInfoRequested._decode(_i1.Input input) {
    return RevenueInfoRequested(when: _i1.U32Codec.codec.decode(input));
  }

  /// BlockNumberFor<T>
  final int when;

  @override
  Map<String, Map<String, int>> toJson() => {
        'RevenueInfoRequested': {'when': when}
      };

  int _sizeHint() {
    int size = 1;
    size = size + _i1.U32Codec.codec.sizeHint(when);
    return size;
  }

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      0,
      output,
    );
    _i1.U32Codec.codec.encodeTo(
      when,
      output,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(
        this,
        other,
      ) ||
      other is RevenueInfoRequested && other.when == when;

  @override
  int get hashCode => when.hashCode;
}

/// A core has received a new assignment from the broker chain.
class CoreAssigned extends Event {
  const CoreAssigned({required this.core});

  factory CoreAssigned._decode(_i1.Input input) {
    return CoreAssigned(core: _i1.U32Codec.codec.decode(input));
  }

  /// CoreIndex
  final _i3.CoreIndex core;

  @override
  Map<String, Map<String, int>> toJson() => {
        'CoreAssigned': {'core': core}
      };

  int _sizeHint() {
    int size = 1;
    size = size + const _i3.CoreIndexCodec().sizeHint(core);
    return size;
  }

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      1,
      output,
    );
    _i1.U32Codec.codec.encodeTo(
      core,
      output,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(
        this,
        other,
      ) ||
      other is CoreAssigned && other.core == core;

  @override
  int get hashCode => core.hashCode;
}
