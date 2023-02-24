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

    test('Given a Some([3, true]) it should be encoded to 0x010c01', () {
      final output = HexOutput();
      final codec = ScaleCodec(registry);
      codec.encodeTo('A', Some([3, true]), output);
      expect(output.toString(), '0x010c01');
    });

    test('Given a None it should be encoded to 0x00', () {
      final output = HexOutput();
      final codec = ScaleCodec(registry);
      codec.encodeTo('A', None, output);
      expect(output.toString(), '0x00');
    });

    test('Given a Some(true) it should be encoded to 0x0101', () {
      final output = HexOutput();
      final codec = ScaleCodec(registry);
      codec.encodeTo('B', Some(true), output);
      expect(output.toString(), '0x0101');
    });

    test('Given a Some(false) it should be encoded to 0x0100', () {
      final output = HexOutput();
      final codec = ScaleCodec(registry);
      codec.encodeTo('B', Some(false), output);
      expect(output.toString(), '0x0100');
    });

    test('Given a Some(None) it should be encoded to 0x0100', () {
      final output = HexOutput();
      final codec = ScaleCodec(registry);
      codec.encodeTo('C', Some(None), output);
      expect(output.toString(), '0x0100');
    });

    test('Given a Some(Some(true)) it should be encoded to 0x010101', () {
      final output = HexOutput();
      final codec = ScaleCodec(registry);
      codec.encodeTo('C', Some(Some(true)), output);
      expect(output.toString(), '0x010101');
    });

    test('Given a Some(Some(false)) it should be encoded to 0x010100', () {
      final output = HexOutput();
      final codec = ScaleCodec(registry);
      codec.encodeTo('C', Some(Some(false)), output);
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

    test('Given a 0x010c01 it should be decoded to Some([3, true])', () {
      final input = HexInput('0x010c01');
      final codec = ScaleCodec(registry);
      final result = codec.decode('A', input);
      expect(result.toString(), Some([3, true]).toString());
    });

    test('Given a 0x00 it should be decoded to None', () {
      final input = HexInput('0x00');
      final codec = ScaleCodec(registry);
      final result = codec.decode('A', input);
      expect(result.toString(), None.toString());
    });

    test('Given a 0x0101 it should be decoded to Some(true)', () {
      final input = HexInput('0x0101');
      final codec = ScaleCodec(registry);
      final result = codec.decode('B', input);
      expect(result.toString(), Some(true).toString());
    });

    test('Given a 0x0100 it should be decoded to Some(false)', () {
      final input = HexInput('0x0100');
      final codec = ScaleCodec(registry);
      final result = codec.decode('B', input);
      expect(result.toString(), Some(false).toString());
    });

    test('Given a 0x0100 it should be decoded to Some(None)', () {
      final input = HexInput('0x0100');
      final codec = ScaleCodec(registry);
      final result = codec.decode('C', input);
      expect(result.toString(), Some(None).toString());
    });

    test('Given a 0x010101 it should be decoded to Some(Some(true))', () {
      final input = HexInput('0x010101');
      final codec = ScaleCodec(registry);
      final result = codec.decode('C', input);
      expect(result.toString(), Some(Some(true)).toString());
    });

    test('Given a 0x010100 it should be decoded to Some(Some(false))', () {
      final input = HexInput('0x010100');
      final codec = ScaleCodec(registry);
      final result = codec.decode('C', input);
      expect(result.toString(), Some(Some(false)).toString());
    });
  });
}
