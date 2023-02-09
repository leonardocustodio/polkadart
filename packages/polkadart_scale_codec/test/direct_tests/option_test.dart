import 'package:polkadart_scale_codec/polkadart_scale_codec.dart';
import 'package:test/test.dart';

void main() {
  group('Option Encode Test:', () {
    test('Given a Some([3, true]) it should be encoded to 0x010c01', () {
      final output = HexOutput();
      OptionCodec(TupleCodec([CompactCodec.instance, BoolCodec.instance]))
          .encodeTo(Some([3, true]), output);
      expect(output.toString(), '0x010c01');
    });

    test('Given a None it should be encoded to 0x00', () {
      final output = HexOutput();
      OptionCodec(U8Codec.instance).encodeTo(None, output);
      expect(output.toString(), '0x00');
    });

    test('Given a Some(true) it should be encoded to 0x0101', () {
      final output = HexOutput();
      OptionCodec(BoolCodec.instance).encodeTo(Some(true), output);
      expect(output.toString(), '0x0101');
    });

    test('Given a Some(false) it should be encoded to 0x0100', () {
      final output = HexOutput();
      OptionCodec(BoolCodec.instance).encodeTo(Some(false), output);
      expect(output.toString(), '0x0100');
    });

    test('Given a Some(None) it should be encoded to 0x0100', () {
      final output = HexOutput();
      OptionCodec(OptionCodec(BoolCodec.instance)).encodeTo(Some(None), output);
      expect(output.toString(), '0x0100');
    });

    test('Given a Some(Some(true)) it should be encoded to 0x010101', () {
      final output = HexOutput();
      OptionCodec(OptionCodec(BoolCodec.instance))
          .encodeTo(Some(Some(true)), output);
      expect(output.toString(), '0x010101');
    });

    test('Given a Some(Some(false)) it should be encoded to 0x010100', () {
      final output = HexOutput();
      OptionCodec(OptionCodec(BoolCodec.instance))
          .encodeTo(Some(Some(false)), output);
      expect(output.toString(), '0x010100');
    });
  });

  group('Option Decode Test:', () {
    test('Given a 0x010c01 it should be decoded to Some([3, true])', () {
      final input = HexInput('0x010c01');
      final result =
          OptionCodec(TupleCodec([CompactCodec.instance, BoolCodec.instance]))
              .decode(input);
      expect(result.toString(), Some([3, true]).toString());
    });

    test('Given a 0x00 it should be decoded to None', () {
      final input = HexInput('0x00');
      final result = OptionCodec(U8Codec.instance).decode(input);
      expect(result, None);
    });

    test('Given a 0x0101 it should be decoded to Some(true)', () {
      final input = HexInput('0x0101');
      final result = OptionCodec(BoolCodec.instance).decode(input);
      expect(result, Some(true));
    });

    test('Given a 0x0100 it should be decoded to Some(false)', () {
      final input = HexInput('0x0100');
      final result = OptionCodec(BoolCodec.instance).decode(input);
      expect(result, Some(false));
    });

    test('Given a 0x0100 it should be decoded to Some(None)', () {
      final input = HexInput('0x0100');
      final result = OptionCodec(OptionCodec(BoolCodec.instance)).decode(input);
      expect(result, Some(None));
    });

    test('Given a 0x010101 it should be decoded to Some(Some(true))', () {
      final input = HexInput('0x010101');
      final result = OptionCodec(OptionCodec(BoolCodec.instance)).decode(input);
      expect(result, Some(Some(true)));
    });

    test('Given a 0x010100 it should be decoded to Some(Some(false))', () {
      final input = HexInput('0x010100');
      final result = OptionCodec(OptionCodec(BoolCodec.instance)).decode(input);
      expect(result, Some(Some(false)));
    });
  });
}
