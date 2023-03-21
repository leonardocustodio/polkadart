import 'package:polkadart_scale_codec/polkadart_scale_codec.dart';

void main() {
  final codec = TupleCodec([CompactCodec.codec, BoolCodec.codec]);

  final output = HexOutput();
  codec.encodeTo([3, true], output);
  print(output.toString()); // 0x0c01

  final input = Input.fromHex('0x0c01');
  final decoded = codec.decode(input);
  print(decoded); // [3, true]
}
