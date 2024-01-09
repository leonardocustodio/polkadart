part of sr25519;

class VrfOutput {
  late r255.Element output;

  VrfOutput(this.output);

  VrfOutput._();

  /// NewOutput creates a new VRF output from a 64-byte element
  factory VrfOutput.fromUint8List(Uint8List list) {
    return VrfOutput._()..decode(list);
  }

  /// AttachInput returns a VrfInOut pair from an output
  /// https://github.com/w3f/schnorrkel/blob/master/src/vrf.rs#L249
  VrfInOut attachInput(PublicKey pub, merlin.Transcript t) {
    final r255.Element input = pub.vrfHash(t);
    return VrfInOut(input, output);
  }

  /// Encode returns the 32-byte encoding of the output
  Uint8List encode() {
    final outbytes = Uint8List(32);
    outbytes.setAll(0, output.encode());
    return outbytes;
  }

  /// Decode sets the VrfOutput to the decoded input
  void decode(Uint8List list) {
    final r255.Element newOutput = r255.Element.newElement();
    newOutput.decode(list);
    output = newOutput;
  }
}
