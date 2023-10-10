// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:typed_data' as _i2;

import 'package:polkadart/scale_codec.dart' as _i1;

import '../../../polkadot_parachain/primitives/hrmp_channel_id.dart' as _i4;
import '../../../polkadot_parachain/primitives/id.dart' as _i3;

/// Contains one variant per dispatchable that can be called by an extrinsic.
abstract class Call {
  const Call();

  factory Call.decode(_i1.Input input) {
    return codec.decode(input);
  }

  static const $CallCodec codec = $CallCodec();

  static const $Call values = $Call();

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

class $Call {
  const $Call();

  HrmpInitOpenChannel hrmpInitOpenChannel({
    required _i3.Id recipient,
    required int proposedMaxCapacity,
    required int proposedMaxMessageSize,
  }) {
    return HrmpInitOpenChannel(
      recipient: recipient,
      proposedMaxCapacity: proposedMaxCapacity,
      proposedMaxMessageSize: proposedMaxMessageSize,
    );
  }

  HrmpAcceptOpenChannel hrmpAcceptOpenChannel({required _i3.Id sender}) {
    return HrmpAcceptOpenChannel(sender: sender);
  }

  HrmpCloseChannel hrmpCloseChannel({required _i4.HrmpChannelId channelId}) {
    return HrmpCloseChannel(channelId: channelId);
  }

  ForceCleanHrmp forceCleanHrmp({
    required _i3.Id para,
    required int inbound,
    required int outbound,
  }) {
    return ForceCleanHrmp(
      para: para,
      inbound: inbound,
      outbound: outbound,
    );
  }

  ForceProcessHrmpOpen forceProcessHrmpOpen({required int channels}) {
    return ForceProcessHrmpOpen(channels: channels);
  }

  ForceProcessHrmpClose forceProcessHrmpClose({required int channels}) {
    return ForceProcessHrmpClose(channels: channels);
  }

  HrmpCancelOpenRequest hrmpCancelOpenRequest({
    required _i4.HrmpChannelId channelId,
    required int openRequests,
  }) {
    return HrmpCancelOpenRequest(
      channelId: channelId,
      openRequests: openRequests,
    );
  }

  ForceOpenHrmpChannel forceOpenHrmpChannel({
    required _i3.Id sender,
    required _i3.Id recipient,
    required int maxCapacity,
    required int maxMessageSize,
  }) {
    return ForceOpenHrmpChannel(
      sender: sender,
      recipient: recipient,
      maxCapacity: maxCapacity,
      maxMessageSize: maxMessageSize,
    );
  }
}

class $CallCodec with _i1.Codec<Call> {
  const $CallCodec();

  @override
  Call decode(_i1.Input input) {
    final index = _i1.U8Codec.codec.decode(input);
    switch (index) {
      case 0:
        return HrmpInitOpenChannel._decode(input);
      case 1:
        return HrmpAcceptOpenChannel._decode(input);
      case 2:
        return HrmpCloseChannel._decode(input);
      case 3:
        return ForceCleanHrmp._decode(input);
      case 4:
        return ForceProcessHrmpOpen._decode(input);
      case 5:
        return ForceProcessHrmpClose._decode(input);
      case 6:
        return HrmpCancelOpenRequest._decode(input);
      case 7:
        return ForceOpenHrmpChannel._decode(input);
      default:
        throw Exception('Call: Invalid variant index: "$index"');
    }
  }

  @override
  void encodeTo(
    Call value,
    _i1.Output output,
  ) {
    switch (value.runtimeType) {
      case HrmpInitOpenChannel:
        (value as HrmpInitOpenChannel).encodeTo(output);
        break;
      case HrmpAcceptOpenChannel:
        (value as HrmpAcceptOpenChannel).encodeTo(output);
        break;
      case HrmpCloseChannel:
        (value as HrmpCloseChannel).encodeTo(output);
        break;
      case ForceCleanHrmp:
        (value as ForceCleanHrmp).encodeTo(output);
        break;
      case ForceProcessHrmpOpen:
        (value as ForceProcessHrmpOpen).encodeTo(output);
        break;
      case ForceProcessHrmpClose:
        (value as ForceProcessHrmpClose).encodeTo(output);
        break;
      case HrmpCancelOpenRequest:
        (value as HrmpCancelOpenRequest).encodeTo(output);
        break;
      case ForceOpenHrmpChannel:
        (value as ForceOpenHrmpChannel).encodeTo(output);
        break;
      default:
        throw Exception(
            'Call: Unsupported "$value" of type "${value.runtimeType}"');
    }
  }

