import 'package:sr25519/sr25519.dart';
import 'package:test/test.dart';
import 'package:merlin/merlin.dart' as merlin;

void main() {
  test('Verify Batch', () {
    final int num = 16;
    final List<merlin.Transcript> transcripts = <merlin.Transcript>[];
    final List<Signature> sigs = <Signature>[];
    final List<PublicKey> pubkeys = <PublicKey>[];

    for (int i = 0; i < num; i++) {
      final transcript = merlin.Transcript('hello_$i');
      final keypair = KeyPair.generateKeypair();
      final priv = keypair.secretKey;
      final pub = keypair.publicKey;

      expect(() => sigs.add(priv.sign(transcript)), returnsNormally);

      expect(() => transcripts.add(merlin.Transcript('hello_$i')),
          returnsNormally);

      expect(() => pubkeys.add(pub), returnsNormally);
    }

    expect(transcripts.length, num);
    expect(sigs.length, num);
    expect(pubkeys.length, num);

    final verified = verifyBatch(transcripts, sigs, pubkeys);
    expect(verified, true, reason: 'failed to batch verify signatures');
  });


  test('Use BatchVerifier() to verify batch', () {
    final num = 16;
    final batchVerifier = BatchVerifier();

    for (int i = 0; i < num; i++) {
      merlin.Transcript transcript = merlin.Transcript('hello_$i');
      final keyPair = KeyPair.generateKeypair();
      final (priv, pub) = (keyPair.secretKey, keyPair.publicKey);

      late Signature sig;
      expect(() => sig = priv.sign(transcript), returnsNormally);

      expect(() => transcript = merlin.Transcript('hello_$i'), returnsNormally);
      expect(() => batchVerifier.add(transcript, sig, pub), returnsNormally);
    }

    final verified = batchVerifier.verify();
    expect(verified, true, reason: 'failed to batch verify signatures');
  });
}
