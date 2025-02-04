// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:typed_data' as _i2;

import 'package:polkadart/scale_codec.dart' as _i1;

class QueueDescriptor {
  const QueueDescriptor({
    required this.first,
    required this.last,
  });

  factory QueueDescriptor.decode(_i1.Input input) {
    return codec.decode(input);
  }

  /// N
  final int first;

  /// N
  final int last;

  static const $QueueDescriptorCodec codec = $QueueDescriptorCodec();

  _i2.Uint8List encode() {
    return codec.encode(this);
  }

  Map<String, int> toJson() => {
        'first': first,
        'last': last,
      };

  @override
  bool operator ==(Object other) =>
      identical(
        this,
        other,
      ) ||
      other is QueueDescriptor && other.first == first && other.last == last;

  @override
  int get hashCode => Object.hash(
        first,
        last,
      );
}

class $QueueDescriptorCodec with _i1.Codec<QueueDescriptor> {
  const $QueueDescriptorCodec();

  @override
  void encodeTo(
    QueueDescriptor obj,
    _i1.Output output,
  ) {
    _i1.U32Codec.codec.encodeTo(
      obj.first,
      output,
    );
    _i1.U32Codec.codec.encodeTo(
      obj.last,
      output,
    );
  }

  @override
  QueueDescriptor decode(_i1.Input input) {
    return QueueDescriptor(
      first: _i1.U32Codec.codec.decode(input),
      last: _i1.U32Codec.codec.decode(input),
    );
  }

  @override
  int sizeHint(QueueDescriptor obj) {
    int size = 0;
    size = size + _i1.U32Codec.codec.sizeHint(obj.first);
    size = size + _i1.U32Codec.codec.sizeHint(obj.last);
    return size;
  }
}
