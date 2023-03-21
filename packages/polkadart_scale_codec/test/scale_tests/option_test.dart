import 'package:polkadart_scale_codec/polkadart_scale_codec.dart';
import 'package:test/test.dart';

void main() {
  // Test with Registry
  group('Option Encode Test:', () {
    final registry = Registry()
      ..registerCustomCodec(<String, dynamic>{
        'A': 'Option<(Compact<U8>, bool)>',
        'B': 'Option<bool>',
        'C': 'Option<B>',
      });

    test('Given a Option.some([3, true]) it should be encoded to 0x010c01', () {
      final output = HexOutput();
      final codec = ScaleCodec(registry);
      codec.encodeTo('A', Option.some([3, true]), output);
      expect(output.toString(), '0x010c01');
    });

    test('Given a None it should be encoded to 0x00', () {
      final output = HexOutput();
      final codec = ScaleCodec(registry);
      codec.encodeTo('A', None, output);
      expect(output.toString(), '0x00');
    });

    test('Given a Option.some(true) it should be encoded to 0x0101', () {
      final output = HexOutput();
      final codec = ScaleCodec(registry);
      codec.encodeTo('B', Option.some(true), output);
      expect(output.toString(), '0x0101');
    });

    test('Given a Option.some(false) it should be encoded to 0x0100', () {
      final output = HexOutput();
      final codec = ScaleCodec(registry);
      codec.encodeTo('B', Option.some(false), output);
      expect(output.toString(), '0x0100');
    });

    test('Given a Option.some(None) it should be encoded to 0x0100', () {
      final output = HexOutput();
      final codec = ScaleCodec(registry);
      codec.encodeTo('C', Option.some(None), output);
      expect(output.toString(), '0x0100');
    });

    test(
        'Given a Option.some(Option.some(true)) it should be encoded to 0x010101',
        () {
      final output = HexOutput();
      final codec = ScaleCodec(registry);
      codec.encodeTo('C', Option.some(Option.some(true)), output);
      expect(output.toString(), '0x010101');
    });

    test(
        'Given a Option.some(Option.some(false)) it should be encoded to 0x010100',
        () {
      final output = HexOutput();
      final codec = ScaleCodec(registry);
      codec.encodeTo('C', Option.some(Option.some(false)), output);
      expect(output.toString(), '0x010100');
    });
  });

  group('Option Decode Test:', () {
    final registry = Registry()
      ..registerCustomCodec(<String, dynamic>{
        'A': 'Option<(Compact<U8>, bool)>',
        'B': 'Option<bool>',
        'C': 'Option<B>',
      });

    test('Given a 0x010c01 it should be decoded to Option.some([3, true])', () {
      final input = Input.fromHex('0x010c01');
      final codec = ScaleCodec(registry);
      final result = codec.decode('A', input);
      expect(result.runtimeType, Option);

      final expected = Option.some([3, true]);
      expect(result.isNone, expected.isNone);
      expect(result.value, expected.value);
    });

    test('Given a 0x00 it should be decoded to None', () {
      final input = Input.fromHex('0x00');
      final codec = ScaleCodec(registry);
      final result = codec.decode('A', input);
      expect(result, None);
      expect(result.isNone, true);
      expect(result.value, null);
    });

    test('Given a 0x0101 it should be decoded to Option.some(true)', () {
      final input = Input.fromHex('0x0101');
      final codec = ScaleCodec(registry);
      final result = codec.decode('B', input);
      expect(result.runtimeType, Option);

      final expected = Option.some(true);
      expect(result.isNone, expected.isNone);
      expect(result.value, expected.value);
    });

    test('Given a 0x0100 it should be decoded to Option.some(false)', () {
      final input = Input.fromHex('0x0100');
      final codec = ScaleCodec(registry);
      final result = codec.decode('B', input);
      expect(result.runtimeType, Option);

      final expected = Option.some(false);
      expect(result.isNone, expected.isNone);
      expect(result.value, expected.value);
    });

    test('Given a 0x0100 it should be decoded to Option.some(None)', () {
      final input = Input.fromHex('0x0100');
      final codec = ScaleCodec(registry);
      final result = codec.decode('C', input);
      expect(result.runtimeType, Option);

      final expected = Option.some(None);
      expect(result.isNone, expected.isNone);
      expect(result.value, expected.value);
    });

    test(
        'Given a 0x010101 it should be decoded to Option.some(Option.some(true))',
        () {
      final input = Input.fromHex('0x010101');
      final codec = ScaleCodec(registry);
      final result = codec.decode('C', input);
      expect(result.runtimeType, Option);

      final expected = Option.some(Option.some(true));
      expect(result.isNone, expected.isNone);
      expect(result.value, expected.value);
    });

    test(
        'Given a 0x010100 it should be decoded to Option.some(Option.some(false))',
        () {
      final input = Input.fromHex('0x010100');
      final codec = ScaleCodec(registry);
      final result = codec.decode('C', input);
      expect(result.runtimeType, Option);

      final expected = Option.some(Option.some(false));
      expect(result.isNone, expected.isNone);
      expect(result.value, expected.value);
    });
  });
}
