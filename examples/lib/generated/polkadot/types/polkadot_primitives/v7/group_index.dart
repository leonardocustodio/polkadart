// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:polkadart/scale_codec.dart' as _i1;

typedef GroupIndex = int;

class GroupIndexCodec with _i1.Codec<GroupIndex> {
  const GroupIndexCodec();

  @override
  GroupIndex decode(_i1.Input input) {
    return _i1.U32Codec.codec.decode(input);
  }

  @override
  void encodeTo(
    GroupIndex value,
    _i1.Output output,
  ) {
    _i1.U32Codec.codec.encodeTo(
      value,
      output,
    );
  }

  @override
  int sizeHint(GroupIndex value) {
    return _i1.U32Codec.codec.sizeHint(value);
  }
}
