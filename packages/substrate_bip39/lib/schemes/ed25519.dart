import 'dart:typed_data' show Uint8List;
import 'package:pointycastle/digests/blake2b.dart' show Blake2bDigest;
import 'package:polkadart_scale_codec/polkadart_scale_codec.dart'
    show ByteOutput, StrCodec, U8ArrayCodec;
import '../exceptions.dart' show SubstrateBip39Exception;
import '../crypto_scheme.dart' show CryptoScheme;
import '../secret_uri.dart' show DeriveJunction;

class Ed25519 extends CryptoScheme {
  const Ed25519() : super(32);

  /// Derive a child key from a series of given junctions.
  ///
  /// Reference: https://github.com/paritytech/substrate/blob/polkadot-v0.9.43/primitives/core/src/ed25519.rs#L385-L399
  @override
  Future<Uint8List> derive(List<int> seed, Iterable<DeriveJunction> path,
      {Uint8List? output}) {
    output ??= Uint8List.fromList(seed);
    for (final junction in path) {
      if (junction.isSoft) {
        throw SubstrateBip39Exception.invalidPath(
            'Soft key derivation is not supported for ED25519');
      }
      deriveHardJunction(output, junction.junctionId, output: output);
    }
    return Future.value(output);
  }

  /// Derive a single hard junction.
  Uint8List deriveHardJunction(List<int> seed, List<int> junction,
      {Uint8List? output}) {
    final bytes = ByteOutput();
    StrCodec.codec.encodeTo('Ed25519HDKD', bytes);
    U8ArrayCodec(super.seedSize).encodeTo(seed, bytes);
    U8ArrayCodec(junction.length).encodeTo(junction, bytes);
    final digest = Blake2bDigest(digestSize: 32);
    final jose = bytes.toBytes();
    digest.update(jose, 0, jose.length);
    output ??= Uint8List(32);
    digest.doFinal(output, 0);
    return output;
  }
}
