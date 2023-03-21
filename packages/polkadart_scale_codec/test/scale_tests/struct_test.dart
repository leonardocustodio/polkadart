import 'package:polkadart_scale_codec/polkadart_scale_codec.dart';
import 'package:test/test.dart';

void main() {
  // Test with Registry
  group('CompositeCodec Encode Test:', () {
    final registry = Registry()
      ..registerCustomCodec(<String, dynamic>{
        'OrderCompositeList': 'Vec<OrderComposite>',
        'OrderComposite': {
          'index': 'UnsignedInt8',
          'note': 'Str',
          'Juice': 'JuiceName',
          'Remarks': 'Option<Str>',
        },
        'JuiceName': {
          'name': 'Str',
          'ounces': 'UnsignedInt8',
        },
        'UnsignedInt8': 'U8',
      });
    test(
        'When struct "OrderComposite" is encoded then it returns correct hex 0x0838546869732069732061206e6f7465104b69776901014448657920466f6f642077617320676f6f64',
        () {
      final output = HexOutput();
      final codec = ScaleCodec(registry);
      codec.encodeTo(
        'OrderComposite',
        {
          'index': 8,
          'note': 'This is a note',
          'Juice': {
            'name': 'Kiwi',
            'ounces': 1,
          },
          'Remarks': Option.some('Hey Food was good'),
        },
        output,
      );
      expect(
        output.toString(),
        '0x0838546869732069732061206e6f7465104b69776901014448657920466f6f642077617320676f6f64',
      );
    });
    test(
        'When struct "OrderCompositeList" is encoded then it returns correct hex',
        () {
      final output = HexOutput();
      final codec = ScaleCodec(registry);
      codec.encodeTo(
        'OrderCompositeList',
        [
          {
            'index': 0,
            'note': 'This is a note 0',
            'Juice': {
              'name': 'Kiwi Juice',
              'ounces': 1,
            },
            'Remarks': Option.some('Hey Food was good'),
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
  group('CompositeCodec Decode Test:', () {
    final registry = Registry()
      ..registerCustomCodec(<String, dynamic>{
        'OrderCompositeList': 'Vec<OrderComposite>',
        'OrderComposite': {
          'index': 'UnsignedInt8',
          'note': 'Str',
          'Juice': 'JuiceName',
          'Remarks': 'Option<Str>',
        },
        'JuiceName': {
          'name': 'Str',
          'ounces': 'UnsignedInt8',
        },
        'UnsignedInt8': 'U8',
      });
    test(
        'When struct "OrderComposite" is decoded then it returns correct value',
        () {
      final input = Input.fromHex(
          '0x0838546869732069732061206e6f7465104b69776901014448657920466f6f642077617320676f6f64');
      final codec = ScaleCodec(registry);

      final result = codec.decode('OrderComposite', input);

      expect(result, {
        'index': 8,
        'note': 'This is a note',
        'Juice': {
          'name': 'Kiwi',
          'ounces': 1,
        },
        'Remarks': Option.some('Hey Food was good'),
      });
      expect(input.remainingLength, 0);
    });
    test(
        'When struct "OrderCompositeList" is decoded then it returns correct value',
        () {
      final input = Input.fromHex(
          '0x080040546869732069732061206e6f74652030284b697769204a7569636501014448657920466f6f642077617320676f6f640840546869732069732061206e6f746520312042656574726f6f740200');
      final codec = ScaleCodec(registry);
      final result = codec.decode('OrderCompositeList', input);
      expect(result, [
        {
          'index': 0,
          'note': 'This is a note 0',
          'Juice': {
            'name': 'Kiwi Juice',
            'ounces': 1,
          },
          'Remarks': Option.some('Hey Food was good'),
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
      expect(input.remainingLength, 0);
    });
    test('When struct "JuiceName" is decoded then it returns correct value',
        () {
      final input = Input.fromHex('0x104b69776901');
      final codec = ScaleCodec(registry);
      final result = codec.decode('JuiceName', input);
      expect(
        result,
        {
          'name': 'Kiwi',
          'ounces': 1,
        },
      );
      expect(input.remainingLength, 0);
    });
  });
}
