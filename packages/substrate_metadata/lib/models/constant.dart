part of models;

///
/// Metadata represeting one pallet constant.
class Constant<T> {
  ///
  /// The constant type codec suitable for decoding the constant bytes
  final Codec<T> type;

  ///
  /// Value stored in the constant (SCALE encoded).
  final Uint8List bytes;

  ///
  /// Documentation of the constant.
  final List<String> docs;

  ///
  /// Creates a constant object model
  const Constant({required this.type, required this.bytes, required this.docs});

  ///
  /// Decoded constant value from the bytes using the type codec
  T get value {
    return type.decode(Input.fromBytes(bytes));
  }
}
