part of io;

/// Trait that allows reading of data into a slice.
class ByteInput with Input {
  ByteInput(Uint8List buffer) {
    _buffer = buffer;
  }

  ByteInput.fromList(List<int> buffer) {
    _buffer = Uint8List.fromList(buffer);
  }

  @override
  int read() {
    return _buffer[offset++];
  }

  @override
  UnmodifiableUint8ListView readBytes(int length) {
    if (offset + length > _buffer.length) {
      throw Exception('Not enough bytes to read');
    }
    final bytes = _buffer.sublist(offset, offset + length);
    offset += length;
    return UnmodifiableUint8ListView(bytes);
  }

  /// clone
  @override
  ByteInput clone() {
    return ByteInput(_buffer);
  }
}
