import 'dart:math';
import 'dart:typed_data';
import 'package:polkadart_scale_codec/src/util/exceptions.dart';

import '../util/utils.dart';

abstract class Sink {
  void write(int byte);

  void bytes(Uint8List b);

  void _uncheckedU16(int val) {
    write(val & 0xff);
    write(val >>> 8);
  }

  void _uncheckedU32(int val) {
    write(val & 0xff);
    write((val >>> 8) & 0xff);
    write((val >>> 16) & 0xff);
    write(val >>> 24);
  }

  void _uncheckedU64(BigInt val) {
    _uncheckedU32((val & '0xffffffff'.bigInt).toInt());
    _uncheckedU32((val >> 32.bigInt.toInt()).toInt());
  }

  void _uncheckedU128(BigInt val) {
    _uncheckedU64(val & '0xffffffffffffffff'.bigInt);
    _uncheckedU64(val >> 64.bigInt.toInt());
  }

  void _uncheckedU256(BigInt val) {
    _uncheckedU128(val & calculateBigIntPow(2, 128) - 1.bigInt);
    _uncheckedU128(val >> 128.bigInt.toInt());
  }

  void u8(int val) {
    checkUnsignedInt(val, 8);
    write(val);
  }

  void u16(int val) {
    checkUnsignedInt(val, 16);
    _uncheckedU16(val);
  }

  void u32(int val) {
    checkUnsignedInt(val, 32);
    _uncheckedU32(val);
  }

  void u64(BigInt val) {
    checkUnsignedBigInt(val, 64);
    _uncheckedU64(val);
  }

  void u128(BigInt val) {
    checkUnsignedBigInt(val, 128);
    _uncheckedU128(val);
  }

  void u256(BigInt val) {
    checkUnsignedBigInt(val, 256);
    _uncheckedU256(val);
  }

  void i8(int val) {
    checkSignedInt(val, 8);
    write((val + 256) % 256);
  }

  void i16(int val) {
    checkSignedInt(val, 16);
    int base = pow(2, 16).toInt();
    val = (val + base) % base;
    _uncheckedU16(val);
  }

  void i32(int val) {
    checkSignedInt(val, 32);
    int base = pow(2, 32).toInt();
    val = (val + base) % base;
    _uncheckedU32(val);
  }

  void i64(BigInt val) {
    checkSignedBigInt(val, 64);
    BigInt base = calculateBigIntPow(2, 64);
    val = (val + base) % base;
    _uncheckedU64(val);
  }

  void i128(BigInt val) {
    checkSignedBigInt(val, 128);
    BigInt base = calculateBigIntPow(2, 128);
    val = (val + base) % base;
    _uncheckedU128(val);
  }

  void i256(BigInt val) {
    checkSignedBigInt(val, 256);
    BigInt base = calculateBigIntPow(2, 256);
    val = (val + base) % base;
    _uncheckedU256(val);
  }

  void str(String val) {
    List<int> encodedBytes = utf8Encoder(val);
    compact(encodedBytes.length);
    bytes(Uint8List.fromList(encodedBytes));
  }

  void boolean(bool val) {
    write(val ? 1 : 0);
  }

  ///
  /// `dyanmic val`: (int or BigInt)
  ///
  /// ```
  /// throw UnexpectedTypeException: when (val is not either (int or BigInt))
  /// throw InvalidCompactException: when (val < 0)
  /// ```
  void compact(dynamic val) {
    if (val is int) {
      if (val < 0) {
        throw InvalidCompactException();
      }

      _compactFromInt(val);
      return;
    } else if (val is BigInt) {
      if (val.toInt() < 0) {
        throw InvalidCompactException();
      }
      _compactFromBigInt(val);
      return;
    } else {
      throw UnexpectedTypeException(
          'Expected `int` or `BigInt`, but found ${val.runtimeType}');
    }
  }

  void _compactFromBigInt(BigInt value) {
    if (value.toInt() < 64) {
      write(value.toInt() * 4);
    } else if (value.toInt() < pow(2, 14).toInt()) {
      int val = value.toInt();
      write((val.toInt() & 63) * 4 + 1);
      write(val >>> 6);
    } else if (value.toInt() < pow(2, 30).toInt()) {
      int val = value.toInt();
      write((val & 63) * 4 + 2);
      write((val >>> 6) & 0xff);
      _uncheckedU16(val.toInt() >>> 14);
    } else if (value.toInt() < 2.bigInt.pow(536.bigInt.toInt()).toInt()) {
      BigInt val = value;
      write(unsignedIntByteLength(val) * 4 - 13);
      while (val.toInt() > 0) {
        write(val.toInt() & '0xff'.bigInt.toInt());
        val = val >> 8.bigInt.toInt();
      }
    } else {
      throw IncompatibleCompactException(value.toRadixString(16));
    }
  }

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
    } else if (value < 2.bigInt.pow(536.bigInt.toInt()).toInt()) {
      final val = BigInt.from(value);
      write(unsignedIntByteLength(val) * 4 - 13);
      while (value > 0) {
        write(value & '0xff'.bigInt.toInt());
        value = value >> 8.bigInt.toInt();
      }
    } else {
      throw IncompatibleCompactException(value.toRadixString(16));
    }
  }
}

class HexSink extends Sink {
  String _hex = '0x';

  @override
  void write(int byte) {
    _hex += (byte >>> 4).toRadixString(16);
    _hex += (byte & 15).toRadixString(16);
  }

  @override
  void bytes(Uint8List b) {
    _hex += utf8Decoder(b);
  }

  String toHex() {
    return _hex;
  }
}

class ByteSink extends Sink {
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
  void bytes(Uint8List b) {
    _alloc(b.length);
    _data.setAll(_pos, b);
    _pos += b.length;
  }

  Uint8List toBytes() {
    return _data.sublist(0, _pos);
  }
}
