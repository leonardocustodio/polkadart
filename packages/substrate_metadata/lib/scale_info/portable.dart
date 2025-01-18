part of scale_info;

/// Represent a type in it's portable form.
class PortableType {
  /// The ID of the portable type.
  final TypeId id;

  /// The portable form of the type.
  final TypeMetadata type;

  static const $PortableType codec = $PortableType._();

  /// Creates a new field.
  const PortableType({required this.id, required this.type});

  Map<String, dynamic> toJson() => {'id': id, 'type': type.toJson()};
}

class $PortableType implements Codec<PortableType> {
  const $PortableType._();

  @override
  PortableType decode(Input input) {
    final id = TypeIdCodec.codec.decode(input);
    final type = TypeMetadata.codec.decode(input);

    final runtimeCall = type.path.contains('RuntimeCall');
    final runtimeEvent = type.path.contains('RuntimeEvent');
    final runtimeError = type.path.contains('RuntimeError');
    if (runtimeCall || runtimeEvent || runtimeError) {
      print('Runtime type: ${type.path}');
    }

    return PortableType(
      id: id,
      type: type,
    );
  }

  @override
  Uint8List encode(PortableType value) {
    final output = ByteOutput(sizeHint(value));
    encodeTo(value, output);
    return output.toBytes(copy: false);
  }

  @override
  void encodeTo(PortableType value, Output output) {
    CompactCodec.codec.encodeTo(value.id, output);
    TypeMetadata.codec.encodeTo(value.type, output);
  }

  @override
  int sizeHint(PortableType value) {
    int size = TypeIdCodec.codec.sizeHint(value.id);
    size += TypeMetadata.codec.sizeHint(value.type);
    return size;
  }
}
