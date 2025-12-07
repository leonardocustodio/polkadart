part of metadata;

/// A field of a struct-like data type.
///
/// Name is optional so it can represent both named and unnamed fields.
class Field {
  /// Codec instance for Field
  static const $Field codec = $Field._();

  /// Optional field name (None for tuple-like structs)
  final String? name;

  /// Type ID of the field
  final int type;

  /// Optional type name override
  final String? typeName;

  /// Documentation for this field
  final List<String> docs;

  const Field({
    this.name,
    required this.type,
    this.typeName,
    this.docs = const [],
  });

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{};
    json['type'] = type;
    if (name != null) {
      json['name'] = name!;
    }
    if (typeName != null) {
      json['typeName'] = typeName!;
    }
    if (docs.isNotEmpty) {
      json['docs'] = docs;
    }
    return json;
  }
}

/// Codec for Field
class $Field with Codec<Field> {
  const $Field._();

  @override
  Field decode(Input input) {
    // Decode optional field name
    final name = OptionCodec(StrCodec.codec).decode(input);

    // Decode type ID
    final type = CompactCodec.codec.decode(input);

    // Decode optional type name
    final typeName = OptionCodec(StrCodec.codec).decode(input);

    // Decode documentation
    final docs = SequenceCodec(StrCodec.codec).decode(input);

    return Field(
      name: name,
      type: type,
      typeName: typeName,
      docs: docs,
    );
  }

  @override
  void encodeTo(Field value, Output output) {
    OptionCodec(StrCodec.codec).encodeTo(value.name, output);
    CompactCodec.codec.encodeTo(value.type, output);
    OptionCodec(StrCodec.codec).encodeTo(value.typeName, output);
    SequenceCodec(StrCodec.codec).encodeTo(value.docs, output);
  }

  @override
  int sizeHint(Field value) {
    var size = 0;
    size += OptionCodec(StrCodec.codec).sizeHint(value.name);
    size += CompactCodec.codec.sizeHint(value.type);
    size += OptionCodec(StrCodec.codec).sizeHint(value.typeName);
    size += SequenceCodec(StrCodec.codec).sizeHint(value.docs);
    return size;
  }

  @override
  bool isSizeZero() {
    // This class just delegates to inner codecs
    return OptionCodec(StrCodec.codec).isSizeZero() &&
        CompactCodec.codec.isSizeZero() &&
        SequenceCodec(StrCodec.codec).isSizeZero();
  }
}
