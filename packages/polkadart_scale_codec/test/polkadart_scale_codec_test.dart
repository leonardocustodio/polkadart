import 'dart:mirrors';

import 'package:polkadart_scale_codec/src/core/core.dart';
import 'package:test/expect.dart';
import 'package:test/scaffolding.dart';

void testCompact(String hex, dynamic val) {
  test('Src.compact: $hex == $val', () {
    var src = Source(hex);
    expect(src.compact(), equals(val));

    // This should not throw error.
    expect(() => src.assertEOF(), returnsNormally);
  });

  test('Sink.compact: $hex == $val', () {
    // Test with Hex
    var sink = HexSink();
    sink.compact(val);
    expect(sink.toHex(), equals(hex));
  });
}

void testPrimitiveEncode(String method, dynamic args, String expectedHex) {
  test('HexSink().$method($args) must return value $expectedHex.', () {
    var sink = HexSink();
    var mirrorSink = reflect(sink);
    mirrorSink.invoke(Symbol(method), [args]);

    var hex = mirrorSink.invoke(Symbol('toHex'), []).reflectee;
    expect(hex, equals(expectedHex));
  });
}

void testPrimitiveDecode(String method, String args, dynamic expectedValue) {
  test('Source(\'$args\').$method() must return value $expectedValue.', () {
    var src = Source(args);

    var mirrorSrc = reflect(src);
    var decoded = mirrorSrc.invoke(Symbol(method), []).reflectee;
    expect(decoded, equals(expectedValue));
  });
}

void main() {
  group('Test Compact:', () {
    testCompact('0x00', 0);
    testCompact('0x04', 1);
    testCompact('0xa8', 42);
    testCompact('0x1501', 69);
    testCompact('0xfeff0300', 65535);
    testCompact('0x0b00407a10f35a', 100000000000000);
    testCompact(
        '0x1700007014057fd8b806', BigInt.parse('124000000000000000000'));
  });

  group('Testing primitives:', () {
    // Unsigned Bits
    // u8 low
    testPrimitiveEncode('u8', 0, '0x00');
    testPrimitiveDecode('u8', '0x00', 0);

    // u8 high
    testPrimitiveEncode('u8', 255, '0xff');
    testPrimitiveDecode('u8', '0xff', 255);

    // u16 low
    testPrimitiveEncode('u16', 0, '0x0000');
    testPrimitiveDecode('u16', '0x0000', 0);

    // u16 high
    testPrimitiveEncode('u16', 65535, '0xffff');
    testPrimitiveDecode('u16', '0xffff', 65535);

    // u32 low
    testPrimitiveEncode('u32', 0, '0x00000000');
    testPrimitiveDecode('u32', '0x00000000', 0);

    // u32 high
    testPrimitiveEncode('u32', 4294967295, '0xffffffff');
    testPrimitiveDecode('u32', '0xffffffff', 4294967295);

    // Signed Bits
    // i8 low
    testPrimitiveEncode('i8', -128, '0x80');
    testPrimitiveDecode('i8', '0x80', -128);

    // i8 high
    testPrimitiveEncode('i8', 127, '0x7f');
    testPrimitiveDecode('i8', '0x7f', 127);

    // i16 low
    testPrimitiveEncode('i16', -32768, '0x0080');
    testPrimitiveDecode('i16', '0x0080', -32768);

    // i16 high
    testPrimitiveEncode('i16', 32767, '0xff7f');
    testPrimitiveDecode('i16', '0xff7f', 32767);

    // i32 low
    testPrimitiveEncode('i32', -2147483648, '0x00000080');
    testPrimitiveDecode('i32', '0x00000080', -2147483648);

    // i32 high
    testPrimitiveEncode('i32', 2147483647, '0xffffff7f');
    testPrimitiveDecode('i32', '0xffffff7f', 2147483647);

    // Bool
    // true
    testPrimitiveEncode('boolean', true, '0x01');
    testPrimitiveDecode('boolean', '0x01', true);

    // false
    testPrimitiveEncode('boolean', false, '0x00');
    testPrimitiveDecode('boolean', '0x00', false);
/*
    testPrimitiveEncode('u128', BigInt.parse('7777777331098293847977777773'));
    testPrimitiveEncode(
        'u256',
        BigInt.parse(
            '77777773310982938479777777737777777331098293847977777773'));
    testPrimitiveEncode('str', 'hello');
    testPrimitiveEncode('str', 'привет'); */
  });
}
