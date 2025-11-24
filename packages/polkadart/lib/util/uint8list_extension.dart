import 'dart:typed_data' show Uint8List;

extension Uint8ListExtension on Uint8List {
  int compareBytes(final Uint8List other) {
    final minLength = length < other.length ? length : other.length;

    for (int i = 0; i < minLength; i++) {
      if (this[i] != other[i]) {
        return this[i] < other[i] ? -1 : 1;
      }
    }

    if (length != other.length) {
      return length < other.length ? -1 : 1;
    }

    return 0;
  }

  bool equals(final Uint8List other) {
    return compareBytes(other) == 0;
  }
}
