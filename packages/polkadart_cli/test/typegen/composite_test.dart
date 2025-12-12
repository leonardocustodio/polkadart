import 'package:polkadart_cli/polkadart_cli.dart' show PrimitiveDescriptor, CompositeBuilder, Field;
import 'package:test/test.dart';

void main() {
  group('CompositeGenerator', () {
    test('Point(x, y)', () {
      final generator = CompositeBuilder(
        id: 5,
        filePath: './types/point.dart',
        name: 'Point',
        docs: [],
        fields: [
          Field(originalName: 'x', codec: PrimitiveDescriptor.i32(1), docs: []),
          Field(originalName: 'y', codec: PrimitiveDescriptor.i32(1), docs: []),
        ],
      );

      // Check the point class
      final output = generator.build();
      expect(output.classes.length, 2);
      final pointClass = output.classes.first;
      expect(pointClass.name, 'Point');
      expect(pointClass.fields.length, 3);
      expect(pointClass.fields.firstWhere((f) => f.name == 'x').type!.symbol, 'int');
      expect(pointClass.fields.firstWhere((f) => f.name == 'y').type!.symbol, 'int');
      expect(pointClass.fields.firstWhere((f) => f.name == 'codec').type!.symbol, '\$PointCodec');

      // Check the codec class
      final pointCodecClass = output.classes.last;
      expect(pointCodecClass.name, '\$PointCodec');
      expect(pointCodecClass.fields.length, 0);
      expect(pointCodecClass.methods.length, 4);
      expect(
        pointCodecClass.methods.firstWhere((m) => m.name == 'encodeTo').returns?.type.symbol,
        'void',
      );
      expect(
        pointCodecClass.methods.firstWhere((m) => m.name == 'decode').returns?.type.symbol,
        'Point',
      );
      expect(
        pointCodecClass.methods.firstWhere((m) => m.name == 'sizeHint').returns?.type.symbol,
        'int',
      );
      expect(
        pointCodecClass.methods.firstWhere((m) => m.name == 'isSizeZero').returns?.type.symbol,
        'bool',
      );

      expect(
        generator.build().build(),
        [
          '// ignore_for_file: no_leading_underscores_for_library_prefixes\n',
          'import \'dart:typed_data\' as _i2;\n',
          '\n',
          'import \'package:polkadart_scale_codec/polkadart_scale_codec.dart\' as _i1;\n',
          '\n',
          'class Point {\n',
          '  const Point({\n',
          '    required this.x,\n',
          '    required this.y,\n',
          '  });\n',
          '\n',
          '  factory Point.decode(_i1.Input input) {\n',
          '    return codec.decode(input);\n',
          '  }\n',
          '\n',
          '  final int x;\n',
          '\n',
          '  final int y;\n',
          '\n',
          '  static const \$PointCodec codec = \$PointCodec();\n',
          '\n',
          '  _i2.Uint8List encode() {\n',
          '    return codec.encode(this);\n',
          '  }\n',
          '\n',
          '  Map<String, int> toJson() => {\n',
          '        \'x\': x,\n',
          '        \'y\': y,\n',
          '      };\n',
          '\n',
          '  @override\n',
          '  bool operator ==(Object other) =>\n',
          '      identical(\n',
          '        this,\n',
          '        other,\n',
          '      ) ||\n',
          '      other is Point && other.x == x && other.y == y;\n',
          '\n',
          '  @override\n',
          '  int get hashCode => Object.hash(\n',
          '        x,\n',
          '        y,\n',
          '      );\n',
          '}\n',
          '\n',
          'class \$PointCodec with _i1.Codec<Point> {\n',
          '  const \$PointCodec();\n',
          '\n',
          '  @override\n',
          '  void encodeTo(\n',
          '    Point obj,\n',
          '    _i1.Output output,\n',
          '  ) {\n',
          '    _i1.I32Codec.codec.encodeTo(\n',
          '      obj.x,\n',
          '      output,\n',
          '    );\n',
          '    _i1.I32Codec.codec.encodeTo(\n',
          '      obj.y,\n',
          '      output,\n',
          '    );\n',
          '  }\n',
          '\n',
          '  @override\n',
          '  Point decode(_i1.Input input) {\n',
          '    return Point(\n',
          '      x: _i1.I32Codec.codec.decode(input),\n',
          '      y: _i1.I32Codec.codec.decode(input),\n',
          '    );\n',
          '  }\n',
          '\n',
          '  @override\n',
          '  int sizeHint(Point obj) {\n',
          '    int size = 0;\n',
          '    size = size + _i1.I32Codec.codec.sizeHint(obj.x);\n',
          '    size = size + _i1.I32Codec.codec.sizeHint(obj.y);\n',
          '    return size;\n',
          '  }\n',
          '\n',
          '  @override\n',
          '  bool isSizeZero() =>\n',
          '      _i1.I32Codec.codec.isSizeZero() && _i1.I32Codec.codec.isSizeZero();\n',
          '}\n',
          '',
        ].join(),
      );
    });
  });
}
