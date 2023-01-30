part of codec_types;

///
/// FixedVec
class FixedVec extends Codec<List<dynamic>> {
  ///
  /// constructor
  FixedVec._() : super(registry: Registry());

  ///
  /// Decodes the value from the Codec's input
  @override
  List<dynamic> decode(Input input) {
    return [];
  }

  ///
  /// Encodes FixedVec of values.
  @override
  void encode(Encoder encoder, List<dynamic> values) {
    if (values.length != fixedLength) {
      throw FixedVecException(
          'FixedVecException: Invalid length, expected $fixedLength, found ${values.length}');
    }
    for (final val in values) {
      subType!.encode(encoder, val);
    }
  }
}
