part of codec_types;

///
/// Enum to encode/decode Enum
class Enum extends Codec<dynamic> {
  ///
  /// conEnumor
  Enum._() : super(registry: Registry());

  ///
  /// [static] returns a new instance of Enum
  @override
  Enum freshInstance() => Enum._();

  ///
  /// Decodes the value from the Codec's input
  @override
  dynamic decode(Input input) {
    //
    // Read the index of the key from the input
    final int keyIndex = input.byte();

    //
    // Check if typeStruct is not empty indicating that it is an enum of Complex type
    if (typeStruct.isNotEmpty) {
      //
      // Check if the keyIndex is within the range of the typeStruct
      assertionCheck(keyIndex < typeStruct.length,
          'InvalidEnumException: Expected keyIndex to be less than ${typeStruct.length}, but found $keyIndex');

      //
      // Get the key from the typeStruct
      final String key = typeStruct.keys.toList()[keyIndex];

      //
      // Get the codec from the typeStruct
      final Codec codec = typeStruct[key]!;

      //
      // Decode the value of the key with the corresponding codec from the typeStruct
      final dynamic value = codec.decode(input);

      return <String, dynamic>{key: value};
    } else {
      //
      // Check if the keyIndex is within the range of the valueList
      assertionCheck(keyIndex < valueList.length,
          'InvalidEnumException: Expected keyIndex to be less than ${valueList.length}, but found $keyIndex');

      //
      // Get the key from the valueList
      final String key = valueList[keyIndex];

      return key;
    }
  }

  ///
  /// Encodes Enum of value
  @override
  void encode(Encoder encoder, dynamic value) {
    //
    // Check if typeStruct is not empty indicating that it is an enum of Complex type
    if (typeStruct.isNotEmpty) {
      assertionCheck(value is Map,
          'Expected value of type Map but found ${value.runtimeType}');

      //
      // Check if the value has only 1 key
      assertionCheck(value.length == 1,
          'Expected only 1 key in value but found multiple keys: ${value.keys}');

      final String key = value.keys.first;

      if (!typeStruct.containsKey(key)) {
        throw InvalidEnumException(
            'InvalidEnumException: Expected one of key from: ${typeStruct.keys.toList().join(",")}, but found key: $value');
      }

      //
      // Write the index of the key from the typeStruct to the encoder
      encoder.write(typeStruct.keys.toList().indexOf(key));

      //
      // Encode the value of the key with the corresponding codec from the typeStruct
      typeStruct[key]!.encode(encoder, value[key]);
    } else {
      // Check if the value is a String because it is an enum of Simple Type
      assertionCheck(value is String,
          'Expected value of type String but found ${value.runtimeType}');

      final int keyIndex = valueList.indexOf(value);

      if (keyIndex == -1) {
        throw InvalidEnumException(
            'InvalidEnumException: Expected one of value from: ${valueList.join(",")}, but found value: $value');
      }

      //
      // Write the index of the key from the valueList to the encoder
      encoder.write(keyIndex);
    }
  }
}
