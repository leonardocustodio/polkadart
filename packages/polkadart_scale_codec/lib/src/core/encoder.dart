part of polkadart_scale_codec_core;

///
/// Abstract class to laydown the defined set of instructions when making a [HexEncoder]
abstract class ScaleCodecEncoder {
  /// process and append the byte to the data
  void write(int byte);

  /// append the list of bytes to the data.
  void bytes(List<int> b);

  void _uncheckedU16(int value) {
    write(value & 0xff);
    write(value >>> 8);
  }

  void _uncheckedU32(int value) {
    write(value & 0xff);
    write((value >>> 8) & 0xff);
    write((value >>> 16) & 0xff);
    write(value >>> 24);
  }

  void _uncheckedU64(BigInt value) {
    _uncheckedU32((value & '0xffffffff'.toBigInt).toInt());
    _uncheckedU32((value >> 32.toBigInt.toInt()).toInt());
  }

  void _uncheckedU128(BigInt value) {
    _uncheckedU64(value & '0xffffffffffffffff'.toBigInt);
    _uncheckedU64(value >> 64.toBigInt.toInt());
  }

  void _uncheckedU256(BigInt value) {
    _uncheckedU128(value & calculateBigIntPow(2, 128) - 1.toBigInt);
    _uncheckedU128(value >> 128.toBigInt.toInt());
  }

  void u8(int value) {
    checkUnsignedInt(value, 8);
    write(value);
  }

  void u16(int value) {
    checkUnsignedInt(value, 16);
    _uncheckedU16(value);
  }

  void u32(int value) {
    checkUnsignedInt(value, 32);
    _uncheckedU32(value);
  }

  void u64(BigInt value) {
    checkUnsignedBigInt(value, 64);
    _uncheckedU64(value);
  }

  void u128(BigInt value) {
    checkUnsignedBigInt(value, 128);
    _uncheckedU128(value);
  }

  void u256(BigInt value) {
    checkUnsignedBigInt(value, 256);
    _uncheckedU256(value);
  }

  void i8(int value) {
    checkSignedInt(value, 8);
    write((value + 256) % 256);
  }

  void i16(int value) {
    checkSignedInt(value, 16);
    int base = pow(2, 16).toInt();
    value = (value + base) % base;
    _uncheckedU16(value);
  }

  void i32(int value) {
    checkSignedInt(value, 32);
    int base = pow(2, 32).toInt();
    value = (value + base) % base;
    _uncheckedU32(value);
  }

  void i64(BigInt value) {
    checkSignedBigInt(value, 64);
    BigInt base = calculateBigIntPow(2, 64);
    value = (value + base) % base;
    _uncheckedU64(value);
  }

  void i128(BigInt value) {
    checkSignedBigInt(value, 128);
    BigInt base = calculateBigIntPow(2, 128);
    value = (value + base) % base;
    _uncheckedU128(value);
  }

  void i256(BigInt value) {
    checkSignedBigInt(value, 256);
    BigInt base = calculateBigIntPow(2, 256);
    value = (value + base) % base;
    _uncheckedU256(value);
  }

  /// Encode and write string value to the data.
  void str(String value) {
    List<int> encodedBytes = utf8Encoder(value);
    compact(encodedBytes.length);
    bytes(encodedBytes);
  }

  /// write boolean value to data as `int`.
  void boolean(dynamic value) {
    assertionCheck(
        value is bool, 'bool can have input as \'true\' or \'false\'.');
    write(value ? 1 : 0);
  }

  /// `dyanmic value`: (int or BigInt)
  ///
  /// ```
  /// throw UnexpectedTypeException: when (value is not either (int or BigInt))
  /// throw InvalidCompactException: when (value < 0) || (value > calculateBigIntPow(2, 536))
  /// ```
  void compact(dynamic value) {
    if (value is int) {
      if (value < 0) {
        throw IncompatibleCompactException('Value can\'t be less than 0.');
      }
      _compactFromInt(value);
      return;
    } else if (value is BigInt) {
      if (value.toInt() < 0) {
        throw IncompatibleCompactException('Value can\'t be less than 0.');
      }
      _compactFromBigInt(value);
      return;
    } else {
      throw UnexpectedTypeException(
        expectedType: '`int` or `BigInt`',
        receivedType: value.runtimeType.toString(),
      );
    }
  }

  /// Compact the integer value and write it to buffer data.
  ///
  /// Throws `IncompatibleCompactException` when value > calculateBigIntPow(2, 536)
  void _compactFromInt(int value) {
    if (value < 64) {
      write(value * 4);
    } else if (value < pow(2, 14).toInt()) {
      write((value & 63) * 4 + 1);
      write(value >>> 6);
    } else if (value < pow(2, 30).toInt()) {
      write((value & 63) * 4 + 2);
      write((value >>> 6) & 0xff);
      _uncheckedU16(value >>> 14);
    } else if (value < calculateBigIntPow(2, 536).toInt()) {
      final bigIntValue = BigInt.from(value);
      write(unsignedIntByteLength(bigIntValue) * 4 - 13);
      while (value > 0) {
        write(value & '0xff'.toBigInt.toInt());
        value = value >> 8.toBigInt.toInt();
      }
    } else {
      throw IncompatibleCompactException('$value is too large for a compact.');
    }
  }

  /// Compact the BigInt value and write it to buffer data.
  ///
  /// Throws `IncompatibleCompactException` when value > calculateBigIntPow(2, 536)
  void _compactFromBigInt(BigInt bigIntValue) {
    final value = bigIntValue.toInt();
    if (value < 64) {
      write(value * 4);
    } else if (value < pow(2, 14).toInt()) {
      write((value & 63) * 4 + 1);
      write(value >>> 6);
    } else if (value < pow(2, 30).toInt()) {
      write((value & 63) * 4 + 2);
      write((value >>> 6) & 0xff);
      _uncheckedU16(value >>> 14);
    } else if (bigIntValue < calculateBigIntPow(2, 536)) {
      BigInt copiedValue = bigIntValue;
      write(unsignedIntByteLength(copiedValue) * 4 - 13);
      while (copiedValue.toInt() > 0) {
        write((copiedValue & BigInt.parse('0xff')).toInt());
        copiedValue = copiedValue >> 8.toBigInt.toInt();
      }
    } else {
      throw IncompatibleCompactException(
          '$bigIntValue is too large for a compact.');
    }
  }
}

/// `HexEncoder` to write the bytes and parallely write the result as Hex.
class HexEncoder extends ScaleCodecEncoder {
  String _hex = '0x';

  @override
  void write(int byte) {
    _hex += (byte >>> 4).toRadixString(16);
    _hex += (byte & 15).toRadixString(16);
  }

  @override
  void bytes(List<int> b) {
    _hex += encodeHex(b).replaceFirst(RegExp(r'0x'), '');
  }

  /// Return current hex data
  String toHex() {
    return _hex;
  }
}

/// `ByteEncoder` to process and write the bytes
class ByteEncoder extends ScaleCodecEncoder {
  Uint8List _data = Uint8List(128);
  int _pos = 0;

  void _alloc(int size) {
    if (_data.length - _pos < size) {
      Uint8List newData = Uint8List(max(size, _data.length) * 2);
      newData.setAll(0, _data);
      _data = newData;
    }
  }

  @override
  void write(int byte) {
    _alloc(1);
    _data[_pos] = byte;
    _pos += 1;
  }

  @override
  void bytes(List<int> b) {
    _alloc(b.length);
    _data.setAll(_pos, b);
    _pos += b.length;
  }

  Uint8List toBytes() {
    return _data.sublist(0, _pos);
  }
}
