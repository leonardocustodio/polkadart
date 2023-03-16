import 'package:scale_codec_generator/scale_codec_generator.dart'
    show
        TypeDefGenerator,
        PrimitiveGenerator,
        SequenceGenerator,
        CompositeGenerator;
import 'package:test/test.dart';

void main() {
  group('TypeDefGenerator', () {
    test('Primitive u8', () {
      final generator = TypeDefGenerator(
        filePath: './types/some_type.dart',
        name: 'SomeType',
        generator: PrimitiveGenerator.u8(1),
        docs: [],
      );
      expect(generator.generated()!.build(), 'typedef SomeType = int;\n');
    });
    test('sequence typedef', () {
      final generator = TypeDefGenerator(
        filePath: './types/some_type.dart',
        name: 'SomeType',
        generator: SequenceGenerator(2, PrimitiveGenerator.u8(1)),
        docs: [],
      );
      expect(generator.generated()!.build(), 'typedef SomeType = List<int>;\n');
    });
    test('sequence typedef', () {
      final generator = TypeDefGenerator(
        filePath: './types/some_type.dart',
        name: 'SomeType',
        generator: CompositeGenerator(
            id: 5,
            filePath: './types/point.dart',
            name: 'Point',
            docs: [],
            fields: []),
        docs: [],
      );
      expect(
          generator.generated()!.build(),
          [
            '// ignore_for_file: no_leading_underscores_for_library_prefixes',
            'import \'point.dart\' as _i1;',
            '',
            'typedef SomeType = _i1.Point;',
            '',
          ].join('\n'));
    });
  });
}
