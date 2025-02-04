// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:typed_data' as _i3;

import 'package:polkadart/scale_codec.dart' as _i1;

import 'id.dart' as _i2;

class HrmpChannelId {
  const HrmpChannelId({
    required this.sender,
    required this.recipient,
  });

  factory HrmpChannelId.decode(_i1.Input input) {
    return codec.decode(input);
  }

  /// Id
  final _i2.Id sender;

  /// Id
  final _i2.Id recipient;

  static const $HrmpChannelIdCodec codec = $HrmpChannelIdCodec();

  _i3.Uint8List encode() {
    return codec.encode(this);
  }

  Map<String, int> toJson() => {
        'sender': sender,
        'recipient': recipient,
      };

  @override
  bool operator ==(Object other) =>
      identical(
        this,
        other,
      ) ||
      other is HrmpChannelId &&
          other.sender == sender &&
          other.recipient == recipient;

  @override
  int get hashCode => Object.hash(
        sender,
        recipient,
      );
}

class $HrmpChannelIdCodec with _i1.Codec<HrmpChannelId> {
  const $HrmpChannelIdCodec();

  @override
  void encodeTo(
    HrmpChannelId obj,
    _i1.Output output,
  ) {
    _i1.U32Codec.codec.encodeTo(
      obj.sender,
      output,
    );
    _i1.U32Codec.codec.encodeTo(
      obj.recipient,
      output,
    );
  }

  @override
  HrmpChannelId decode(_i1.Input input) {
    return HrmpChannelId(
      sender: _i1.U32Codec.codec.decode(input),
      recipient: _i1.U32Codec.codec.decode(input),
    );
  }

  @override
  int sizeHint(HrmpChannelId obj) {
    int size = 0;
    size = size + const _i2.IdCodec().sizeHint(obj.sender);
    size = size + const _i2.IdCodec().sizeHint(obj.recipient);
    return size;
  }
}
