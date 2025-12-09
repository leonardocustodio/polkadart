import 'package:polkadart_cli/polkadart_cli.dart'
    show TypeDefBuilder, PrimitiveDescriptor, SequenceDescriptor, CompositeBuilder;
import 'package:test/test.dart';

void main() {
  group('TypeDefGenerator', () {
    test('Primitive u8', () {
      final generator = TypeDefBuilder(
        filePath: './types/some_type.dart',
        name: 'SomeType',
        generator: PrimitiveDescriptor.u8(1),
        docs: [],
      );
      expect(
          generator.build().build(),
          [
            '// ignore_for_file: no_leading_underscores_for_library_prefixes\n',
            'import \'package:polkadart_scale_codec/polkadart_scale_codec.dart\' as _i1;\n',
            '\n',
            'typedef SomeType = int;\n',
            '\n',
            'class SomeTypeCodec with _i1.Codec<SomeType> {\n',
            '  const SomeTypeCodec();\n',
            '\n',
            '  @override\n',
            '  SomeType decode(_i1.Input input) {\n',
            '    return _i1.U8Codec.codec.decode(input);\n',
            '  }\n',
            '\n',
            '  @override\n',
            '  void encodeTo(\n',
            '    SomeType value,\n',
            '    _i1.Output output,\n',
            '  ) {\n',
            '    _i1.U8Codec.codec.encodeTo(\n',
            '      value,\n',
            '      output,\n',
            '    );\n',
            '  }\n',
            '\n',
            '  @override\n',
            '  int sizeHint(SomeType value) {\n',
            '    return _i1.U8Codec.codec.sizeHint(value);\n',
            '  }\n',
            '\n',
            '  @override\n',
            '  bool isSizeZero() {\n',
            '    return _i1.U8Codec.codec.isSizeZero();\n',
            '  }\n',
            '}\n',
            ''
          ].join());
    });
    test('sequence typedef', () {
      final generator = TypeDefBuilder(
        filePath: './types/some_type.dart',
        name: 'SomeType',
        generator: SequenceDescriptor(2, PrimitiveDescriptor.u8(1)),
        docs: [],
      );
      expect(
          generator.build().build(),
          [
            '// ignore_for_file: no_leading_underscores_for_library_prefixes\n',
            'import \'package:polkadart_scale_codec/polkadart_scale_codec.dart\' as _i1;\n',
            '\n',
            'typedef SomeType = List<int>;\n',
            '\n',
            'class SomeTypeCodec with _i1.Codec<SomeType> {\n',
            '  const SomeTypeCodec();\n',
            '\n',
            '  @override\n',
            '  SomeType decode(_i1.Input input) {\n',
            '    return _i1.U8SequenceCodec.codec.decode(input);\n',
            '  }\n',
            '\n',
            '  @override\n',
            '  void encodeTo(\n',
            '    SomeType value,\n',
            '    _i1.Output output,\n',
            '  ) {\n',
            '    _i1.U8SequenceCodec.codec.encodeTo(\n',
            '      value,\n',
            '      output,\n',
            '    );\n',
            '  }\n',
            '\n',
            '  @override\n',
            '  int sizeHint(SomeType value) {\n',
            '    return _i1.U8SequenceCodec.codec.sizeHint(value);\n',
            '  }\n',
            '\n',
            '  @override\n',
            '  bool isSizeZero() {\n',
            '    return _i1.U8SequenceCodec.codec.isSizeZero();\n',
            '  }\n',
            '}\n',
            '',
          ].join());
    });
    test('composite typedef', () {
      final generator = TypeDefBuilder(
        filePath: './types/some_type.dart',
        name: 'SomeType',
        generator: CompositeBuilder(
            id: 5, filePath: './types/point.dart', name: 'Point', docs: [], fields: []),
        docs: [],
      );
      expect(
          generator.build().build(),
          [
            '// ignore_for_file: no_leading_underscores_for_library_prefixes\n',
            'import \'package:polkadart_scale_codec/polkadart_scale_codec.dart\' as _i2;\n',
            '\n',
            'import \'point.dart\' as _i1;\n',
            '\n',
            'typedef SomeType = _i1.Point;\n',
            '\n',
            'class SomeTypeCodec with _i2.Codec<SomeType> {\n',
            '  const SomeTypeCodec();\n',
            '\n',
            '  @override\n',
            '  SomeType decode(_i2.Input input) {\n',
            '    return _i1.Point.codec.decode(input);\n',
            '  }\n',
            '\n',
            '  @override\n',
            '  void encodeTo(\n',
            '    SomeType value,\n',
            '    _i2.Output output,\n',
            '  ) {\n',
            '    _i1.Point.codec.encodeTo(\n',
            '      value,\n',
            '      output,\n',
            '    );\n',
            '  }\n',
            '\n',
            '  @override\n',
            '  int sizeHint(SomeType value) {\n',
            '    return _i1.Point.codec.sizeHint(value);\n',
            '  }\n',
            '\n',
            '  @override\n',
            '  bool isSizeZero() {\n',
            '    return _i1.Point.codec.isSizeZero();\n',
            '  }\n',
            '}\n',
            '',
          ].join());
    });
  });
}
