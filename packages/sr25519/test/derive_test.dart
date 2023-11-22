import 'dart:convert';
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
}
