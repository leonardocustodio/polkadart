part of io;

/// Trait that allows reading of data into a slice.
mixin Input {
  ///
  /// Current index of the buffer
  int offset = 0;

  ///
  /// Buffer to be decoded
  late Uint8List _buffer;

  ///
  /// Get the length of the buffer
  int get length => _buffer.length;

  ///
  /// Get the remaining length of the buffer
  int get remainingLength => _buffer.length - offset;

  ///
  /// Get the byte at the current index
  /// and increment the index by 1
  ///
  /// Example:
  /// ```dart
  /// final input = DefaultInput.fromHex('0x010203');
  /// print(input.read()); // 1
  /// print(input.read()); // 2
  /// print(input.read()); // 3
  /// ```
  int read();

  ///
  /// Gives a peek of the byte of current index and does not increments the current index
  int peekByte() {
    late int b;
    if (offset >= _buffer.length) {
      throw EOFException();
    }
    b = _buffer[offset];
    return b;
  }

  /// Gives a peek of the bytes[currentIndex, currentIndex + length]
  /// Does not increments the current index
  Uint8List peekBytes(int length) {
    final end = offset + length;
    if (_buffer.length < end) {
      throw EOFException();
    }
    return _buffer.sublist(offset, end);
  }

  ///
  /// Get the bytes from the current index to the length
  ///
  /// Example:
  /// ```dart
  /// final input = HexInput.fromHex('0x010203');
  /// print(input.readBytes(3)); // [1, 2, 3]
  /// ```
  UnmodifiableUint8ListView readBytes(int length);

  ///
  /// returns true if there are bytes left to be read
  ///
  /// Example:
  /// ```dart
  /// final input = HexInput.fromHex('0x010203');
  ///
  /// print(input.hasBytes()); // true
  ///
  /// // reading all the bytes
  /// input.readBytes(3);
  ///
  /// // no more bytes left
  /// print(input.hasBytes()); // false
  /// ```
  bool hasBytes() {
    return _buffer.length > offset;
  }
}
