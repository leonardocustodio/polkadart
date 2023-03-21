import 'package:polkadart_scale_codec/polkadart_scale_codec.dart';

void main() {
  {
    final output = HexOutput();
    ArrayCodec(U8Codec.codec, 4).encodeTo([1, 2, 3, 4], output);
    print(output.toString()); // 0x01020304
  }

  {
    final output = HexOutput();
    ArrayCodec(
      ArrayCodec(U8Codec.codec, 2),
      2,
    ).encodeTo(
      [
        [1, 2],
        [3, 4]
      ],
      output,
    );
    print(output.toString()); // 0x01020304
  }

  {
    final output = HexOutput();
    ArrayCodec(U8Codec.codec, 4).encodeTo([5, 6, 7, 8], output);
    print(output.toString()); // 0x05060708
  }

  {
    final output = HexOutput();
    ArrayCodec(
      TupleCodec([U8Codec.codec, BoolCodec.codec]),
      4,
    ).encodeTo(
      [
        [0, true],
        [1, false],
        [2, true],
        [3, false]
      ],
      output,
    );

    print(output.toString()); // 0x0001010002010300
  }

  {
    final input = Input.fromHex('0x0001010002010300');
    final result = ArrayCodec(
      TupleCodec([U8Codec.codec, BoolCodec.codec]),
      4,
    ).decode(input);
    print(result); // [ [0, true], [1, false], [2, true], [3, false] ]
  }
}
