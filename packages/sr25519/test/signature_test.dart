import 'package:sr25519/sr25519.dart';
import 'package:test/test.dart';
import 'package:merlin/merlin.dart' as merlin;

void main() {
  test('Test Sign and Verify', () {
    final merlin.Transcript transcript = merlin.Transcript('hello');
    final KeyPair keypair = KeyPair.generateKeypair();

    final (private, public) = (keypair.secretKey, keypair.publicKey);
    late Signature signature;

    expect(() => signature = private.sign(transcript), returnsNormally);

    final merlin.Transcript transcript2 = merlin.Transcript('hello');

    late bool verified;

    expect(() => (verified, _) = public.verify(signature, transcript2),
        returnsNormally);
    expect(verified, true);
  });
}
