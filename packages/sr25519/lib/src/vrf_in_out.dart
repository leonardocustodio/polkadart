// ignore_for_file: constant_identifier_names

part of sr25519;

// MAX_VRF_BYTES is the maximum bytes that can be extracted from the VRF via MakeBytes
const MAX_VRF_BYTES = 64;

class VrfInOut {
  final r255.Element input;
  final r255.Element output;

  const VrfInOut(this.input, this.output);

  /// Output returns a VrfOutput from a VrfInOut
  VrfOutput getVrfOutput() {
    return VrfOutput(r255.Element.newElement()..set(output));
  }

  /// EncodeOutput returns the 64-byte encoding of the input and output concatenated
  List<int> encode() {
    return List<int>.from([...input.encode(), ...output.encode()],
        growable: false);
  }

  /// makeBytes returns raw bytes output from the VRF
  /// It returns a byte slice of the given size
  /// https://github.com/w3f/schnorrkel/blob/master/src/vrf.rs#L343
  List<int> makeBytes(int size, List<int> context) {
    if (size <= 0 || size > MAX_VRF_BYTES) {
      throw Exception('invalid size parameter');
    }

    final t = merlin.Transcript('VRFResult');
    t.appendMessage(<int>[], context);
    commit(t);
    return t.extractBytes([], size);
  }

  void commit(merlin.Transcript t) {
    t
      ..appendMessage(utf8.encode("vrf-in"), input.encode())
      ..appendMessage(utf8.encode("vrf-out"), output.encode());
  }
}
