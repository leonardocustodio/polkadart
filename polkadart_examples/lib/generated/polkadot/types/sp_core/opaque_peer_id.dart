// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:polkadart/scale_codec.dart' as _i1;

typedef OpaquePeerId = List<int>;

class OpaquePeerIdCodec with _i1.Codec<OpaquePeerId> {
  const OpaquePeerIdCodec();

  @override
  OpaquePeerId decode(_i1.Input input) {
    return _i1.U8SequenceCodec.codec.decode(input);
  }

  @override
  void encodeTo(
    OpaquePeerId value,
    _i1.Output output,
  ) {
    _i1.U8SequenceCodec.codec.encodeTo(
      value,
      output,
    );
  }

  @override
  int sizeHint(OpaquePeerId value) {
    return _i1.U8SequenceCodec.codec.sizeHint(value);
  }
}
