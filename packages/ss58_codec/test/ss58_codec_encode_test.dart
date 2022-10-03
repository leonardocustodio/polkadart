import 'dart:typed_data';

import 'package:ss58_codec/src/exceptions.dart';
import 'package:ss58_codec/ss58_codec.dart';
import 'package:test/test.dart';

void main() {
  group('SS58Codec encode method exception testing', () {
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
