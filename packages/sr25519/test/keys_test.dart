import 'package:collection/collection.dart';
import 'package:convert/convert.dart';
import 'package:sr25519/sr25519.dart';
import 'package:test/test.dart';

void main() {
  test('Test MiniSecretKey fromHex', () {
    final MiniSecretKey priv = MiniSecretKey.fromHex(
        "e5be9a5092b81bca64be81d212e7f2f9eba183bb7a90954f7b76361f6edb5c0a");

    final PublicKey pub = priv.public();
    final List<int> publicBytes = pub.encode();
    final expectexHex =
        '0xd43593c715fdd31c61141abd04a99fd6822c8558854ccde39a5684e7a56da27d';
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
    final msc = MiniSecretKey.fromRawKey(List<int>.filled(32, 0));

    final SecretKey sc = msc.expandEd25519();

    final List<int> expectedBytes = hex.decode(
        'caa835781b15c7706f65b71f7a58c807ab360faed6440fb23e0f4c52e930de0a0a6a85eaa642dac835424b5d7c8d637c00408c7a73da672b7f498521420b6dd3def12e42f3e487e9b14095aa8d5cc16a33491f1b50dadcf8811d1480f3fa8627');

    expect(const ListEquality().equals(expectedBytes.sublist(0, 32), sc.key),
        true);
    expect(const ListEquality().equals(expectedBytes.sublist(32, 64), sc.nonce),
        true);

    final List<int> publicKeyBytes = msc.public().encode();
    expect(
        const ListEquality().equals(expectedBytes.sublist(64), publicKeyBytes),
        true);
  });
}
