// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:typed_data' as _i2;

import 'package:polkadart/scale_codec.dart' as _i1;

import '../../../polkadot_parachain/primitives/hrmp_channel_id.dart' as _i4;
import '../../../polkadot_parachain/primitives/id.dart' as _i3;

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

  Map<String, List<dynamic>> toJson();
}

class $Event {
  const $Event();

  OpenChannelRequested openChannelRequested(
    _i3.Id value0,
    _i3.Id value1,
    int value2,
    int value3,
  ) {
    return OpenChannelRequested(
      value0,
      value1,
      value2,
      value3,
    );
  }

  OpenChannelCanceled openChannelCanceled(
    _i3.Id value0,
    _i4.HrmpChannelId value1,
  ) {
    return OpenChannelCanceled(
      value0,
      value1,
    );
  }

  OpenChannelAccepted openChannelAccepted(
    _i3.Id value0,
    _i3.Id value1,
  ) {
    return OpenChannelAccepted(
      value0,
      value1,
    );
  }

  ChannelClosed channelClosed(
    _i3.Id value0,
    _i4.HrmpChannelId value1,
  ) {
    return ChannelClosed(
      value0,
      value1,
    );
  }

  HrmpChannelForceOpened hrmpChannelForceOpened(
    _i3.Id value0,
    _i3.Id value1,
    int value2,
    int value3,
  ) {
    return HrmpChannelForceOpened(
      value0,
      value1,
      value2,
      value3,
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
        return OpenChannelRequested._decode(input);
      case 1:
        return OpenChannelCanceled._decode(input);
      case 2:
        return OpenChannelAccepted._decode(input);
      case 3:
        return ChannelClosed._decode(input);
      case 4:
        return HrmpChannelForceOpened._decode(input);
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
      case OpenChannelRequested:
        (value as OpenChannelRequested).encodeTo(output);
        break;
      case OpenChannelCanceled:
        (value as OpenChannelCanceled).encodeTo(output);
        break;
      case OpenChannelAccepted:
        (value as OpenChannelAccepted).encodeTo(output);
        break;
      case ChannelClosed:
        (value as ChannelClosed).encodeTo(output);
        break;
      case HrmpChannelForceOpened:
        (value as HrmpChannelForceOpened).encodeTo(output);
        break;
      default:
        throw Exception(
            'Event: Unsupported "$value" of type "${value.runtimeType}"');
    }
  }

  @override
  int sizeHint(Event value) {
    switch (value.runtimeType) {
      case OpenChannelRequested:
        return (value as OpenChannelRequested)._sizeHint();
      case OpenChannelCanceled:
        return (value as OpenChannelCanceled)._sizeHint();
      case OpenChannelAccepted:
        return (value as OpenChannelAccepted)._sizeHint();
      case ChannelClosed:
        return (value as ChannelClosed)._sizeHint();
      case HrmpChannelForceOpened:
        return (value as HrmpChannelForceOpened)._sizeHint();
      default:
        throw Exception(
            'Event: Unsupported "$value" of type "${value.runtimeType}"');
    }
  }
}

/// Open HRMP channel requested.
/// `[sender, recipient, proposed_max_capacity, proposed_max_message_size]`
class OpenChannelRequested extends Event {
  const OpenChannelRequested(
    this.value0,
    this.value1,
    this.value2,
    this.value3,
  );

  factory OpenChannelRequested._decode(_i1.Input input) {
    return OpenChannelRequested(
      _i1.U32Codec.codec.decode(input),
      _i1.U32Codec.codec.decode(input),
      _i1.U32Codec.codec.decode(input),
      _i1.U32Codec.codec.decode(input),
    );
  }

  /// ParaId
  final _i3.Id value0;

  /// ParaId
  final _i3.Id value1;

  /// u32
  final int value2;

  /// u32
  final int value3;

  @override
  Map<String, List<int>> toJson() => {
        'OpenChannelRequested': [
          value0,
          value1,
          value2,
          value3,
        ]
      };

  int _sizeHint() {
    int size = 1;
    size = size + const _i3.IdCodec().sizeHint(value0);
    size = size + const _i3.IdCodec().sizeHint(value1);
    size = size + _i1.U32Codec.codec.sizeHint(value2);
    size = size + _i1.U32Codec.codec.sizeHint(value3);
    return size;
  }

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      0,
      output,
    );
    _i1.U32Codec.codec.encodeTo(
      value0,
      output,
    );
    _i1.U32Codec.codec.encodeTo(
      value1,
      output,
    );
    _i1.U32Codec.codec.encodeTo(
      value2,
      output,
    );
    _i1.U32Codec.codec.encodeTo(
      value3,
      output,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(
        this,
        other,
      ) ||
      other is OpenChannelRequested &&
          other.value0 == value0 &&
          other.value1 == value1 &&
          other.value2 == value2 &&
          other.value3 == value3;

  @override
  int get hashCode => Object.hash(
        value0,
        value1,
        value2,
        value3,
      );
}

/// An HRMP channel request sent by the receiver was canceled by either party.
/// `[by_parachain, channel_id]`
class OpenChannelCanceled extends Event {
  const OpenChannelCanceled(
    this.value0,
    this.value1,
  );

  factory OpenChannelCanceled._decode(_i1.Input input) {
    return OpenChannelCanceled(
      _i1.U32Codec.codec.decode(input),
      _i4.HrmpChannelId.codec.decode(input),
    );
  }

