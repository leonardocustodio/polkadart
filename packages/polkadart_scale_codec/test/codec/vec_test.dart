import 'package:polkadart_scale_codec/src/core/core.dart';

void main() {
  final codec =
      Codec().createTypeCodec('Vec<Vec<u8>>', input: Input('0x041001020304'));

  print(codec.decode());
}
