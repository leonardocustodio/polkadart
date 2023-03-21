part of io;

/// Trait that allows reading of data into a slice.
mixin Input {
  static ByteInput fromHex(String hex) => ByteInput(decodeHex(hex));

  static ByteInput fromBytes(List<int> bytes) => ByteInput.fromBytes(bytes);

  /// Should return the remaining length of the input data. If no information about the input
  /// length is available, `null` should be returned.
  ///
  /// The length is used to constrain the preallocation while decoding. Returning a garbage
  /// length can open the doors for a denial of service attack to your application.
  /// Otherwise, returning `null` can decrease the performance of your application.
  int? get remainingLength;

  ///
  /// Read a single byte from the input.
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
  int peekByte(int index);

  /// Gives a peek of the bytes[currentIndex, currentIndex + length]
  /// Does not increments the current index
  Uint8List peekBytes(int start, int length);

  ///
  /// Get the bytes from the current index to the length
  ///
  /// Example:
  /// ```dart
  /// final input = Input.fromHex('0x010203');
  /// print(input.readBytes(3)); // [1, 2, 3]
  /// ```
  UnmodifiableUint8ListView readBytes(int length);

  ///
  /// returns true if there are bytes left to be read
  ///
  /// Example:
  /// ```dart
  /// final input = Input.fromHex('0x010203');
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
    return remainingLength != null && remainingLength! > 0;
  }

  /// Clone the input
  Input clone();

  /// Get the hex string of the buffer
  String toHex() {
    return encodeHex(buffer);
  }

  Uint8List get buffer;

  void resetOffset();

  ///
  /// Asserts if the end of data is reached or not
  ///
  /// If the end of data is not reached, it throws an exception.
  void assertEndOfDataReached([String message = '']) {
    if (hasBytes()) {
      throw Exception(
          'End of data not reached. There are $remainingLength bytes left to be processed.$message');
    }
  }
}

/// Allows reading of data into.
class ByteInput with Input {
  final Uint8List _buffer;
  int offset = 0;

  ByteInput(this._buffer);

  factory ByteInput.fromBytes(List<int> bytes) {
    if (bytes is Uint8List) {
      return ByteInput(bytes);
    } else {
      return ByteInput(Uint8List.fromList(bytes));
    }
  }

  @override
  int read() {
    return _buffer[offset++];
  }

  @override
  UnmodifiableUint8ListView readBytes(int length) {
    if ((offset + length) > _buffer.length) {
      throw Exception('Not enough bytes to read');
    }
    final bytes =
        UnmodifiableUint8ListView(_buffer.buffer.asUint8List(offset, length));
    offset += length;
    return bytes;
  }

  /// clone
  @override
  ByteInput clone() {
    return ByteInput(_buffer.sublist(0));
  }

  @override
  int peekByte(int index) {
    return _buffer[offset];
  }

  @override
  void resetOffset() => offset = 0;

  @override
  Uint8List peekBytes(int start, int length) {
    return _buffer.sublist(start, start + length);
  }

  @override
  int? get remainingLength => _buffer.lengthInBytes - offset;

  @override
  Uint8List get buffer => _buffer.buffer.asUint8List(0);
}
