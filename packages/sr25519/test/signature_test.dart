import 'dart:convert';

import 'package:collection/collection.dart';
import 'package:convert/convert.dart';
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

  test('Test verify rust', () {
    final List<int> publicBytes = hex.decode(
        '46ebddef8cd9bb167dc30878d7113b7e168e6f0646beffd77d69d39bad76b47a');

    final PublicKey pub = PublicKey();
    pub.decode(publicBytes);

    final List<int> message = utf8.encode('this is a message');

    final Signature sig = Signature.fromHex(
        '4e172314444b8f820bb54c22e95076f220ed25373e5c178234aa6c211d29271244b947e3ff3418ff6b45fd1df1140c8cbff69fc58ee6dc96df70936a2bb74b82');

    final merlin.Transcript transcript =
        Sr25519.newSigningContext(utf8.encode('substrate'), message);

    late bool verified;
    expect(() => (verified, _) = pub.verify(sig, transcript), returnsNormally);
    expect(verified, true);
  });

  test('Test verify public key at infinity', () {
    final merlin.Transcript transcript = merlin.Transcript('hello');
    final SecretKey private = SecretKey();
    final PublicKey publicKey = private.public();

    expect(publicKey.key.equal(publicKeyAtInfinity), 1);

    late Signature signature;
    expect(() => signature = private.sign(transcript), returnsNormally);

    final merlin.Transcript transcript2 = merlin.Transcript('hello');

    final (verified, exception) = publicKey.verify(signature, transcript2);
    expect(exception, isNotNull);
    expect(verified, false);
    expect(
        exception.toString(), 'Exception: public key is the point at infinity');
  });

  test('Test verify rust preaudit deprecated', () {
    final List<int> publicBytes = hex.decode(
        'b4bfa1f7a5166695eb75299fd1c4c03ea212871c342f2c5dfea0902b2c246918');

    final PublicKey pub = PublicKey();
    pub.decode(publicBytes);

    final List<int> message = utf8.encode(
        'Verifying that I am the owner of 5G9hQLdsKQswNPgB499DeA5PkFBbgkLPJWkkS6FAM6xGQ8xD. Hash: 221455a3\n');

    final List<int> sig = hex.decode(
        '5a9755f069939f45d96aaf125cf5ce7ba1db998686f87f2fb3cbdea922078741a73891ba265f70c31436e18a9acd14d189d73c12317ab6c313285cd938453202');

    late bool verified;
    expect(
        () => verified =
            pub.verifySimplePreAuditDeprecated('substrate', message, sig),
        returnsNormally);
    expect(verified, true);
  });
}
