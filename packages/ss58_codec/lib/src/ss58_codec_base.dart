import 'dart:convert';
import 'dart:typed_data';

import 'package:base_x/base_x.dart';
import 'package:cryptography/dart.dart';
import 'package:ss58_codec/src/address.dart';

// Hash Prefix to be added before hashing data
final List<int> _hashPrefix = utf8.encode('SS58PRE');

// base58 hasher
final _base58 =
    BaseXCodec('123456789ABCDEFGHJKLMNPQRSTUVWXYZabcdefghijkmnopqrstuvwxyz');

class SS58Codec {
  ///
  /// Decode SS58 address string.
  ///
  /// This function follows [Ss58Codec trait](https://github.com/paritytech/substrate/blob/ded44948e2d5a398abcb4e342b0513cb690961bb/primitives/core/src/crypto.rs#L245)
  static Address decode(String s) {
    var data = _base58.decode(s);
    if (data.length < 3) {
      throw invalidAddress(s);
    }
    var data0 = data[0];
    late int offset;
    late int prefix;
    if (data0 < 64) {
      prefix = data0;
      offset = 1;
    } else if (data0 < 128) {
      var b1 = data[1];
      var lower = ((data0 << 2) | (b1 >> 6)) & BigInt.from(255).toInt();
      var upper = b1 & BigInt.from(63).toInt();
      prefix = lower | (upper << 8);
      offset = 2;
    } else {
      throw invalidAddress(s);
    }

    late int hashLen;
    switch (data.length - offset) {
      case 34:
      case 35:
        hashLen = 2;
        break;
      case 9:
      case 5:
      case 3:
      case 2:
        hashLen = 1;
        break;
      default:
        throw invalidAddress(s);
    }

    final List<int> hashedData = computeHash(data, hashLen);
    for (var i = 0; i < hashLen; i++) {
      if (hashedData[i] != data[data.length - hashLen + i]) {
        throw invalidAddress(s);
      }
    }

    return Address(
      prefix: prefix,
      bytes: data.sublist(offset, data.length - hashLen),
    );
  }

  ///
  /// Encode SS58 address into canonical string format
  static String encode(Address address) {
    final int prefix = address.prefix;
    assert(prefix >= 0 && prefix < 16384, 'invalid prefix');
    final int len = address.bytes.length;
    late int hashLen;
    switch (len) {
      case 1:
      case 2:
      case 4:
      case 8:
        hashLen = 1;
        break;
      case 32:
      case 33:
        hashLen = 2;
        break;
      default:
        assert(false, 'invalid address length');
    }
    late Uint8List data;
    late int offset;
    if (prefix < 64) {
      data = Uint8List(1 + hashLen + len);
      data[0] = prefix;
      offset = 1;
    } else {
      //
      // 0b1111_1100  ->  BigInt(252)
      // 0b01000000   ->  BigInt(64)
      // 0b11         ->  BigInt(3)
      //
      data = Uint8List(2 + hashLen + len);
      data[0] =
          ((prefix & BigInt.from(252).toInt()) >> 2) | BigInt.from(64).toInt();
      data[1] = (prefix >> 8) | ((prefix & BigInt.from(3).toInt()) << 6);
      offset = 2;
    }

    data.setAll(offset, address.bytes);
    final List<int> hashedData = computeHash(data, hashLen);
    for (var i = 0; i < hashLen; i++) {
      data[offset + len + i] = hashedData[i];
    }
    return _base58.encode(data);
  }
}

List<int> computeHash(Uint8List data, int length) {
  final algorithm = DartBlake2b();

  // sinker to which all the hashes will be appended and then (hashed or digested) at last step;
  final sink = algorithm.newHashSink();

  // add hash prefix
  sink.add(_hashPrefix);
  // add sliced data
  sink.add(data.sublist(0, data.length - length).toList());

  // close the sink to be able to hash/digest
  sink.close();

  return sink.hashSync().bytes;
}

Exception invalidAddress(String s) {
  return Exception('Invalid ss58 address: $s');
}
