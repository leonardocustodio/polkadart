part of io;

/// Default writing of data.
class ByteOutput with Output {
  final Uint8Buffer _buffer;
  int cursor = 0;

  /// Construct a new empty [ByteOutput].
  ///
  /// If [copy] is true (the default), the created builder is a *copying*
  /// builder. A copying builder maintains its own internal buffer and copies
  /// the bytes added to it eagerly.
  ///
  /// If [copy] set to false, the created builder assumes that lists added
  /// to it will not change.
  ByteOutput([int initialLength = 1024]) : _buffer = Uint8Buffer(initialLength);

  Uint8List toBytes({copy = true}) {
    final bytes = _buffer.buffer.asUint8List(0, cursor);
    if (copy) {
      return bytes.sublist(0);
    } else {
      return bytes;
    }
  }

  String toHex() {
    return encodeHex(toBytes(copy: false));
  }

  @override
  void write(List<int> bytes) {
    if (_buffer.length - cursor < bytes.length) {
      _buffer.insertAll(cursor, bytes);
    } else {
      _buffer.setRange(cursor, cursor + bytes.length, bytes);
    }
    cursor += bytes.length;
  }

  @override
  void pushByte(int byte) {
    if (cursor >= _buffer.length) {
      _buffer.add(byte);
      cursor++;
      return;
    }
    _buffer[cursor++] = byte;
  }

  int get length => cursor;
}
