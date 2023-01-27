import 'package:polkadart_scale_codec/polkadart_scale_codec.dart';
import 'package:test/test.dart';

void main() {
  final registry = TypeRegistry.createRegistry()
    ..registerCustomCodec({
      'OrderStructList': 'Vec<OrderStruct>',
      'OrderStruct': {
        '_struct': {
          'index': 'UnsignedInt8',
          'note': 'Str',
          'Juice': 'JuiceName',
          'Remarks': 'Option<Str>',
        }
      },
      'JuiceName': {
        '_struct': {
          'name': 'Str',
          'ounces': 'UnsignedInt8',
        }
      },
      'UnsignedInt8': 'u8',
    });
  group('Struct Decode Test', () {
    test(
        'When value 0x0838546869732069732061206e6f7465104b69776901014448657920466f6f642077617320676f6f64 is decoded then it returns correct struct value',
        () {
      final codec = Codec(registry: registry).fetchTypeCodec('OrderStruct');
      final structValue = codec.decode(DefaultInput.fromHex(
          '0x0838546869732069732061206e6f7465104b69776901014448657920466f6f642077617320676f6f64'));
      expect(
        structValue,
        equals(
          {
            'index': 8,
            'note': 'This is a note',
            'Juice': {
              'name': 'Kiwi',
              'ounces': 1,
            },
            'Remarks': Some('Hey Food was good'),
          },
        ),
      );
    });
    test('When hex is decoded then it returns correct struct value', () {
      final codec = Codec(registry: registry).fetchTypeCodec('OrderStructList');
      final structValue = codec.decode(DefaultInput.fromHex(
          '0x080040546869732069732061206e6f74652030284b697769204a7569636501014448657920466f6f642077617320676f6f640840546869732069732061206e6f746520312042656574726f6f740200'));
      expect(
        structValue,
        equals([
          {
            'index': 0,
            'note': 'This is a note 0',
            'Juice': {
              'name': 'Kiwi Juice',
              'ounces': 1,
            },
            'Remarks': Some('Hey Food was good'),
          },
          {
            'index': 8,
            'note': 'This is a note 1',
            'Juice': {
              'name': 'Beetroot',
              'ounces': 2,
            },
            'Remarks': None,
          },
        ]),
      );
    });

    test(
        'When value 0x104b69776901 is decoded then it returns correct struct value,',
        () {
      final codec = Codec(registry: registry).fetchTypeCodec('JuiceName');
      final structValue = codec.decode(DefaultInput.fromHex('0x104b69776901'));
      expect(
        structValue,
        equals(
          {
            'name': 'Kiwi',
            'ounces': 1,
          },
        ),
      );
    });
  });
  group('Struct Encode Test', () {
    test(
        'When struct "OrderStruct" is encoded then it returns correct hex 0x0838546869732069732061206e6f7465104b69776901014448657920466f6f642077617320676f6f64',
        () {
      final codec = Codec(registry: registry).fetchTypeCodec('OrderStruct');
      final encoder = HexEncoder();
      codec.encode(encoder, {
        'index': 8,
        'note': 'This is a note',
        'Juice': {
          'name': 'Kiwi',
          'ounces': 1,
        },
        'Remarks': Some('Hey Food was good'),
      });
      expect(
          encoder.toHex(),
          equals(
              '0x0838546869732069732061206e6f7465104b69776901014448657920466f6f642077617320676f6f64'));
    });

    test('When struct "OrderStructList" is encoded then it returns correct hex',
        () {
      final codec = Codec(registry: registry).fetchTypeCodec('OrderStructList');
      final encoder = HexEncoder();
      codec.encode(encoder, [
        {
          'index': 0,
          'note': 'This is a note 0',
          'Juice': {
            'name': 'Kiwi Juice',
            'ounces': 1,
          },
          'Remarks': Some('Hey Food was good'),
        },
        {
          'index': 8,
          'note': 'This is a note 1',
          'Juice': {
            'name': 'Beetroot',
            'ounces': 2,
          },
          'Remarks': None,
        },
      ]);
      expect(
          encoder.toHex(),
          equals(
              '0x080040546869732069732061206e6f74652030284b697769204a7569636501014448657920466f6f642077617320676f6f640840546869732069732061206e6f746520312042656574726f6f740200'));
    });
    test(
        'When struct "JuiceName" is encoded then it returns correct hex 0x104b69776901',
        () {
      final codec = Codec(registry: registry).fetchTypeCodec('JuiceName');
      final encoder = HexEncoder();
      codec.encode(encoder, {
        'name': 'Kiwi',
        'ounces': 1,
      });
      expect(encoder.toHex(), equals('0x104b69776901'));
    });
  });

  /// Exception Test
  group('Struct Decode Exception Test', () {
    test(
        'When incorrect key in struct value is encoded then it returns Exception',
        () {
      final codec = Codec(registry: registry).fetchTypeCodec('OrderStruct');
      final encoder = HexEncoder();

      expect(
          () => codec.encode(encoder, {
                'index': 8,
                'note': 'This is a note',
                'Juice': {
                  'name': 'Kiwi',
                  'ounces': 1,
                },
                'Invalid_Key': Some('Hey Food was good'),
              }),
          throwsA(isA<InvalidStructException>()));
    });
  });
}
