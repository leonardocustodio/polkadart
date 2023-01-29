part of codec_types;

///
/// BTreeMap to encode/decode map of values
class BTreeMap extends Codec<Map<dynamic, dynamic>> {
  ///
  /// constructor
  BTreeMap._() : super(registry: Registry());

  ///
  /// [static] returns a new instance of BTreeMap
  @override
  BTreeMap freshInstance() => BTreeMap._();

  ///
  /// Decodes the value from the Codec's input
  @override
  Map<dynamic, dynamic> decode(Input input) {
    if (typeStruct.isEmpty) {
      throw InvalidBTreeMapException(
          'InvalidBTreeMapException: Expected typeStruct to be non-empty, but found ${typeStruct.length}');
    }

    assertionCheck(typeStruct['key'] != null,
        'InvalidBTreeMapException: Expected typeStruct to contain key: "key", but found ${typeStruct.keys.toList()}');

    assertionCheck(typeStruct['value'] != null,
        'InvalidBTreeMapException: Expected typeStruct to contain key: "value", but found ${typeStruct.keys.toList()}');

    final result = <dynamic, dynamic>{};

    final length = Compact.decodeFromInput(input);

    for (var i = 0; i < length; i++) {
      final key = typeStruct['key']!.decode(input);

      result[key] = typeStruct['value']!.decode(input);
    }

    return result;
  }

  ///
  /// Encodes BTreeMap of values.
  @override
  void encode(Encoder encoder, Map<dynamic, dynamic> map) {
    if (typeStruct.isEmpty) {
      throw InvalidBTreeMapException(
          'InvalidBTreeMapException: Expected typeStruct to be non-empty, but found ${typeStruct.length}');
    }

    assertionCheck(typeStruct['key'] != null,
        'InvalidBTreeMapException: Expected typeStruct to contain key: "key", but found ${typeStruct.keys.toList()}');

    assertionCheck(typeStruct['value'] != null,
        'InvalidBTreeMapException: Expected typeStruct to contain key: "value", but found ${typeStruct.keys.toList()}');

    Compact.encodeToEncoder(encoder, map.length);

    for (final entry in map.entries) {
      typeStruct['key']!.encode(encoder, entry.key);
      typeStruct['value']!.encode(encoder, entry.value);
    }
  }
}
