// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:typed_data' as _i2;

import 'package:polkadart/scale_codec.dart' as _i1;

import '../../../polkadot_parachain_primitives/primitives/hrmp_channel_id.dart'
    as _i4;
import '../../../polkadot_parachain_primitives/primitives/id.dart' as _i3;

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

  OpenChannelRequested openChannelRequested({
    required _i3.Id sender,
    required _i3.Id recipient,
    required int proposedMaxCapacity,
    required int proposedMaxMessageSize,
  }) {
    return OpenChannelRequested(
      sender: sender,
      recipient: recipient,
      proposedMaxCapacity: proposedMaxCapacity,
      proposedMaxMessageSize: proposedMaxMessageSize,
    );
  }

  OpenChannelCanceled openChannelCanceled({
    required _i3.Id byParachain,
    required _i4.HrmpChannelId channelId,
  }) {
    return OpenChannelCanceled(
      byParachain: byParachain,
      channelId: channelId,
    );
  }

  OpenChannelAccepted openChannelAccepted({
    required _i3.Id sender,
    required _i3.Id recipient,
  }) {
    return OpenChannelAccepted(
      sender: sender,
      recipient: recipient,
    );
  }

  ChannelClosed channelClosed({
    required _i3.Id byParachain,
    required _i4.HrmpChannelId channelId,
  }) {
    return ChannelClosed(
      byParachain: byParachain,
      channelId: channelId,
    );
  }

  HrmpChannelForceOpened hrmpChannelForceOpened({
    required _i3.Id sender,
    required _i3.Id recipient,
    required int proposedMaxCapacity,
    required int proposedMaxMessageSize,
  }) {
    return HrmpChannelForceOpened(
      sender: sender,
      recipient: recipient,
      proposedMaxCapacity: proposedMaxCapacity,
      proposedMaxMessageSize: proposedMaxMessageSize,
    );
  }

  HrmpSystemChannelOpened hrmpSystemChannelOpened({
    required _i3.Id sender,
    required _i3.Id recipient,
    required int proposedMaxCapacity,
    required int proposedMaxMessageSize,
  }) {
    return HrmpSystemChannelOpened(
      sender: sender,
      recipient: recipient,
      proposedMaxCapacity: proposedMaxCapacity,
      proposedMaxMessageSize: proposedMaxMessageSize,
    );
  }

  OpenChannelDepositsUpdated openChannelDepositsUpdated({
    required _i3.Id sender,
    required _i3.Id recipient,
  }) {
    return OpenChannelDepositsUpdated(
      sender: sender,
      recipient: recipient,
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
      case 5:
        return HrmpSystemChannelOpened._decode(input);
      case 6:
        return OpenChannelDepositsUpdated._decode(input);
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
      case HrmpSystemChannelOpened:
        (value as HrmpSystemChannelOpened).encodeTo(output);
        break;
      case OpenChannelDepositsUpdated:
        (value as OpenChannelDepositsUpdated).encodeTo(output);
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
      case HrmpSystemChannelOpened:
        return (value as HrmpSystemChannelOpened)._sizeHint();
      case OpenChannelDepositsUpdated:
        return (value as OpenChannelDepositsUpdated)._sizeHint();
      default:
        throw Exception(
            'Event: Unsupported "$value" of type "${value.runtimeType}"');
    }
  }
}

/// Open HRMP channel requested.
class OpenChannelRequested extends Event {
  const OpenChannelRequested({
    required this.sender,
    required this.recipient,
    required this.proposedMaxCapacity,
    required this.proposedMaxMessageSize,
  });

  factory OpenChannelRequested._decode(_i1.Input input) {
    return OpenChannelRequested(
      sender: _i1.U32Codec.codec.decode(input),
      recipient: _i1.U32Codec.codec.decode(input),
      proposedMaxCapacity: _i1.U32Codec.codec.decode(input),
      proposedMaxMessageSize: _i1.U32Codec.codec.decode(input),
    );
  }

