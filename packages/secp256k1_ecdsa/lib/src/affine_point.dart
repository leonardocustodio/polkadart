part of secp256k1;

/// Point in 2d xy affine coordinates
class AffinePoint {
  BigInt x;
  BigInt y;
  AffinePoint(this.x, this.y);
}
