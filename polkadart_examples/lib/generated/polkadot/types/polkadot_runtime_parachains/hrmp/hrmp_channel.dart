// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:typed_data' as _i3;

import 'package:polkadart/scale_codec.dart' as _i1;

import '../../primitive_types/h256.dart' as _i2;

class HrmpChannel {
  const HrmpChannel({
    required this.maxCapacity,
    required this.maxTotalSize,
    required this.maxMessageSize,
    required this.msgCount,
    required this.totalSize,
    this.mqcHead,
    required this.senderDeposit,
    required this.recipientDeposit,
  });

  factory HrmpChannel.decode(_i1.Input input) {
    return codec.decode(input);
  }

  /// u32
  final int maxCapacity;

  /// u32
  final int maxTotalSize;

  /// u32
  final int maxMessageSize;

  /// u32
  final int msgCount;

  /// u32
  final int totalSize;

  /// Option<Hash>
  final _i2.H256? mqcHead;

  /// Balance
  final BigInt senderDeposit;

  /// Balance
  final BigInt recipientDeposit;

  static const $HrmpChannelCodec codec = $HrmpChannelCodec();

  _i3.Uint8List encode() {
    return codec.encode(this);
  }

  Map<String, dynamic> toJson() => {
        'maxCapacity': maxCapacity,
        'maxTotalSize': maxTotalSize,
        'maxMessageSize': maxMessageSize,
        'msgCount': msgCount,
        'totalSize': totalSize,
        'mqcHead': mqcHead?.toList(),
        'senderDeposit': senderDeposit,
        'recipientDeposit': recipientDeposit,
      };

  @override
  bool operator ==(Object other) =>
      identical(
        this,
        other,
      ) ||
      other is HrmpChannel &&
          other.maxCapacity == maxCapacity &&
          other.maxTotalSize == maxTotalSize &&
          other.maxMessageSize == maxMessageSize &&
          other.msgCount == msgCount &&
          other.totalSize == totalSize &&
          other.mqcHead == mqcHead &&
          other.senderDeposit == senderDeposit &&
          other.recipientDeposit == recipientDeposit;

  @override
  int get hashCode => Object.hash(
        maxCapacity,
        maxTotalSize,
        maxMessageSize,
        msgCount,
        totalSize,
        mqcHead,
        senderDeposit,
        recipientDeposit,
      );
}

class $HrmpChannelCodec with _i1.Codec<HrmpChannel> {
  const $HrmpChannelCodec();

  @override
  void encodeTo(
    HrmpChannel obj,
    _i1.Output output,
  ) {
    _i1.U32Codec.codec.encodeTo(
      obj.maxCapacity,
      output,
    );
    _i1.U32Codec.codec.encodeTo(
      obj.maxTotalSize,
      output,
    );
    _i1.U32Codec.codec.encodeTo(
      obj.maxMessageSize,
      output,
    );
    _i1.U32Codec.codec.encodeTo(
      obj.msgCount,
      output,
    );
    _i1.U32Codec.codec.encodeTo(
      obj.totalSize,
      output,
    );
    const _i1.OptionCodec<_i2.H256>(_i2.H256Codec()).encodeTo(
      obj.mqcHead,
      output,
    );
    _i1.U128Codec.codec.encodeTo(
      obj.senderDeposit,
      output,
    );
    _i1.U128Codec.codec.encodeTo(
      obj.recipientDeposit,
      output,
    );
  }

  @override
  HrmpChannel decode(_i1.Input input) {
    return HrmpChannel(
      maxCapacity: _i1.U32Codec.codec.decode(input),
      maxTotalSize: _i1.U32Codec.codec.decode(input),
      maxMessageSize: _i1.U32Codec.codec.decode(input),
      msgCount: _i1.U32Codec.codec.decode(input),
      totalSize: _i1.U32Codec.codec.decode(input),
      mqcHead: const _i1.OptionCodec<_i2.H256>(_i2.H256Codec()).decode(input),
      senderDeposit: _i1.U128Codec.codec.decode(input),
      recipientDeposit: _i1.U128Codec.codec.decode(input),
    );
  }

  @override
  int sizeHint(HrmpChannel obj) {
    int size = 0;
    size = size + _i1.U32Codec.codec.sizeHint(obj.maxCapacity);
    size = size + _i1.U32Codec.codec.sizeHint(obj.maxTotalSize);
    size = size + _i1.U32Codec.codec.sizeHint(obj.maxMessageSize);
    size = size + _i1.U32Codec.codec.sizeHint(obj.msgCount);
    size = size + _i1.U32Codec.codec.sizeHint(obj.totalSize);
    size = size +
        const _i1.OptionCodec<_i2.H256>(_i2.H256Codec()).sizeHint(obj.mqcHead);
    size = size + _i1.U128Codec.codec.sizeHint(obj.senderDeposit);
    size = size + _i1.U128Codec.codec.sizeHint(obj.recipientDeposit);
    return size;
  }
}
