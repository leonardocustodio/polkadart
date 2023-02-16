import 'package:polkadart_scale_codec/polkadart_scale_codec.dart';
import 'package:test/test.dart';

void main() {
  // Test with Registry
  group('StructCodec Encode Test:', () {
    final registry = Registry()
      ..registerCustomCodec(<String, dynamic>{
        'OrderStructList': 'Vec<OrderStruct>',
        'OrderStruct': {
          'index': 'UnsignedInt8',
          'note': 'Str',
          'Juice': 'JuiceName',
          'Remarks': 'Option<Str>',
        },
        'JuiceName': {
          'name': 'Str',
          'ounces': 'UnsignedInt8',
        },
        'UnsignedInt8': 'u8',
      });
    test(
        'When struct "OrderStruct" is encoded then it returns correct hex 0x0838546869732069732061206e6f7465104b69776901014448657920466f6f642077617320676f6f64',
        () {
      final output = HexOutput();
      final codec = ScaleCodec(registry);
      codec.encodeTo(
        'OrderStruct',
        {
          'index': 8,
          'note': 'This is a note',
          'Juice': {
            'name': 'Kiwi',
            'ounces': 1,
          },
          'Remarks': Some('Hey Food was good'),
        },
        output,
      );
      expect(
        output.toString(),
        '0x0838546869732069732061206e6f7465104b69776901014448657920466f6f642077617320676f6f64',
      );
    });
    test('When struct "OrderStructList" is encoded then it returns correct hex',
        () {
      final output = HexOutput();
      final codec = ScaleCodec(registry);
      codec.encodeTo(
        'OrderStructList',
        [
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
        ],
        output,
      );
      expect(
          output.toString(),
          equals(
              '0x080040546869732069732061206e6f74652030284b697769204a7569636501014448657920466f6f642077617320676f6f640840546869732069732061206e6f746520312042656574726f6f740200'));
    });
    test(
        'When struct "JuiceName" is encoded then it returns correct hex 0x104b69776901',
        () {
      final output = HexOutput();
      final codec = ScaleCodec(registry);
      codec.encodeTo(
        'JuiceName',
        {
          'name': 'Kiwi',
          'ounces': 1,
        },
        output,
      );
      expect(output.toString(), '0x104b69776901');
    });
  });

  // Decode Tests
  group('StructCodec Decode Test:', () {
    final registry = Registry()
      ..registerCustomCodec(<String, dynamic>{
        'OrderStructList': 'Vec<OrderStruct>',
        'OrderStruct': {
          'index': 'UnsignedInt8',
          'note': 'Str',
          'Juice': 'JuiceName',
          'Remarks': 'Option<Str>',
        },
        'JuiceName': {
          'name': 'Str',
          'ounces': 'UnsignedInt8',
        },
        'UnsignedInt8': 'u8',
      });
    test('When struct "OrderStruct" is decoded then it returns correct value',
        () {
      final input = HexInput(
          '0x0838546869732069732061206e6f7465104b69776901014448657920466f6f642077617320676f6f64');
      final codec = ScaleCodec(registry);
      final result = codec.decode('OrderStruct', input);
      expect(
        result,
        equals({
          'index': 8,
          'note': 'This is a note',
          'Juice': {
            'name': 'Kiwi',
            'ounces': 1,
          },
          'Remarks': Some('Hey Food was good'),
        }),
      );
    });
    test(
        'When struct "OrderStructList" is decoded then it returns correct value',
        () {
      final input = HexInput(
          '0x080040546869732069732061206e6f74652030284b697769204a7569636501014448657920466f6f642077617320676f6f640840546869732069732061206e6f746520312042656574726f6f740200');
      final codec = ScaleCodec(registry);
      final result = codec.decode('OrderStructList', input);
      expect(
          result,
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
          ]));
    });
    test('When struct "JuiceName" is decoded then it returns correct value',
        () {
      final input = HexInput('0x104b69776901');
      final codec = ScaleCodec(registry);
      final result = codec.decode('JuiceName', input);
      expect(
        result,
        equals({
          'name': 'Kiwi',
          'ounces': 1,
        }),
      );
    });
  });
}
