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
    // Bool
    // true
    testPrimitiveCompact('boolean', true, '0x01');
    testPrimitiveUncompact('boolean', '0x01', true);

    // false
    testPrimitiveCompact('boolean', false, '0x00');
    testPrimitiveUncompact('boolean', '0x00', false);
  });
}
