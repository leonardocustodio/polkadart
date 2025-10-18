part of metadata;

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
}
