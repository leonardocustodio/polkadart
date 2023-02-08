part of io;

/// Trait that allows reading of data into a slice.
class Uint8ListInput with Input {
  late Uint8List _buffer;
  int offset = 0;

  Uint8ListInput(Uint8List buffer) {
    _buffer = buffer;
  }

  Uint8ListInput.fromList(List<int> buffer) {
    _buffer = Uint8List.fromList(buffer);
  }

  @override
  int remainingLen() {
    return _buffer.lengthInBytes - offset;
  }

  @override
  int read() {
    return _buffer[offset++];
  }

  @override
  UnmodifiableUint8ListView readBytes(int len) {
    final bytes = _buffer.sublist(offset, offset + len);
    offset += len;
    return UnmodifiableUint8ListView(bytes);
  }
}