  @override
  int sizeHint(Call value) {
    switch (value.runtimeType) {
      case HrmpInitOpenChannel:
        return (value as HrmpInitOpenChannel)._sizeHint();
      case HrmpAcceptOpenChannel:
        return (value as HrmpAcceptOpenChannel)._sizeHint();
      case HrmpCloseChannel:
        return (value as HrmpCloseChannel)._sizeHint();
      case ForceCleanHrmp:
        return (value as ForceCleanHrmp)._sizeHint();
      case ForceProcessHrmpOpen:
        return (value as ForceProcessHrmpOpen)._sizeHint();
      case ForceProcessHrmpClose:
        return (value as ForceProcessHrmpClose)._sizeHint();
      case HrmpCancelOpenRequest:
        return (value as HrmpCancelOpenRequest)._sizeHint();
      case ForceOpenHrmpChannel:
        return (value as ForceOpenHrmpChannel)._sizeHint();
      default:
        throw Exception(
            'Call: Unsupported "$value" of type "${value.runtimeType}"');
    }
  }
}

/// Initiate opening a channel from a parachain to a given recipient with given channel
/// parameters.
///
/// - `proposed_max_capacity` - specifies how many messages can be in the channel at once.
/// - `proposed_max_message_size` - specifies the maximum size of the messages.
///
/// These numbers are a subject to the relay-chain configuration limits.
///
/// The channel can be opened only after the recipient confirms it and only on a session
/// change.
class HrmpInitOpenChannel extends Call {
  const HrmpInitOpenChannel({
    required this.recipient,
    required this.proposedMaxCapacity,
    required this.proposedMaxMessageSize,
  });

  factory HrmpInitOpenChannel._decode(_i1.Input input) {
    return HrmpInitOpenChannel(
      recipient: _i1.U32Codec.codec.decode(input),
      proposedMaxCapacity: _i1.U32Codec.codec.decode(input),
      proposedMaxMessageSize: _i1.U32Codec.codec.decode(input),
    );
  }

  /// ParaId
  final _i3.Id recipient;

  /// u32
  final int proposedMaxCapacity;

  /// u32
  final int proposedMaxMessageSize;

  @override
  Map<String, Map<String, int>> toJson() => {
        'hrmp_init_open_channel': {
          'recipient': recipient,
          'proposedMaxCapacity': proposedMaxCapacity,
          'proposedMaxMessageSize': proposedMaxMessageSize,
        }
      };

  int _sizeHint() {
    int size = 1;
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
      other is HrmpInitOpenChannel &&
          other.recipient == recipient &&
          other.proposedMaxCapacity == proposedMaxCapacity &&
          other.proposedMaxMessageSize == proposedMaxMessageSize;

  @override
  int get hashCode => Object.hash(
        recipient,
        proposedMaxCapacity,
        proposedMaxMessageSize,
      );
}

/// Accept a pending open channel request from the given sender.
///
/// The channel will be opened only on the next session boundary.
class HrmpAcceptOpenChannel extends Call {
  const HrmpAcceptOpenChannel({required this.sender});

  factory HrmpAcceptOpenChannel._decode(_i1.Input input) {
    return HrmpAcceptOpenChannel(sender: _i1.U32Codec.codec.decode(input));
  }

  /// ParaId
  final _i3.Id sender;

  @override
  Map<String, Map<String, int>> toJson() => {
        'hrmp_accept_open_channel': {'sender': sender}
      };

  int _sizeHint() {
    int size = 1;
    size = size + const _i3.IdCodec().sizeHint(sender);
    return size;
  }

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      1,
      output,
    );
    _i1.U32Codec.codec.encodeTo(
      sender,
      output,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(
        this,
        other,
      ) ||
      other is HrmpAcceptOpenChannel && other.sender == sender;

  @override
  int get hashCode => sender.hashCode;
}

/// Initiate unilateral closing of a channel. The origin must be either the sender or the
/// recipient in the channel being closed.
///
/// The closure can only happen on a session change.
class HrmpCloseChannel extends Call {
  const HrmpCloseChannel({required this.channelId});

