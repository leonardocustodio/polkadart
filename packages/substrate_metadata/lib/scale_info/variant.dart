part of scale_info;

/// A struct enum variant with either named (struct) or unnamed (tuple struct)
/// fields.
class Variant {
  /// Index of the variant, used in `parity-scale-codec`.
  final int index;

  /// The name of the variant.
  final String name;

  /// The fields of the variant.
  final List<Field> fields;

  /// Documentation
  final List<String> docs;

  static const $VariantCodec codec = $VariantCodec._();

  /// Creates a new variant.
  const Variant(
      {required this.index, required this.name, required this.fields, required this.docs});

  Set<int> typeDependencies() {
    return fields.map((field) => field.type).toSet();
  }

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{
      'name': name,
    };
    if (fields.isNotEmpty) {
      json['fields'] = fields.map((e) => e.toJson()).toList();
    }
    json['index'] = index;
    if (docs.isNotEmpty) {
      json['docs'] = docs;
    }
    return json;
  }
}

class $VariantCodec implements Codec<Variant> {
  const $VariantCodec._();

  @override
  Variant decode(Input input) {
    final name = StrCodec.codec.decode(input);
    final fields = SequenceCodec(Field.codec).decode(input);
    final index = U8Codec.codec.decode(input);
    final docs = SequenceCodec(StrCodec.codec).decode(input);
    return Variant(
      index: index,
      name: name,
      fields: fields,
      docs: docs,
    );
  }

  @override
  Uint8List encode(Variant variant) {
    final output = ByteOutput(sizeHint(variant));
    encodeTo(variant, output);
    return output.toBytes(copy: false);
  }

  @override
  void encodeTo(Variant variant, Output output) {
    StrCodec.codec.encodeTo(variant.name, output);
    SequenceCodec(Field.codec).encodeTo(variant.fields, output);
    U8Codec.codec.encodeTo(variant.index, output);
    SequenceCodec(StrCodec.codec).encodeTo(variant.docs, output);
  }

  @override
  int sizeHint(Variant variant) {
    int size = StrCodec.codec.sizeHint(variant.name);
    size += SequenceCodec(Field.codec).sizeHint(variant.fields);
    size += U8Codec.codec.sizeHint(variant.index);
    size += SequenceCodec(StrCodec.codec).sizeHint(variant.docs);
    return size;
  }
}
