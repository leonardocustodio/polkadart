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

  test('Test Sign and Verify Keypair', () {
    final merlin.Transcript transcript = merlin.Transcript('hello');
    final KeyPair keypair = KeyPair.generateKeypair();
    final (private, public) = (keypair.secretKey, keypair.publicKey);

    final KeyPair kp = KeyPair.from(public, private);

    late Signature signature;
    expect(() => signature = kp.sign(transcript), returnsNormally);

    final merlin.Transcript transcript2 = merlin.Transcript('hello');

    late bool verified;
    expect(() => (verified, _) = public.verify(signature, transcript2),
        returnsNormally);
    expect(verified, true);
  });

  test('Test Verify', () {
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

    final merlin.Transcript transcript3 = merlin.Transcript('hello');
    late bool verified2;
    expect(() => (verified2, _) = public.verify(signature, transcript3),
        returnsNormally);
    expect(verified2, true);
  });


  test('Test Verify Keypair', () {
    final merlin.Transcript transcript = merlin.Transcript('hello');
    final KeyPair keypair = KeyPair.generateKeypair();
    final (private, public) = (keypair.secretKey, keypair.publicKey);

    final KeyPair kp = KeyPair.from(public, private);
    late Signature signature;
    expect(() => signature = kp.sign(transcript), returnsNormally);

    final merlin.Transcript transcript2 = merlin.Transcript('hello');
    late bool verified;
    expect(() => (verified, _) = kp.verify(signature, transcript2),
        returnsNormally);
    expect(verified, true);

    final merlin.Transcript transcript3 = merlin.Transcript('hello');
    late bool verified2;
    expect(() => (verified2, _) = kp.verify(signature, transcript3),
        returnsNormally);
    expect(verified2, true);
  });

}
