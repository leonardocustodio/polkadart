import 'dart:mirrors';
import 'package:polkadart_scale_codec/src/core/core.dart';
import 'package:test/expect.dart';
import 'package:test/scaffolding.dart';

void testCompact(String hex, dynamic val) {
  test('Src.compact: $hex == $val', () {
    var src = Src(hex);
    expect(src.compact(), equals(val));

    /// This should not throw error.
    src.assertEOF();
  });

  test('Sink.compact: $hex == $val', () {
    /// Test with Hex
    var sink = HexSink();
    sink.compact(val);
    expect(sink.toHex(), equals(hex));
  });
}

void testPrimitiveTypes(String method, dynamic arg) {
  test('$method($arg)', () {
    var sink = HexSink();
    var mirrorSink = reflect(sink);
    mirrorSink.invoke(Symbol(method), [arg]);

    var src = Src(mirrorSink.invoke(Symbol('toHex'), []).reflectee);

    var mirrorSrc = reflect(src);
    var decoded = mirrorSrc.invoke(Symbol(method), []).reflectee;
    expect(decoded, equals(arg));
  });
}

void main() {
  group('Test Compact: ', () {
    testCompact('0x00', 0);
    testCompact('0x04', 1);
    testCompact('0xa8', 42);
    testCompact('0x1501', 69);
    testCompact('0xfeff0300', 65535);
    testCompact('0x0b00407a10f35a', 100000000000000);
    testCompact(
        '0x1700007014057fd8b806', BigInt.parse('124000000000000000000'));
  });

  group('testing primitives: ', () {
    testPrimitiveTypes('u8', 5);
    testPrimitiveTypes('u8', 255);
    testPrimitiveTypes('u16', 126);
    testPrimitiveTypes('u16', 3220);
    testPrimitiveTypes('u64', BigInt.from(233));
    testPrimitiveTypes('u128', BigInt.from(987733));
    testPrimitiveTypes('u256', BigInt.from(77522123));
    testPrimitiveTypes('i8', -100);
    testPrimitiveTypes('i8', 100);
    testPrimitiveTypes('i16', 126);
    testPrimitiveTypes('i16', 3220);
    testPrimitiveTypes('i32', 32423445435.toSigned(32));
    testPrimitiveTypes('i64', BigInt.from(233));
    testPrimitiveTypes('i128', BigInt.from(987733));
    testPrimitiveTypes('i256', BigInt.from(77522123));
    testPrimitiveTypes('boolean', true);
    testPrimitiveTypes('boolean', false);
    testPrimitiveTypes('u128', BigInt.parse('7777777331098293847977777773'));
    testPrimitiveTypes(
        'u256',
        BigInt.parse(
            '77777773310982938479777777737777777331098293847977777773'));
    testPrimitiveTypes('str', 'hello');
    testPrimitiveTypes('str', 'привет');
  });
}
