part of core;

mixin Codec<E> {
  E decode(Input input);

  /// Convert self to a slice and append it to the destination.
  void encodeTo(E element, Output output);

  /// If possible give a hint of expected size of the encoding.
  ///
  /// This method is used inside default implementation of `encode`
  /// to avoid re-allocations.
  int sizeHint(E element) {
    final sizeTracker = SizeTracker();
    encodeTo(element, sizeTracker);
    return sizeTracker.size;
  }

  /// Convert self to an owned vector.
  Uint8List encode(E element) {
    final bytes = ByteOutput(sizeHint(element));
    encodeTo(element, bytes);
    return bytes.buffer.toBytes();
  }
}
