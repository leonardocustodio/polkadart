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
}
