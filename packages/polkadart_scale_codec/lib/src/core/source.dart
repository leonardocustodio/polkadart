part of core;

class Source {
  ///
  /// Current index of the data
  int currentIndex = 0;

  ///
  /// Data to be decoded
  late Uint8List data;

  ///
  /// Source(data_to_decode)
  ///
  /// Example:
  /// ```dart
  /// final source = Source('0x010203');
  /// print(source.data); // [1, 2, 3]
  /// ```
  Source(String data) {
    this.data = decodeHex(data);
  }

  ///
  /// SourcefromBytes(data_to_decode)
  ///
  /// Example:
  /// ```dart
  /// final source = SourcefromBytes([1, 2, 3]);
  /// ```
  Source.fromBytes(List<int> data) {
    this.data = Uint8List.fromList(data);
  }

  ///
  /// Get the length of the data
  int get length => data.length;

  ///
  /// Get the remaining length of the data
  int get remainingLength => data.length - currentIndex;

  ///
  /// Get the byte at the current index
  /// and increment the index by 1
  ///
  /// Example:
  /// ```dart
  /// final source = Source('0x010203');
  /// print(source.byte()); // 1
  /// print(source.byte()); // 2
  /// print(source.byte()); // 3
  /// ```
  int byte() {
    late int b;
    if (currentIndex >= data.length) {
      throw EOFException();
    }
    b = data[currentIndex];
    currentIndex += 1;
    return b;
  }

  ///
  /// Get the bytes from the current index to the length
  ///
  /// Example:
  /// ```dart
  /// final source = Source('0x010203');
  /// print(source.bytes(3)); // [1, 2, 3]
  /// ```
  Uint8List bytes(int length) {
    final beg = currentIndex;
    final end = currentIndex += length;
    if (data.length < end) {
      throw EOFException();
    }
    return data.sublist(beg, end);
  }

  ///
  /// returns true if there are bytes left to be read
  ///
  /// Example:
  /// ```dart
  /// final source = Source('0x010203');
  ///
  /// print(source.hasBytes()); // true
  ///
  /// // reading all the bytes
  /// source.bytes(3);
  ///
  /// // no more bytes left
  /// print(source.hasBytes()); // false
  /// ```
  bool hasBytes() {
    return data.length > currentIndex;
  }
}
