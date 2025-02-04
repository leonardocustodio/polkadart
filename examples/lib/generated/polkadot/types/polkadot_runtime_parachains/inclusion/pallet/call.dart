// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:polkadart/scale_codec.dart' as _i1;

/// Contains a variant per dispatchable extrinsic that this pallet has.
typedef Call = dynamic;

class CallCodec with _i1.Codec<Call> {
  const CallCodec();

  @override
  Call decode(_i1.Input input) {
    return _i1.NullCodec.codec.decode(input);
  }

  @override
  void encodeTo(
    Call value,
    _i1.Output output,
  ) {
    _i1.NullCodec.codec.encodeTo(
      value,
      output,
    );
  }

  @override
  int sizeHint(Call value) {
    return _i1.NullCodec.codec.sizeHint(value);
  }
}
