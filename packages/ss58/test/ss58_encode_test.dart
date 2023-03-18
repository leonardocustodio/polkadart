import 'dart:typed_data' show Uint8List;

import 'package:convert/convert.dart' show hex;
import 'package:ss58/src/exceptions.dart'
    show InvalidPrefixException, BadAddressLengthException;
import 'package:ss58/src/address.dart' show Address;
import 'package:test/test.dart';

void main() {
  group('SS58Codec encode method', () {
    test('Should encode when prefix is zero', () {
      final address =
          Address(prefix: 0, pubkey: Uint8List.fromList([1, 2, 3, 4]));

      expect(() => address.encode(), returnsNormally);
    });

    test('Should encode when prefix is 64', () {
      final address =
          Address(prefix: 64, pubkey: Uint8List.fromList([1, 2, 3, 4]));

      expect(() => address.encode(), returnsNormally);
    });

    test('Should encode when bytes,length is 8', () {
      final address = Address(
          prefix: 0, pubkey: Uint8List.fromList([1, 2, 3, 4, 5, 6, 7, 8]));

      expect(() => address.encode(), returnsNormally);
    });

    test('Should encode when bytes,length is 32', () {
      final address = Address(prefix: 0, pubkey: Uint8List(32));

      expect(() => address.encode(), returnsNormally);
    });

    test('Should encode and return correct address', () {
      final int prefix = 42;
      final Uint8List bytes = Uint8List.fromList(hex.decode(
          'd43593c715fdd31c61141abd04a99fd6822c8558854ccde39a5684e7a56da27d'));

      final String expectedEncodedAddress =
          '5GrwvaEF5zXb26Fz9rcQpDWS57CtERHpNehXCPcNoHGKutQY';

      final String encodedAddress =
          Address(prefix: prefix, pubkey: bytes).encode();

      expect(encodedAddress, expectedEncodedAddress);
    });
  });
  group('SS58Codec encode exception', () {
    test(
        'Should throw InvalidPrefixException when an address has negative prefix',
        () {
      final addressWithNegativePrefix =
          Address(prefix: -1, pubkey: Uint8List.fromList([]));
      final expectedErrorMessage = 'Invalid SS58 prefix: -1.';
      expect(
        () => addressWithNegativePrefix.encode(),
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
          Address(prefix: 16384, pubkey: Uint8List.fromList([]));
      final expectedErrorMessage = 'Invalid SS58 prefix: 16384.';

      expect(
        () => addressWithInvalidPrefix.encode(),
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
          'Bad Length Address: Address(prefix: $prefix, bytes: 0x${hex.encode(bytes)}).';
      expect(
        () => Address(prefix: prefix, pubkey: bytes).encode(),
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
          'Bad Length Address: Address(prefix: $prefix, bytes: 0x${hex.encode(bytes)}).';
      expect(
        () => Address(prefix: prefix, pubkey: bytes).encode(),
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
          'Bad Length Address: Address(prefix: $prefix, bytes: 0x${hex.encode(bytes)}).';
      expect(
        () => Address(prefix: prefix, pubkey: bytes).encode(),
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
          'Bad Length Address: Address(prefix: $prefix, bytes: 0x${hex.encode(bytes)}).';
      expect(
        () => Address(prefix: prefix, pubkey: bytes).encode(),
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
          'Bad Length Address: Address(prefix: $prefix, bytes: 0x${hex.encode(bytes)}).';

      expect(
        () => Address(prefix: prefix, pubkey: bytes).encode(),
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
          'Bad Length Address: Address(prefix: $prefix, bytes: 0x${hex.encode(bytes)}).';

      expect(
        () => Address(prefix: prefix, pubkey: bytes).encode(),
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
          'Bad Length Address: Address(prefix: $prefix, bytes: 0x${hex.encode(bytes)}).';

      expect(
        () => Address(prefix: prefix, pubkey: bytes).encode(),
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
