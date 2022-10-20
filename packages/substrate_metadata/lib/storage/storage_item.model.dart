import 'dart:typed_data';

class StorageItem {
  List<String> hashers;
  List<int> keys;
  int value;

  /// "Optional" or "Default" or "Required"
  String modifier;
  Uint8List fallback;
  List<String>? docs;

  StorageItem({
    required this.hashers,
    required this.keys,
    required this.value,
    required this.modifier,
    required this.fallback,
    this.docs,
  });
}
