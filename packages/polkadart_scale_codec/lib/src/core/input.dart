part of core;

class Input {
  ///
  /// Current index of the buffer
  int currentIndex = 0;

  ///
  /// Buffer to be decoded
  late Uint8List buffer;

  ///
  /// Input(buffer_to_decode)
  ///
  /// Example:
  /// ```dart
  /// final input = Input('0x010203');
  /// print(input.buffer); // [1, 2, 3]
  /// ```
  Input(String buffer) {
    this.buffer = decodeHex(buffer);
  }

  ///
  /// Input.fromBytes(buffer_to_decode)
  ///
  /// Example:
  /// ```dart
  /// final input = Input.fromBytes([1, 2, 3]);
  /// ```
  Input.fromBytes(List<int> buffer) {
    this.buffer = Uint8List.fromList(buffer);
  }

  ///
  /// Get the length of the buffer
  int get length => buffer.length;

  ///
  /// Get the remaining length of the buffer
  int get remainingLength => buffer.length - currentIndex;

  ///
  /// Get the byte at the current index
  /// and increment the index by 1
  ///
  /// Example:
  /// ```dart
  /// final input = Input('0x010203');
  /// print(input.byte()); // 1
  /// print(input.byte()); // 2
  /// print(input.byte()); // 3
  /// ```
  int byte() {
    late int b;
    if (currentIndex >= buffer.length) {
      throw EOFException();
    }
    b = buffer[currentIndex];
    currentIndex += 1;
    return b;
  }

  ///
  /// Get the bytes from the current index to the length
  ///
  /// Example:
  /// ```dart
  /// final input = Input('0x010203');
  /// print(input.bytes(3)); // [1, 2, 3]
  /// ```
  Uint8List bytes(int length) {
    final beg = currentIndex;
    final end = currentIndex += length;
    if (buffer.length < end) {
      throw EOFException();
    }
    return buffer.sublist(beg, end);
  }

  ///
  /// returns true if there are bytes left to be read
  ///
  /// Example:
  /// ```dart
  /// final input = Input('0x010203');
  ///
  /// print(input.hasBytes()); // true
  ///
  /// // reading all the bytes
  /// input.bytes(3);
  ///
  /// // no more bytes left
  /// print(input.hasBytes()); // false
  /// ```
  bool hasBytes() {
    return buffer.length > currentIndex;
  }
}