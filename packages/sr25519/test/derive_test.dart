import 'dart:convert';

import 'package:collection/collection.dart';
import 'package:convert/convert.dart';
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

  test('Test Derive Soft', () {
    // test vectors from https://github.com/Warchant/sr25519-crust/blob/master/test/derive.cpp#L32

    final vector = TestingVector(
      keyPair:
          '4c1250e05afcd79e74f6c035aee10248841090e009b6fd7ba6a98d5dc743250cafa4b32c608e3ee2ba624850b3f14c75841af84b16798bf1ee4a3875aa37a2cee661e416406384fe1ca091980958576d2bff7c461636e9f22c895f444905ea1f',
      chainCode:
          '0c666f6f00000000000000000000000000000000000000000000000000000000',
      public:
          'b21e5aabeeb35d6a1bf76226a6c65cd897016df09ef208243e59eed2401f5357',
      hard: false,
    );

    vector.deriveHardSoft();
  });

  test('Test Derive Hard', () {
    // test vectors from https://github.com/Warchant/sr25519-crust/blob/4b167a8db2c4114561e5380e3493375df426b124/test/derive.cpp#L13

    final vector = TestingVector(
      keyPair:
          '4c1250e05afcd79e74f6c035aee10248841090e009b6fd7ba6a98d5dc743250cafa4b32c608e3ee2ba624850b3f14c75841af84b16798bf1ee4a3875aa37a2cee661e416406384fe1ca091980958576d2bff7c461636e9f22c895f444905ea1f',
      chainCode:
          '14416c6963650000000000000000000000000000000000000000000000000000',
      public:
          'd8db757f04521a940f0237c8a1e44dfbe0b3e39af929eb2e9e257ba61b9a0a1a',
      hard: true,
    );

    vector.deriveHardSoft();
  });
}

/// commonVectors is a struct to set the vectors used for deriving soft or hard
/// keys for testing
class TestingVector {
  /// KeyPair in the hex encoded string of a known keypair
  final String keyPair;

  /// ChainCode is the chain code for generating the derived key hex encoded
  final String chainCode;

  /// Public is the expected resulting public key of the derived key hex
  /// encoded
  final String public;

  /// Hard indicates if the vectors are for deriving a Hard key
  final bool hard;

  const TestingVector({
    required this.keyPair,
    required this.chainCode,
    required this.public,
    required this.hard,
  });

  /// deriveCommon provides common functions for testing Soft and Hard key derivation
  void deriveHardSoft() {
    final kp = hex.decode(keyPair);

    final cc = hex.decode(chainCode);

    final List<int> privBytes = List.from(kp.sublist(0, 32), growable: false);
    final priv = SecretKey();
    priv.decode(privBytes);
    final List<int> ccBytes = List.from(cc.sublist(0, 32), growable: false);

    late ExtendedKey derived;

    if (hard) {
      derived = ExtendedKey.deriveKeyHard(priv, [], ccBytes);
    } else {
      derived = ExtendedKey.deriveKeySimple(priv, [], ccBytes);
    }

    final List<int> expectedPub = hex.decode(public);

    final PublicKey resultPub = derived.public();

    final List<int> resultPubBytes = resultPub.encode();
    expect(const ListEquality().equals(resultPubBytes, expectedPub), true);
  }
}
