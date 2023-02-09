part of primitives;

///
/// Result to encode/decode map of values
class Result<T> with Codec<Map<String, T>> {
  final Codec<T> okCodec;
  final Codec<T> errCodec;

  ///
  /// Constructor
  const Result({required this.okCodec, required this.errCodec});

  ///
  /// Decodes the value from the Codec's input
  @override
  Map<String, T> decode(Input input) {
    final index = input.read();
    if (index == 0) {
      return {'Ok': okCodec.decode(input)};
    } else if (index == 1) {
      return {'Err': errCodec.decode(input)};
    } else {
      throw ResultException(
          'ResultException: Expected byte 0 or 1, but found: $index');
    }
  }

  ///
  /// Encodes Result of values.
  @override
  void encodeTo(Map<String, T> value, Output output) {
    if (value.containsKey('Ok')) {
      output.pushByte(0);
      okCodec.encodeTo(value['Ok'] as T, output);
    } else if (value.containsKey('Err')) {
      output.pushByte(1);
      errCodec.encodeTo(value['Err'] as T, output);
    } else {
      throw ResultException(
          'ResultException: Expected key "Ok" or "Err" in value but found: $value');
    }
  }
}
