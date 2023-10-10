// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:typed_data' as _i2;

import 'package:polkadart/scale_codec.dart' as _i1;
import 'package:quiver/collection.dart' as _i3;

class DoubleEncoded {
  const DoubleEncoded({required this.encoded});

  factory DoubleEncoded.decode(_i1.Input input) {
    return codec.decode(input);
  }

  /// Vec<u8>
  final List<int> encoded;

  static const $DoubleEncodedCodec codec = $DoubleEncodedCodec();

  _i2.Uint8List encode() {
    return codec.encode(this);
  }

  Map<String, List<int>> toJson() => {'encoded': encoded};

  @override
  bool operator ==(Object other) =>
      identical(
        this,
        other,
      ) ||
      other is DoubleEncoded &&
          _i3.listsEqual(
            other.encoded,
            encoded,
          );

  @override
  int get hashCode => encoded.hashCode;
}

class $DoubleEncodedCodec with _i1.Codec<DoubleEncoded> {
  const $DoubleEncodedCodec();

  @override
  void encodeTo(
    DoubleEncoded obj,
    _i1.Output output,
  ) {
    _i1.U8SequenceCodec.codec.encodeTo(
      obj.encoded,
      output,
    );
  }

  @override
  DoubleEncoded decode(_i1.Input input) {
    return DoubleEncoded(encoded: _i1.U8SequenceCodec.codec.decode(input));
  }

  @override
  int sizeHint(DoubleEncoded obj) {
    int size = 0;
    size = size + _i1.U8SequenceCodec.codec.sizeHint(obj.encoded);
    return size;
  }
}
