part of polkadart_scale_codec_core;

class Source {
  int _idx = 0;
  late Uint8List _data;

  Source(dynamic data) {
    assertionCheck(data is String || data is List<int> || data is Uint8List,
        'Source(data) -> `data` should be either String, List<int> or Uint8List.');
    if (data is String) {
      _data = decodeHex(data);
    } else {
      _data = data is Uint8List ? data : Uint8List.fromList(data);
    }
  }

  int _byte() {
    late int b;
    if (_idx >= _data.length) {
      throw EOFException();
    }
    b = _data[_idx];
    _idx += 1;
    return b;
  }

  int i8() {
    var b = _byte();
    return (b | (b & (pow(2, 7) as int)) * 0x1fffffe).toSigned(16);
  }

  int u8() {
    return _byte();
  }

  int i16() {
    var value = u16();
    return (value | (value & (pow(2, 15) as int)) * 0x1fffe).toSigned(16);
  }

  int u16() {
    var first = _byte();
    var last = _byte();
    return first + last * (pow(2, 8) as int);
  }

  int i32() {
    return _byte() +
        _byte() * (pow(2, 8) as int) +
        _byte() * (pow(2, 16) as int) +
        (_byte() << 24).toSigned(32);
  }

  int u32() {
    return _byte() +
        _byte() * (pow(2, 8) as int) +
        _byte() * (pow(2, 16) as int) +
        _byte() * (pow(2, 24) as int);
  }

  BigInt i64() {
    var lo = u32();
    var hi = i32();
    return BigInt.from(lo) + (BigInt.from(hi) << 32);
  }

  BigInt u64() {
    var lo = u32();
    var hi = u32();
    return BigInt.from(lo) + (BigInt.from(hi) << 32);
  }

  BigInt i128() {
    var lo = u64();
    var hi = i64();
    return lo + (hi << 64);
  }

  BigInt u128() {
    var lo = u64();
    var hi = u64();
    return lo + (hi << 64);
  }

  BigInt i256() {
    var lo = u128();
    var hi = i128();
    return lo + (hi << 128);
  }

  BigInt u256() {
    var lo = u128();
    var hi = u128();
    return lo + (hi << 128);
  }

  ///
  /// Returns: `BigInt` | `int`
  dynamic decodeCompact() {
    int b = _byte();
    var mode = b & 3;
    switch (mode) {
      case 0:
        return b >> 2;
      case 1:
        return (b >> 2) + _byte() * pow(2, 6);
      case 2:
        return (b >> 2) +
            _byte() * pow(2, 6) +
            _byte() * pow(2, 14) +
            _byte() * pow(2, 22);
      case 3:
        // returning BigInt here
        return _bigCompact(b >> 2);
    }
  }

  ///
  /// Returns: `BigInt` | `int`
  dynamic _bigCompact(num length) {
    var i = u32();
    switch (length) {
      case 0:
        return i;
      case 1:
        return i + _byte() * pow(2, 32);
      case 2:
        return i + _byte() * pow(2, 32) + _byte() * pow(2, 40);
    }
    var n = BigInt.from(i);
    var base = BigInt.from(32);
    while (length-- != 0) {
      n += BigInt.from(_byte()) << base.toInt();
      base += BigInt.from(8);
    }
    // returning [BigInt] here
    return n;
  }

  int compactLength() {
    var length = decodeCompact();
    assertionCheck(length is int);
    return length;
  }

  String str() {
    var length = compactLength();
    var buf = bytes(length);
    return utf8.decode(buf.toList());
  }

  Uint8List bytes(int length) {
    var beg = _idx;
    var end = _idx += length;
    if (_data.length < end) {
      throw EOFException();
    }
    return _data.sublist(beg, end);
  }

  bool boolean() {
    return _byte() != 0;
  }

  bool hasBytes() {
    return _data.length > _idx;
  }

  void assertEOF() {
    if (hasBytes()) {
      throw UnprocessedDataLeftException();
    }
  }
}
