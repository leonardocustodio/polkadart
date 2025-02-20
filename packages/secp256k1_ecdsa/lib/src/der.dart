part of secp256k1;

class DER {
  static (BigInt d, List<int> l) _parseInt(List<int> data) {
    if (data.length < 2 || data[0] != 0x02) {
      throw Exception('Invalid signature integer tag');
    }
    final len = data[1];
    final res = data.sublist(2, len + 2);
    if (len == 0 || res.length != len) {
      throw Exception('Invalid signature integer: wrong length');
    }
    // https://crypto.stackexchange.com/a/57734 Leftmost bit of first byte is 'negative' flag,
    // since we always use positive integers here. It must always be empty:
    // - add zero byte if exists
    // - if next byte doesn't have a flag, leading zero is not allowed (minimal encoding)
    if (res[0] & 0x80 != 0) {
      throw Exception('Invalid signature integer: negative');
    }
    if (res[0] == 0x00 && (res[1] & 0x80) == 0) {
      throw Exception('Invalid signature integer: unnecessary leading zero');
    }
    // d is data, l is left
    return (
      Utilities.bytesToBigInt(Uint8List.fromList(res)),
      data.sublist(len + 2)
    );
  }

  static Signature toSigFromHex(String hex) {
    return toSigFromBytes(Utilities.hexToBytes(hex));
  }

  static Signature toSigFromBytes(Uint8List data) {
    final int l = data.length;
    if (l < 2 || data[0] != 0x30) {
      throw Exception('Invalid signature tag');
    }
    if (data[1] != l - 2) {
      throw Exception('Invalid signature: incorrect length');
    }
    final (r, sBytes) = DER._parseInt(data.sublist(2));
    final (s, rBytesLeft) = DER._parseInt(sBytes);
    if (rBytesLeft.isNotEmpty) {
      throw Exception('Invalid signature: left bytes after parsing');
    }
    return Signature(r: r, s: s);
  }

  static String hexFromSig(Signature sig) {
    final String s = slice(h(sig.s.toRadixString(16)));
    final String r = slice(h(sig.r.toRadixString(16)));
    final int shl = s.length ~/ 2;
    final int rhl = r.length ~/ 2;
    final String sl = h(shl.toRadixString(16));
    final String rl = h(rhl.toRadixString(16));
    return '30${h((rhl + shl + 4).toRadixString(16))}02$rl${r}02$sl$s';
  }

  static String h(String hex) {
    return hex.length.isOdd ? '0$hex' : hex;
  }

  static String slice(String s) {
    return int.parse(s[0], radix: 16) >= 8 ? '00$s' : s;
  }
}
