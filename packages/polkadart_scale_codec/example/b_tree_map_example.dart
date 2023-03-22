import 'package:polkadart_scale_codec/polkadart_scale_codec.dart';

void main() {
  {
    final output = HexOutput();
    BTreeMapCodec(keyCodec: U8Codec.codec, valueCodec: BoolCodec.codec)
        .encodeTo({42: true}, output);
    print(output.toString()); // '0x042a01'
  }

  {
    final output = HexOutput();
    BTreeMapCodec(
            keyCodec: BTreeMapCodec(
                keyCodec: U32Codec.codec, valueCodec: BoolCodec.codec),
            valueCodec: BoolCodec.codec)
        .encodeTo({
      {632: false}: true
    }, output);
    print(output.toString()); // '0x0404780200000001'
  }

  {
    final output = HexOutput();
    BTreeMapCodec(
      keyCodec: BTreeMapCodec(
        keyCodec: StrCodec.codec,
        valueCodec: BoolCodec.codec,
      ),
      valueCodec: BoolCodec.codec,
    ).encodeTo(
      {
        {'1291': true}: false,
      },
      output,
    );
    print(output.toString()); // '0x040410313239310100'
  }

  {
    final input = Input.fromHex('0x0404780200000001');
    final result = BTreeMapCodec(
      keyCodec: BTreeMapCodec(
        keyCodec: U32Codec.codec,
        valueCodec: BoolCodec.codec,
      ),
      valueCodec: BoolCodec.codec,
    ).decode(input);
    print(result.toString()); // { {632: false}: true }
  }

  {
    final input = Input.fromHex('0x040410313239310100');
    final result = BTreeMapCodec(
      keyCodec: BTreeMapCodec(
        keyCodec: StrCodec.codec,
        valueCodec: BoolCodec.codec,
      ),
      valueCodec: BoolCodec.codec,
    ).decode(input);
    print(result.toString()); // { {'1291': true}: false }
  }

  {
    final input = Input.fromHex('0x042a0100');
    final result = BTreeMapCodec(
      keyCodec: TupleCodec([U8Codec.codec, BoolCodec.codec]),
      valueCodec: BoolCodec.codec,
    ).decode(input);
    print(result.toString()); // { [42, true]: false }
  }
}
