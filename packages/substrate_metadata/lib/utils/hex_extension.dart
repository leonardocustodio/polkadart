part of utils;

extension ListExtension on Uint8List {
  // Convert Uint8List to Hexadecimal String
  String toHexString() {
    return '0x${encodeHex(this)}';
  }

  Input toInput() {
    return Input.fromBytes(toList());
  }
}

extension ListIntExtension on List<int> {
  String toHexString() {
    return '0x${encodeHex(this)}';
  }

  Input toInput() {
    return Input.fromBytes(this);
  }
}
