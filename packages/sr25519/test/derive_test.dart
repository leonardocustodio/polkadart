import 'dart:convert';
import 'package:collection/collection.dart';
import 'package:cryptography/dart.dart';
import 'package:merlin/merlin.dart' as merlin;
import 'package:sr25519/sr25519.dart';
import 'package:test/test.dart';

void main() {
  test('Test Derive Key', () {
    final SecretKey priv = KeyPair.generateKeypair().secretKey;

    late final merlin.Transcript transcript;
    expect(
        () => transcript =
            Sr25519.newSigningContext(utf8.encode('test'), utf8.encode('noot')),
        returnsNormally);
    final msg = utf8.encode('hello');
    final cc = DartBlake2b().hashSync(msg).bytes;
    expect(() => priv.deriveKey(transcript, cc), returnsNormally);
  });

  test('Test Derive Public And Private Match', () {
    final KeyPair keyPair = KeyPair.generateKeypair();
    final PublicKey pub = keyPair.publicKey;
    final SecretKey priv = keyPair.secretKey;

    final merlin.Transcript transcriptPriv =
        Sr25519.newSigningContext(utf8.encode('test'), utf8.encode('noot'));
    final merlin.Transcript transcriptPub =
        Sr25519.newSigningContext(utf8.encode('test'), utf8.encode('noot'));
    final List<int> msg = utf8.encode('hello');

    final List<int> cc = DartBlake2b().hashSync(msg).bytes;
    final ExtendedKey dpriv = priv.deriveKey(transcriptPriv, cc);

    // confirm chain codes are the same for private and public paths
    final ExtendedKey dpub = pub.deriveKey(transcriptPub, cc);
    expect(const ListEquality().equals(dpriv.chaincode, dpub.chaincode), true);

    final PublicKey dpub2 = (dpriv.key as SecretKey).public();
    final List<int> pubbytes = dpub.key.encode();
    final List<int> pubFromPrivBytes = dpub2.encode();

    // confirm public keys are the same from private and public paths
    expect(const ListEquality().equals(pubbytes, pubFromPrivBytes), true);

    final merlin.Transcript signingTranscript =
        Sr25519.newSigningContext(utf8.encode('test'), utf8.encode('signme'));
    final merlin.Transcript verifyTranscript =
        Sr25519.newSigningContext(utf8.encode('test'), utf8.encode('signme'));
    final sig = (dpriv.key as SecretKey).sign(signingTranscript);

    // confirm that key derived from public path can verify signature derived from private path
    final (verified, _) = (dpub.key as PublicKey).verify(sig, verifyTranscript);
    expect(verified, true);
  });
}
