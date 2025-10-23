import 'dart:typed_data' show Uint8List;

import 'package:convert/convert.dart' show hex;

extension ListExtension on Uint8List {
  // Convert Uint8List to Hexadecimal String
  String toHexString() {
    return '0x${hex.encode(this)}';
  }
}

extension ListIntExtension on List<int> {
  String toHexString() {
    return '0x${hex.encode(this)}';
  }
}
