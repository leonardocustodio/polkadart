part of io;

/// Allows writing of data.
mixin Output {
  static ByteOutput byteOutput() => ByteOutput(10);

  /// Write to the output.
  void write(List<int> bytes);

  /// Write a single byte to the output.
  void pushByte(int byte) {
    write(Uint8List.fromList([byte]));
  }
}