  /// ParaId
  final _i3.Id sender;

  /// ParaId
  final _i3.Id recipient;

  /// u32
  final int proposedMaxCapacity;

  /// u32
  final int proposedMaxMessageSize;

  @override
  Map<String, Map<String, int>> toJson() => {
        'OpenChannelRequested': {
          'sender': sender,
          'recipient': recipient,
          'proposedMaxCapacity': proposedMaxCapacity,
          'proposedMaxMessageSize': proposedMaxMessageSize,
        }
      };

  int _sizeHint() {
    int size = 1;
    size = size + const _i3.IdCodec().sizeHint(sender);
    size = size + const _i3.IdCodec().sizeHint(recipient);
    size = size + _i1.U32Codec.codec.sizeHint(proposedMaxCapacity);
    size = size + _i1.U32Codec.codec.sizeHint(proposedMaxMessageSize);
    return size;
  }

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      0,
      output,
    );
    _i1.U32Codec.codec.encodeTo(
      sender,
      output,
    );
    _i1.U32Codec.codec.encodeTo(
      recipient,
      output,
    );
    _i1.U32Codec.codec.encodeTo(
      proposedMaxCapacity,
      output,
    );
    _i1.U32Codec.codec.encodeTo(
      proposedMaxMessageSize,
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
          other.sender == sender &&
          other.recipient == recipient &&
          other.proposedMaxCapacity == proposedMaxCapacity &&
          other.proposedMaxMessageSize == proposedMaxMessageSize;

  @override
  int get hashCode => Object.hash(
        sender,
        recipient,
        proposedMaxCapacity,
        proposedMaxMessageSize,
      );
}

/// An HRMP channel request sent by the receiver was canceled by either party.
class OpenChannelCanceled extends Event {
  const OpenChannelCanceled({
    required this.byParachain,
    required this.channelId,
  });

  factory OpenChannelCanceled._decode(_i1.Input input) {
    return OpenChannelCanceled(
      byParachain: _i1.U32Codec.codec.decode(input),
      channelId: _i4.HrmpChannelId.codec.decode(input),
    );
  }

  /// ParaId
  final _i3.Id byParachain;

  /// HrmpChannelId
  final _i4.HrmpChannelId channelId;

  @override
  Map<String, Map<String, dynamic>> toJson() => {
        'OpenChannelCanceled': {
          'byParachain': byParachain,
          'channelId': channelId.toJson(),
        }
      };

  int _sizeHint() {
    int size = 1;
    size = size + const _i3.IdCodec().sizeHint(byParachain);
    size = size + _i4.HrmpChannelId.codec.sizeHint(channelId);
    return size;
  }

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      1,
      output,
    );
    _i1.U32Codec.codec.encodeTo(
      byParachain,
      output,
    );
    _i4.HrmpChannelId.codec.encodeTo(
      channelId,
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
          other.byParachain == byParachain &&
          other.channelId == channelId;

  @override
  int get hashCode => Object.hash(
        byParachain,
        channelId,
      );
}

/// Open HRMP channel accepted.
class OpenChannelAccepted extends Event {
  const OpenChannelAccepted({
    required this.sender,
    required this.recipient,
  });

  factory OpenChannelAccepted._decode(_i1.Input input) {
    return OpenChannelAccepted(
      sender: _i1.U32Codec.codec.decode(input),
      recipient: _i1.U32Codec.codec.decode(input),
    );
  }

  /// ParaId
  final _i3.Id sender;

  /// ParaId
  final _i3.Id recipient;

  @override
  Map<String, Map<String, int>> toJson() => {
        'OpenChannelAccepted': {
          'sender': sender,
          'recipient': recipient,
        }
      };

