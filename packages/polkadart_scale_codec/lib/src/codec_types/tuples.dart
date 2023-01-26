part of codec_types;

///
/// Tuples to encode/decode vector of values
class Tuples extends Codec<List> {
  ///
  /// constructor
  Tuples._() : super(registry: Registry());

  ///
  /// [static] returns a new instance of Tuples
  @override
  Tuples freshInstance() => Tuples._();

  ///
  /// Decodes the value from the Codec's input
  ///
  /// Example:
  /// ```dart
  /// final codec = Codec().fetchTypeCodec('(Compact<u8>, bool)');
  /// final value = codec.decode(Input('0x0c01'));
  /// print(value); // [3, true]
  /// ```
  @override
  List decode(Input input) {
    final result = [];

    for (final indexedKey in typeStruct) {
      result.add(fetchTypeCodec(indexedKey).decode(input));
    }
    return result;
  }

  ///
  /// Encodes Tuples of values.
  ///
  /// Example:
  /// ```dart
  /// final codec = Codec().fetchTypeCodec('(Compact<u8>, bool)');
  /// final encoder = HexEncoder();
  /// final value = codec.encode(encoder, [3, true]);
  /// print(encoder.toHex()); // 0x0c01
  /// ```
  @override
  void encode(Encoder encoder, List values) {
    if (typeStruct.isEmpty) {
      throw InvalidTupleException(
          'InvalidTupleException: Atleast 1 subtype is expected for Tuple.');
    }

    if (typeStruct.length != values.length) {
      throw InvalidTupleException(
          'InvalidTupleException: The number of values does not match the number of types.');
    }

    for (var i = 0; i < values.length; i++) {
      final codec = fetchTypeCodec(typeStruct[i]);
      codec.encode(encoder, values[i]);
    }
  }
}
