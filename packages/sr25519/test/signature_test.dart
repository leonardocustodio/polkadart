import 'package:collection/collection.dart';
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

  test('Test Signature Encode and Decode', () {
    final merlin.Transcript transcript = merlin.Transcript('hello');
    final SecretKey private = KeyPair.generateKeypair().secretKey;

    late Signature signature;
    expect(() => signature = private.sign(transcript), returnsNormally);

    final List<int> encoded = signature.encode();

    late Signature result;
    expect(() => result = Signature.fromBytes(encoded), returnsNormally);

    final List<int> sExpected = signature.s.encode();
    final List<int> sActual = result.s.encode();

    final List<int> rExpected = signature.r.encode();
    final List<int> rActual = result.r.encode();

    expect(const ListEquality<int>().equals(sExpected, sActual), true);
    expect(const ListEquality<int>().equals(rExpected, rActual), true);
  });
}
