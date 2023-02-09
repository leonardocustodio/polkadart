import 'package:polkadart_scale_codec/polkadart_scale_codec.dart';
import 'package:test/test.dart';

void main() {
  group('BTreeMap Encode Test:', () {
    test('Given a {42: true} it should be encoded to 0x042a01', () {
      final output = HexOutput();
      BTreeMap(keyCodec: U8Codec.instance, valueCodec: BoolCodec.instance)
          .encodeTo({42: true}, output);
      expect(output.toString(), '0x042a01');
    });

    test(
        'When value {{632: false}: true} is encoded then it returns 0x0404780200000001',
        () {
      final output = HexOutput();
      BTreeMap(
              keyCodec: BTreeMap(
                  keyCodec: U32Codec.instance, valueCodec: BoolCodec.instance),
              valueCodec: BoolCodec.instance)
          .encodeTo({
        {632: false}: true
      }, output);
      expect(output.toString(), '0x0404780200000001');
    });
    test(
        'When value {{"1291": true}: false} is encoded then it returns 0x040410313239310100',
        () {
      final output = HexOutput();
      BTreeMap(
        keyCodec: BTreeMap(
          keyCodec: StrCodec.instance,
          valueCodec: BoolCodec.instance,
        ),
        valueCodec: BoolCodec.instance,
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
      BTreeMap(
        keyCodec: TupleCodec([U8Codec.instance, BoolCodec.instance]),
        valueCodec: BoolCodec.instance,
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
      final input = HexInput('0x042a01');
      final result = BTreeMap(
        keyCodec: U8Codec.instance,
        valueCodec: BoolCodec.instance,
      ).decode(input);
      expect(result.toString(), {42: true}.toString());
    });

    test(
        'When value 0x0404780200000001 is decoded then it returns {{632: false}: true}',
        () {
      final input = HexInput('0x0404780200000001');
      final result = BTreeMap(
        keyCodec: BTreeMap(
          keyCodec: U32Codec.instance,
          valueCodec: BoolCodec.instance,
        ),
        valueCodec: BoolCodec.instance,
      ).decode(input);
      expect(
          result.toString(),
          {
            {632: false}: true
          }.toString());
    });

    test(
        'When value 0x040410313239310100 is decoded then it returns {{"1291": true}: false}',
        () {
      final input = HexInput('0x040410313239310100');
      final result = BTreeMap(
        keyCodec: BTreeMap(
          keyCodec: StrCodec.instance,
          valueCodec: BoolCodec.instance,
        ),
        valueCodec: BoolCodec.instance,
      ).decode(input);
      expect(
          result.toString(),
          {
            {'1291': true}: false
          }.toString());
    });

    test('When value 0x042a0100 is decoded then it returns {[42, true]: false}',
        () {
      final input = HexInput('0x042a0100');
      final result = BTreeMap(
        keyCodec: TupleCodec([U8Codec.instance, BoolCodec.instance]),
        valueCodec: BoolCodec.instance,
      ).decode(input);
      expect(
          result.toString(),
          {
            [42, true]: false
          }.toString());
    });
  });
}