  int _sizeHint() {
    int size = 1;
    size = size + const _i3.IdCodec().sizeHint(sender);
    size = size + const _i3.IdCodec().sizeHint(recipient);
    return size;
  }

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      2,
      output,
    );
    _i1.U32Codec.codec.encodeTo(
      sender,
      output,
    );
    _i1.U32Codec.codec.encodeTo(
      recipient,
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
          other.sender == sender &&
          other.recipient == recipient;

  @override
  int get hashCode => Object.hash(
        sender,
        recipient,
      );
}

/// HRMP channel closed.
class ChannelClosed extends Event {
  const ChannelClosed({
    required this.byParachain,
    required this.channelId,
  });

  factory ChannelClosed._decode(_i1.Input input) {
    return ChannelClosed(
      byParachain: _i1.U32Codec.codec.decode(input),
      channelId: _i4.HrmpChannelId.codec.decode(input),
    );
  }

  /// ParaId
  final _i3.Id byParachain;

  /// HrmpChannelId
  final _i4.HrmpChannelId channelId;

  @override
  Map<String, Map<String, dynamic>> toJson() => {
        'ChannelClosed': {
          'byParachain': byParachain,
          'channelId': channelId.toJson(),
        }
      };

  int _sizeHint() {
    int size = 1;
    size = size + const _i3.IdCodec().sizeHint(byParachain);
    size = size + _i4.HrmpChannelId.codec.sizeHint(channelId);
    return size;
  }

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      3,
      output,
    );
    _i1.U32Codec.codec.encodeTo(
      byParachain,
      output,
    );
    _i4.HrmpChannelId.codec.encodeTo(
      channelId,
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
          other.byParachain == byParachain &&
          other.channelId == channelId;

  @override
  int get hashCode => Object.hash(
        byParachain,
        channelId,
      );
}

/// An HRMP channel was opened via Root origin.
class HrmpChannelForceOpened extends Event {
  const HrmpChannelForceOpened({
    required this.sender,
    required this.recipient,
    required this.proposedMaxCapacity,
    required this.proposedMaxMessageSize,
  });

  factory HrmpChannelForceOpened._decode(_i1.Input input) {
    return HrmpChannelForceOpened(
      sender: _i1.U32Codec.codec.decode(input),
      recipient: _i1.U32Codec.codec.decode(input),
      proposedMaxCapacity: _i1.U32Codec.codec.decode(input),
      proposedMaxMessageSize: _i1.U32Codec.codec.decode(input),
    );
  }

  /// ParaId
  final _i3.Id sender;

  /// ParaId
  final _i3.Id recipient;

  /// u32
  final int proposedMaxCapacity;

  /// u32
  final int proposedMaxMessageSize;

  @override
  Map<String, Map<String, int>> toJson() => {
        'HrmpChannelForceOpened': {
          'sender': sender,
          'recipient': recipient,
          'proposedMaxCapacity': proposedMaxCapacity,
          'proposedMaxMessageSize': proposedMaxMessageSize,
        }
      };

  int _sizeHint() {
    int size = 1;
    size = size + const _i3.IdCodec().sizeHint(sender);
    size = size + const _i3.IdCodec().sizeHint(recipient);
    size = size + _i1.U32Codec.codec.sizeHint(proposedMaxCapacity);
    size = size + _i1.U32Codec.codec.sizeHint(proposedMaxMessageSize);
    return size;
  }

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      4,
      output,
    );
    _i1.U32Codec.codec.encodeTo(
      sender,
      output,
    );
    _i1.U32Codec.codec.encodeTo(
      recipient,
      output,
    );
    _i1.U32Codec.codec.encodeTo(
      proposedMaxCapacity,
      output,
    );
    _i1.U32Codec.codec.encodeTo(
      proposedMaxMessageSize,
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
          other.sender == sender &&
          other.recipient == recipient &&
          other.proposedMaxCapacity == proposedMaxCapacity &&
          other.proposedMaxMessageSize == proposedMaxMessageSize;

  @override
  int get hashCode => Object.hash(
        sender,
        recipient,
        proposedMaxCapacity,
        proposedMaxMessageSize,
      );
}

