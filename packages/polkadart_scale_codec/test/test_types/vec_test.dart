import 'package:polkadart_scale_codec/polkadart_scale_codec.dart';
import 'package:test/expect.dart';
import 'package:test/scaffolding.dart';

void main() {
  // Creates the registry for parsing the types and selecting particular schema.
  final registry = TypeRegistry(
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
    group('Test Vec<u8>:', () {
      // Encode
      test(
          'When [255, 255] is encoded then it should produce result: \'0x08ffff\'',
          () {
        final String expectedValue = '0x08ffff';
        final String encodedValue =
            codec.encode(registry.getIndex('Vec<u8>'), [255, 255]);
        expect(encodedValue, expectedValue);
      });

      // Decode
      test('When 0x08ffff is decoded then it should produce result: [255, 255]',
          () {
        final expectedValue = [255, 255];
        final decodedValue =
            codec.decode(registry.getIndex('Vec<u8>'), '0x08ffff');
        expect(decodedValue, expectedValue);
      });
    });
  }

  {
    group('Test Vec<u8>:', () {
      // Encode
      test(
          'When [Some(255), None] is encoded then it should produce result: \'0x0801ff00\'',
          () {
        final String expectedValue = '0x0801ff00';

        final String encodedValue = codec
            .encode(registry.getIndex('Vec<Option<u8>>'), [Some(255), None]);

        expect(encodedValue, expectedValue);
      });

      // Decode
      test(
          'When 0x0801ff00 is decoded then it should produce result: [Some(255), None]',
          () {
        final expectedValue = [Some(255), None];

        final decodedValue =
            codec.decode(registry.getIndex('Vec<Option<u8>>'), '0x0801ff00');

        expect(decodedValue, expectedValue);
      });
    });
  }

  {
    group('Test Vec<u256>:', () {
      final values = [0.toBigInt, 2.toBigInt.pow(255) - 1.toBigInt];
      // Encode
      test('When $values are encoded then it should pass easily', () {
        final expectedValue =
            '0x080000000000000000000000000000000000000000000000000000000000000000ffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff7f';

        final encodedValue =
            codec.encode(registry.getIndex('Vec<u256>'), values);

        expect(encodedValue, expectedValue);
      });

      // Decode
      test(
          '0x080000000000000000000000000000000000000000000000000000000000000000ffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff7f when decoded should produce result: $values',
          () {
        var decoded = codec.decode(registry.getIndex('Vec<u256>'),
            '0x080000000000000000000000000000000000000000000000000000000000000000ffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff7f');
        expect(decoded, values);
      });
    });
  }
  {
    group('Test Vec<i256>:', () {
      final values = [-2.toBigInt.pow(255 - 1), 2.toBigInt.pow(255 - 1)];
      // Encode
      test('When $values is encoded should pass easily', () {
        final expectedValue =
            '0x0800000000000000000000000000000000000000000000000000000000000000c00000000000000000000000000000000000000000000000000000000000000040';

        final encoded = codec.encode(registry.getIndex('Vec<i256>'), values);

        expect(encoded, expectedValue);
      });

      // Decode
      test(
          '0x0800000000000000000000000000000000000000000000000000000000000000c00000000000000000000000000000000000000000000000000000000000000040 when decoded should produce result: $values',
          () {
        final expectedValue = values;
        final decodedvalue = codec.decode(registry.getIndex('Vec<i256>'),
            '0x0800000000000000000000000000000000000000000000000000000000000000c00000000000000000000000000000000000000000000000000000000000000040');
        expect(decodedvalue, expectedValue);
      });
    });
  }

  {
    group('Test Vec<bool>:', () {
      // Encode
      test(
          'When [false, true, true] is encoded then it should produce result: \'0x0c000101\'',
          () {
        final expectedValue = '0x0c000101';

        final encodedValue =
            codec.encode(registry.getIndex('Vec<bool>'), [false, true, true]);

        expect(encodedValue, expectedValue);
      });
      test('When [] is encoded then it should produce result: \'0x00\'', () {
        final expectedValue = '0x00';

        final encodedValue = codec.encode(registry.getIndex('Vec<bool>'), []);

        expect(encodedValue, expectedValue);
      });

      // Decode
      test(
          'When 0x0c000101 is decoded then it should produce result: [false, true, true]',
          () {
        final expectedValue = [false, true, true];

        final decodedValue =
            codec.decode(registry.getIndex('Vec<bool>'), '0x0c000101');

        expect(decodedValue, expectedValue);
      });
    });
  }

  {
    group('Test Vec<Option<bool>>:', () {
      // Encode
      test(
          'When [Some(false), Some(true), None, Some(true)] is encoded then it should produce result: \'0x0c000101\'',
          () {
        final expectedValue = '0x1001000101000101';

        final encodedValue = codec.encode(
            registry.getIndex('Vec<Option<bool>>'),
            [Some(false), Some(true), None, Some(true)]);

        expect(encodedValue, expectedValue);
      });

      // Decode
      test(
          'When 0x1001000101000101 is decoded then it should produce result: [Some(false), Some(true), None, Some(true)]',
          () {
        final expectedValue = [Some(false), Some(true), None, Some(true)];

        final decodedValue = codec.decode(
            registry.getIndex('Vec<Option<bool>>'), '0x1001000101000101');

        expect(decodedValue, equals(expectedValue));
      });
    });
  }

  {
    group('Test Vec<Vec<u8>>:', () {
      // Encode
      test(
          'When [[255, 255], [1, 2, 3, 4]] is encoded then it should produce result: \'0x0808ffff1001020304\'',
          () {
        final expectedValue = '0x0808ffff1001020304';

        final encodedValue = codec.encode(registry.getIndex('Vec<Vec<u8>>'), [
          [255, 255],
          [1, 2, 3, 4]
        ]);

        expect(encodedValue, expectedValue);
      });

      // Decode
      test(
          'When 0x0808ffff1001020304 is decoded then it should produce result: [[255, 255], [1, 2, 3, 4]]',
          () {
        final expectedValue = [
          [255, 255],
          [1, 2, 3, 4]
        ];

        final decodedValue = codec.decode(
            registry.getIndex('Vec<Vec<u8>>'), '0x0808ffff1001020304');

        expect(decodedValue, expectedValue);
      });
    });
  }

  {
    group('Test Vec<Text>:', () {
      // Encode
      test(
          'When ["Hamlet", "Война и мир", "三国演义", "أَلْف لَيْلَة وَلَيْلَة‎"] is encoded then it should pass easily.',
          () {
        final expectedValue =
            '0x101848616d6c657450d092d0bed0b9d0bdd0b020d0b820d0bcd0b8d18030e4b889e59bbde6bc94e4b989bcd8a3d98ed984d992d98120d984d98ed98ad992d984d98ed8a920d988d98ed984d98ed98ad992d984d98ed8a9e2808e';

        final encodedValue = codec.encode(registry.getIndex('Vec<Text>'),
            ["Hamlet", "Война и мир", "三国演义", "أَلْف لَيْلَة وَلَيْلَة‎"]);

        expect(encodedValue, expectedValue);
      });

      // Decode
      test(
          'When \'0x101848616d6c657450d092d0bed0b9d0bdd0b020d0b820d0bcd0b8d18030e4b889e59bbde6bc94e4b989bcd8a3d98ed984d992d98120d984d98ed98ad992d984d98ed8a920d988d98ed984d98ed98ad992d984d98ed8a9e2808e\' is decoded then it should produce result: ["Hamlet", "Война и мир", "三国演义", "أَلْف لَيْلَة وَلَيْلَة‎"]',
          () {
        final expectedValue = [
          "Hamlet",
          "Война и мир",
          "三国演义",
          "أَلْف لَيْلَة وَلَيْلَة‎"
        ];

        final decodedValue = codec.decode(registry.getIndex('Vec<Text>'),
            '0x101848616d6c657450d092d0bed0b9d0bdd0b020d0b820d0bcd0b8d18030e4b889e59bbde6bc94e4b989bcd8a3d98ed984d992d98120d984d98ed98ad992d984d98ed8a920d988d98ed984d98ed98ad992d984d98ed8a9e2808e');

        expect(decodedValue, expectedValue);
      });
    });

    group('Exception Test Vec<Text>:', () {
      test(
          'When ["Hamlet", "Война и мир", "三国演义", true] is encoded then it should throw \'AssertionException\'',
          () {
        expect(
            () => codec.encode(registry.getIndex('Vec<Text>'),
                ["Hamlet", "Война и мир", "三国演义", true]),
            throwsA(isA<AssertionException>()));
      });
      test(
          'When decoded with incorrect length at first 2 bytes of hex, then it should throw exception \'EOFException\'',
          () {
        final encodedHex =
            '0x201848616d6c657450d092d0bed0b9d0bdd0b020d0b820d0bcd0b8d18030e4b889e59bbde6bc94e4b989bcd8a3d98ed984d992d98120d984d98ed98ad992d984d98ed8a920d988d98ed984d98ed98ad992d984d98ed8a9e2808e';

        expect(() => codec.decode(registry.getIndex('Vec<Text>'), encodedHex),
            throwsA(isA<EOFException>()));
      });
    });
  }

  {
    group('Test Vec<(u32, Option<bool>)>:', () {
      test(
          'When [[716, None], [256, Some(true)]] is encoded then it should produce result: \'0x08cc02000000000100000101\'',
          () {
        final expectedValue = '0x08cc02000000000100000101';

        final encodedValue =
            codec.encode(registry.getIndex('Vec<(u32, Option<bool>)>'), [
          [716, None],
          [256, Some(true)]
        ]);

        expect(encodedValue, expectedValue);
      });
      test(
          'When \'0x08cc02000000000100000101\' is decoded then it should produce result: [[716, None], [256, Some(true)]]',
          () {
        final expectedValue = [
          [716, None],
          [256, Some(true)]
        ];

        final decodedValue = codec.decode(
            registry.getIndex('Vec<(u32, Option<bool>)>'),
            '0x08cc02000000000100000101');

        expect(decodedValue, expectedValue);
      });
    });

    group('Encode Exception Test Vec<(u32, Option<bool>)>:', () {
      test(
          'When [[716, \'null\', 123], [256, true]] is encoded it should throw \'AssertionException\'',
          () {
        final value = [
          [716, 'null', 123],
          [256, true]
        ];

        expect(
            () => codec.encode(
                registry.getIndex('Vec<(u32, Option<bool>)>'), value),
            throwsA(isA<AssertionException>()));
      });

      test(
          'When [[716, 252], [256, true]] is encoded it should throw \'AssertionException\'',
          () {
        final value = [
          [716, 252],
          [256, true]
        ];

        expect(
            () => codec.encode(
                registry.getIndex('Vec<(u32, Option<bool>)>'), value),
            throwsA(isA<AssertionException>()));
      });
    });
  }
  {
    group('Test Vec<(String, bool)>:', () {
      // Encode
      test(
          'When [[\'true\', true], [\'false\', false]] is encoded then it should produce result: \'0x081074727565011466616c736500\'',
          () {
        final expectedValue = '0x081074727565011466616c736500';

        final encodedValue =
            codec.encode(registry.getIndex('Vec<(String, bool)>'), [
          ['true', true],
          ['false', false]
        ]);

        expect(encodedValue, expectedValue);
      });

      // Decode
      test(
          'When \'0x081074727565011466616c736500\' is decoded then it should produce result: [[\'true\', true], [\'false\', false]]',
          () {
        final expectedValue = [
          ['true', true],
          ['false', false]
        ];

        final decodedValue = codec.decode(
            registry.getIndex('Vec<(String, bool)>'),
            '0x081074727565011466616c736500');

        expect(decodedValue, expectedValue);
      });
    });
  }

  {
    //
    // Testing with Vec<(u32, u32, u16)>
    //
    group('Test Vec<(u32, u32, u16)>:', () {
      test(
          'When [[716, 47054848, 0], [256, 0, 0]] is encoded then it should produce result: \'0x08cc0200000000ce02000000010000000000000000\'',
          () {
        final expectedValue = '0x08cc0200000000ce02000000010000000000000000';

        final encodedValue =
            codec.encode(registry.getIndex('Vec<(u32, u32, u16)>'), [
          [716, 47054848, 0],
          [256, 0, 0]
        ]);

        expect(encodedValue, expectedValue);
      });
      test(
          'When \'0x08cc0200000000ce02000000010000000000000000\' is decoded then it should produce result: [[716, 47054848, 0], [256, 0, 0]]',
          () {
        final expectedValue = [
          [716, 47054848, 0],
          [256, 0, 0]
        ];

        final decodedValue = codec.decode(
            registry.getIndex('Vec<(u32, u32, u16)>'),
            '0x08cc0200000000ce02000000010000000000000000');

        expect(decodedValue, expectedValue);
      });
    });

    group('Encode Exception Test Vec<(u32, u32, u16)>:', () {
      test(
          'When [[716, 47054848], [256, 0, 0]] is encoded then it should throw \'AssertionException\'',
          () {
        expect(
            () => codec.encode(registry.getIndex('Vec<(u32, u32, u16)>'), [
                  [716, 47054848],
                  [256, 0, 0]
                ]),
            throwsA(isA<AssertionException>()));
      });

      test(
          'When [[716, 47054848, \'0\'], [256, \'0\', \'0\']] is encoded then it should throw \'AssertionException\'',
          () {
        expect(
            () => codec.encode(registry.getIndex('Vec<(u32, u32, u16)>'), [
                  [716, 47054848, '0'],
                  ['256', '0', '0']
                ]),
            throwsA(isA<AssertionException>()));
      });
    });
  }
}
