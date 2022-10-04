import 'dart:typed_data';

import 'package:convert/convert.dart';
import 'package:ss58_codec/src/exceptions.dart';
import 'package:ss58_codec/ss58_codec.dart';
import 'package:test/test.dart';

void main() {
  group('SS58Codec encode method', () {
    test('Should encode when prefix is zero', () {
      final address =
          Address(prefix: 0, bytes: Uint8List.fromList([1, 2, 3, 4]));

      expect(() => SS58Codec.encode(address), returnsNormally);
    });

    test('Should encode when prefix is 64', () {
      final address =
          Address(prefix: 64, bytes: Uint8List.fromList([1, 2, 3, 4]));

      expect(() => SS58Codec.encode(address), returnsNormally);
    });

    test('Should encode when bytes,length is 8', () {
      final address = Address(
          prefix: 0, bytes: Uint8List.fromList([1, 2, 3, 4, 5, 6, 7, 8]));

      expect(() => SS58Codec.encode(address), returnsNormally);
    });

    test('Should encode when bytes,length is 32', () {
      final address = Address(prefix: 0, bytes: Uint8List(32));

      expect(() => SS58Codec.encode(address), returnsNormally);
    });

    test('Should encode and return correct address', () {
      final int prefix = 42;
      final Uint8List bytes = Uint8List.fromList(hex.decode(
          'd43593c715fdd31c61141abd04a99fd6822c8558854ccde39a5684e7a56da27d'));

      final String expectedEncodedAddress =
          '5GrwvaEF5zXb26Fz9rcQpDWS57CtERHpNehXCPcNoHGKutQY';

      final String encodedAddress =
          SS58Codec.encode(Address(prefix: prefix, bytes: bytes));

      expect(encodedAddress, expectedEncodedAddress);
    });
  });
  group('SS58Codec encode exception', () {
    test(
        'Should throw InvalidPrefixException when an address has negative prefix',
        () {
      final addressWithNegativePrefix =
          Address(prefix: -1, bytes: Uint8List.fromList([]));
      final expectedErrorMessage = 'Invalid SS58 prefix byte: -1.';
      expect(
        () => SS58Codec.encode(addressWithNegativePrefix),
        throwsA(
          predicate((exception) =>
              exception is InvalidPrefixException &&
              exception.toString() == expectedErrorMessage),
        ),
      );
    });

    test(
        'Should throw InvalidPrefixException when an address prefix is greater than the limit',
        () {
      final addressWithInvalidPrefix =
          Address(prefix: 16384, bytes: Uint8List.fromList([]));
      final expectedErrorMessage = 'Invalid SS58 prefix byte: 16384.';

      expect(
        () => SS58Codec.encode(addressWithInvalidPrefix),
        throwsA(
          predicate((exception) =>
              exception is InvalidPrefixException &&
              exception.toString() == expectedErrorMessage),
        ),
      );
    });

    test(
        'Should throw BadAddressLengthException when an address bytes length is equal to 3.',
        () {
      final Uint8List bytes = Uint8List(3);
      final int prefix = 0;
      final expectedErrorMessage =
          'Bad Length Address: prefix: 0, bytes: $bytes.';
      expect(
        () => SS58Codec.encode(Address(prefix: prefix, bytes: bytes)),
        throwsA(
          predicate(
            (exception) =>
                exception is BadAddressLengthException &&
                exception.toString() == expectedErrorMessage,
          ),
        ),
      );
    });

    test(
        'Should throw BadAddressLengthException when an address bytes length is equal to 5.',
        () {
      final Uint8List bytes = Uint8List(5);
      final int prefix = 0;
      final expectedErrorMessage =
          'Bad Length Address: prefix: 0, bytes: $bytes.';
      expect(
        () => SS58Codec.encode(Address(prefix: prefix, bytes: bytes)),
        throwsA(
          predicate(
            (exception) =>
                exception is BadAddressLengthException &&
                exception.toString() == expectedErrorMessage,
          ),
        ),
      );
    });

    test(
        'Should throw BadAddressLengthException when an address bytes length is equal to 6.',
        () {
      final Uint8List bytes = Uint8List(6);
      final int prefix = 0;
      final expectedErrorMessage =
          'Bad Length Address: prefix: 0, bytes: $bytes.';
      expect(
        () => SS58Codec.encode(Address(prefix: prefix, bytes: bytes)),
        throwsA(
          predicate(
            (exception) =>
                exception is BadAddressLengthException &&
                exception.toString() == expectedErrorMessage,
          ),
        ),
      );
    });

    test(
        'Should throw BadAddressLengthException when an address bytes length is equal to 7.',
        () {
      final Uint8List bytes = Uint8List(7);
      final int prefix = 0;
      final expectedErrorMessage =
          'Bad Length Address: prefix: 0, bytes: $bytes.';
      expect(
        () => SS58Codec.encode(Address(prefix: prefix, bytes: bytes)),
        throwsA(
          predicate(
            (exception) =>
                exception is BadAddressLengthException &&
                exception.toString() == expectedErrorMessage,
          ),
        ),
      );
    });

    test(
        'Should throw BadAddressLengthException when an address bytes length is equal to 9.',
        () {
      final Uint8List bytes = Uint8List(9);
      final int prefix = 0;

      final expectedErrorMessage =
          'Bad Length Address: prefix: 0, bytes: $bytes.';

      expect(
        () => SS58Codec.encode(Address(prefix: prefix, bytes: bytes)),
        throwsA(
          predicate(
            (exception) =>
                exception is BadAddressLengthException &&
                exception.toString() == expectedErrorMessage,
          ),
        ),
      );
    });

    test(
        'Should throw BadAddressLengthException when an address bytes length is equal to 31.',
        () {
      final Uint8List bytes = Uint8List(31);
      final int prefix = 0;

      final expectedErrorMessage =
          'Bad Length Address: prefix: 0, bytes: $bytes.';

      expect(
        () => SS58Codec.encode(Address(prefix: prefix, bytes: bytes)),
        throwsA(
          predicate(
            (exception) =>
                exception is BadAddressLengthException &&
                exception.toString() == expectedErrorMessage,
          ),
        ),
      );
    });

    test(
        'Should throw BadAddressLengthException when an address bytes length is equal to 35.',
        () {
      final Uint8List bytes = Uint8List(35);
      final int prefix = 0;

      final expectedErrorMessage =
          'Bad Length Address: prefix: 0, bytes: $bytes.';

      expect(
        () => SS58Codec.encode(Address(prefix: prefix, bytes: bytes)),
        throwsA(
          predicate(
            (exception) =>
                exception is BadAddressLengthException &&
                exception.toString() == expectedErrorMessage,
          ),
        ),
      );
    });
  });
}
