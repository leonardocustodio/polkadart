/* part of hashers_base;

class HasherHelper {
  final Hasher? hasher;
  final bool concat;

  /* const HasherHelper._(this.hasher, this.concat)
      : assert(hasher != null || concat == true); */

  const HasherHelper.identity()
      : hasher = null,
        concat = true;

  const HasherHelper.blake2b128()
      : hasher = Hasher.blake2b128,
        concat = false;

  const HasherHelper.blake2b128Concat()
      : hasher = Hasher.blake2b128,
        concat = true;

  const HasherHelper.blake2b256()
      : hasher = Hasher.blake2b256,
        concat = false;

  const HasherHelper.twoxx64()
      : hasher = Hasher.twoxx64,
        concat = false;

  const HasherHelper.twoxx64Concat()
      : hasher = Hasher.twoxx64,
        concat = true;

  const HasherHelper.twoxx128()
      : hasher = Hasher.twoxx128,
        concat = false;

  const HasherHelper.twoxx128Concat()
      : hasher = Hasher.twoxx128,
        concat = true;

  const HasherHelper.twoxx256()
      : hasher = Hasher.twoxx256,
        concat = false;

  const HasherHelper.twoxx256Concat()
      : hasher = Hasher.twoxx256,
        concat = true;

  int size(Uint8List bytes) {
    int size = hasher?.digestSize ?? 0;
    if (concat) {
      size += bytes.length;
    }
    return size;
  }

  void hashTo({required Uint8List bytes, required Uint8List output}) {
    final int offset = hasher?.digestSize ?? 0;
    if (hasher != null) {
      hasher!.hashTo(data: bytes, output: output);
    }
    if (concat) {
      for (int i = 0; i < bytes.length; i++) {
        output[i + offset] = bytes[i];
      }
    }
  }

  Uint8List hash(Uint8List bytes) {
    final Uint8List output = Uint8List(size(bytes));
    hashTo(bytes: bytes, output: output);
    return output;
  }
}
 */
