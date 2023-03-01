import 'package:polkadart_scale_codec/polkadart_scale_codec.dart';
import 'package:test/test.dart';

void main() {
  group('Option Encode Test:', () {
    test('Given a Option.some([3, true]) it should be encoded to 0x010c01', () {
      final output = HexOutput();
      OptionCodec(TupleCodec([CompactCodec.instance, BoolCodec.instance]))
          .encodeTo(Option.some([3, true]), output);
      expect(output.toString(), '0x010c01');
    });

    test('Given a None it should be encoded to 0x00', () {
      final output = HexOutput();
      OptionCodec(U8Codec.instance).encodeTo(Option.none(), output);
      expect(output.toString(), '0x00');
    });

    test('Given a Option.some(true) it should be encoded to 0x0101', () {
      final output = HexOutput();
      OptionCodec(BoolCodec.instance).encodeTo(Option.some(true), output);
      expect(output.toString(), '0x0101');
    });

    test('Given a Option.some(false) it should be encoded to 0x0100', () {
      final output = HexOutput();
      OptionCodec(BoolCodec.instance).encodeTo(Option.some(false), output);
      expect(output.toString(), '0x0100');
    });

    test('Given a Option.some(None) it should be encoded to 0x0100', () {
      final output = HexOutput();
      OptionCodec(OptionCodec(BoolCodec.instance))
          .encodeTo(Option.some(None), output);
      expect(output.toString(), '0x0100');
    });

    test(
        'Given a Option.some(Option.some(true)) it should be encoded to 0x010101',
        () {
      final output = HexOutput();
      OptionCodec(OptionCodec(BoolCodec.instance))
          .encodeTo(Option.some(Option.some(true)), output);
      expect(output.toString(), '0x010101');
    });

    test(
        'Given a Option.some(Option.some(false)) it should be encoded to 0x010100',
        () {
      final output = HexOutput();
      OptionCodec(OptionCodec(BoolCodec.instance))
          .encodeTo(Option.some(Option.some(false)), output);
      expect(output.toString(), '0x010100');
    });
  });

  group('Option Decode Test:', () {
    test('Given a 0x010c01 it should be decoded to Option.some([3, true])', () {
      final input = HexInput('0x010c01');
      final result =
          OptionCodec(TupleCodec([CompactCodec.instance, BoolCodec.instance]))
              .decode(input);
      expect(result.toString(), Option.some([3, true]).toString());
    });

    test('Given a 0x00 it should be decoded to None', () {
      final input = HexInput('0x00');
      final result = OptionCodec(U8Codec.instance).decode(input);
      expect(result, None);
    });

    test('Given a 0x0101 it should be decoded to Option.some(true)', () {
      final input = HexInput('0x0101');
      final result = OptionCodec(BoolCodec.instance).decode(input);
      expect(result, Option.some(true));
    });

    test('Given a 0x0100 it should be decoded to Option.some(false)', () {
      final input = HexInput('0x0100');
      final result = OptionCodec(BoolCodec.instance).decode(input);
      expect(result, Option.some(false));
    });

    test('Given a 0x0100 it should be decoded to Option.some(None)', () {
      final input = HexInput('0x0100');
      final result = OptionCodec(OptionCodec(BoolCodec.instance)).decode(input);
      expect(result, Option.some(None));
    });

    test(
        'Given a 0x010101 it should be decoded to Option.some(Option.some(true))',
        () {
      final input = HexInput('0x010101');
      final result = OptionCodec(OptionCodec(BoolCodec.instance)).decode(input);
      expect(result, Option.some(Option.some(true)));
    });

    test(
        'Given a 0x010100 it should be decoded to Option.some(Option.some(false))',
        () {
      final input = HexInput('0x010100');
      final result = OptionCodec(OptionCodec(BoolCodec.instance)).decode(input);
      expect(result, Option.some(Option.some(false)));
    });
  });
}
