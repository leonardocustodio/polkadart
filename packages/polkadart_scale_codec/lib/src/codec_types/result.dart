part of codec_types;

///
/// Result to encode/decode map of values
class Result extends Codec<Map<String, dynamic>> {
  ///
  /// conResultor
  Result._() : super(registry: Registry());

  ///
  /// Decodes the value from the Codec's input
  @override
  Map<String, dynamic> decode(Input input) {
    if (typeStruct.isEmpty || typeStruct.length != 2) {
      throw InvalidResultException(
          'InvalidResultException: Expected Ok or Err type.');
    }

    final index = input.byte();
    if (index == 0) {
      return {'Ok': typeStruct['Ok']!.decode(input)};
    } else if (index == 1) {
      return {'Err': typeStruct['Err']!.decode(input)};
    } else {
      throw InvalidResultException(
          'InvalidResultException: Expected 0 or 1 in value. but found: $index');
    }
  }

  ///
  /// Encodes Result of values.
  @override
  void encode(Encoder encoder, Map<String, dynamic> map) {
    if (typeStruct.isEmpty) {
      throw InvalidResultException(
          'InvalidResultException: Expected Ok or Err type.');
    }

    if (map.containsKey('Ok')) {
      encoder.write(0);
      typeStruct['Ok']!.encode(encoder, map['Ok']);
    } else if (map.containsKey('Err')) {
      encoder.write(1);
      typeStruct['Err']!.encode(encoder, map['Err']);
    } else {
      throw InvalidResultException(
          'InvalidResultException: Expected "Ok" or "Err" in value. but found: $map');
    }
  }
}
