part of primitives;

///
/// FixedVec
class FixedVecCodec with Codec<List<dynamic>> {
  final Codec<dynamic> subType;
  final int fixedLength;

  ///
  /// constructor
  const FixedVecCodec(this.subType, this.fixedLength);

  ///
  /// Decodes the value from the Codec's input
  @override
  List<dynamic> decode(Input input) {
    final values = <dynamic>[];
    for (var i = 0; i < fixedLength; i++) {
      values.add(subType.decode(input));
    }
    return values;
  }

  ///
  /// Encodes FixedVec of values.
  @override
  void encodeTo(List<dynamic> values, Output output) {
    if (values.length != fixedLength) {
      throw FixedVecException(
          'FixedVecException: Invalid length, expected `fixedLength` and `values` to be of equal length, but found ${values.length}');
    }
    for (final val in values) {
      subType.encodeTo(val, output);
    }
  }
}
