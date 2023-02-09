part of primitives;

///
/// Result to encode/decode map of values
class Result with Codec<Map<String, dynamic>> {
  final Codec<dynamic> okCodec;
  final Codec<dynamic> errCodec;

  ///
  /// Constructor
  const Result({required this.okCodec, required this.errCodec});

  ///
  /// Decodes the value from the Codec's input
  @override
  Map<String, dynamic> decode(Input input) {
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
  void encodeTo(Map<dynamic, dynamic> value, Output output) {
    if (value.containsKey('Ok')) {
      output.pushByte(0);
      okCodec.encodeTo(value['Ok'], output);
    } else if (value.containsKey('Err')) {
      output.pushByte(1);
      errCodec.encodeTo(value['Err'], output);
    } else {
      throw ResultException(
          'ResultException: Expected key "Ok" or "Err" in value but found: $value');
    }
  }
}
