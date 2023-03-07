part of io;

class HexOutput with Output {
  late final StringBuffer _buffer;

  HexOutput() : _buffer = StringBuffer('0x');

  @override
  void pushByte(int byte) {
    _buffer.write(byte.toRadixString(16).padLeft(2, '0'));
  }

  @override
  void write(List<int> bytes) {
    _buffer
        .writeAll(bytes.map((byte) => byte.toRadixString(16).padLeft(2, '0')));
  }

  ///
  /// Return current hex buffer
  @override
  String toString() {
    return _buffer.toString();
  }
}
