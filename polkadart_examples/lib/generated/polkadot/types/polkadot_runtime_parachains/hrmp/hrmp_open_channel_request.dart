// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:typed_data' as _i2;

import 'package:polkadart/scale_codec.dart' as _i1;

class HrmpOpenChannelRequest {
  const HrmpOpenChannelRequest({
    required this.confirmed,
    required this.age,
    required this.senderDeposit,
    required this.maxMessageSize,
    required this.maxCapacity,
    required this.maxTotalSize,
  });

  factory HrmpOpenChannelRequest.decode(_i1.Input input) {
    return codec.decode(input);
  }

  /// bool
  final bool confirmed;

  /// SessionIndex
  final int age;

  /// Balance
  final BigInt senderDeposit;

  /// u32
  final int maxMessageSize;

  /// u32
  final int maxCapacity;

  /// u32
  final int maxTotalSize;

  static const $HrmpOpenChannelRequestCodec codec =
      $HrmpOpenChannelRequestCodec();

  _i2.Uint8List encode() {
    return codec.encode(this);
  }

  Map<String, dynamic> toJson() => {
        'confirmed': confirmed,
        'age': age,
        'senderDeposit': senderDeposit,
        'maxMessageSize': maxMessageSize,
        'maxCapacity': maxCapacity,
        'maxTotalSize': maxTotalSize,
      };

  @override
  bool operator ==(Object other) =>
      identical(
        this,
        other,
      ) ||
      other is HrmpOpenChannelRequest &&
          other.confirmed == confirmed &&
          other.age == age &&
          other.senderDeposit == senderDeposit &&
          other.maxMessageSize == maxMessageSize &&
          other.maxCapacity == maxCapacity &&
          other.maxTotalSize == maxTotalSize;

  @override
  int get hashCode => Object.hash(
        confirmed,
        age,
        senderDeposit,
        maxMessageSize,
        maxCapacity,
        maxTotalSize,
      );
}

class $HrmpOpenChannelRequestCodec with _i1.Codec<HrmpOpenChannelRequest> {
  const $HrmpOpenChannelRequestCodec();

  @override
  void encodeTo(
    HrmpOpenChannelRequest obj,
    _i1.Output output,
  ) {
    _i1.BoolCodec.codec.encodeTo(
      obj.confirmed,
      output,
    );
    _i1.U32Codec.codec.encodeTo(
      obj.age,
      output,
    );
    _i1.U128Codec.codec.encodeTo(
      obj.senderDeposit,
      output,
    );
    _i1.U32Codec.codec.encodeTo(
      obj.maxMessageSize,
      output,
    );
    _i1.U32Codec.codec.encodeTo(
      obj.maxCapacity,
      output,
    );
    _i1.U32Codec.codec.encodeTo(
      obj.maxTotalSize,
      output,
    );
  }

  @override
  HrmpOpenChannelRequest decode(_i1.Input input) {
    return HrmpOpenChannelRequest(
      confirmed: _i1.BoolCodec.codec.decode(input),
      age: _i1.U32Codec.codec.decode(input),
      senderDeposit: _i1.U128Codec.codec.decode(input),
      maxMessageSize: _i1.U32Codec.codec.decode(input),
      maxCapacity: _i1.U32Codec.codec.decode(input),
      maxTotalSize: _i1.U32Codec.codec.decode(input),
    );
  }

  @override
  int sizeHint(HrmpOpenChannelRequest obj) {
    int size = 0;
    size = size + _i1.BoolCodec.codec.sizeHint(obj.confirmed);
    size = size + _i1.U32Codec.codec.sizeHint(obj.age);
    size = size + _i1.U128Codec.codec.sizeHint(obj.senderDeposit);
    size = size + _i1.U32Codec.codec.sizeHint(obj.maxMessageSize);
    size = size + _i1.U32Codec.codec.sizeHint(obj.maxCapacity);
    size = size + _i1.U32Codec.codec.sizeHint(obj.maxTotalSize);
    return size;
  }
}