  factory HrmpCloseChannel._decode(_i1.Input input) {
    return HrmpCloseChannel(channelId: _i4.HrmpChannelId.codec.decode(input));
  }

  /// HrmpChannelId
  final _i4.HrmpChannelId channelId;

  @override
  Map<String, Map<String, Map<String, int>>> toJson() => {
        'hrmp_close_channel': {'channelId': channelId.toJson()}
      };

  int _sizeHint() {
    int size = 1;
    size = size + _i4.HrmpChannelId.codec.sizeHint(channelId);
    return size;
  }

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      2,
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
      other is HrmpCloseChannel && other.channelId == channelId;

  @override
  int get hashCode => channelId.hashCode;
}

/// This extrinsic triggers the cleanup of all the HRMP storage items that
/// a para may have. Normally this happens once per session, but this allows
/// you to trigger the cleanup immediately for a specific parachain.
///
/// Origin must be Root.
///
/// Number of inbound and outbound channels for `para` must be provided as witness data of weighing.
class ForceCleanHrmp extends Call {
  const ForceCleanHrmp({
    required this.para,
    required this.inbound,
    required this.outbound,
  });

  factory ForceCleanHrmp._decode(_i1.Input input) {
    return ForceCleanHrmp(
      para: _i1.U32Codec.codec.decode(input),
      inbound: _i1.U32Codec.codec.decode(input),
      outbound: _i1.U32Codec.codec.decode(input),
    );
  }

  /// ParaId
  final _i3.Id para;

  /// u32
  final int inbound;

  /// u32
  final int outbound;

  @override
  Map<String, Map<String, int>> toJson() => {
        'force_clean_hrmp': {
          'para': para,
          'inbound': inbound,
          'outbound': outbound,
        }
      };

  int _sizeHint() {
    int size = 1;
    size = size + const _i3.IdCodec().sizeHint(para);
    size = size + _i1.U32Codec.codec.sizeHint(inbound);
    size = size + _i1.U32Codec.codec.sizeHint(outbound);
    return size;
  }

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      3,
      output,
    );
    _i1.U32Codec.codec.encodeTo(
      para,
      output,
    );
    _i1.U32Codec.codec.encodeTo(
      inbound,
      output,
    );
    _i1.U32Codec.codec.encodeTo(
      outbound,
      output,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(
        this,
        other,
      ) ||
      other is ForceCleanHrmp &&
          other.para == para &&
          other.inbound == inbound &&
          other.outbound == outbound;

  @override
  int get hashCode => Object.hash(
        para,
        inbound,
        outbound,
      );
}

/// Force process HRMP open channel requests.
///
/// If there are pending HRMP open channel requests, you can use this
/// function process all of those requests immediately.
///
/// Total number of opening channels must be provided as witness data of weighing.
class ForceProcessHrmpOpen extends Call {
  const ForceProcessHrmpOpen({required this.channels});

  factory ForceProcessHrmpOpen._decode(_i1.Input input) {
    return ForceProcessHrmpOpen(channels: _i1.U32Codec.codec.decode(input));
  }

  /// u32
  final int channels;

  @override
  Map<String, Map<String, int>> toJson() => {
        'force_process_hrmp_open': {'channels': channels}
      };

  int _sizeHint() {
    int size = 1;
    size = size + _i1.U32Codec.codec.sizeHint(channels);
    return size;
  }

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      4,
      output,
    );
    _i1.U32Codec.codec.encodeTo(
      channels,
      output,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(
        this,
        other,
      ) ||
      other is ForceProcessHrmpOpen && other.channels == channels;

  @override
  int get hashCode => channels.hashCode;
}

/// Force process HRMP close channel requests.
///
/// If there are pending HRMP close channel requests, you can use this
/// function process all of those requests immediately.
///
/// Total number of closing channels must be provided as witness data of weighing.
class ForceProcessHrmpClose extends Call {
  const ForceProcessHrmpClose({required this.channels});

  factory ForceProcessHrmpClose._decode(_i1.Input input) {
    return ForceProcessHrmpClose(channels: _i1.U32Codec.codec.decode(input));
  }

  /// u32
  final int channels;

  @override
  Map<String, Map<String, int>> toJson() => {
        'force_process_hrmp_close': {'channels': channels}
      };

