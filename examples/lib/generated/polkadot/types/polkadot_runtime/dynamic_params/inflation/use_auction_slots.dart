// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:polkadart/scale_codec.dart' as _i1;

typedef UseAuctionSlots = dynamic;

class UseAuctionSlotsCodec with _i1.Codec<UseAuctionSlots> {
  const UseAuctionSlotsCodec();

  @override
  UseAuctionSlots decode(_i1.Input input) {
    return _i1.NullCodec.codec.decode(input);
  }

  @override
  void encodeTo(
    UseAuctionSlots value,
    _i1.Output output,
  ) {
    _i1.NullCodec.codec.encodeTo(
      value,
      output,
    );
  }

  @override
  int sizeHint(UseAuctionSlots value) {
    return _i1.NullCodec.codec.sizeHint(value);
  }
}
