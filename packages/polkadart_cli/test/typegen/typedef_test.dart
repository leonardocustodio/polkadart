import 'package:polkadart_cli/polkadart_cli.dart'
    show
        TypeDefBuilder,
        PrimitiveDescriptor,
        SequenceDescriptor,
        CompositeBuilder;
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
      expect(generator.build().build(), 'typedef SomeType = int;\n');
    });
    test('sequence typedef', () {
      final generator = TypeDefBuilder(
        filePath: './types/some_type.dart',
        name: 'SomeType',
        generator: SequenceDescriptor(2, PrimitiveDescriptor.u8(1)),
        docs: [],
      );
      expect(generator.build().build(), 'typedef SomeType = List<int>;\n');
    });
    test('sequence typedef', () {
      final generator = TypeDefBuilder(
        filePath: './types/some_type.dart',
        name: 'SomeType',
        generator: CompositeBuilder(
            id: 5,
            filePath: './types/point.dart',
            name: 'Point',
            docs: [],
            fields: []),
        docs: [],
      );
      expect(
          generator.build().build(),
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
