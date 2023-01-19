part of generator_types;

class PrimitiveTypeGenerator extends TypeGenerator {
  const PrimitiveTypeGenerator._({
    required super.id,
    required super.fileName,
    required super.className,
    required super.filePath,
    super.fields = const <TypeFields>[],
  }) : super(
          isGeneric: false,
          imports: const <String>[],
        );

  static PrimitiveTypeGenerator fromJson(Map<String, dynamic> map) {
    final String primitive = map['type']['def']['Primitive'];
    return PrimitiveTypeGenerator._(
      id: map['id'],
      fileName: primitive,
      className: '${primitive.nameCase(separator: '')}Codec',
      filePath: 'primitive_types/$primitive',
      fields: <TypeFields>[
        TypeFields(
          fieldType: _typeNameFromPrimitive(primitive),
          fieldVariableName: 'value',
        ),
      ],
    );
  }

  static String _typeNameFromPrimitive(String className) {
    switch (className.toLowerCase()) {
      case 'str':
        return 'String';
      case 'i8':
      case 'i16':
      case 'i32':
      case 'u8':
      case 'u16':
      case 'u32':
        return 'int';
      case 'i64':
      case 'i128':
      case 'i256':
      case 'u64':
      case 'u128':
      case 'u256':
        return 'BigInt';
      case 'bool':
        return 'bool';
      default:
        throw Exception('Unknown primitive type: $className');
    }
  }

  String _codecNameFromPrimitive() {
    switch (className.toLowerCase().replaceAll('codec', '')) {
      case 'str':
        return 'StringCodec';
      case 'bool':
        return 'BoolCodec';
      case 'i8':
      case 'i16':
      case 'i32':
      case 'u8':
      case 'u16':
      case 'u32':
      case 'i64':
      case 'i128':
      case 'i256':
      case 'u64':
      case 'u128':
      case 'u256':
        return className
            .toLowerCase()
            .replaceAll('codec', '')
            .nameCase(separator: '');
      default:
        throw Exception('Unknown primitive type: $className');
    }
  }

  @override
  String toEncodeMethod() {
    final buffer = StringBuffer();

    buffer
      ..writeln('  @override')
      ..writeln('  void encode(scale_codec.Encoder encoder) {');

    /// write
    ///
    /// `scale_codec.{CodecName}().encode(encoder, value);`
    buffer
      ..write('    // scale_codec.')
      ..write(_codecNameFromPrimitive())
      ..writeln('().encode(encoder, value);');

    buffer.writeln('  }');

    return buffer.toString();
  }
}
