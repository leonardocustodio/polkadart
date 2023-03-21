import 'package:polkadart_scale_codec/polkadart_scale_codec.dart';
import 'package:test/test.dart';

void main() {
  group('Option Encode Test:', () {
    test('Given a Option.some([3, true]) it should be encoded to 0x010c01', () {
      final output = HexOutput();
      OptionCodec(TupleCodec([CompactCodec.codec, BoolCodec.codec]))
          .encodeTo([3, true], output);
      expect(output.toString(), '0x010c01');
    });

    test('Given a None it should be encoded to 0x00', () {
      final output = HexOutput();
      OptionCodec(U8Codec.codec).encodeTo(null, output);
      expect(output.toString(), '0x00');
    });

    test('Given a Option.some(true) it should be encoded to 0x0101', () {
      final output = HexOutput();
      OptionCodec(BoolCodec.codec).encodeTo(true, output);
      expect(output.toString(), '0x0101');
    });

    test('Given a Option.some(false) it should be encoded to 0x0100', () {
      final output = HexOutput();
      OptionCodec(BoolCodec.codec).encodeTo(false, output);
      expect(output.toString(), '0x0100');
    });

    test('Given a Option.some(None) it should be encoded to 0x0100', () {
      final output = HexOutput();
      NestedOptionCodec(OptionCodec(BoolCodec.codec))
          .encodeTo(Option.some(null), output);
      expect(output.toString(), '0x0100');
    });

    test(
        'Given a Option.some(Option.some(true)) it should be encoded to 0x010101',
        () {
      final output = HexOutput();
      NestedOptionCodec(OptionCodec(BoolCodec.codec))
          .encodeTo(Option.some(true), output);
      expect(output.toString(), '0x010101');
    });

    test(
        'Given a Option.some(Option.some(false)) it should be encoded to 0x010100',
        () {
      final output = HexOutput();
      NestedOptionCodec(OptionCodec(BoolCodec.codec))
          .encodeTo(Option.some(false), output);
      expect(output.toString(), '0x010100');
    });
  });

  group('Option Decode Test:', () {
    test('Given a 0x010c01 it should be decoded to Option.some([3, true])', () {
      final input = Input.fromHex('0x010c01');
      final result =
          OptionCodec(TupleCodec([CompactCodec.codec, BoolCodec.codec]))
              .decode(input);
      expect(result.toString(), [3, true].toString());
      expect(input.remainingLength, 0);
    });

    test('Given a 0x00 it should be decoded to None', () {
      final input = Input.fromHex('0x00');
      final result = OptionCodec(U8Codec.codec).decode(input);
      expect(result, null);
      expect(input.remainingLength, 0);
    });

    test('Given a 0x0101 it should be decoded to Option.some(true)', () {
      final input = Input.fromHex('0x0101');
      final result = OptionCodec(BoolCodec.codec).decode(input);
      expect(result, true);
      expect(input.remainingLength, 0);
    });

    test('Given a 0x0100 it should be decoded to Option.some(false)', () {
      final input = Input.fromHex('0x0100');
      final result = OptionCodec(BoolCodec.codec).decode(input);
      expect(result, false);
      expect(input.remainingLength, 0);
    });

    test('Given a 0x0100 it should be decoded to Option.some(None)', () {
      final input = Input.fromHex('0x0100');
      final result =
          NestedOptionCodec(OptionCodec(BoolCodec.codec)).decode(input);
      expect(result.toString(), Option.some(null).toString());
      expect(input.remainingLength, 0);
    });

    test(
        'Given a 0x010101 it should be decoded to Option.some(Option.some(true))',
        () {
      final input = Input.fromHex('0x010101');
      final result =
          NestedOptionCodec(OptionCodec(BoolCodec.codec)).decode(input);
      expect(result.toString(), Option.some(true).toString());
      expect(input.remainingLength, 0);
    });

    test(
        'Given a 0x010100 it should be decoded to Option.some(Option.some(false))',
        () {
      final input = Input.fromHex('0x010100');
      final result =
          NestedOptionCodec(OptionCodec(BoolCodec.codec)).decode(input);
      expect(result.toString(), Option.some(false).toString());
      expect(input.remainingLength, 0);
    });
  });
}
