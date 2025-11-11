// Copyright (c) 2023, Sudipto Chandra
// All rights reserved. Check LICENSE file for details.
// This code is part of hashlib 1.12.0
// https://pub.dev/packages/hashlib

part of substrate_hashers;

/// An instance of [XXHash64] with seed = 0
const XXHash64 xxh64 = XXHash64(0);

/// XXHash64 is a fast and efficient non-cryptographic hash function for
/// 64-bit platforms. It is designed for producing a quick and reliable hash
/// value for a given data, which can be used for many applications, such as
/// checksum, data validation, etc. In addition, it has a good distribution of
/// hash values, which helps to reduce [collisions][wiki].
///
/// This implementation was derived from https://github.com/Cyan4973/xxHash
///
/// [wiki]: https://github.com/Cyan4973/xxHash/wiki/Collision-ratio-comparison
///
/// **WARNING: It should not be used for cryptographic purposes.**
class XXHash64 extends BlockHashBase {
  final int seed;

  /// Creates a new instance of [XXHash64].
  ///
  /// Parameters:
  /// - [seed] is an optional 64-bit integer. Default: 0
  const XXHash64([this.seed = 0]);

  @override
  final String name = 'XXH64';

  @override
  XXHash64Sink createSink() => XXHash64Sink(seed);

  /// Get and instance of [XXHash64] with an specific seed
  XXHash64 withSeed(int seed) => XXHash64(seed);
}

/// Gets the 64-bit xxHash value of a String.
///
/// Parameters:
/// - [input] is the string to hash.
/// - The [encoding] is the encoding to use. Default is `input.codeUnits`.
int xxh64code(String input, [Encoding? encoding]) {
  return xxh64.string(input, encoding).number();
}

/// Gets the 64-bit xxHash hash of a String in hexadecimal.
///
/// Parameters:
/// - [input] is the string to hash.
/// - The [encoding] is the encoding to use. Default is `input.codeUnits`
String xxh64sum(String input, [Encoding? encoding]) {
  return xxh64.string(input, encoding).hex();
}

/// Extension to [String] to generate [xxh64] code.
extension XXHash64StringExtension on String {
  /// Gets the 64-bit xxHash value of a String.
  ///.
  /// Parameters:
  /// - If no [encoding] is defined, the `codeUnits` is used to get the bytes.
  int xxh64code([Encoding? encoding]) {
    return xxh64.string(this, encoding).number();
  }

  /// Gets the 64-bit xxHash hash of a String in hexadecimal.
  ///
  /// Parameters:
  /// - If no [encoding] is defined, the `codeUnits` is used to get the bytes.
  String xxh64sum([Encoding? encoding]) {
    return xxh64.string(this, encoding).hex();
  }
}
