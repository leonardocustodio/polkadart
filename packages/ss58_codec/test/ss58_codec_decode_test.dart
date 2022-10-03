import 'dart:typed_data';

import 'package:convert/convert.dart';
import 'package:ss58_codec/src/exceptions.dart';
import 'package:ss58_codec/ss58_codec.dart';
import 'package:test/test.dart';

void main() {
  group('SS58Codec decode method tests', () {
    test('Should decoded data be equal to expected address', () {
      final Address decodedAddress =
          SS58Codec.decode('5GrwvaEF5zXb26Fz9rcQpDWS57CtERHpNehXCPcNoHGKutQY');

      final int prefix = 42;
      final Uint8List bytes = Uint8List.fromList(hex.decode(
          'd43593c715fdd31c61141abd04a99fd6822c8558854ccde39a5684e7a56da27d'));

      expect(decodedAddress, Address(prefix: prefix, bytes: bytes));
    });
    test(
        'Should decode the given kusama addresses and return prefix equal to kusama prefix',
        () {
      final kusamaPrefix = 2;

      // kusama addresses
      final address1 = 'EXtQYFeY2ivDsfazZvGC9aG87DxnhWH2f9kjUUq2pXTZKF5';
      final address2 = 'H9Sa5qnaiK1oiLDstHRvgH9G6p9sMZ2j82hHMdxaq2QeAKk';
      final address3 = 'FXCgfz7AzQA1fNaUqubSgXxGh77sjWVVkypgueWLmAcwv79';

      expect(SS58Codec.decode(address1).prefix, kusamaPrefix);
      expect(SS58Codec.decode(address2).prefix, kusamaPrefix);
      expect(SS58Codec.decode(address3).prefix, kusamaPrefix);
    });

    test(
        'Should decode the given polkadot address and return prefix equal to polkadot prefix',
        () {
      final polkadotPrefix = 0;

      // polkadot address
      final address = '1zugcag7cJVBtVRnFxv5Qftn7xKAnR6YJ9x4x3XLgGgmNnS';

      expect(SS58Codec.decode(address).prefix, polkadotPrefix);
    });

    test(
        'Should decode the given crust address and return prefix equal to crust prefix',
        () {
      final crustPrefix = 66;

      // polkadot address
      final address = 'cTMxUeDi2HdYVpedqu5AFMtyDcn4djbBfCKiPDds6k1fuFYXL';

      expect(SS58Codec.decode(address).prefix, crustPrefix);
    });
  });
  group('SS58Codec decode method exception testing', () {
    test('should throw BadAddressLengthException when data.lentgh is too small',
        () {
      final expectedErrorMessage = 'Bad Length Address: KS.';
      expect(
        () => SS58Codec.decode('KS'),
        throwsA(
          predicate((exception) =>
              exception is BadAddressLengthException &&
              exception.toString() == expectedErrorMessage),
        ),
      );
    });

    test(
        'should throw InvalidPrefixException when first character of data is greater than 127',
        () {
      // Ex:
      // ```
      // Uint8List test = decode(fRWKeM1KzddF4G6N6isvg6SpFVWJLLXRyYvK1dXLx4xjP);
      // print('$test') => [`129`, 87, 121, 101, 101, 66, 117, 113, 134, 103, 193, 64, 109, 47, 24, 9, 100, 151, 78, 205, 74, 127, 183, 173, 105, 102, 53, 139, 176, 225, 152, 73, 158];
      // ```

      final expectedErrorMessage = 'Invalid SS58 prefix byte.';
      expect(
        () => SS58Codec.decode('fRWKeM1KzddF4G6N6isvg6SpFVWJLLXRyYvK1dXLx4xjP'),
        throwsA(
          predicate((exception) =>
              exception is InvalidPrefixException &&
              exception.toString() == expectedErrorMessage),
        ),
      );
    });

    test(
        'Should throw BadAddressLengthException when decoded address (data.length - offset) != any of [2, 3, 5, 9, 34, 35]',
        () {
      final expectedErrorMessage = 'Bad Length Address.';
      expect(
        () => SS58Codec.decode(
            '3HX1zEyzCbxeXe34JY8SNSVAZ6djFccsV5f67PTied4CcWHspQ'),
        throwsA(
          predicate((exception) =>
              exception is BadAddressLengthException &&
              exception.toString() == expectedErrorMessage),
        ),
      );
      expect(
        () => SS58Codec.decode(
            '4pa95kBXvMqgbpDXkFVHE9JfnNqamjYQYtmSTZGcnBXwvnmosP'),
        throwsA(
          predicate((exception) =>
              exception is BadAddressLengthException &&
              exception.toString() == expectedErrorMessage),
        ),
      );
      expect(
        () => SS58Codec.decode(
            '3rr8zEMfiR2AjQYpVvncJCAcRP7CLzfxMGuUU2Pw2MCotrsQnS'),
        throwsA(
          predicate((exception) =>
              exception is BadAddressLengthException &&
              exception.toString() == expectedErrorMessage),
        ),
      );
      expect(
        () => SS58Codec.decode(
            '4uqUGom7PszVSaZipgHYwVNsMESj1W6cmMZYeXGFeeXGX6VEqm'),
        throwsA(
          predicate((exception) =>
              exception is BadAddressLengthException &&
              exception.toString() == expectedErrorMessage),
        ),
      );
    });

    test(
        'Should throw InvalidCheckSumException when decoded address is Invalid',
        () {
      final expectedErrorMessage = 'Invalid checksum';
      expect(
        () => SS58Codec.decode(
            '3HX1zEyzCbxeXe34JY8SNSVAZ6djFccsV5f67PTied4CcWHs'),
        throwsA(
          predicate((exception) =>
              exception is InvalidCheckSumException &&
              exception.toString() == expectedErrorMessage),
        ),
      );
    });
  });
}
