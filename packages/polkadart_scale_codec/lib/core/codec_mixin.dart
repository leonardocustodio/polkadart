part of core;

mixin Codec<E> {
  E decode(Input input);

  /// Convert self to a slice and append it to the destination.
  void encodeTo(E value, Output output);

  /// If possible give a hint of expected size of the encoding.
  ///
  /// This method is used inside default implementation of `encode`
  /// to avoid re-allocations.
  int sizeHint(E value) {
    final sizeTracker = SizeTracker();
    encodeTo(value, sizeTracker);
    return sizeTracker.size;
  }

  /// Convert self to an owned vector.
  Uint8List encode(E value) {
    final bytes = ByteOutput();
    encodeTo(value, bytes);
    return bytes.toBytes();
  }
}
