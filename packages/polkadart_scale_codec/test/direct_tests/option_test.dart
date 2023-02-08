import 'package:polkadart_scale_codec/polkadart_scale_codec.dart';
import 'package:test/test.dart';

void main() {
  group('Option Encode Test:', () {
    test('None encoding', () {
      final output = HexOutput();
      OptionCodec(U8Codec.instance).encodeTo(None, output);
      expect(output.toString(), '0x00');
    });

    test('Some(true) encoding', () {
      final output = HexOutput();
      OptionCodec(BoolCodec.instance).encodeTo(Some(true), output);
      expect(output.toString(), '0x0101');
    });

    test('Some(false) encoding', () {
      final output = HexOutput();
      OptionCodec(BoolCodec.instance).encodeTo(Some(false), output);
      expect(output.toString(), '0x0100');
    });

    test('Some(None) encoding', () {
      final output = HexOutput();
      OptionCodec(OptionCodec(BoolCodec.instance))
          .encodeTo(Some(None), output);
      expect(output.toString(), '0x0100');
    });

    test('Some(Some(true)) encoding', () {
      final output = HexOutput();
      OptionCodec(OptionCodec(BoolCodec.instance))
          .encodeTo(Some(Some(true)), output);
      expect(output.toString(), '0x010101');
    });

    test('Some(Some(false)) encoding', () {
      final output = HexOutput();
      OptionCodec(OptionCodec(BoolCodec.instance))
          .encodeTo(Some(Some(false)), output);
      expect(output.toString(), '0x010100');
    });
  });
}
