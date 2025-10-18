part of metadata;

class PortableRegistry {
  /// List of all registered types
  ///
  /// Each type has a unique ID (its index in this list) and a complete
  /// definition including its structure and documentation.
  final List<PortableType> types;
  const PortableRegistry({required this.types});

  /// Codec instance for PortableRegistry
  static const $PortableRegistry codec = $PortableRegistry._();

  /// Get a type by its ID
  ///
  /// Returns null if the ID is out of bounds.
  PortableType? getType(int id) {
    if (id >= 0 && id < types.length) {
      return types[id];
    }
    return null;
  }

  /// Creates `Map` from Class Object
  Map<String, dynamic> toJson() => <String, dynamic>{
        'types': types.map((final PortableType value) => value.toJson()).toList(growable: false),
      };
}

/// Codec for PortableRegistry
class $PortableRegistry with Codec<PortableRegistry> {
  const $PortableRegistry._();

  @override
  PortableRegistry decode(Input input) {
    final types = SequenceCodec(PortableType.codec).decode(input);
    return PortableRegistry(types: types);
  }

  @override
  void encodeTo(PortableRegistry value, final Output output) {
    SequenceCodec(PortableType.codec).encodeTo(value.types, output);
  }

  @override
  int sizeHint(PortableRegistry value) {
    return SequenceCodec(PortableType.codec).sizeHint(value.types);
  }
}
