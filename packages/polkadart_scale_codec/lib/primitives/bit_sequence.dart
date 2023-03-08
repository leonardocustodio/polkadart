part of primitives;

///
/// Defines the BitArray memory model used to interface bit-slice regions to raw memory,
/// and manage type-state changes as demanded by the region descriptor.
/// Reference: https://github.com/ferrilab/bitvec/blob/v0/22/3/src/store.rs#L307-L316
enum BitStore {
  U8(1),
  U16(2),
  U32(4),
  U64(8);

  final int byteSize;

  const BitStore(this.byteSize);

  //
  // Calculate the number of bytes required to store the given number of bits
  int calculateByteSize(int bitCount) {
    return ((bitCount + (byteSize * 8) - 1) ~/ (byteSize * 8)) * byteSize;
  }
}

///
/// In-Element Bit Ordering
/// The BitOrder bridges semantic indices to electrical position counters or
/// selection masks (marked by the BitSel and BitMask types).
/// Reference: https://github.com/ferrilab/bitvec/blob/v0/22/3/src/order.rs#L358-L377
enum BitOrder {
  MSB,
  LSB,
}

///
/// A codec representing a sequence of bits.
class BitSequenceCodec with Codec<BitArray> {
  final BitStore bitStore;
  final BitOrder bitOrder;

  const BitSequenceCodec(this.bitStore, this.bitOrder);

  void _encodeMSB(BitArray bitArray, Output dest) {
    final elementCount =
        bitStore.calculateByteSize(bitArray.length) ~/ bitStore.byteSize;
    final bitsPerElement = bitStore.byteSize * 8;

    for (var i = 0; i < elementCount; i++) {
      BigInt element = BigInt.zero;
      for (var j = 0; j < bitsPerElement; j++) {
        final index = i * bitsPerElement + j;
        if (index >= bitArray.length) {
          break;
        }
        if (bitArray[index]) {
          element |= BigInt.one << (bitsPerElement - j - 1);
        }
      }
      for (var j = 0; j < bitStore.byteSize; j++) {
        dest.pushByte((element >> (j * 8)).toUnsigned(8).toInt());
      }
    }
  }

  BitArray _decodeMSB(Input input) {
    final bitArray = BitArray(CompactCodec.codec.decode(input));
    final elementCount =
        bitStore.calculateByteSize(bitArray.length) ~/ bitStore.byteSize;
    final bitsPerElement = bitStore.byteSize * 8;

    for (var elementIndex = 0; elementIndex < elementCount; elementIndex++) {
      BigInt element = BigInt.zero;
      for (var j = 0; j < bitStore.byteSize; j++) {
        element |= BigInt.from(input.read()) << (j * 8);
      }
      for (var bitIndex = 0; bitIndex < bitsPerElement; bitIndex++) {
        final index = (elementIndex * bitsPerElement) + bitIndex;
        if (index >= bitArray.length) {
          break;
        }
        if (element & (BigInt.one << ((bitsPerElement - 1) - bitIndex)) >
            BigInt.zero) {
          bitArray.setBit(index);
        }
      }
    }
    return bitArray;
  }

  void _encodeLSB(BitArray bitArray, Output dest) {
    final elementCount =
        bitStore.calculateByteSize(bitArray.length) ~/ bitStore.byteSize;
    final bitsPerElement = bitStore.byteSize * 8;

    for (var i = 0; i < elementCount; i++) {
      BigInt element = BigInt.zero;
      for (var j = 0; j < bitsPerElement; j++) {
        final index = i * bitsPerElement + j;
        if (index >= bitArray.length) {
          break;
        }
        if (bitArray[index]) {
          element |= BigInt.one << j;
        }
      }
      for (var j = 0; j < bitStore.byteSize; j++) {
        dest.pushByte((element >> (j * 8)).toUnsigned(8).toInt());
      }
    }
  }

  BitArray _decodeLSB(Input input) {
    final bitArray = BitArray(CompactCodec.codec.decode(input));
    final sizeInBytes = bitStore.calculateByteSize(bitArray.length);
    for (var i = 0; i < sizeInBytes; i++) {
      final int byte = input.read();
      for (var j = 0; j < 8; j++) {
        if (byte & (1 << j) > 0) {
          bitArray.setBit(i * 8 + j);
        }
      }
    }
    return bitArray;
  }

  @override
  void encodeTo(BitArray value, Output output) {
    CompactCodec.codec.encodeTo(value.length, output);
    switch (bitOrder) {
      case BitOrder.MSB:
        _encodeMSB(value, output);
        break;
      case BitOrder.LSB:
        _encodeLSB(value, output);
    }
  }

  @override
  BitArray decode(Input input) {
    switch (bitOrder) {
      case BitOrder.MSB:
        return _decodeMSB(input);
      case BitOrder.LSB:
        return _decodeLSB(input);
    }
  }

  @override
  int sizeHint(BitArray value) {
    int size = CompactCodec.codec.sizeHint(value.length);
    size += bitStore.calculateByteSize(value.length);
    return size;
  }
}

int _bitMask(int index, {int bitSize = 32, bool lsbOrder = false}) {
  if (lsbOrder) {
    return 1 << (bitSize - 1 - (index % bitSize));
  }
  return 1 << (index % bitSize);
}

///
/// Bit array to store bits.
class BitArray {
  Uint32List _data;
  int _length;

