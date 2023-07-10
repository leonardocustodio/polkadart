import 'dart:typed_data' show Uint8List;
import './secret_uri.dart' show DeriveJunction;
import 'package:pointycastle/digests/blake2b.dart' show Blake2bDigest;
import 'package:polkadart_scale_codec/polkadart_scale_codec.dart'
    show ByteOutput, StrCodec, U8ArrayCodec;

class Ed25519Pair {
  /// Derive a child key from a series of given junctions.
  ///
  /// Reference: https://github.com/paritytech/substrate/blob/polkadot-v0.9.43/primitives/core/src/ed25519.rs#L385-L399
  static Uint8List derive(List<int> seed, Iterable<DeriveJunction> path,
      {Uint8List? output}) {
    output ??= Uint8List.fromList(seed);
    for (final junction in path) {
      if (junction.isSoft) {
        throw SoftKeyInPathException(
            'Soft key derivation is not supported for ED25519');
      }
      deriveHardJunction(output, junction.junctionId, output: output);
    }
    return output;
  }

  /// Derive a single hard junction.
  static Uint8List deriveHardJunction(List<int> seed, List<int> junction,
      {Uint8List? output}) {
    final bytes = ByteOutput();
    StrCodec.codec.encodeTo("Ed25519HDKD", bytes);
    U8ArrayCodec(32).encodeTo(seed, bytes);
    U8ArrayCodec(DeriveJunction.junctionIdLength).encodeTo(junction, bytes);
    final digest = Blake2bDigest(digestSize: 32);
    final jose = bytes.toBytes();
    digest.update(jose, 0, jose.length);
    output ??= Uint8List(32);
    digest.doFinal(output, 0);
    return output;
  }
}

class SoftKeyInPathException implements Exception {
  String cause;
  SoftKeyInPathException(this.cause);
}
