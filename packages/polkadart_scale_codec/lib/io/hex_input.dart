part of io;

class HexInput with Input {
  HexInput(String hex) {
    _buffer = decodeHex(hex);
  }

  @override
  int read() {
    return _buffer[offset++];
  }

  @override
  UnmodifiableUint8ListView readBytes(int length) {
    final bytes = _buffer.sublist(offset, offset + length);
    offset += length;
    return UnmodifiableUint8ListView(bytes);
  }
}
