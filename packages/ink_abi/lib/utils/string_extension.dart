part of ink_abi;

extension StringExtensionNull on String? {
  String? capitalize() {
    if (this == null) {
      return null;
    }
    if (this!.isEmpty) {
      return this;
    }
    if (this!.length == 1) {
      return this!.toUpperCase();
    }
    return '${this![0].toUpperCase()}${this!.substring(1)}';
  }
}

extension StringExtension on String {
  String capitalize() {
    if (isEmpty) {
      return this;
    }
    if (length == 1) {
      return toUpperCase();
    }
    return '${this[0].toUpperCase()}${substring(1)}';
  }
}
