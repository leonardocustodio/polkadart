import 'dart:typed_data';
import 'package:sr25519/sr25519.dart';
import 'package:test/test.dart';
import 'package:merlin/merlin.dart' as merlin;

void main() {
  test('Test Keypair Input and Output', () {
    final merlin.Transcript signTranscript = merlin.Transcript("vrf-test");
    final merlin.Transcript verifyTranscript = merlin.Transcript("vrf-test");

    final kp = KeyPair.generateKeypair();

    final (inout, proof) = kp.vrfSign(signTranscript);

    final outslice = inout.output.encode();
    final out = VrfOutput.newOutput(Uint8List.fromList(outslice));

    final bool isVerified = kp.vrfVerify(verifyTranscript, out, proof);
    expect(isVerified, true);
  });
}
