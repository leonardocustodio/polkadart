part of models;

///
/// A constant object model
class Constant {
  ///
  /// The constant type codec suitable for decoding the constant bytes
  final Codec type;

  ///
  /// The constant bytes
  final Uint8List bytes;

  ///
  /// The constant documentation
  final List<String> docs;

  ///
  /// Creates a constant object model
  const Constant({required this.type, required this.bytes, required this.docs});

  ///
  /// Decoded constant value from the bytes using the type codec
  dynamic get value {
    return type.decode(Input.fromBytes(bytes));
  }
}
