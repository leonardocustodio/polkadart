import 'dart:convert';
import 'dart:typed_data';

import 'package:base_x/base_x.dart';
import 'package:cryptography/dart.dart';
import 'package:ss58_codec/src/address.dart';
import 'package:ss58_codec/src/exceptions.dart';

/// [Private]
///
/// Hash Prefix to be added before hashing data.
final List<int> _hashPrefix = utf8.encode('SS58PRE');

/// [Private]
///
/// Fast base encoding / decoding of any given alphabet using bitcoin style leading zero compression.
final _base58 =
    BaseXCodec('123456789ABCDEFGHJKLMNPQRSTUVWXYZabcdefghijkmnopqrstuvwxyz');

/// Key that can be encoded to/from SS58.
///
/// For more information see [Substrate (ss58)](https://docs.substrate.io/v3/advanced/ss58/)
class SS58Codec {
  ///
  /// Decode SS58 address string.
  ///
  /// This function follows [Ss58Codec trait](https://github.com/paritytech/substrate/blob/ded44948e2d5a398abcb4e342b0513cb690961bb/primitives/core/src/crypto.rs#L245)
  ///
  /// ```
  /// [Exceptions]
  /// throw InvalidPrefixException:    when (first byte of decoded address > 127)
  /// throw BadAddressLengthException: when (address.length < 3)
  /// throw InvalidCheckSumException: when hashed data is invalid
  /// ```
  static Address decode(String address) {
    var data = _base58.decode(address);
    if (data.length < 3) {
      throw BadAddressLengthException(address);
    }
    late int offset;
    late int prefix;
    if (data[0] < 64) {
      prefix = data[0];
      offset = 1;
    } else if (data[0] < 128) {
      // weird bit manipulation owing to the combination of LE encoding and missing two
      // bits from the left.
      // d[0] d[1] are: 01aaaaaa bbcccccc
      // they make the LE-encoded 16-bit value: aaaaaabb 00cccccc
      // so the lower byte is formed of aaaaaabb and the higher byte is 00cccccc
      var lower = ((data[0] << 2) | (data[1] >> 6));
      var upper = data[1] & BigInt.from(63).toInt();
      prefix = (lower & BigInt.from(255).toInt()) | (upper << 8);
      offset = 2;
    } else {
      throw InvalidPrefixException();
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
        throw BadAddressLengthException();
    }

    final List<int> hashedData = computeHash(data, hashLen);
    for (var i = 0; i < hashLen; i++) {
      if (hashedData[i] != data[data.length - hashLen + i]) {
        throw InvalidCheckSumException();
      }
    }

    return Address(
      prefix: prefix,
      bytes: data.sublist(offset, data.length - hashLen),
    );
  }

  ///
  /// Encode SS58 address into canonical string format.
  ///
  /// ```
  /// [Exceptions]
  /// throw InvalidPrefixException:    when (prefix < 0 || prefix >= 16384)
  /// throw BadAddressLengthException: when (address.bytes are of improper length)
  /// ```
  static String encode(Address address) {
    final int prefix = address.prefix;
    if (prefix < 0 || prefix > 16383) {
      throw InvalidPrefixException(prefix);
    }
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
        throw BadAddressLengthException(address.toString());
    }
    late Uint8List data;
    late int offset;
    if (prefix < 64) {
      data = Uint8List(1 + hashLen + len);
      data[0] = prefix;
      offset = 1;
    } else {
      // 0b1111_1100  ->  BigInt(252)
      // 0b01000000   ->  BigInt(64)
      // 0b11         ->  BigInt(3)
      data = Uint8List(2 + hashLen + len);

      // upper six bits of the lower byte(!)
      data[0] =
          ((prefix & BigInt.from(252).toInt()) >> 2) | BigInt.from(64).toInt();

      // lower two bits of the lower byte in the high pos,
      // lower bits of the upper byte in the low pos
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

/// `computeHash` uses `Blake2b` for hashing.
///
/// BLAKE2B ([RFC 7693](https://tools.ietf.org/html/rfc7693)) [HashAlgorithm].
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
