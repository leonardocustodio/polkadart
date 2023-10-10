// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:polkadart/scale_codec.dart' as _i1;

typedef Vote = int;

class VoteCodec with _i1.Codec<Vote> {
  const VoteCodec();

  @override
  Vote decode(_i1.Input input) {
    return _i1.U8Codec.codec.decode(input);
  }

  @override
  void encodeTo(
    Vote value,
    _i1.Output output,
  ) {
    _i1.U8Codec.codec.encodeTo(
      value,
      output,
    );
  }

  @override
  int sizeHint(Vote value) {
    return _i1.U8Codec.codec.sizeHint(value);
  }
}
