import 'dart:convert';
import 'package:merlin/merlin.dart' as merlin;
import 'package:sr25519/sr25519.dart';
import 'package:test/test.dart';

void main() {
  test('Example Test', () {
    final msg = utf8.encode('hello friends');
    final signingCtx = utf8.encode('example');

    final merlin.Transcript signingTranscript =
        Sr25519.newSigningContext(signingCtx, msg);

    final merlin.Transcript verifyTranscript =
        Sr25519.newSigningContext(signingCtx, msg);

    final keypair = Sr25519.generateKeyPair();

    final (priv, pub) = (keypair.secretKey, keypair.publicKey);

    final Signature sig = priv.sign(signingTranscript);

    final (ok, _) = pub.verify(sig, verifyTranscript);

    expect(ok, true);
  });
}
