import 'package:polkadart_scale_codec/polkadart_scale_codec.dart';

void main() {
  ///
  ///
  /// Array Example
  ///
  ///
  {
    final output = HexOutput();
    ArrayCodec(U8Codec.codec, 4).encodeTo([1, 2, 3, 4], output);
    print(output.toString()); // 0x01020304
  }

  {
    final input = Input.fromHex('0x0001010002010300');
    final result = ArrayCodec(
      TupleCodec([U8Codec.codec, BoolCodec.codec]),
      4,
    ).decode(input);
    print(result); // [ [0, true], [1, false], [2, true], [3, false] ]
  }

  ///
  ///
  /// Btree Map Example
  ///
  ///

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

  ///
  ///
  /// Compact Big Int Example
  ///
  ///
  {
    final byteInput = Input.fromHex('0x130000000000000001');
    final decoded = CompactCodec.codec.decode(byteInput);
    print(decoded); // 72057594037927936

    final output = HexOutput();
    CompactCodec.codec.encodeTo(decoded, output);
    print(output.toString()); // 0x130000000000000001
  }

  ///
  ///
  /// Compact Big Int Example
  ///
  ///
  {
    final byteInput = Input.fromHex('13ffffffffffffffff');
    final decoded = CompactBigIntCodec.codec.decode(byteInput);
    print(decoded); // 18446744073709551615

    final output = HexOutput();
    CompactBigIntCodec.codec.encodeTo(decoded, output);
    print(output.toString()); // 13ffffffffffffffff
  }

  ///
  ///
  /// Composite Example
  ///
  ///
  {
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

  ///
  ///
  /// Option Example
  ///
  ///
  {
    final codec =
        OptionCodec(TupleCodec([CompactCodec.codec, BoolCodec.codec]));

    final output = HexOutput();
    codec.encodeTo([3, true], output);
    print(output.toString()); // '0x010c01'

    final input = Input.fromHex('0x010c01');
    final decoded = codec.decode(input);
    print(decoded); // [3, true]
  }

  ///
  ///
  /// Signed Int Example
  ///
  ///
  {
    final input = Input.fromHex(
        '0xffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff7f');
    final decoded = I256Codec.codec.decode(input);
    print(
        decoded); // BigInt.parse('57896044618658097711785492504343953926634992332820282019728792003956564819967')

    final output = HexOutput();
    I256Codec.codec.encodeTo(decoded, output);
    print(output
        .toString()); // 0xffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff7f
  }

  ///
  ///
  /// Un-signed Int Example
  ///
  ///
  {
    final input = Input.fromHex(
        '0xffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff');
    final decoded = U256Codec.codec.decode(input);
    print(
        decoded); //  BigInt.parse('115792089237316195423570985008687907853269984665640564039457584007913129639935')

    final output = HexOutput();
    U256Codec.codec.encodeTo(decoded, output);
    print(output
        .toString()); // 0xffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff
  }

  ///
  ///
  /// Tuple Example
  ///
  ///
  {
    final codec = TupleCodec([CompactCodec.codec, BoolCodec.codec]);

    final output = HexOutput();
    codec.encodeTo([3, true], output);
    print(output.toString()); // 0x0c01

    final input = Input.fromHex('0x0c01');
    final decoded = codec.decode(input);
    print(decoded); // [3, true]
  }
}
