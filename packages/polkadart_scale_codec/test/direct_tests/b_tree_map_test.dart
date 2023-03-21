import 'package:polkadart_scale_codec/polkadart_scale_codec.dart';
import 'package:test/test.dart';

void main() {
  group('BTreeMap Encode Test:', () {
    test('Given a {42: true} it should be encoded to 0x042a01', () {
      final output = HexOutput();
      BTreeMapCodec(keyCodec: U8Codec.codec, valueCodec: BoolCodec.codec)
          .encodeTo({42: true}, output);
      expect(output.toString(), '0x042a01');
    });

    test(
        'When value {{632: false}: true} is encoded then it returns 0x0404780200000001',
        () {
      final output = HexOutput();
      BTreeMapCodec(
              keyCodec: BTreeMapCodec(
                  keyCodec: U32Codec.codec, valueCodec: BoolCodec.codec),
              valueCodec: BoolCodec.codec)
          .encodeTo({
        {632: false}: true
      }, output);
      expect(output.toString(), '0x0404780200000001');
    });
    test(
        'When value {{"1291": true}: false} is encoded then it returns 0x040410313239310100',
        () {
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
      expect(output.toString(), '0x040410313239310100');
    });

    test('When value {[42, true]: false} is encoded then it returns 0x042a0100',
        () {
      final output = HexOutput();
      BTreeMapCodec(
        keyCodec: TupleCodec([U8Codec.codec, BoolCodec.codec]),
        valueCodec: BoolCodec.codec,
      ).encodeTo(
        {
          [42, true]: false,
        },
        output,
      );
      expect(output.toString(), '0x042a0100');
    });
  });

  group('BTreeMap Decode Test:', () {
    test('Given a 0x042a01 it should be decoded to {42: true}', () {
      final input = Input.fromHex('0x042a01');
      final result = BTreeMapCodec(
        keyCodec: U8Codec.codec,
        valueCodec: BoolCodec.codec,
      ).decode(input);
      expect(result.toString(), {42: true}.toString());
      expect(input.remainingLength, 0);
    });

    test(
        'When value 0x0404780200000001 is decoded then it returns {{632: false}: true}',
        () {
      final input = Input.fromHex('0x0404780200000001');
      final result = BTreeMapCodec(
        keyCodec: BTreeMapCodec(
          keyCodec: U32Codec.codec,
          valueCodec: BoolCodec.codec,
        ),
        valueCodec: BoolCodec.codec,
      ).decode(input);
      expect(
          result.toString(),
          {
            {632: false}: true
          }.toString());
      expect(input.remainingLength, 0);
    });

    test(
        'When value 0x040410313239310100 is decoded then it returns {{"1291": true}: false}',
        () {
      final input = Input.fromHex('0x040410313239310100');
      final result = BTreeMapCodec(
        keyCodec: BTreeMapCodec(
          keyCodec: StrCodec.codec,
          valueCodec: BoolCodec.codec,
        ),
        valueCodec: BoolCodec.codec,
      ).decode(input);
      expect(
          result.toString(),
          {
            {'1291': true}: false
          }.toString());
      expect(input.remainingLength, 0);
    });

    test('When value 0x042a0100 is decoded then it returns {[42, true]: false}',
        () {
      final input = Input.fromHex('0x042a0100');
      final result = BTreeMapCodec(
        keyCodec: TupleCodec([U8Codec.codec, BoolCodec.codec]),
        valueCodec: BoolCodec.codec,
      ).decode(input);
      expect(
          result.toString(),
          {
            [42, true]: false
          }.toString());
      expect(input.remainingLength, 0);
    });
  });
}
