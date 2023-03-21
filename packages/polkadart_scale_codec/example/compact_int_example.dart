import 'package:polkadart_scale_codec/polkadart_scale_codec.dart';

void main() {
  final byteInput = Input.fromHex('0x130000000000000001');
  final decoded = CompactCodec.codec.decode(byteInput);
  print(decoded); // 72057594037927936

  final output = HexOutput();
  CompactCodec.codec.encodeTo(decoded, output);
  print(output.toString()); // 0x130000000000000001
}
