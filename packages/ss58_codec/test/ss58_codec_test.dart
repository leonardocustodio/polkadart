import 'package:convert/convert.dart';
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
}

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
