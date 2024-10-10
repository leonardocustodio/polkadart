part of scale_info;

/// A generic type parameter.
class TypeParameter {
  /// The name of the generic type parameter e.g. "T".
  final String name;

  /// The concrete type for the type parameter.
  ///
  /// `null` if the type parameter is skipped.
  final TypeId? type;

  static const $TypeParameterCodec codec = $TypeParameterCodec._();

  const TypeParameter({required this.name, this.type});

  Map<String, dynamic> toJson() => {'name': name, 'type': type};
}

class $TypeParameterCodec implements Codec<TypeParameter> {
  const $TypeParameterCodec._();

  @override
  TypeParameter decode(Input input) {
    final name = StrCodec.codec.decode(input);
    final type = OptionCodec(TypeIdCodec.codec).decode(input);
    return TypeParameter(
      name: name,
      type: type,
    );
  }

  @override
  Uint8List encode(TypeParameter value) {
    final output = ByteOutput(sizeHint(value));
    encodeTo(value, output);
    return output.toBytes(copy: false);
  }

  @override
  void encodeTo(TypeParameter value, Output output) {
    StrCodec.codec.encodeTo(value.name, output);
    OptionCodec(TypeIdCodec.codec).encodeTo(value.type, output);
  }

  @override
  int sizeHint(TypeParameter value) {
    int size = StrCodec.codec.sizeHint(value.name);
    size += OptionCodec(TypeIdCodec.codec).sizeHint(value.type);
    return size;
  }
}
