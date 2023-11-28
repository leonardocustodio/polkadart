import 'dart:convert';
import 'dart:typed_data';

import 'package:collection/collection.dart';
import 'package:merlin/merlin.dart' as merlin;
import 'package:ristretto255/ristretto255.dart' as r255;
import 'package:sr25519/sr25519.dart';
import 'package:test/test.dart';

void main() {
  test('Test Keypair Input and Output', () {
    final merlin.Transcript signTranscript = merlin.Transcript('vrf-test');
    final merlin.Transcript verifyTranscript = merlin.Transcript('vrf-test');

    final KeyPair kp = KeyPair.generateKeypair();

    final (inout, proof) = kp.vrfSign(signTranscript);

    final outslice = inout.output.encode();
    final out = VrfOutput.fromUint8List(Uint8List.fromList(outslice));

    final bool isVerified = kp.vrfVerify(verifyTranscript, out, proof);
    expect(isVerified, true);
  });

  test('Test Input and Output', () {
    final merlin.Transcript signTranscript = merlin.Transcript('vrf-test');
    final merlin.Transcript verifyTranscript = merlin.Transcript('vrf-test');

    final KeyPair kp = KeyPair.generateKeypair();
    final (priv, pub) = (kp.secretKey, kp.publicKey);

    final (inout, proof) = priv.vrfSign(signTranscript);

    final outslice = inout.output.encode();

    final out = VrfOutput.fromUint8List(Uint8List.fromList(outslice));

    final bool isVerified = pub.vrfVerify(verifyTranscript, out, proof);
    expect(isVerified, true);
  });

  test('Test Output  Encode and Decode', () {
    final r255.Element o = newRandomElement();

    final VrfOutput out = VrfOutput(o);

    final Uint8List enc = out.encode();
    final VrfOutput out2 = VrfOutput.fromUint8List(enc);

    final Uint8List enc2 = out2.encode();
    expect(const ListEquality().equals(enc, enc2), true);
  });

  test('Test Proof Encode and Decode', () {
    final r255.Scalar c = newRandomScalar();
    final r255.Scalar s = newRandomScalar();

    final VrfProof proof = VrfProof(c, s);

    final Uint8List enc = proof.encode();
    final VrfProof proof2 = VrfProof.fromUint8List(enc);

    expect(() => proof2.decode(enc), returnsNormally);

    final Uint8List enc2 = proof2.encode();
    expect(const ListEquality().equals(enc, enc2), true);
  });

  test('Test VRF Sign and Verify', () {
    final merlin.Transcript signTranscript = merlin.Transcript('vrf-test');
    final merlin.Transcript verifyTranscript = merlin.Transcript('vrf-test');
    final merlin.Transcript verify2Transcript = merlin.Transcript('vrf-test');

    final KeyPair kp = KeyPair.generateKeypair();
    final (priv, pub) = (kp.secretKey, kp.publicKey);

    final (inout, proof) = priv.vrfSign(signTranscript);

    final bool ok =
        pub.vrfVerify(verifyTranscript, inout.getVrfOutput(), proof);
    expect(ok, true);

    proof.c = newRandomScalar();

    final bool ok2 =
        pub.vrfVerify(verify2Transcript, inout.getVrfOutput(), proof);
    expect(ok2, false);
  });

  test('Test VrfVerify rust', () {
    // test case from https://github.com/w3f/schnorrkel/blob/798ab3e0813aa478b520c5cf6dc6e02fd4e07f0a/src/vrf.rs#L922
    final pubbytes = Uint8List.fromList([
      192,
      42,
      72,
      186,
      20,
      11,
      83,
      150,
      245,
      69,
      168,
      222,
      22,
      166,
      167,
      95,
      125,
      248,
      184,
      67,
      197,
      10,
      161,
      107,
      205,
      116,
      143,
      164,
      143,
      127,
      166,
      84
    ]);
    final pub = PublicKey.newPublicKey(pubbytes);

    final transcript =
        Sr25519.newSigningContext(utf8.encode('yo!'), utf8.encode('meow'));
    final Uint8List inputbytes = Uint8List.fromList([
      56,
      52,
      39,
      115,
      143,
      80,
      43,
      66,
      174,
      177,
      101,
      21,
      177,
      15,
      199,
      228,
      180,
      110,
      208,
      139,
      229,
      146,
      24,
      231,
      118,
      175,
      180,
      55,
      191,
      37,
      150,
      61
    ]);
    final Uint8List outputbytes = Uint8List.fromList([
      0,
      91,
      50,
      25,
      214,
      94,
      119,
      36,
      71,
      216,
      33,
      152,
      85,
      184,
      34,
      120,
      61,
      161,
      164,
      223,
      76,
      53,
      40,
      246,
      76,
      38,
      235,
      204,
      43,
      31,
      179,
      28
    ]);

    final r255.Element input = r255.Element.newElement();
    input.decode(inputbytes);

    final r255.Element output = r255.Element.newElement();
    output.decode(outputbytes);

    final VrfInOut inout = VrfInOut(input, output);

    final Uint8List cbytes = Uint8List.fromList([
      120,
      23,
      235,
      159,
      115,
      122,
      207,
      206,
      123,
      232,
      75,
      243,
      115,
      255,
      131,
      181,
      219,
      241,
      200,
      206,
      21,
      22,
      238,
      16,
      68,
      49,
      86,
      99,
      76,
      139,
      39,
      0
    ]);
    final Uint8List sbytes = Uint8List.fromList([
      102,
      106,
      181,
      136,
      97,
      141,
      187,
      1,
      234,
      183,
      241,
      28,
      27,
      229,
      133,
      8,
      32,
      246,
      245,
      206,
      199,
      142,
      134,
      124,
      226,
      217,
      95,
      30,
      176,
      246,
      5,
      3
    ]);
    final r255.Scalar c = r255.Scalar();
    c.decode(cbytes);

    final r255.Scalar s = r255.Scalar();
    s.decode(sbytes);

    final VrfProof proof = VrfProof(c, s);

    final bool ok = pub.vrfVerify(transcript, inout.getVrfOutput(), proof);
    expect(ok, true);
  });

  // input data from https://github.com/noot/schnorrkel/blob/master/src/vrf.rs#L922
  test('Test VrfInOut  MakeBytes', () {
    final merlin.Transcript transcript =
        Sr25519.newSigningContext(utf8.encode('yo!'), utf8.encode('meow'));

    final Uint8List pub = Uint8List.fromList([
      12,
      132,
      183,
      11,
      234,
      190,
      96,
      172,
      111,
      239,
      163,
      137,
      148,
      163,
      69,
      79,
      230,
      61,
      134,
      41,
      69,
      90,
      134,
      229,
      132,
      128,
      6,
      63,
      139,
      220,
      202,
      0
    ]);
    final Uint8List input = Uint8List.fromList([
      188,
      162,
      182,
      161,
      195,
      26,
      55,
      223,
      166,
      205,
      136,
      92,
      211,
      130,
      184,
      194,
      183,
      81,
      215,
      192,
      168,
      12,
      39,
      55,
      218,
      165,
      8,
      105,
      155,
      73,
      128,
      68
    ]);
    final Uint8List output = Uint8List.fromList([
      214,
      40,
      153,
      246,
      88,
      74,
      127,
      242,
      54,
      193,
      7,
      5,
      90,
      51,
      45,
      5,
      207,
      59,
      64,
      68,
      134,
      232,
      19,
      223,
      249,
      88,
      74,
      125,
      64,
      74,
      220,
      48
    ]);
    final Uint8List proof = Uint8List.fromList([
      144,
      199,
      179,
      5,
      250,
      199,
      220,
      177,
      12,
      220,
      242,
      196,
      168,
      237,
      106,
      3,
      62,
      195,
      74,
      127,
      134,
      107,
      137,
      91,
      165,
      104,
      223,
      244,
      3,
      4,
      141,
      10,
      129,
      54,
      134,
      31,
      49,
      250,
      205,
      203,
      254,
      142,
      87,
      123,
      216,
      108,
      190,
      112,
      204,
      204,
      188,
      30,
      84,
      36,
      247,
      217,
      59,
      125,
      45,
      56,
      112,
      195,
      84,
      15
    ]);
    final Uint8List makeBytes16Expected = Uint8List.fromList([
      169,
      57,
      149,
      50,
      0,
      243,
      120,
      138,
      25,
      250,
      74,
      235,
      247,
      137,
      228,
      40
    ]);

    final PublicKey pubkey = PublicKey.newPublicKey(pub);

    final VrfOutput out = VrfOutput.fromUint8List(output);

    final VrfInOut inout = out.attachInput(pubkey, transcript);

    expect(const ListEquality().equals(input, inout.input.encode()), true);

    final VrfProof p = VrfProof.fromUint8List(proof);

    final merlin.Transcript verifyTranscript =
        Sr25519.newSigningContext(utf8.encode('yo!'), utf8.encode('meow'));
    final bool ok = pubkey.vrfVerify(verifyTranscript, out, p);
    expect(ok, true);

    final List<int> bytes =
        inout.makeBytes(16, utf8.encode('substrate-babe-vrf'));

    expect(const ListEquality().equals(makeBytes16Expected, bytes), true);
  });

  test('Test VrfVerify NotKusama', () {
    final merlin.Transcript transcript =
        Sr25519.newSigningContext(utf8.encode('yo!'), utf8.encode('meow'));
    final Uint8List pub = Uint8List.fromList([
      178,
      10,
      148,
      176,
      134,
      205,
      129,
      139,
      45,
      90,
      42,
      14,
      71,
      116,
      227,
      233,
      15,
      253,
      56,
      53,
      123,
      7,
      89,
      240,
      129,
      61,
      83,
      213,
      88,
      73,
      45,
      111
    ]);
    final Uint8List input = Uint8List.fromList([
      118,
      192,
      145,
      134,
      145,
      226,
      209,
      28,
      62,
      15,
      187,
      236,
      43,
      229,
      255,
      161,
      72,
      122,
      128,
      21,
      28,
      155,
      72,
      19,
      67,
      100,
      50,
      217,
      72,
      35,
      95,
      111
    ]);
    final Uint8List output = Uint8List.fromList([
      114,
      173,
      188,
      116,
      143,
      11,
      157,
      244,
      87,
      214,
      231,
      0,
      234,
      34,
      157,
      145,
      62,
      154,
      68,
      161,
      121,
      66,
      49,
      25,
      123,
      38,
      138,
      20,
      207,
      105,
      7,
      5
    ]);
    final Uint8List proof = Uint8List.fromList([
      123,
      219,
      60,
      236,
      49,
      106,
      113,
      229,
      135,
      98,
      153,
      252,
      10,
      63,
      65,
      174,
      242,
      191,
      130,
      65,
      119,
      177,
      227,
      15,
      103,
      219,
      192,
      100,
      174,
      204,
      136,
      3,
      95,
      148,
      246,
      105,
      108,
      51,
      20,
      173,
      123,
      108,
      5,
      49,
      253,
      21,
      170,
      41,
      214,
      1,
      141,
      97,
      93,
      182,
      52,
      175,
      202,
      186,
      149,
      213,
      69,
      57,
      7,
      14
    ]);
    final Uint8List makeBytes16Expected = Uint8List.fromList([
      193,
      153,
      104,
      18,
      4,
      27,
      121,
      146,
      149,
      228,
      12,
      17,
      251,
      184,
      117,
      16
    ]);

    final PublicKey pubkey = PublicKey.newPublicKey(pub);
    pubkey.kusamaVRF = false;

    final VrfOutput out = VrfOutput.fromUint8List(output);

    final VrfInOut inout = out.attachInput(pubkey, transcript);
    expect(const ListEquality().equals(input, inout.input.encode()), true);

    final VrfProof p = VrfProof.fromUint8List(proof);

    final merlin.Transcript verifyTranscript =
        Sr25519.newSigningContext(utf8.encode('yo!'), utf8.encode('meow'));
    final bool ok = pubkey.vrfVerify(verifyTranscript, out, p);
    expect(ok, true);

    final List<int> bytes =
        inout.makeBytes(16, utf8.encode('substrate-babe-vrf'));
    expect(const ListEquality().equals(makeBytes16Expected, bytes), true);
  });

  test('Test VRFVerify Public Key at Infinity', () {
    final merlin.Transcript signTranscript = merlin.Transcript('vrf-test');
    final merlin.Transcript verifyTranscript = merlin.Transcript('vrf-test');

    final SecretKey priv = SecretKey();
    final PublicKey pub = priv.public();

    expect(pub.key.equal(publicKeyAtInfinity) == 1, true);

    final (inout, proof) = priv.vrfSign(signTranscript);

    final bool verified =
        pub.vrfVerify(verifyTranscript, inout.getVrfOutput(), proof);

    // Not verified because [public key is at infinity].
    expect(verified, false);
  });
}
