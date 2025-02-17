part of sr25519;

class Signature {
  r255.Element r = r255.Element.newElement();
  r255.Scalar s = r255.Scalar();

  Signature.from(this.r, this.s);

  Signature._();

  /// Signature.fromBytes returns a new Signature from the given bytes List<int>
  factory Signature.fromBytes(Uint8List bytes) {
    if (bytes.length != 64) {
      throw Exception('Invalid bytes. Expected bytes of length 64, got ${bytes.length}');
    }

    final sig = Signature._();
    sig.decode(bytes);
    return sig;
  }

  /// Signature.fromHex returns a new Signature from the given hex-encoded string
  factory Signature.fromHex(String s) {
    final sigHex = hex.decode(s);
    if (sigHex.length != 64) {
      throw Exception('Invalid hex string. Expected 64 bytes, got ${sigHex.length}');
    }

    final sig = Signature._();
    sig.decode(Uint8List.fromList(sigHex));
    return sig;
  }

  /// Decode sets a Signature from bytes
  /// see: https://github.com/w3f/schnorrkel/blob/db61369a6e77f8074eb3247f9040ccde55697f20/src/sign.rs#L100
  void decode(Uint8List bytes) {
    if (bytes.length != 64) {
      throw Exception('invalid bytes length');
    }
    if (bytes[63] & 128 == 0) {
      throw Exception('signature is not marked as a schnorrkel signature');
    }

    final cp = Uint8List.fromList(bytes.toList());

    r = r255.Element.newElement();
    r.decode(Uint8List.fromList(cp.sublist(0, 32)));
    cp[63] &= 127;
    s = r255.Scalar();
    s.decode(cp.sublist(32, 64).toList());
  }

  /// Encode turns a signature into a byte array
  /// see: https://github.com/w3f/schnorrkel/blob/db61369a6e77f8074eb3247f9040ccde55697f20/src/sign.rs#L77
  Uint8List encode() {
    final Uint8List out = Uint8List(64);
    out
      ..setRange(0, 32, r.encode())
      ..setRange(32, 64, s.encode());
    out[63] |= 128;
    return out;
  }

  /// decodeNotDistinguishedFromEd25519 sets a signature from bytes, not checking if the signature
  /// is explicitly marked as a schnorrkel signature
  factory Signature.decodeNotDistinguishedFromEd25519(Uint8List bytes) {
    if (bytes.length != 64) {
      throw Exception('invalid bytes length');
    }
    final cp = Uint8List.fromList(bytes);
    cp[63] |= 128;
    return Signature._()..decode(cp);
  }
}
