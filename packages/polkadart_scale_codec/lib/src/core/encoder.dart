part of core;

///
/// mixin to laydown the foundation defined set of instructions when making a [HexEncoder] or [ByteEncoder]
mixin Encoder {
  ///
  /// append single byte to the input
  void write(int byte);

  ///
  /// append the list of bytes to the input.
  void bytes(List<int> bytes);
}

///
/// `HexEncoder` to write the bytes and parallely write the result as Hex.
class HexEncoder with Encoder {
  late final StringBuffer _buffer;

  HexEncoder() : _buffer = StringBuffer('0x');

  @override
  void write(int byte) {
    _buffer.write(byte.toRadixString(16).padLeft(2, '0'));
  }

  @override
  void bytes(List<int> bytes) {
    _buffer
        .writeAll(bytes.map((byte) => byte.toRadixString(16).padLeft(2, '0')));
  }

  ///
  /// Return current hex buffer
  String toHex() {
    return _buffer.toString();
  }
}

///
/// `ByteEncoder` to process and write the bytes
class ByteEncoder with Encoder {
  late final BytesBuilder _buffer;

  ByteEncoder() : _buffer = BytesBuilder();

  @override
  void write(int byte) {
    _buffer.addByte(byte);
  }

  @override
  void bytes(List<int> bytes) {
    _buffer.add(bytes);
  }

  ///
  /// Returns a copy of the bytes
  Uint8List toBytes() {
    return _buffer.toBytes();
  }

  ///
  /// Returns the bytes and clears the buffer
  Uint8List takeBytes() {
    return _buffer.takeBytes();
  }
}
