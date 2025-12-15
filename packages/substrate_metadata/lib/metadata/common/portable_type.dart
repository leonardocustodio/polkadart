part of metadata;

/// A type definition in the portable registry
class PortableType {
  /// Unique identifier for this type
  final int id;

  /// The actual type definition
  final PortableTypeDef type;

  const PortableType({required this.id, required this.type});

  /// Codec instance for PortableType
  static const $PortableType codec = $PortableType._();

  Map<String, dynamic> toJson() => <String, dynamic>{'id': id, 'type': type.toJson()};
}

/// Codec for PortableType
class $PortableType with Codec<PortableType> {
  const $PortableType._();

  @override
  PortableType decode(Input input) {
    // Decode type ID (compact encoded)
    final id = CompactCodec.codec.decode(input);

    // Decode type definition
    final type = PortableTypeDef.codec.decode(input);

    return PortableType(id: id, type: type);
  }

  @override
  void encodeTo(PortableType value, Output output) {
    CompactCodec.codec.encodeTo(value.id, output);
    PortableTypeDef.codec.encodeTo(value.type, output);
  }

  @override
  int sizeHint(PortableType value) {
    var size = 0;
    size += CompactCodec.codec.sizeHint(value.id);
    size += PortableTypeDef.codec.sizeHint(value.type);
    return size;
  }

  @override
  bool isSizeZero() => CompactCodec.codec.isSizeZero() && PortableTypeDef.codec.isSizeZero();
}
