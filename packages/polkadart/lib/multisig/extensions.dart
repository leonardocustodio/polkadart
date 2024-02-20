part of multisig;

extension StrinExtension on String {
  List<int> hexToListInt() {
    return hex.decode(this).toList();
  }

  Uint8List hexToUint8List() {
    return Uint8List.fromList(hex.decode(this).toList());
  }
}

extension Uint8ListExtension on Uint8List {
  String toHex() {
    return hex.encode(this);
  }
}

extension ListIntExtension on List<int> {
  Uint8List toUint8List() {
    return Uint8List.fromList(this);
  }

  String toHex() {
    return hex.encode(this);
  }
}
