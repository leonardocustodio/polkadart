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

void testPrimitiveCompact(String method, dynamic args, String expectedHex) {
  test('HexSink().$method($args) must return value $expectedHex.', () {
    var sink = HexSink();
    var mirrorSink = reflect(sink);
    mirrorSink.invoke(Symbol(method), [args]);

    var hex = mirrorSink.invoke(Symbol('toHex'), []).reflectee;
    expect(hex, equals(expectedHex));
  });
}

void testPrimitiveUncompact(String method, String args, dynamic expectedValue) {
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
    // u8
    {
      // lowest acceptable possible
      testPrimitiveCompact('u8', 0, '0x00');
      testPrimitiveUncompact('u8', '0x00', 0);

      // highest acceptable possible
      testPrimitiveCompact('u8', 127, '0x7f');
      testPrimitiveUncompact('u8', '0x7f', 127);
    }

    // u16
    {
      // lowest acceptable possible
      testPrimitiveCompact('u16', 0, '0x0000');
      testPrimitiveUncompact('u16', '0x0000', 0);

      // highest acceptable possible
      testPrimitiveCompact('u16', 32767, '0xff7f');
      testPrimitiveUncompact('u16', '0xff7f', 32767);
    }

    // u32
    {
      // lowest acceptable possible
      testPrimitiveCompact('u32', 0, '0x00000000');
      testPrimitiveUncompact('u32', '0x00000000', 0);

      // highest acceptable possible
      testPrimitiveCompact('u32', 2147483647, '0xffffff7f');
      testPrimitiveUncompact('u32', '0xffffff7f', 2147483647);
    }

    // Signed Bits
    //i8
    {
      // i8 lowest acceptable possible
      testPrimitiveCompact('i8', -128, '0x80');
      testPrimitiveUncompact('i8', '0x80', -128);

      // i8 highest acceptable possible
      testPrimitiveCompact('i8', 127, '0x7f');
      testPrimitiveUncompact('i8', '0x7f', 127);
    }

    // i16
    {
      // lowest acceptable possible
      testPrimitiveCompact('i16', -32768, '0x0080');
      testPrimitiveUncompact('i16', '0x0080', -32768);

      // highest acceptable possible
      testPrimitiveCompact('i16', 32767, '0xff7f');
      testPrimitiveUncompact('i16', '0xff7f', 32767);
    }

    // i32
    {
      // lowest acceptable possible
      testPrimitiveCompact('i32', -2147483648, '0x00000080');
      testPrimitiveUncompact('i32', '0x00000080', -2147483648);

      // highest acceptable possilbe
      testPrimitiveCompact('i32', 2147483647, '0xffffff7f');
      testPrimitiveUncompact('i32', '0xffffff7f', 2147483647);
    }

    // Bool
    // true
    testPrimitiveCompact('boolean', true, '0x01');
    testPrimitiveUncompact('boolean', '0x01', true);

    // false
    testPrimitiveCompact('boolean', false, '0x00');
    testPrimitiveUncompact('boolean', '0x00', false);
  });
}