  /// ParaId
  final _i3.Id value0;

  /// HrmpChannelId
  final _i4.HrmpChannelId value1;

  @override
  Map<String, List<dynamic>> toJson() => {
        'OpenChannelCanceled': [
          value0,
          value1.toJson(),
        ]
      };

  int _sizeHint() {
    int size = 1;
    size = size + const _i3.IdCodec().sizeHint(value0);
    size = size + _i4.HrmpChannelId.codec.sizeHint(value1);
    return size;
  }

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      1,
      output,
    );
    _i1.U32Codec.codec.encodeTo(
      value0,
      output,
    );
    _i4.HrmpChannelId.codec.encodeTo(
      value1,
      output,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(
        this,
        other,
      ) ||
      other is OpenChannelCanceled &&
          other.value0 == value0 &&
          other.value1 == value1;

  @override
  int get hashCode => Object.hash(
        value0,
        value1,
      );
}

/// Open HRMP channel accepted. `[sender, recipient]`
class OpenChannelAccepted extends Event {
  const OpenChannelAccepted(
    this.value0,
    this.value1,
  );

  factory OpenChannelAccepted._decode(_i1.Input input) {
    return OpenChannelAccepted(
      _i1.U32Codec.codec.decode(input),
      _i1.U32Codec.codec.decode(input),
    );
  }

  /// ParaId
  final _i3.Id value0;

  /// ParaId
  final _i3.Id value1;

  @override
  Map<String, List<int>> toJson() => {
        'OpenChannelAccepted': [
          value0,
          value1,
        ]
      };

  int _sizeHint() {
    int size = 1;
    size = size + const _i3.IdCodec().sizeHint(value0);
    size = size + const _i3.IdCodec().sizeHint(value1);
    return size;
  }

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      2,
      output,
    );
    _i1.U32Codec.codec.encodeTo(
      value0,
      output,
    );
    _i1.U32Codec.codec.encodeTo(
      value1,
      output,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(
        this,
        other,
      ) ||
      other is OpenChannelAccepted &&
          other.value0 == value0 &&
          other.value1 == value1;

  @override
  int get hashCode => Object.hash(
        value0,
        value1,
      );
}

/// HRMP channel closed. `[by_parachain, channel_id]`
class ChannelClosed extends Event {
  const ChannelClosed(
    this.value0,
    this.value1,
  );

  factory ChannelClosed._decode(_i1.Input input) {
    return ChannelClosed(
      _i1.U32Codec.codec.decode(input),
      _i4.HrmpChannelId.codec.decode(input),
    );
  }

  /// ParaId
  final _i3.Id value0;

  /// HrmpChannelId
  final _i4.HrmpChannelId value1;

  @override
  Map<String, List<dynamic>> toJson() => {
        'ChannelClosed': [
          value0,
          value1.toJson(),
        ]
      };

  int _sizeHint() {
    int size = 1;
    size = size + const _i3.IdCodec().sizeHint(value0);
    size = size + _i4.HrmpChannelId.codec.sizeHint(value1);
    return size;
  }

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      3,
      output,
    );
    _i1.U32Codec.codec.encodeTo(
      value0,
      output,
    );
    _i4.HrmpChannelId.codec.encodeTo(
      value1,
      output,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(
        this,
        other,
      ) ||
      other is ChannelClosed &&
          other.value0 == value0 &&
          other.value1 == value1;

  @override
  int get hashCode => Object.hash(
        value0,
        value1,
      );
}

/// An HRMP channel was opened via Root origin.
/// `[sender, recipient, proposed_max_capacity, proposed_max_message_size]`
class HrmpChannelForceOpened extends Event {
  const HrmpChannelForceOpened(
    this.value0,
    this.value1,
    this.value2,
    this.value3,
  );

  factory HrmpChannelForceOpened._decode(_i1.Input input) {
    return HrmpChannelForceOpened(
      _i1.U32Codec.codec.decode(input),
      _i1.U32Codec.codec.decode(input),
      _i1.U32Codec.codec.decode(input),
      _i1.U32Codec.codec.decode(input),
    );
  }

  /// ParaId
  final _i3.Id value0;

  /// ParaId
  final _i3.Id value1;

  /// u32
  final int value2;

  /// u32
  final int value3;

  @override
  Map<String, List<int>> toJson() => {
        'HrmpChannelForceOpened': [
          value0,
          value1,
          value2,
          value3,
        ]
      };

  int _sizeHint() {
    int size = 1;
    size = size + const _i3.IdCodec().sizeHint(value0);
    size = size + const _i3.IdCodec().sizeHint(value1);
    size = size + _i1.U32Codec.codec.sizeHint(value2);
    size = size + _i1.U32Codec.codec.sizeHint(value3);
    return size;
  }

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      4,
      output,
    );
    _i1.U32Codec.codec.encodeTo(
      value0,
      output,
    );
    _i1.U32Codec.codec.encodeTo(
      value1,
      output,
    );
    _i1.U32Codec.codec.encodeTo(
      value2,
      output,
    );
    _i1.U32Codec.codec.encodeTo(
      value3,
      output,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(
        this,
        other,
      ) ||
      other is HrmpChannelForceOpened &&
          other.value0 == value0 &&
          other.value1 == value1 &&
          other.value2 == value2 &&
          other.value3 == value3;

  @override
  int get hashCode => Object.hash(
        value0,
        value1,
        value2,
        value3,
      );
}