  BitArray._(this._length, this._data);

  ///
  /// Creates a bit array with maximum [length] items.
  factory BitArray(int length) =>
      BitArray._(length, Uint32List((length + 31) >> 5));

  ///
  /// Creates a bit array using a byte buffer.
  factory BitArray.fromByteBuffer(int length, ByteBuffer buffer) {
    final data = buffer.asUint32List();
    return BitArray._(length, data);
  }

  ///
  /// Creates a bit array using a Uint8List.
  factory BitArray.fromUint8List(int length, Uint8List list) {
    if (list.lengthInBytes % 4 != 0) {
      throw FormatException('Uint8List length must be a multiplication of 4');
    }
    final data =
        list.buffer.asUint32List(list.offsetInBytes, list.lengthInBytes >> 2);
    return BitArray._(length, data);
  }

  ///
  /// Create a bit array from a binary string.
  factory BitArray.parseBinary(String bitString) {
    final data = Uint32List((bitString.length + 31) >> 5);
    for (var i = 0; i < bitString.length; i++) {
      if (bitString[i] == '1') {
        data[i >> 5] |= _bitMask(i);
      } else if (bitString[i] != '0') {
        throw FormatException('Binary string should consist of 0s and 1s only');
      }
    }
    return BitArray._(bitString.length, data);
  }

  ///
  /// The value of the bit with the specified [index].
  bool operator [](int index) {
    return (_data[index >> 5] & _bitMask(index)) != 0;
  }

  ///
  /// Sets the bit specified by the [index] to the [value].
  void operator []=(int index, bool value) {
    if (value) {
      setBit(index);
    } else {
      clearBit(index);
    }
  }

  ///
  /// The number of bit in this [BitArray].
  ///
  /// [length] will be rounded up to match the 32-bit boundary.
  ///
  /// The valid index values for the array are `0` through `length - 1`.
  int get length => _length;

  ///
  /// Whether the [BitArray] is empty == has only zero values.
  bool get isEmpty {
    return _data.every((i) => i == 0);
  }

  ///
  /// Whether the [BitArray] is not empty == has set values.
  bool get isNotEmpty {
    return _data.any((i) => i != 0);
  }

  ///
  /// Sets the bit specified by the [index] to false.
  void clearBit(int index) {
    _data[index >> 5] &= (~_bitMask(index)).toUnsigned(32);
  }

  ///
  /// Sets the bits specified by the [indexes] to false.
  void clearBits(Iterable<int> indexes) {
    indexes.forEach(clearBit);
  }

  ///
  /// Sets all of the bits in the current [BitArray] to false.
  void clearAll() {
    for (var i = 0; i < _data.length; i++) {
      _data[i] = 0;
    }
  }

  /// Sets the bit specified by the [index] to true.
  void setBit(int index) {
    _data[index >> 5] |= _bitMask(index);
  }

  ///
  /// Sets the bits specified by the [indexes] to true.
  void setBits(Iterable<int> indexes) {
    indexes.forEach(setBit);
  }

  ///
  /// Sets all the bit values in the current [BitArray] to true.
  void setAll() {
    for (var i = 0; i < _data.length; i++) {
      _data[i] = -1;
    }
  }

  ///
  /// Inverts the bit specified by the [index].
  void invertBit(int index) {
    this[index] = !this[index];
  }

  /// Inverts the bits specified by the [indexes].
  void invertBits(Iterable<int> indexes) {
    indexes.forEach(invertBit);
  }

  ///
  /// Inverts all the bit values in the current [BitArray].
  void invertAll() {
    for (var i = 0; i < _data.length; i++) {
      _data[i] = ~(_data[i]);
    }
  }

  ///
  /// Creates a copy of the current [BitArray].
  BitArray clone() {
    final newData = Uint32List(_data.length);
    newData.setRange(0, _data.length, _data);
    return BitArray._(_length, newData);
  }

  ///
  /// Creates a string of 0s and 1s of the content of the array.
  String toBinaryString() {
    final sb = StringBuffer();
    for (var i = 0; i < length; i++) {
      sb.write(this[i] ? '1' : '0');
    }
    return sb.toString();
  }

  @override
  String toString() {
    final data = toBinaryString();
    return 'BitArray(length: $length, data: $data)';
  }

  ///
  /// The backing, mutable byte buffer of the [BitArray].
  /// Use with caution.
  ByteBuffer get byteBuffer => _data.buffer;

  ///
  /// Returns an iterable wrapper of the bit array that iterates over the index
  /// numbers and returns the 32-bit int blocks.
  Iterable<int> asUint32Iterable() => _data;

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (other is BitArray &&
        runtimeType == other.runtimeType &&
        length == other.length) {
      final iter = asUint32Iterable().iterator;
      final otherIter = other.asUint32Iterable().iterator;
      while (iter.moveNext() && otherIter.moveNext()) {
        if (iter.current != otherIter.current) {
          return false;
        }
      }
      return true;
    }
    return false;
  }

  @override
  int get hashCode =>
      asUint32Iterable().fold(
          0, (int previousValue, element) => previousValue ^ element.hashCode) ^
      length.hashCode;

  List<int> toJson() {
    final list = <int>[];
    for (var i = 0; i < length; i++) {
      list.add(this[i] ? 1 : 0);
    }
    return list;
  }
}
