import 'dart:typed_data' show Uint8List;
import 'package:pointycastle/digests/blake2b.dart' show Blake2bDigest;
import 'package:polkadart_scale_codec/polkadart_scale_codec.dart'
    show ByteOutput, StrCodec, U8ArrayCodec;
import '../exceptions.dart' show SubstrateBip39Exception;
import '../crypto_scheme.dart' show CryptoScheme;
import '../secret_uri.dart' show DeriveJunction;

class Secp256k1 extends CryptoScheme {
  const Secp256k1() : super(32);

  /// Derive a child key from a series of given junctions.
  @override
  Future<Uint8List> derive(List<int> seed, Iterable<DeriveJunction> path, {Uint8List? output}) {
    output ??= Uint8List.fromList(seed);
    for (final junction in path) {
      if (junction.isSoft) {
        throw SubstrateBip39Exception.invalidPath(
          'Soft key derivation is not supported for ECDSA/Secp256k1',
        );
      }
      deriveHardJunction(output, junction.junctionId, output: output);
    }
    return Future.value(output);
  }

  /// Derive a single hard junction.
  Uint8List deriveHardJunction(List<int> seed, List<int> junction, {Uint8List? output}) {
    final bytes = ByteOutput();
    StrCodec.codec.encodeTo('Secp256k1HDKD', bytes);
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
