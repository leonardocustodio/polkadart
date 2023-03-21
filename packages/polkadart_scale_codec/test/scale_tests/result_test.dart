import 'package:polkadart_scale_codec/polkadart_scale_codec.dart';
import 'package:test/test.dart';

void main() {
  // Test with Registry
  group('ResultCodec Encode Test:', () {
    final registry = Registry()
      ..registerCustomCodec(<String, dynamic>{
        'A': 'Result<U8, U8>',
        'C': 'Result<U8, bool>',
        'B': 'Result<C, bool>',
        'D': 'Result<(U8, bool), bool>'
      });

    test('When value MapEntry("Ok", 42) is encoded then it returns 0x002a', () {
      final output = HexOutput();
      final codec = ScaleCodec(registry);
      codec.encodeTo('A', MapEntry('Ok', 42), output);
      expect(output.toString(), '0x002a');
    });
    test('When value MapEntry("Err", false) is encoded then it returns 0x0100',
        () {
      final output = HexOutput();
      final codec = ScaleCodec(registry);
      codec.encodeTo('C', MapEntry('Err', false), output);
      expect(output.toString(), '0x0100');
    });
    test(
        'When value MapEntry("Ok", MapEntry("Err", false)) is encoded then it returns 0x000100',
        () {
      final output = HexOutput();
      final codec = ScaleCodec(registry);
      codec.encodeTo('B', MapEntry('Ok', MapEntry('Err', false)), output);
      expect(output.toString(), '0x000100');
    });
    test(
        'When value MapEntry("Ok", MapEntry("Err", true)) is encoded then it returns 0x000101',
        () {
      final output = HexOutput();
      final codec = ScaleCodec(registry);
      codec.encodeTo('B', MapEntry('Ok', MapEntry('Err', true)), output);
      expect(output.toString(), '0x000101');
    });
    test(
        'When value MapEntry("Ok", [42, true]) is encoded then it returns 0x002a01',
        () {
      final output = HexOutput();
      final codec = ScaleCodec(registry);
      codec.encodeTo('D', MapEntry('Ok', [42, true]), output);
      expect(output.toString(), '0x002a01');
    });
  });

  // Decode Tests
  group('ResultCodec Decode Test:', () {
    final registry = Registry()
      ..registerCustomCodec(<String, dynamic>{
        'A': 'Result<U8, U8>',
        'C': 'Result<U8, bool>',
        'B': 'Result<C, bool>',
        'D': 'Result<(U8, bool), bool>'
      });

    test('When value 0x002a is decoded then it returns MapEntry("Ok", 42)', () {
      final input = Input.fromHex('0x002a');
      final codec = ScaleCodec(registry);
      final result = codec.decode('A', input);
      expect(result.toString(), MapEntry('Ok', 42).toString());
    });
    test('When value 0x0100 is decoded then it returns MapEntry("Err", false)',
        () {
      final input = Input.fromHex('0x0100');
      final codec = ScaleCodec(registry);
      final result = codec.decode('C', input);
      expect(result.toString(), MapEntry('Err', false).toString());
    });
    test(
        'When value 0x000100 is decoded then it returns MapEntry("Ok", MapEntry("Err", false))',
        () {
      final input = Input.fromHex('0x000100');
      final codec = ScaleCodec(registry);
      final result = codec.decode('B', input);
      expect(
          result.toString(), MapEntry('Ok', MapEntry('Err', false)).toString());
    });
    test(
        'When value 0x000101 is decoded then it returns MapEntry("Ok", MapEntry("Err", true))',
        () {
      final input = Input.fromHex('0x000101');
      final codec = ScaleCodec(registry);
      final result = codec.decode('B', input);
      expect(
          result.toString(), MapEntry('Ok', MapEntry('Err', true)).toString());
    });
    test(
        'When value 0x002a01 is decoded then it returns MapEntry("Ok", [42, true])',
        () {
      final input = Input.fromHex('0x002a01');
      final codec = ScaleCodec(registry);
      final result = codec.decode('D', input);
      expect(result.toString(), MapEntry('Ok', [42, true]).toString());
    });
  });
}
