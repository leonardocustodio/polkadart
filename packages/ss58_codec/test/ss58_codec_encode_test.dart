import 'dart:math';
import 'dart:typed_data';

import 'package:ss58_codec/src/exceptions.dart';
import 'package:ss58_codec/ss58_codec.dart';
import 'package:test/test.dart';
import 'test_extension.dart';

void main() {
  group('SS58Codec encode method', () {
    test('Should encode all addresses sucessfully', () {
      final address1 =
          Address(prefix: 0, bytes: Uint8List.fromList([1, 2, 3, 4]));
      final address2 = Address(prefix: 64, bytes: Uint8List.fromList([1, 2]));
      final address3 = Address(prefix: 16383, bytes: Uint8List.fromList([2]));

      expect(() => SS58Codec.encode(address1), returnsNormally);
      expect(() => SS58Codec.encode(address2), returnsNormally);
      expect(() => SS58Codec.encode(address3), returnsNormally);
    });

    test(
        'Should encode the address and then re-decode that encoded object to match with original bytes passed',
        () {
      final originalAddress = Address(
          prefix: 64, bytes: Uint8List.fromList(List<int>.filled(32, 32)));

      final String encodedAddress = SS58Codec.encode(originalAddress);

      final Address decodedAddress = SS58Codec.decode(encodedAddress);

      decodedAddress.isEqual(originalAddress);
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
        'Should throw BadAddressLengthException when an address bytes length is equal to 3, 5, 6 or 7.',
        () {
      for (var len in [3, 5, 6, 7]) {
        final bytes = Uint8List(len);
        final invalidAddress = Address(prefix: 0, bytes: bytes);
        final expectedErrorMessage =
            'Bad Length Address: prefix: 0, bytes: $bytes.';
        expect(
          () => SS58Codec.encode(invalidAddress),
          throwsA(
            predicate(
              (exception) =>
                  exception is BadAddressLengthException &&
                  exception.toString() == expectedErrorMessage,
            ),
          ),
        );
      }
    });

    test(
        'Should throw BadAddressLengthException when an address bytes length is equal to [9-31]',
        () {
      for (var len = 9; len <= 31; len++) {
        final bytes = Uint8List(len);
        final invalidAddress = Address(prefix: 0, bytes: bytes);
        final expectedErrorMessage =
            'Bad Length Address: prefix: 0, bytes: $bytes.';

        expect(
          () => SS58Codec.encode(invalidAddress),
          throwsA(
            predicate(
              (exception) =>
                  exception is BadAddressLengthException &&
                  exception.toString() == expectedErrorMessage,
            ),
          ),
        );
      }
    });

    test(
        'Should throw BadAddressLengthException when an address bytes length is equal or greater than 34',
        () {
      for (var len in [34, 35]) {
        final bytes = Uint8List(len);
        final invalidAddress = Address(prefix: 0, bytes: bytes);
        final expectedErrorMessage =
            'Bad Length Address: prefix: 0, bytes: $bytes.';

        expect(
          () => SS58Codec.encode(invalidAddress),
          throwsA(
            predicate(
              (exception) =>
                  exception is BadAddressLengthException &&
                  exception.toString() == expectedErrorMessage,
            ),
          ),
        );
      }
    });
  });
}

int randomInt(int max) {
  return Random.secure().nextInt(max);
}
