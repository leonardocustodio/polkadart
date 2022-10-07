import 'package:polkadart_scale_codec/polkadart_scale_codec.dart';
import 'package:test/expect.dart';
import 'package:test/scaffolding.dart';

void main() {
  // Creates the registry for parsing the types and selecting particular schema.
  final registry = OldTypeRegistry(
    types: <String, dynamic>{
      'Codec': {
        'a': 'Vec<u8>',
        'b': 'Vec<Vec<u8>>',
        'c': 'Vec<u256>',
        'd': 'Vec<i256>',
        'e': 'Vec<(u32, u32, u16)>',
        'f': 'Vec<(u32, Option<bool>)>',
        'g': 'Vec<(String, bool)>', // String ~ Text ~ Str
        'h': 'Vec<bool>',
        'i': 'Vec<Option<bool>>',
        'j': 'Vec<Option<u8>>',
        'k': 'Vec<Text>', // Text ~ String ~ Str
      },
    },
  );
  // specifying which schema key to select and use
  registry.select('Codec');

  // fetching the parsed types from `Json` to `Type`
  final types = registry.getTypes();

  // Initializing Scale-Codec object
  final codec = Codec(types);

  {
    //
    // Testing with Vec<u8>
    //
    group('Test Vec<u8>:', () {
      test('[255, 255] when encoded should produce result: \'0x08ffff\'', () {
        var encoded =
            codec.encodeToHex(registry.getIndex('Vec<u8>'), [255, 255]);
        expect('0x08ffff', encoded);
      });

      test('0x08ffff when decoded should produce result: [255, 255]', () {
        var decoded =
            codec.decodeBinary(registry.getIndex('Vec<u8>'), '0x08ffff');
        expect([255, 255], decoded);
      });
    });
  }
  {
    //
    // Testing with Vec<Option<u8>>
    //
    group('Test Vec<u8>:', () {
      test('[255, null] when encoded should produce result: \'0x0801ff00\'', () {
        var encoded =
            codec.encodeToHex(registry.getIndex('Vec<Option<u8>>'), [255, null]);
        expect('0x0801ff00', encoded);
      });

      test('0x0801ff00 when decoded should produce result: [255, null]', () {
        var decoded =
            codec.decodeBinary(registry.getIndex('Vec<Option<u8>>'), '0x0801ff00');
        expect([255, null], decoded);
      });
    });
  }

  {
    //
    // Testing with Vec<u256>
    //
    group('Test Vec<u256>:', () {
      final values = [0.toBigInt, 2.toBigInt.pow(255) - 1.toBigInt];
      test(
          '$values when encoded should produce result: \'0x080000000000000000000000000000000000000000000000000000000000000000ffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff7f\'',
          () {
        var encoded = codec.encodeToHex(registry.getIndex('Vec<u256>'), values);
        expect(
            '0x080000000000000000000000000000000000000000000000000000000000000000ffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff7f',
            encoded);
      });

      test(
          '0x080000000000000000000000000000000000000000000000000000000000000000ffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff7f when decoded should produce result: $values',
          () {
        var decoded = codec.decodeBinary(registry.getIndex('Vec<u256>'),
            '0x080000000000000000000000000000000000000000000000000000000000000000ffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff7f');
        expect(values, decoded);
      });
    });
  }
  {
    //
    // Testing with Vec<i256>
    //
    group('Test Vec<i256>:', () {
      final values = [-2.toBigInt.pow(255 - 1), 2.toBigInt.pow(255 - 1)];
      test(
          '$values when encoded should produce result: \'0x0800000000000000000000000000000000000000000000000000000000000000c00000000000000000000000000000000000000000000000000000000000000040\'',
          () {
        var encoded = codec.encodeToHex(registry.getIndex('Vec<i256>'), values);
        expect(
            '0x0800000000000000000000000000000000000000000000000000000000000000c00000000000000000000000000000000000000000000000000000000000000040',
            encoded);
      });

      test(
          '0x0800000000000000000000000000000000000000000000000000000000000000c00000000000000000000000000000000000000000000000000000000000000040 when decoded should produce result: $values',
          () {
        var decoded = codec.decodeBinary(registry.getIndex('Vec<i256>'),
            '0x0800000000000000000000000000000000000000000000000000000000000000c00000000000000000000000000000000000000000000000000000000000000040');
        expect(values, decoded);
      });
    });
  }

  {
    //
    // Testing with Vec<bool>
    //
    group('Test Vec<bool>:', () {
      // Encode
      test(
          '[false, true, true] when encoded should produce result: \'0x0c000101\'',
          () {
        var encoded = codec
            .encodeToHex(registry.getIndex('Vec<bool>'), [false, true, true]);
        expect('0x0c000101', encoded);
      });
      test('[] when encoded should produce result: \'0x00\'', () {
        var encoded = codec.encodeToHex(registry.getIndex('Vec<bool>'), []);
        expect('0x00', encoded);
      });

      // Decode
      test('0x0c000101 when decoded should produce result: [false, true, true]',
          () {
        var decoded =
            codec.decodeBinary(registry.getIndex('Vec<bool>'), '0x0c000101');
        expect([false, true, true], decoded);
      });
    });
  }

  {
    //
    // Testing with Vec<Option<bool>>
    //
    group('Test Vec<Option<bool>>:', () {
      // Encode
      test(
          '[false, true, true] when encoded should produce result: \'0x0c000101\'',
          () {
        var encoded = codec.encodeToHex(
            registry.getIndex('Vec<Option<bool>>'), [false, true, null, true]);
        expect('0x1001000101000101', encoded);
      });

      // Decode
      test(
          '0x1001000101000101 when decoded should produce result: [false, true, null, true]',
          () {
        var decoded = codec.decodeBinary(
            registry.getIndex('Vec<Option<bool>>'), '0x1001000101000101');
        expect([false, true, null, true], decoded);
      });
    });
  }

  {
    //
    // Testing with Vec<Vec<u8>>
    //
    group('Test Vec<Vec<u8>>:', () {
      // Encode
      test(
          '[[255, 255], [1, 2, 3, 4]] when encoded should produce result: \'0x0808ffff1001020304\'',
          () {
        var encoded = codec.encodeToHex(registry.getIndex('Vec<Vec<u8>>'), [
          [255, 255],
          [1, 2, 3, 4]
        ]);
        expect('0x0808ffff1001020304', encoded);
      });

      // Decode
      test(
          '0x0808ffff1001020304 when decoded should produce result: [[255, 255], [1, 2, 3, 4]]',
          () {
        var decoded = codec.decodeBinary(
            registry.getIndex('Vec<Vec<u8>>'), '0x0808ffff1001020304');
        expect([
          [255, 255],
          [1, 2, 3, 4]
        ], decoded);
      });
    });
  }

  {
    //
    // Testing with Vec<Text>
    //
    group('Test Vec<Text>:', () {
      // Encode
      test(
          '["Hamlet", "Война и мир", "三国演义", "أَلْف لَيْلَة وَلَيْلَة‎"] when encoded should pass easily.',
          () {
        var encoded = codec.encodeToHex(registry.getIndex('Vec<Text>'),
            ["Hamlet", "Война и мир", "三国演义", "أَلْف لَيْلَة وَلَيْلَة‎"]);
        expect(
            '0x101848616d6c657450d092d0bed0b9d0bdd0b020d0b820d0bcd0b8d18030e4b889e59bbde6bc94e4b989bcd8a3d98ed984d992d98120d984d98ed98ad992d984d98ed8a920d988d98ed984d98ed98ad992d984d98ed8a9e2808e',
            encoded);
      });

      // Decode
      test(
          ' when decoded should produce result: ["Hamlet", "Война и мир", "三国演义", "أَلْف لَيْلَة وَلَيْلَة‎"]',
          () {
        var decoded = codec.decodeBinary(registry.getIndex('Vec<Text>'),
            '0x101848616d6c657450d092d0bed0b9d0bdd0b020d0b820d0bcd0b8d18030e4b889e59bbde6bc94e4b989bcd8a3d98ed984d992d98120d984d98ed98ad992d984d98ed8a920d988d98ed984d98ed98ad992d984d98ed8a9e2808e');
        expect(["Hamlet", "Война и мир", "三国演义", "أَلْف لَيْلَة وَلَيْلَة‎"],
            decoded);
      });
    });

    group('Exception Test Vec<Text>:', () {
      test(
          '["Hamlet", "Война и мир", "三国演义", true] when encoded should pass easily.',
          () {
        final exceptionMessage =
            'Needed val of type \'String\' but found bool.';
        expect(
            () => codec.encodeToHex(registry.getIndex('Vec<Text>'),
                ["Hamlet", "Война и мир", "三国演义", true]),
            throwsA(predicate((e) =>
                e is AssertionException && e.toString() == exceptionMessage)));
      });
      test(
          'decodeBinary should throw exception \'EOFException\' when decoded with incorrect length at first 2 bytes of hex.',
          () {
        final encodedHex =
            '0x201848616d6c657450d092d0bed0b9d0bdd0b020d0b820d0bcd0b8d18030e4b889e59bbde6bc94e4b989bcd8a3d98ed984d992d98120d984d98ed98ad992d984d98ed8a920d988d98ed984d98ed98ad992d984d98ed8a9e2808e';

        final exceptionMessage = 'Unexpected end of file/source exception.';
        expect(
            () =>
                codec.decodeBinary(registry.getIndex('Vec<Text>'), encodedHex),
            throwsA(predicate(
                (e) => e is EOFException && e.toString() == exceptionMessage)));
      });
    });
  }

  {
    //
    // Testing with Vec<(u32, Option<bool>)>
    //
    group('Test Vec<(u32, Option<bool>)>:', () {
      test(
          '[[716, null], [256, true]] when encoded should produce result: \'0x08cc02000000000100000101\'',
          () {
        var encoded =
            codec.encodeToHex(registry.getIndex('Vec<(u32, Option<bool>)>'), [
          [716, null],
          [256, true]
        ]);
        expect('0x08cc02000000000100000101', encoded);
      });
      test(
          '\'0x08cc02000000000100000101\' when decoded should produce result: [[716, null], [256, true]]',
          () {
        var decoded = codec.decodeBinary(
            registry.getIndex('Vec<(u32, Option<bool>)>'),
            '0x08cc02000000000100000101');
        expect([
          [716, null],
          [256, true]
        ], decoded);
      });
    });

    group('Encode Exception Test Vec<(u32, Option<bool>)>:', () {
      test(
          '[[716, null], [256, true]] should throw \'AssertionException\' with message: \'Incorrect length of values to unwrap to tuple.\'.',
          () {
        final exceptionMessage =
            'Incorrect length of values to unwrap to tuple.';
        expect(
            () => codec.encodeToHex(
                    registry.getIndex('Vec<(u32, Option<bool>)>'), [
                  [716, 'null', 123],
                  [256, true]
                ]),
            throwsA(predicate((e) =>
                e is AssertionException && e.toString() == exceptionMessage)));
      });

      test(
          '[[716, null], [256, true]] should throw \'AssertionException\' with message: \'Needed val of type \'int\' but found String.\'.',
          () {
        final exceptionMessage = 'Needed val of type \'bool\' but found int.';
        expect(
            () => codec.encodeToHex(
                    registry.getIndex('Vec<(u32, Option<bool>)>'), [
                  [716, 252],
                  [256, true]
                ]),
            throwsA(predicate((e) =>
                e is AssertionException && e.toString() == exceptionMessage)));
      });
    });
  }
  {
    //
    // Testing with Vec<(String, bool)>
    //
    group('Test Vec<(String, bool)>:', () {
      test(
          '[[\'true\', true], [\'false\', false]] when encoded should produce result: \'0x081074727565011466616c736500\'',
          () {
        var encoded =
            codec.encodeToHex(registry.getIndex('Vec<(String, bool)>'), [
          ['true', true],
          ['false', false]
        ]);
        expect('0x081074727565011466616c736500', encoded);
      });
      test(
          '\'0x081074727565011466616c736500\' when decoded should produce result: [[\'true\', true], [\'false\', false]]',
          () {
        var decoded = codec.decodeBinary(
            registry.getIndex('Vec<(String, bool)>'),
            '0x081074727565011466616c736500');
        expect([
          ['true', true],
          ['false', false]
        ], decoded);
      });
    });
  }

  {
    //
    // Testing with Vec<(u32, u32, u16)>
    //
    group('Test Vec<(u32, u32, u16)>:', () {
      test(
          '[[716, 47054848, 0], [256, 0, 0]] when encoded should produce result: \'0x08cc0200000000ce02000000010000000000000000\'',
          () {
        var encoded =
            codec.encodeToHex(registry.getIndex('Vec<(u32, u32, u16)>'), [
          [716, 47054848, 0],
          [256, 0, 0]
        ]);
        expect('0x08cc0200000000ce02000000010000000000000000', encoded);
      });
      test(
          '\'0x08cc0200000000ce02000000010000000000000000\' when decoded should produce result: [[716, 47054848, 0], [256, 0, 0]]',
          () {
        var decoded = codec.decodeBinary(
            registry.getIndex('Vec<(u32, u32, u16)>'),
            '0x08cc0200000000ce02000000010000000000000000');
        expect([
          [716, 47054848, 0],
          [256, 0, 0]
        ], decoded);
      });
    });

    group('Encode Exception Test Vec<(u32, u32, u16)>:', () {
      test(
          '[[716, 47054848], [256, 0, 0]] should throw \'AssertionException\' with message: \'Incorrect length of values to unwrap to tuple.\'.',
          () {
        final exceptionMessage =
            'Incorrect length of values to unwrap to tuple.';
        expect(
            () => codec.encodeToHex(registry.getIndex('Vec<(u32, u32, u16)>'), [
                  [716, 47054848],
                  [256, 0, 0]
                ]),
            throwsA(predicate((e) =>
                e is AssertionException && e.toString() == exceptionMessage)));
      });

      test(
          '[[716, 47054848, \'0\'], [256, \'0\', \'0\']] should throw \'AssertionException\' with message: \'Needed val of type \'int\' but found String.\'.',
          () {
        final exceptionMessage = 'Needed val of type \'int\' but found String.';
        expect(
            () => codec.encodeToHex(registry.getIndex('Vec<(u32, u32, u16)>'), [
                  [716, 47054848, '0'],
                  ['256', '0', '0']
                ]),
            throwsA(predicate((e) =>
                e is AssertionException && e.toString() == exceptionMessage)));
      });
    });
  }
}
