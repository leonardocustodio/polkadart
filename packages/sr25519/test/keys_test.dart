import 'package:collection/collection.dart';
import 'package:convert/convert.dart';
import 'package:sr25519/sr25519.dart';
import 'package:test/test.dart';

void main() {
  test('Test MiniSecretKey fromHex', () {
    final MiniSecretKey priv = MiniSecretKey.fromHex(
      'e5be9a5092b81bca64be81d212e7f2f9eba183bb7a90954f7b76361f6edb5c0a',
    );

    final PublicKey pub = priv.public();
    final List<int> publicBytes = pub.encode();
    final expectexHex = '0xd43593c715fdd31c61141abd04a99fd6822c8558854ccde39a5684e7a56da27d';
    final actualHex = '0x${hex.encode(publicBytes)}';
    expect(actualHex, expectexHex);
  });

  test('Test Generate Keypair', () {
    final keyPair = KeyPair.generateKeypair();

    final (priv, pub) = (keyPair.secretKey, keyPair.publicKey);
    final pub2 = priv.public();

    final expectedBytes = pub2.encode();
    final actualBytes = pub.encode();

    expect(const ListEquality().equals(actualBytes, expectedBytes), true);
  });

  test('Test Generate Keypair From SecretKey', () {
    final keyPair = KeyPair.generateKeypair();

    final (priv, pub) = (keyPair.secretKey, keyPair.publicKey);

    final kp = priv.keypair();
    final expectedBytes = pub.encode();

    final actualBytes = kp.publicKey.encode();

    expect(const ListEquality().equals(actualBytes, expectedBytes), true);
  });

  // test cases from: https://github.com/Warchant/sr25519-crust/blob/master/test/keypair_from_seed.cpp
  test('Test MiniSecret Key_ExpandEd25519', () {
    final msc = MiniSecretKey();

    final SecretKey sc = msc.expandEd25519();

    final List<int> expectedBytes = hex.decode(
      'caa835781b15c7706f65b71f7a58c807ab360faed6440fb23e0f4c52e930de0a0a6a85eaa642dac835424b5d7c8d637c00408c7a73da672b7f498521420b6dd3def12e42f3e487e9b14095aa8d5cc16a33491f1b50dadcf8811d1480f3fa8627',
    );

    expect(const ListEquality().equals(expectedBytes.sublist(0, 32), sc.key), true);
    expect(const ListEquality().equals(expectedBytes.sublist(32, 64), sc.nonce), true);

    final List<int> publicKeyBytes = msc.public().encode();
    expect(const ListEquality().equals(expectedBytes.sublist(64), publicKeyBytes), true);
  });

  test('Test MiniSecretKey_Public', () {
    // test vectors from https://github.com/noot/schnorrkel/blob/master/src/keys.rs#L996
    final List<int> raw = [
      1,
      2,
      3,
      4,
      5,
      6,
      7,
      8,
      9,
      0,
      1,
      2,
      3,
      4,
      5,
      6,
      7,
      8,
      9,
      0,
      1,
      2,
      3,
      4,
      5,
      6,
      7,
      8,
      9,
      0,
      1,
      2,
    ];
    final MiniSecretKey msc = MiniSecretKey.fromRawKey(raw);

    final List<int> expectedKey = [
      11,
      241,
      180,
      83,
      213,
      181,
      31,
      180,
      138,
      45,
      144,
      84,
      2,
      78,
      47,
      81,
      225,
      208,
      202,
      53,
      128,
      52,
      89,
      144,
      36,
      92,
      197,
      51,
      166,
      28,
      152,
      10,
    ];
    final List<int> expectedNonce = [
      69,
      121,
      245,
      84,
      53,
      88,
      241,
      101,
      252,
      126,
      198,
      17,
      237,
      114,
      215,
      135,
      224,
      58,
      4,
      75,
      134,
      169,
      226,
      109,
      76,
      133,
      25,
      135,
      115,
      81,
      176,
      46,
    ];
    final List<int> expectedPubkey = [
      140,
      122,
      228,
      195,
      50,
      29,
      229,
      250,
      94,
      159,
      183,
      123,
      208,
      116,
      7,
      78,
      229,
      29,
      247,
      64,
      172,
      187,
      92,
      144,
      121,
      56,
      242,
      3,
      116,
      99,
      100,
      32,
    ];

    final SecretKey sc = msc.expandEd25519();

    expect(const ListEquality().equals(expectedKey, sc.key), true);
    expect(const ListEquality().equals(expectedNonce, sc.nonce), true);

    final List<int> publicKeyBytes = msc.public().encode();
    expect(const ListEquality().equals(expectedPubkey, publicKeyBytes), true);
  });

  test('Test PublicKey_Decode', () {
    // test vectors from https://github.com/Warchant/sr25519-crust/blob/master/test/ds.cpp#L48
    late List<int> pubBytes;
    expect(
      () =>
          pubBytes = hex.decode('46ebddef8cd9bb167dc30878d7113b7e168e6f0646beffd77d69d39bad76b47a'),
      returnsNormally,
    );

    final List<int> bytes = List<int>.filled(32, 0, growable: false);
    bytes.setRange(0, 32, pubBytes);

    final PublicKey pub = PublicKey();
    expect(() => pub.decode(bytes), returnsNormally);

    late List<int> privBytes;
    expect(
      () => privBytes = hex.decode(
        '05d65584630d16cd4af6d0bec10f34bb504a5dcb62dba2122d49f5a663763d0a',
      ),
      returnsNormally,
    );
    bytes.setRange(0, 32, privBytes);

    final SecretKey priv = SecretKey();
    expect(() => priv.decode(privBytes), returnsNormally);

    final PublicKey expectedPublicKey = priv.public();
    final List<int> expectedPublicKeyBytes = expectedPublicKey.encode();

    final List<int> actualPublicKeyBytes = pub.encode();

    expect(const ListEquality().equals(actualPublicKeyBytes, expectedPublicKeyBytes), true);
  });

  test('Test New Public Key', () {
    final List<int> pub = [
      140,
      122,
      228,
      195,
      50,
      29,
      229,
      250,
      94,
      159,
      183,
      123,
      208,
      116,
      7,
      78,
      229,
      29,
      247,
      64,
      172,
      187,
      92,
      144,
      121,
      56,
      242,
      3,
      116,
      99,
      100,
      32,
    ];
    final PublicKey pk = PublicKey.newPublicKey(pub);

    final List<int> enc = pk.encode();
    expect(const ListEquality().equals(pub, enc), true);
  });

  test('Test New Secret Key From Ed25519Bytes', () {
    // test vectors from https://github.com/w3f/schnorrkel/blob/ab3e3d609cd8b9eefbe0333066f698c40fd09582/src/keys.rs#L504-L507
    final List<int> b = List<int>.filled(64, 0, growable: false);
    final List<int> byteshex = hex.decode(
      '28b0ae221c6bb06856b287f60d7ea0d98552ea5a16db16956849aa371db3eb51fd190cce74df356432b410bd64682309d6dedb27c76845daf388557cbac3ca34',
    );

    b.setRange(0, 64, byteshex);

    final List<int> pub = List<int>.filled(32, 0, growable: false);
    final List<int> pubHex = hex.decode(
      '46ebddef8cd9bb167dc30878d7113b7e168e6f0646beffd77d69d39bad76b47a',
    );

    pub.setRange(0, 32, pubHex);

    final SecretKey sc = SecretKey.fromEd25519Bytes(b);
    final PublicKey pk = sc.public();
    expect(const ListEquality().equals(pub, pk.encode()), true);
  });
}
