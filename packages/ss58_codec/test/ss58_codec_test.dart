import 'package:convert/convert.dart';
import 'package:ss58_codec/src/exceptions.dart';
import 'dart:typed_data';
import 'dart:math';

import 'package:ss58_codec/ss58_codec.dart';
import 'package:test/test.dart';
import 'test_extension.dart';

void main() {
  test('Custom Address Test', () {
    final Address decodedAddress =
        SS58Codec.decode('5GrwvaEF5zXb26Fz9rcQpDWS57CtERHpNehXCPcNoHGKutQY');

    final expectedAddress = Address(
        prefix: 42,
        bytes: Uint8List.fromList(hex.decode(
            'd43593c715fdd31c61141abd04a99fd6822c8558854ccde39a5684e7a56da27d')));

    // Match whether the 2 addresses are equal or not
    decodedAddress.isEqual(expectedAddress);
  });
  group('address decoding-encoding -> ', () {
    /// kusama
    decodeTest('EXtQYFeY2ivDsfazZvGC9aG87DxnhWH2f9kjUUq2pXTZKF5', 2);
    decodeTest('H9Sa5qnaiK1oiLDstHRvgH9G6p9sMZ2j82hHMdxaq2QeAKk', 2);
    decodeTest('FXCgfz7AzQA1fNaUqubSgXxGh77sjWVVkypgueWLmAcwv79', 2);

    /// polkadot
    decodeTest('1zugcag7cJVBtVRnFxv5Qftn7xKAnR6YJ9x4x3XLgGgmNnS', 0);

    /// robonomics
    decodeTest('4HMMaWUW7McTGrmo9hSe9mkyKHpd9pzKGqkAFrCWnTFdwHpY', 32);

    /// hydradx
    decodeTest('7LKANFqnxGZ5zVyQNsiNZM2n9dSVLNzmkwKoUKR7AALea3vN', 63);

    /// crust
    decodeTest('cTMxUeDi2HdYVpedqu5AFMtyDcn4djbBfCKiPDds6k1fuFYXL', 66);

    /// subspace testnet
    decodeTest('st6v8nztLTbiqY5Hw97L5FWCBmpzMsrAh5qXZ1tJs1epNvoFA', 2254);

    /// basilisk
    decodeTest('bXn5CfJB2qHvqnuMqTpXn6un9Fjch8mwkb9i3JUsGVD4ChLoe', 10041);
  });

  group('bytes encoding-decoding -> ', () {
    encodeBytes(0, Uint8List.fromList([1, 2, 3, 4]));
    encodeBytes(64, Uint8List.fromList([1, 2]));
    encodeBytes(16383, Uint8List.fromList([2]));

    for (var len in [1, 2, 4, 8, 32, 33]) {
      var prefix = randomInt(16384);
      encodeBytes(prefix, Uint8List.fromList(List<int>.filled(len, len)));
    }
  });

  /// [SS58Codec] `decode` method Exception testing
  group('decode: throw exception -> ', () {
    /// `String` address with `length < 3`
    test('data.length < 3 ', () {
      expect(
        () => SS58Codec.decode('KS'),
        throwsA(
          predicate((exception) =>
              exception is BadAddressLengthException &&
              exception.toString() == 'Bad Length Address: KS.'),
        ),
      );
    });

    /// decoded address first byte is greater than 127.
    /// Ex:
    /// ```
    /// Uint8List test = decode(fRWKeM1KzddF4G6N6isvg6SpFVWJLLXRyYvK1dXLx4xjP);
    /// print('$test') => [`129`, 87, 121, 101, 101, 66, 117, 113, 134, 103, 193, 64, 109, 47, 24, 9, 100, 151, 78, 205, 74, 127, 183, 173, 105, 102, 53, 139, 176, 225, 152, 73, 158];
    /// ```
    test('data[0] > 128 ', () {
      expect(
        () => SS58Codec.decode('fRWKeM1KzddF4G6N6isvg6SpFVWJLLXRyYvK1dXLx4xjP'),
        throwsA(
          predicate((exception) =>
              exception is InvalidPrefixException &&
              exception.toString() == 'Invalid SS58 prefix byte.'),
        ),
      );
    });

    /// example of invalid decoded address length
    test('(data.length - offset) != any of [2, 3, 5, 9, 34, 35]', () {
      expect(
        () => SS58Codec.decode(
            '3HX1zEyzCbxeXe34JY8SNSVAZ6djFccsV5f67PTied4CcWHspQ'),
        throwsA(
          predicate((exception) =>
              exception is BadAddressLengthException &&
              exception.toString() == 'Bad Length Address.'),
        ),
      );
      expect(
        () => SS58Codec.decode(
            '4pa95kBXvMqgbpDXkFVHE9JfnNqamjYQYtmSTZGcnBXwvnmosP'),
        throwsA(
          predicate((exception) =>
              exception is BadAddressLengthException &&
              exception.toString() == 'Bad Length Address.'),
        ),
      );
      expect(
        () => SS58Codec.decode(
            '3rr8zEMfiR2AjQYpVvncJCAcRP7CLzfxMGuUU2Pw2MCotrsQnS'),
        throwsA(
          predicate((exception) =>
              exception is BadAddressLengthException &&
              exception.toString() == 'Bad Length Address.'),
        ),
      );
      expect(
        () => SS58Codec.decode(
            '4uqUGom7PszVSaZipgHYwVNsMESj1W6cmMZYeXGFeeXGX6VEqm'),
        throwsA(
          predicate((exception) =>
              exception is BadAddressLengthException &&
              exception.toString() == 'Bad Length Address.'),
        ),
      );
    });

    /// example of invalid decoded address.
    test('invalid check sum exception', () {
      expect(
        () => SS58Codec.decode(
            '3HX1zEyzCbxeXe34JY8SNSVAZ6djFccsV5f67PTied4CcWHs'),
        throwsA(
          predicate((exception) =>
              exception is InvalidCheckSumException &&
              exception.toString() == 'Invalid checksum'),
        ),
      );
    });
  });

  /// [SS58Codec] `encode` method Exception testing
  group('encode: throw exception -> ', () {
    /// [Address] with invalid `prefix`
    test('invalid prefix ', () {
      /// [Address] invalid because of `negative` prefix
      final addressWithNegativePrefix =
          Address(prefix: -1, bytes: Uint8List.fromList([]));
      expect(
        () => SS58Codec.encode(addressWithNegativePrefix),
        throwsA(
          predicate((exception) =>
              exception is InvalidPrefixException &&
              exception.toString() == 'Invalid SS58 prefix byte: -1.'),
        ),
      );

      /// [Address] invalid because of prefix is greater than the limit
      final addressWithInvalidPrefix =
          Address(prefix: 16384, bytes: Uint8List.fromList([]));

      expect(
        () => SS58Codec.encode(addressWithInvalidPrefix),
        throwsA(
          predicate((exception) =>
              exception is InvalidPrefixException &&
              exception.toString() == 'Invalid SS58 prefix byte: 16384.'),
        ),
      );
    });

    /// [Address] with invalid `address.bytes.length`
    test('invalid address length at lengths: [3, 5, 6, 7]', () {
      for (var len in [3, 5, 6, 7]) {
        final invalidAddress = Address(prefix: 0, bytes: Uint8List(len));
        expect(
          () => SS58Codec.encode(invalidAddress),
          throwsA(
            predicate(
              (exception) =>
                  exception is BadAddressLengthException &&
                  exception.toString() ==
                      'Bad Length Address: ${invalidAddress.toString()}.',
            ),
          ),
        );
      }
    });

    /// [Address] with invalid `address.bytes.length`
    test('invalid address length 9-31', () {
      for (var len = 9; len <= 31; len++) {
        final invalidAddress = Address(prefix: 0, bytes: Uint8List(len));
        expect(
          () => SS58Codec.encode(invalidAddress),
          throwsA(
            predicate(
              (exception) =>
                  exception is BadAddressLengthException &&
                  exception.toString() ==
                      'Bad Length Address: ${invalidAddress.toString()}.',
            ),
          ),
        );
      }
    });

    /// [Address] with invalid `address.bytes.length`
    test('invalid address length at length: 34+', () {
      for (var len in [34, 35]) {
        final invalidAddress = Address(prefix: 0, bytes: Uint8List(len));
        expect(
          () => SS58Codec.encode(invalidAddress),
          throwsA(
            predicate(
              (exception) =>
                  exception is BadAddressLengthException &&
                  exception.toString() ==
                      'Bad Length Address: ${invalidAddress.toString()}.',
            ),
          ),
        );
      }
    });
  });
}

/// Returns one random `int` less than [max].
int randomInt(int max) {
  return Random.secure().nextInt(max);
}

///
/// decode the address string and then re-decode that encoded object to match with original bytes passed
void decodeTest(String address, int prefix) {
  test('$address ', () {
    // decoding the address string
    final Address decodedAddress = SS58Codec.decode(address);
    // match here
    decodedAddress.prefix.isEqual(prefix);

    // encoding back the decoded address
    final encodedAddress = SS58Codec.encode(decodedAddress);
    // match here
    encodedAddress.isEqual(address);
  });
}

///
/// encode the bytes and then re-decode that encoded object to match with original bytes passed
void encodeBytes(int prefix, Uint8List bytes) {
  test('$bytes', () {
    var originalAddress = Address(prefix: prefix, bytes: bytes);

    // Encode Address bytes
    final String encodedAddress = SS58Codec.encode(originalAddress);

    // Decode the above encoded Address bytes back
    final Address decodedAddress = SS58Codec.decode(encodedAddress);

    // match here
    decodedAddress.isEqual(originalAddress);
  });
}