  int _sizeHint() {
    int size = 1;
    size = size + _i1.U32Codec.codec.sizeHint(channels);
    return size;
  }

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      5,
      output,
    );
    _i1.U32Codec.codec.encodeTo(
      channels,
      output,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(
        this,
        other,
      ) ||
      other is ForceProcessHrmpClose && other.channels == channels;

  @override
  int get hashCode => channels.hashCode;
}

/// This cancels a pending open channel request. It can be canceled by either of the sender
/// or the recipient for that request. The origin must be either of those.
///
/// The cancellation happens immediately. It is not possible to cancel the request if it is
/// already accepted.
///
/// Total number of open requests (i.e. `HrmpOpenChannelRequestsList`) must be provided as
/// witness data.
class HrmpCancelOpenRequest extends Call {
  const HrmpCancelOpenRequest({
    required this.channelId,
    required this.openRequests,
  });

  factory HrmpCancelOpenRequest._decode(_i1.Input input) {
    return HrmpCancelOpenRequest(
      channelId: _i4.HrmpChannelId.codec.decode(input),
      openRequests: _i1.U32Codec.codec.decode(input),
    );
  }

  /// HrmpChannelId
  final _i4.HrmpChannelId channelId;

  /// u32
  final int openRequests;

  @override
  Map<String, Map<String, dynamic>> toJson() => {
        'hrmp_cancel_open_request': {
          'channelId': channelId.toJson(),
          'openRequests': openRequests,
        }
      };

  int _sizeHint() {
    int size = 1;
    size = size + _i4.HrmpChannelId.codec.sizeHint(channelId);
    size = size + _i1.U32Codec.codec.sizeHint(openRequests);
    return size;
  }

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      6,
      output,
    );
    _i4.HrmpChannelId.codec.encodeTo(
      channelId,
      output,
    );
    _i1.U32Codec.codec.encodeTo(
      openRequests,
      output,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(
        this,
        other,
      ) ||
      other is HrmpCancelOpenRequest &&
          other.channelId == channelId &&
          other.openRequests == openRequests;

  @override
  int get hashCode => Object.hash(
        channelId,
        openRequests,
      );
}

/// Open a channel from a `sender` to a `recipient` `ParaId` using the Root origin. Although
/// opened by Root, the `max_capacity` and `max_message_size` are still subject to the Relay
/// Chain's configured limits.
///
/// Expected use is when one of the `ParaId`s involved in the channel is governed by the
/// Relay Chain, e.g. a common good parachain.
class ForceOpenHrmpChannel extends Call {
  const ForceOpenHrmpChannel({
    required this.sender,
    required this.recipient,
    required this.maxCapacity,
    required this.maxMessageSize,
  });

  factory ForceOpenHrmpChannel._decode(_i1.Input input) {
    return ForceOpenHrmpChannel(
      sender: _i1.U32Codec.codec.decode(input),
      recipient: _i1.U32Codec.codec.decode(input),
      maxCapacity: _i1.U32Codec.codec.decode(input),
      maxMessageSize: _i1.U32Codec.codec.decode(input),
    );
  }

  /// ParaId
  final _i3.Id sender;

  /// ParaId
  final _i3.Id recipient;

  /// u32
  final int maxCapacity;

  /// u32
  final int maxMessageSize;

  @override
  Map<String, Map<String, int>> toJson() => {
        'force_open_hrmp_channel': {
          'sender': sender,
          'recipient': recipient,
          'maxCapacity': maxCapacity,
          'maxMessageSize': maxMessageSize,
        }
      };

  int _sizeHint() {
    int size = 1;
    size = size + const _i3.IdCodec().sizeHint(sender);
    size = size + const _i3.IdCodec().sizeHint(recipient);
    size = size + _i1.U32Codec.codec.sizeHint(maxCapacity);
    size = size + _i1.U32Codec.codec.sizeHint(maxMessageSize);
    return size;
  }

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      7,
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
      maxCapacity,
      output,
    );
    _i1.U32Codec.codec.encodeTo(
      maxMessageSize,
      output,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(
        this,
        other,
      ) ||
      other is ForceOpenHrmpChannel &&
          other.sender == sender &&
          other.recipient == recipient &&
          other.maxCapacity == maxCapacity &&
          other.maxMessageSize == maxMessageSize;

  @override
  int get hashCode => Object.hash(
        sender,
        recipient,
        maxCapacity,
        maxMessageSize,
      );
}