/// An HRMP channel was opened with a system chain.
class HrmpSystemChannelOpened extends Event {
  const HrmpSystemChannelOpened({
    required this.sender,
    required this.recipient,
    required this.proposedMaxCapacity,
    required this.proposedMaxMessageSize,
  });

  factory HrmpSystemChannelOpened._decode(_i1.Input input) {
    return HrmpSystemChannelOpened(
      sender: _i1.U32Codec.codec.decode(input),
      recipient: _i1.U32Codec.codec.decode(input),
      proposedMaxCapacity: _i1.U32Codec.codec.decode(input),
      proposedMaxMessageSize: _i1.U32Codec.codec.decode(input),
    );
  }

  /// ParaId
  final _i3.Id sender;

  /// ParaId
  final _i3.Id recipient;

  /// u32
  final int proposedMaxCapacity;

  /// u32
  final int proposedMaxMessageSize;

  @override
  Map<String, Map<String, int>> toJson() => {
        'HrmpSystemChannelOpened': {
          'sender': sender,
          'recipient': recipient,
          'proposedMaxCapacity': proposedMaxCapacity,
          'proposedMaxMessageSize': proposedMaxMessageSize,
        }
      };

  int _sizeHint() {
    int size = 1;
    size = size + const _i3.IdCodec().sizeHint(sender);
    size = size + const _i3.IdCodec().sizeHint(recipient);
    size = size + _i1.U32Codec.codec.sizeHint(proposedMaxCapacity);
    size = size + _i1.U32Codec.codec.sizeHint(proposedMaxMessageSize);
    return size;
  }

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      5,
      output,
    );
    _i1.U32Codec.codec.encodeTo(
      sender,
      output,
    );
    _i1.U32Codec.codec.encodeTo(
      recipient,
      output,
    );
    _i1.U32Codec.codec.encodeTo(
      proposedMaxCapacity,
      output,
    );
    _i1.U32Codec.codec.encodeTo(
      proposedMaxMessageSize,
      output,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(
        this,
        other,
      ) ||
      other is HrmpSystemChannelOpened &&
          other.sender == sender &&
          other.recipient == recipient &&
          other.proposedMaxCapacity == proposedMaxCapacity &&
          other.proposedMaxMessageSize == proposedMaxMessageSize;

  @override
  int get hashCode => Object.hash(
        sender,
        recipient,
        proposedMaxCapacity,
        proposedMaxMessageSize,
      );
}

/// An HRMP channel's deposits were updated.
class OpenChannelDepositsUpdated extends Event {
  const OpenChannelDepositsUpdated({
    required this.sender,
    required this.recipient,
  });

  factory OpenChannelDepositsUpdated._decode(_i1.Input input) {
    return OpenChannelDepositsUpdated(
      sender: _i1.U32Codec.codec.decode(input),
      recipient: _i1.U32Codec.codec.decode(input),
    );
  }

  /// ParaId
  final _i3.Id sender;

  /// ParaId
  final _i3.Id recipient;

  @override
  Map<String, Map<String, int>> toJson() => {
        'OpenChannelDepositsUpdated': {
          'sender': sender,
          'recipient': recipient,
        }
      };

  int _sizeHint() {
    int size = 1;
    size = size + const _i3.IdCodec().sizeHint(sender);
    size = size + const _i3.IdCodec().sizeHint(recipient);
    return size;
  }

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      6,
      output,
    );
    _i1.U32Codec.codec.encodeTo(
      sender,
      output,
    );
    _i1.U32Codec.codec.encodeTo(
      recipient,
      output,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(
        this,
        other,
      ) ||
      other is OpenChannelDepositsUpdated &&
          other.sender == sender &&
          other.recipient == recipient;

  @override
  int get hashCode => Object.hash(
        sender,
        recipient,
      );
}
