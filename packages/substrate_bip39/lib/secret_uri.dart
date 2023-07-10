import 'dart:typed_data' show Uint8List;
import 'package:collection/collection.dart'
    show ListEquality, DeepCollectionEquality;
import 'package:polkadart_scale_codec/polkadart_scale_codec.dart'
    show U64Codec, StrCodec;
import 'package:pointycastle/digests/blake2b.dart' show Blake2bDigest;

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

    final n = BigInt.tryParse(code);
    final List<int> bytes;
    if (n != null) {
      // number
      bytes = U64Codec.codec.encode(n);
    } else {
      // something else
      bytes = StrCodec.codec.encode(code);
    }

    return DeriveJunction.fromBytes(hard, Uint8List.fromList(bytes));
  }

  bool get isSoft => !hardenedDerivation;
  bool get isHard => hardenedDerivation;

  @override
  bool operator ==(Object other) =>
      other is DeriveJunction &&
      other.hardenedDerivation == hardenedDerivation &&
      eq(other.junctionId, junctionId);

  @override
  int get hashCode => Object.hash(hardenedDerivation, junctionId);
}

class SecretUri {
  final String phrase;
  final String? password;
  final List<DeriveJunction> junctions;

  /// The root phrase for our publicly known keys.
  static const devPhrase =
      'bottom drive obey lake curtain smoke basket hold race lonely fit walk';

  static RegExp secretPhraseRegex = RegExp(
      r'^(?<phrase>[\d\w ]+)?(?<path>(//?[^/]+)*)(///(?<password>.*))?$');
  static RegExp junctionRegex = RegExp(r'/(/?[^/]+)');

  SecretUri(this.phrase, this.password, this.junctions);

  factory SecretUri.fromStr(String str) {
    final match = secretPhraseRegex.firstMatch(str);
    if (match == null) {
      throw Exception('Invalid format'); // TODO: Create custom exception
    }

    final junctions =
        junctionRegex.allMatches(match.namedGroup('path')!).map((junction) {
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
