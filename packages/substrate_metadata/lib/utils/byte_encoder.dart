import 'dart:math';
import 'dart:typed_data';

import 'package:polkadart_scale_codec/polkadart_scale_codec.dart';

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
