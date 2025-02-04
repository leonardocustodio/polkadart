// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:polkadart/scale_codec.dart' as _i1;

typedef HeadData = List<int>;

class HeadDataCodec with _i1.Codec<HeadData> {
  const HeadDataCodec();

  @override
  HeadData decode(_i1.Input input) {
    return _i1.U8SequenceCodec.codec.decode(input);
  }

  @override
  void encodeTo(
    HeadData value,
    _i1.Output output,
  ) {
    _i1.U8SequenceCodec.codec.encodeTo(
      value,
      output,
    );
  }

  @override
  int sizeHint(HeadData value) {
    return _i1.U8SequenceCodec.codec.sizeHint(value);
  }
}
