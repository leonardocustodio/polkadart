import 'dart:typed_data' show Uint8List;
import 'package:collection/collection.dart'
    show ListEquality, DeepCollectionEquality;
import 'package:polkadart_scale_codec/polkadart_scale_codec.dart'
    show U64Codec, StrCodec;
import 'package:pointycastle/digests/blake2b.dart' show Blake2bDigest;
import './exceptions.dart' show SubstrateBip39Exception;

Function eq = const ListEquality().equals;
Function deepEq = const DeepCollectionEquality().equals;

/// A since derivation junction description. It is the single parameter used when creating
/// a new secret key from an existing secret key and, in the case of `SoftRaw` and `SoftIndex`
/// a new public key from an existing public key.
class DeriveJunction {
  /// false -> Soft (vanilla) derivation. Public keys have a correspondent derivation.
  /// true  -> Hard ("hardened") derivation. Public keys do not have a correspondent derivation.
  final bool hardenedDerivation;

  /// inner junction id.
  final List<int> junctionId;

  /// The length of the junction identifier. Note that this is also referred to as the
  /// `CHAIN_CODE_LENGTH` in the context of Schnorrkel.
  static const junctionIdLength = 32;

  const DeriveJunction(this.hardenedDerivation, this.junctionId)
      : assert(junctionId.length == junctionIdLength);

  /// Create a new DeriveJunction from a given byte encoded value.
  factory DeriveJunction.fromBytes(bool hard, Uint8List junctionId) {
    final bytes = Uint8List(junctionIdLength);
    if (junctionId.length > junctionIdLength) {
      final digest = Blake2bDigest(digestSize: 32);
      digest.update(junctionId, 0, junctionId.length);
      digest.doFinal(bytes, 0);
    } else {
      bytes.setAll(0, junctionId);
    }
    return DeriveJunction(hard, bytes);
  }

  factory DeriveJunction.fromStr(String str) {
    final bool hard;
    final String code;
    if (str.startsWith('/')) {
      hard = true;
      code = str.substring(1);
    } else {
      hard = false;
      code = str;
    }

    final n = BigInt.tryParse(code, radix: 10);
    final Uint8List bytes;
    if (n != null &&
        n >= BigInt.zero &&
        n < BigInt.parse('18446744073709551616')) {
      // number
      bytes = U64Codec.codec.encode(n);
    } else {
      // something else
      bytes = StrCodec.codec.encode(code);
    }

    return DeriveJunction.fromBytes(hard, bytes);
  }

  /// Return `true` if the junction is soft.
  bool get isSoft => !hardenedDerivation;

  /// Return `true` if the junction is hard.
  bool get isHard => hardenedDerivation;

  @override
  bool operator ==(Object other) =>
      other is DeriveJunction &&
      other.hardenedDerivation == hardenedDerivation &&
      eq(other.junctionId, junctionId);

  @override
  int get hashCode => Object.hash(hardenedDerivation, junctionId);
}

/// A secret uri (`SURI`) that can be used to generate a key pair.
///
/// The `SURI` can be parsed from a string. The string is interpreted in the following way:
///
/// - If `string` is a possibly `0x` prefixed 64-digit hex string, then it will be interpreted
/// directly as a `MiniSecretKey` (aka "seed" in `subkey`).
/// - If `string` is a valid BIP-39 key phrase of 12, 15, 18, 21 or 24 words, then the key will
/// be derived from it. In this case:
///   - the phrase may be followed by one or more items delimited by `/` characters.
///   - the path may be followed by `///`, in which case everything after the `///` is treated
/// as a password.
/// - If `string` begins with a `/` character it is prefixed with the Substrate public `DEV_PHRASE`
///   and interpreted as above.
///
/// In this case they are interpreted as HDKD junctions; purely numeric items are interpreted as
/// integers, non-numeric items as strings. Junctions prefixed with `/` are interpreted as soft
/// junctions, and with `//` as hard junctions.
///
/// There is no correspondence mapping between `SURI` strings and the keys they represent.
/// Two different non-identical strings can actually lead to the same secret being derived.
/// Notably, integer junction indices may be legally prefixed with arbitrary number of zeros.
/// Similarly an empty password (ending the `SURI` with `///`) is perfectly valid and will
/// generally be equivalent to no password at all.
///
class SecretUri {
  /// The phrase to derive the private key.
  ///
  /// This can either be a 64-bit hex string or a BIP-39 key phrase.
  final String phrase;

  /// Optional password as given as part of the uri.
  final String? password;

  /// The junctions as part of the uri.
  final List<DeriveJunction> junctions;

  /// The root phrase for our publicly known keys.
  static const devPhrase =
      'bottom drive obey lake curtain smoke basket hold race lonely fit walk';

  static final RegExp _secretPhraseRegex = RegExp(
      r'^(?<phrase>[\d\w ]+)?(?<path>(//?[^/]+)*)(///(?<password>.*))?$');
  static final RegExp _junctionRegex = RegExp(r'/(/?[^/]+)');

  SecretUri(this.phrase, this.password, this.junctions);

  factory SecretUri.fromStr(String str) {
    final matches = _secretPhraseRegex.allMatches(str);
    if (matches.length != 1) {
      throw SubstrateBip39Exception.invalidFormat();
    }
    final match = matches.first;

    final junctions =
        _junctionRegex.allMatches(match.namedGroup('path')!).map((junction) {
      return DeriveJunction.fromStr(junction.group(1)!);
    }).toList();

    final phrase = match.namedGroup('phrase') ?? devPhrase;
    final password = match.namedGroup('password');

    return SecretUri(phrase, password, junctions);
  }

  @override
  bool operator ==(Object other) =>
      other is SecretUri &&
      other.phrase == phrase &&
      other.password == password &&
      deepEq(other.junctions, junctions);

  @override
  int get hashCode => Object.hash(phrase, password, junctions);
}
