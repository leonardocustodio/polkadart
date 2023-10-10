// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:typed_data' as _i2;

import 'package:polkadart/scale_codec.dart' as _i1;
import 'package:quiver/collection.dart' as _i3;

class InboundDownwardMessage {
  const InboundDownwardMessage({
    required this.sentAt,
    required this.msg,
  });

  factory InboundDownwardMessage.decode(_i1.Input input) {
    return codec.decode(input);
  }

  /// BlockNumber
  final int sentAt;

  /// DownwardMessage
  final List<int> msg;

  static const $InboundDownwardMessageCodec codec =
      $InboundDownwardMessageCodec();

  _i2.Uint8List encode() {
    return codec.encode(this);
  }

  Map<String, dynamic> toJson() => {
        'sentAt': sentAt,
        'msg': msg,
      };

  @override
  bool operator ==(Object other) =>
      identical(
        this,
        other,
      ) ||
      other is InboundDownwardMessage &&
          other.sentAt == sentAt &&
          _i3.listsEqual(
            other.msg,
            msg,
          );

  @override
  int get hashCode => Object.hash(
        sentAt,
        msg,
      );
}

class $InboundDownwardMessageCodec with _i1.Codec<InboundDownwardMessage> {
  const $InboundDownwardMessageCodec();

  @override
  void encodeTo(
    InboundDownwardMessage obj,
    _i1.Output output,
  ) {
    _i1.U32Codec.codec.encodeTo(
      obj.sentAt,
      output,
    );
    _i1.U8SequenceCodec.codec.encodeTo(
      obj.msg,
      output,
    );
  }

  @override
  InboundDownwardMessage decode(_i1.Input input) {
    return InboundDownwardMessage(
      sentAt: _i1.U32Codec.codec.decode(input),
      msg: _i1.U8SequenceCodec.codec.decode(input),
    );
  }

  @override
  int sizeHint(InboundDownwardMessage obj) {
    int size = 0;
    size = size + _i1.U32Codec.codec.sizeHint(obj.sentAt);
    size = size + _i1.U8SequenceCodec.codec.sizeHint(obj.msg);
    return size;
  }
}
