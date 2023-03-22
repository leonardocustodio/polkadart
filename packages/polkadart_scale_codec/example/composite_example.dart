import 'package:polkadart_scale_codec/polkadart_scale_codec.dart';

void main() {
  final codec = CompositeCodec(
    {
      'a': U8Codec.codec,
      'b': BoolCodec.codec,
    },
  );

  final input = Input.fromHex('0x2a01');
  final decoded = codec.decode(input);
  print(decoded); // {a: 42, b: true}

  final output = HexOutput();
  codec.encodeTo(
    {'a': 42, 'b': true},
    output,
  );
  print(output.toString()); // '0x2a01'
}
