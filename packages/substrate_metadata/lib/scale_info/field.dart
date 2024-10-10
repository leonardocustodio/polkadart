part of scale_info;

/// A field of a struct-like data type.
///
/// Name is optional so it can represent both named and unnamed fields.
///
/// This can be a named field of a struct type or an enum struct variant, or an
/// unnamed field of a tuple struct.
///
/// # Type name
///
/// The `type_name` field contains a string which is the name of the type of the
/// field as it appears in the source code. The exact contents and format of the
/// type name are not specified, but in practice will be the name of any valid
/// type for a field e.g.
///
///   - Concrete types e.g `"u32"`, `"bool"`, `"Foo"` etc.
///   - Type parameters e.g `"T"`, `"U"`
///   - Generic types e.g `"Vec<u32>"`, `"Vec<T>"`
///   - Associated types e.g. `"T::MyType"`, `"<T as MyTrait>::MyType"`
///   - Type aliases e.g. `"MyTypeAlias"`, `"MyTypeAlias<T>"`
///   - Other built in Rust types e.g. arrays, references etc.
///
/// Note that the type name doesn't correspond to the underlying type of the
/// field, unless using a concrete type directly. Any given type may be referred
/// to by multiple field type names, when using generic type parameters and type
/// aliases.
///
/// This is intended for informational and diagnostic purposes only. Although it
/// is possible to infer certain properties e.g. whether a type name is a type
/// alias, there are no guarantees provided, and the type name representation
/// may change.
class Field {
  /// The type of the field.
  final TypeId type;

  /// The name of the field. None for unnamed fields.
  final String? name;

  /// The name of the type of the field as it appears in the source code.
  final String? typeName;

  /// Documentation
  final List<String> docs;

  static const $FieldCodec codec = $FieldCodec._();

  /// Creates a new field.
  const Field(
      {required this.type, this.name, this.typeName, required this.docs});

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{};
    if (name != null) {
      json['name'] = name!;
    }
    json['type'] = type;
    if (typeName != null) {
      json['typeName'] = typeName!;
    }
    if (docs.isNotEmpty) {
      json['docs'] = docs;
    }
    return json;
  }
}

class $FieldCodec implements Codec<Field> {
  const $FieldCodec._();

  @override
  Field decode(Input input) {
    final name = OptionCodec(StrCodec.codec).decode(input);
    final type = TypeIdCodec.codec.decode(input);
    final typeName = OptionCodec(StrCodec.codec).decode(input);
    final docs = SequenceCodec(StrCodec.codec).decode(input);
    return Field(
      type: type,
      name: name,
      typeName: typeName,
      docs: docs,
    );
  }

  @override
  Uint8List encode(Field value) {
    final output = ByteOutput(sizeHint(value));
    encodeTo(value, output);
    return output.toBytes(copy: false);
  }

  @override
  void encodeTo(Field value, Output output) {
    OptionCodec(StrCodec.codec).encodeTo(value.name, output);
    TypeIdCodec.codec.encodeTo(value.type, output);
    OptionCodec(StrCodec.codec).encodeTo(value.typeName, output);
    SequenceCodec(StrCodec.codec).encodeTo(value.docs, output);
  }

  @override
  int sizeHint(Field value) {
    int size = OptionCodec(StrCodec.codec).sizeHint(value.name);
    size += TypeIdCodec.codec.sizeHint(value.type);
    size += OptionCodec(StrCodec.codec).sizeHint(value.typeName);
    size += SequenceCodec(StrCodec.codec).sizeHint(value.docs);
    return size;
  }
}
