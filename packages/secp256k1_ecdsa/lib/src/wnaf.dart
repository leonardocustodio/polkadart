part of secp256k1;

class WNAF {
  final Point p;
  final Point f;
  const WNAF._(this.p, this.f);

  static WNAF wNAF(BigInt n) {
    // w-ary non-adjacent form (wNAF) method.
    // Compared to other point mult methods,
    if (Gpows.isEmpty) {
      Gpows.addAll(Utilities.precompute());
    }
    final comp = Gpows.map((e) => e.copy()).toList();
    // negate
    Point neg(bool cnd, Point p) {
      final n = p.negate();
      return cnd ? n : p;
    }

    // f must be G, or could become I in the end
    Point p = Point.I.copy();
    Point f = Point.G.copy();

    // W=8 17 windows
    final int windows = 1 + 256 ~/ W;
    // W=8 128 window size
    final wsize = 1 << (W - 1);
    // W=8 will create mask 0b11111111
    final mask = BigInt.from(1 << W) - BigInt.one;
    // W=8 256
    final int maxNum = 1 << W;
    // W=8 8
    final shiftBy = BigInt.from(W);
    for (var w = 0; w < windows; w++) {
      final int off = w * wsize;
      // extract W bits.
      int wbits = (n & mask).toInt();
      // shift number by W bits.
      n >>= shiftBy.toInt();
      // split if bits > max: +224 => 256-32
      if (wbits > wsize) {
        wbits -= maxNum;
        n += BigInt.one;
      }
      // offsets, evaluate both
      final int off1 = off;
      final int off2 = off + (wbits.abs()) - 1;
      final bool cnd1 = w % 2 != 0;
      final bool cnd2 = wbits < 0;
      // conditions, evaluate both
      if (wbits == 0) {
        // bits are 0: add garbage to fake point
        f = f.add(neg(cnd1, comp[off1]));
      } else {
        // ^ can't add off2, off2 = I
        // bits are 1: add to result point
        p = p.add(neg(cnd2, comp[off2]));
      }
    } // return both real and fake points for JIT
    return WNAF._(p, f);
  } // !! you can disable precomputes by commenting-out call of the wNAF() inside Point#mul()
}
