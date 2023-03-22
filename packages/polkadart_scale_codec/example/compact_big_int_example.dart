import 'package:polkadart_scale_codec/polkadart_scale_codec.dart';

void main() {
  final byteInput = Input.fromHex('13ffffffffffffffff');
  final decoded = CompactBigIntCodec.codec.decode(byteInput);
  print(decoded); // 18446744073709551615

  final output = HexOutput();
  CompactBigIntCodec.codec.encodeTo(decoded, output);
  print(output.toString()); // 13ffffffffffffffff
}
