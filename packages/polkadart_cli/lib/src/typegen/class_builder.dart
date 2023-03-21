import 'dart:core' show List, String, int;
import 'package:path/path.dart' as p;
import 'package:code_builder/code_builder.dart'
    show
        Block,
        Class,
        Code,
        Constructor,
        Enum,
        EnumValue,
        Field,
        FieldModifier,
        Method,
        Parameter,
        Reference,
        TypeDef,
        TypeReference,
        declareFinal,
        literalNum,
        literalString,
        refer;
import './typegen.dart' as generators
    show CompositeBuilder, Field, PrimitiveDescriptor, Variant, VariantBuilder;
import './references.dart' as refs;
import '../utils/utils.dart' show sanitizeDocs;

String classToCodecName(String className) {
  return '\$${className}Codec';
}

Class createCompositeClass(generators.CompositeBuilder compositeGenerator) =>
    Class((classBuilder) {
      final dirname = p.dirname(compositeGenerator.filePath);
      final classType =
          TypeReference((b) => b..symbol = compositeGenerator.name);
      final codecType = refer(classToCodecName(compositeGenerator.name));

      classBuilder
        ..name = classType.symbol
        ..docs.addAll(sanitizeDocs(compositeGenerator.docs))
        ..constructors.add(Constructor((b) => b
          ..constant = true
          ..optionalParameters.addAll(
              compositeGenerator.fields.map((field) => Parameter((b) => b
                ..toThis = true
                ..required = field.codec.primitive(dirname).isNullable != true
                ..named = true
                ..name = field.sanitizedName)))))
        ..constructors.add(Constructor((b) => b
          ..name = 'decode'
          ..factory = true
          ..requiredParameters.add(Parameter((b) => b
            ..type = refs.input
            ..name = 'input'))
          ..body = Code('return codec.decode(input);')))
        ..methods.add(Method((b) => b
          ..name = 'encode'
          ..returns = refs.uint8List
          ..body = Code('return codec.encode(this);')))
        ..methods.add(Method((b) => b
          ..name = 'toJson'
          ..returns = compositeGenerator.jsonType(dirname, {})
          ..body = compositeGenerator.toJson(dirname).code))
        ..fields.addAll(compositeGenerator.fields.map((field) => Field((b) => b
          ..name = field.sanitizedName
          ..type = field.codec.primitive(dirname)
          ..docs.addAll(sanitizeDocs(field.docs))
          ..modifier = FieldModifier.final$)))
        ..fields.add(Field((b) => b
          ..name = 'codec'
          ..static = true
          ..type = codecType
          ..modifier = FieldModifier.constant
          ..assignment = codecType.newInstance([]).code));
    });

Class createCompositeCodec(generators.CompositeBuilder compositeGenerator) {
  return Class((classBuilder) {
    final dirname = p.dirname(compositeGenerator.filePath);
    final classType = TypeReference((b) => b..symbol = compositeGenerator.name);
    classBuilder
      ..name = classToCodecName(compositeGenerator.name)
      ..mixins.add(refs.codec(ref: classType))
      ..constructors.add(Constructor((b) => b..constant = true))
      ..methods.add(Method.returnsVoid((b) => b
        ..name = 'encodeTo'
        ..annotations.add(refer('override'))
        ..requiredParameters.addAll([
          Parameter((b) => b
            ..type = classType
            ..name = 'obj'),
          Parameter((b) => b
            ..type = refs.output
            ..name = 'output'),
        ])
        ..body = Block.of(compositeGenerator.fields.map((field) => field.codec
            .encode(dirname, refer('obj').property(field.sanitizedName))
            .statement))))
      ..methods.add(Method((b) => b
        ..name = 'decode'
        ..returns = classType
        ..annotations.add(refer('override'))
        ..requiredParameters.add(Parameter((b) => b
          ..type = refs.input
          ..name = 'input'))
        ..body = Block((b) => b
          ..statements.add(classType
              .newInstance([], {
                for (var field in compositeGenerator.fields)
                  field.sanitizedName: field.codec.decode(dirname)
              })
              .returned
              .statement))))
      ..methods.add(Method((b) => b
        ..name = 'sizeHint'
        ..returns = refs.int
        ..annotations.add(refer('override'))
        ..requiredParameters.add(
          Parameter((b) => b
            ..type = classType
            ..name = 'obj'),
        )
        ..body = Block((b) => b
          ..statements.add(Code('int size = 0;'))
          ..statements.addAll(compositeGenerator.fields.map((field) =>
              refer('size')
                  .assign(refer('size').operatorAdd(field.codec
                      .codecInstance(dirname)
                      .property('sizeHint')
                      .call([refer('obj').property(field.sanitizedName)])))
                  .statement))
          ..statements.add(refer('size').returned.statement))));
  });
}

Class createVariantBaseClass(
  generators.VariantBuilder generator,
  TypeReference jsonType,
) =>
    Class((classBuilder) {
      final Reference variantNameRef = refer(generator.name);
      final Reference valueRef = refer('\$${generator.name}');
      final Reference codecRef = refer(classToCodecName(generator.name));

      classBuilder
        ..name = variantNameRef.symbol
        ..abstract = true
        ..docs.addAll(sanitizeDocs(generator.docs))
        ..constructors.add(Constructor((b) => b..constant = true))
        ..constructors.add(Constructor((b) => b
          ..name = 'decode'
          ..factory = true
          ..requiredParameters.add(Parameter((b) => b
            ..type = refs.input
            ..name = 'input'))
          ..body = Code('return codec.decode(input);')))
        ..fields.addAll([
          Field((b) => b
            ..name = 'codec'
            ..static = true
            ..modifier = FieldModifier.constant
            ..type = codecRef
            ..assignment = codecRef.newInstance([]).code),
          Field((b) => b
            ..name = 'values'
            ..static = true
            ..modifier = FieldModifier.constant
            ..type = valueRef
            ..assignment = valueRef.constInstance([]).code)
        ])
        ..methods.add(Method((b) => b
          ..name = 'encode'
          ..returns = refs.uint8List
          ..body = Block.of([
            Code.scope((a) =>
                'final output = ${a(refs.byteOutput)}(codec.sizeHint(this));'),
            Code('codec.encodeTo(this, output);'),
            Code('return output.buffer.toBytes();'),
          ])))
        ..methods.add(Method((b) => b
          ..name = 'sizeHint'
          ..returns = refs.int
          ..body = Code('return codec.sizeHint(this);')))
        ..methods.add(Method((b) => b
          ..name = 'toJson'
          ..returns = jsonType));
    });

Class createVariantValuesClass(
  generators.VariantBuilder variantGenerator,
) =>
    Class((classBuilder) {
      final dirname = p.dirname(variantGenerator.filePath);

      classBuilder
        ..name = '\$${variantGenerator.name}'
        ..constructors.add(Constructor((b) => b..constant = true))
        ..methods.addAll(variantGenerator.variants.map((variant) => Method(
            (b) => b
              ..returns = refer(variant.name)
              ..name = generators.Field.toFieldName(variant.name)
              ..body = variant.fields.isEmpty
                  ? Code('return const ${variant.name}();')
                  : Block.of([
                      Code('return ${variant.name}('),
                      Block.of(variant.fields.map((field) => Code(
                          '${field.sanitizedName}: ${field.sanitizedName},'))),
                      Code(');'),
                    ])
              ..optionalParameters
                  .addAll(variant.fields.map((field) => Parameter((b) => b
                    ..required =
                        field.codec.primitive(dirname).isNullable != true
                    ..named = true
                    ..type = field.codec.primitive(dirname)
                    ..name = field.sanitizedName))))));
    });

Class createVariantCodec(generators.VariantBuilder variantGenerator) =>
    Class((classBuilder) {
      final dirname = p.dirname(variantGenerator.filePath);
      final Reference classType = refer(variantGenerator.name);

      classBuilder
        ..name = classToCodecName(variantGenerator.name)
        ..constructors.add(Constructor((b) => b..constant = true))
        ..mixins.add(refs.codec(ref: classType))
        ..methods.add(Method((b) => b
          ..name = 'decode'
          ..returns = classType
          ..annotations.add(refer('override'))
          ..requiredParameters.add(Parameter((b) => b
            ..type = refs.input
            ..name = 'input'))
          ..body = Block.of([
            declareFinal('index')
                .assign(generators.PrimitiveDescriptor.u8(1).decode(dirname))
                .statement,
            Code('switch (index) {'),
            Block.of(variantGenerator.variants.map((variant) => Block.of([
                  Code('case ${variant.index}:'),
                  variant.fields.isEmpty
                      ? Code('return const ${variant.name}();')
                      : Code('return ${variant.name}._decode(input);'),
                ]))),
            Code(
                'default: throw Exception(\'${classType.symbol}: Invalid variant index: "\$index"\');'),
            Code('}'),
          ])))
        ..methods.add(Method.returnsVoid((b) => b
          ..name = 'encodeTo'
          ..annotations.add(refer('override'))
          ..requiredParameters.addAll([
            Parameter((b) => b
              ..type = classType
              ..name = 'value'),
            Parameter((b) => b
              ..type = refs.output
              ..name = 'output'),
          ])
          ..body = Block((b) => b
            ..statements.addAll([
              Code('switch (value.runtimeType) {'),
              Block.of(variantGenerator.variants.map((variant) => Block.of([
                    Code('case ${variant.name}:'),
                    Code('(value as ${variant.name}).encodeTo(output);'),
                    Code('break;'),
                  ]))),
              Code(
                  'default: throw Exception(\'${classType.symbol}: Unsupported "\$value" of type "\${value.runtimeType}"\');'),
              Code('}'),
            ]))))
        ..methods.add(Method((b) => b
          ..name = 'sizeHint'
          ..returns = refs.int
          ..annotations.add(refer('override'))
          ..requiredParameters.add(Parameter((b) => b
            ..type = classType
            ..name = 'value'))
          ..body = Block.of([
            Code('switch (value.runtimeType) {'),
            Block.of(variantGenerator.variants.map((variant) => Block.of([
                  Code('case ${variant.name}:'),
                  variant.fields.isEmpty
                      ? Code('return 1;')
                      : Code('return (value as ${variant.name})._sizeHint();'),
                ]))),
            Code(
                'default: throw Exception(\'${classType.symbol}: Unsupported "\$value" of type "\${value.runtimeType}"\');'),
            Code('}'),
          ])));
    });

Class createVariantClass(
  String filePath,
  String typeName,
  generators.Variant variant,
  TypeReference jsonType,
) =>
    Class((classBuilder) {
      final dirname = p.dirname(filePath);

      classBuilder
        ..name = variant.name
        ..extend = refer(typeName)
        ..docs.addAll(sanitizeDocs(variant.docs))
        ..constructors.add(Constructor((b) => b
          ..constant = true
          ..optionalParameters
              .addAll(variant.fields.map((field) => Parameter((b) => b
                ..toThis = true
                ..required = field.codec.primitive(dirname).isNullable != true
                ..named = true
                ..name = field.sanitizedName)))))
        ..methods.add(Method((b) => b
          ..name = 'toJson'
          ..annotations.add(refer('override'))
          ..returns = jsonType
          ..body = variant.toJson(dirname).code))
        ..fields.addAll(variant.fields.map((field) => Field((b) => b
          ..name = field.sanitizedName
          ..type = field.codec.primitive(dirname)
          ..docs.addAll(sanitizeDocs(field.docs))
          ..modifier = FieldModifier.final$)));

      // Create a constructor for decoding
      if (variant.fields.isNotEmpty) {
        classBuilder
          ..constructors.add(Constructor((b) => b
            ..name = '_decode'
            ..factory = true
            ..requiredParameters.add(Parameter((b) => b
              ..type = refs.input
              ..name = 'input'))
            ..body = Block.of([
              Code('return ${variant.name}('),
              Block.of(variant.fields.map((field) => Block.of([
                    Code('${field.sanitizedName}: '),
                    field.codec.decode(dirname).code,
                    Code(', '),
                  ]))),
              Code(');'),
            ])))
          ..methods.add(Method((b) => b
            ..name = '_sizeHint'
            ..returns = refs.int
            ..body = Block((b) => b
              ..statements.add(Code('int size = 1;'))
              ..statements.addAll(variant.fields.map((field) => refer('size')
                  .assign(refer('size').operatorAdd(field.codec
                      .codecInstance(dirname)
                      .property('sizeHint')
                      .call([
                    field.sanitizedName == 'size'
                        ? refer('this').property(field.sanitizedName)
                        : refer(field.sanitizedName)
                  ])))
                  .statement))
              ..statements.add(refer('size').returned.statement))));
      }

      classBuilder.methods.add(Method.returnsVoid((b) => b
        ..name = 'encodeTo'
        ..requiredParameters.addAll([
          Parameter((b) => b
            ..type = refs.output
            ..name = 'output'),
        ])
        ..body = Block(
          (b) => b
            ..statements.add(generators.PrimitiveDescriptor.u8(1)
                .encode(dirname, literalNum(variant.index))
                .statement)
            ..statements.addAll(variant.fields.map((field) => field.codec
                .encode(
                    dirname,
                    field.sanitizedName == 'output'
                        ? refer('this').property(field.sanitizedName)
                        : refer(field.sanitizedName))
                .statement)),
        )));
    });

Enum createSimpleVariantEnum(generators.VariantBuilder variant) =>
    Enum((enumBuilder) {
      final dirname = p.dirname(variant.filePath);
      final Reference typeRef = refer(variant.name);
      final Reference codecRef = refer(classToCodecName(variant.name));

      enumBuilder
        ..name = typeRef.symbol
        ..constructors.add(Constructor((b) => b
          ..constant = true
          ..requiredParameters.addAll([
            Parameter((b) => b
              ..toThis = true
              ..name = 'variantName'),
            Parameter((b) => b
              ..toThis = true
              ..name = 'codecIndex'),
          ])))
        ..constructors.add(Constructor((b) => b
          ..name = 'decode'
          ..factory = true
          ..requiredParameters.add(Parameter((b) => b
            ..type = refs.input
            ..name = 'input'))
          ..body = Code('return codec.decode(input);')))
        ..methods.add(Method((b) => b
          ..name = 'toJson'
          ..returns = variant.jsonType(dirname, {})
          ..body = refer('variantName').code))
        ..fields.addAll([
          Field((b) => b
            ..modifier = FieldModifier.final$
            ..name = 'variantName'
            ..type = refs.string),
          Field((b) => b
            ..modifier = FieldModifier.final$
            ..name = 'codecIndex'
            ..type = refs.int),
          Field((b) => b
            ..name = 'codec'
            ..static = true
            ..modifier = FieldModifier.constant
            ..type = codecRef
            ..assignment = codecRef.newInstance([]).code),
        ])
        ..values.addAll(variant.variants.map((variant) => EnumValue((b) => b
          ..name = generators.Field.toFieldName(variant.name)
          ..arguments.addAll([
            literalString(variant.orignalName),
            literalNum(variant.index)
          ]))))
        ..methods.add(Method((b) => b
          ..name = 'encode'
          ..returns = refs.uint8List
          ..body = Code('return codec.encode(this);')));
    });

Class createSimpleVariantCodec(
  generators.VariantBuilder variant,
) =>
    Class((classBuilder) {
      final className = refer(variant.name);
      final dirname = p.dirname(variant.filePath);

      classBuilder
        ..name = classToCodecName(variant.name)
        ..constructors.add(Constructor((b) => b..constant = true))
        ..mixins.add(refs.codec(ref: className))
        ..methods.add(Method((b) => b
          ..name = 'decode'
          ..returns = className
          ..annotations.add(refer('override'))
          ..requiredParameters.add(Parameter((b) => b
            ..type = refs.input
            ..name = 'input'))
          ..body = Block((b) => b
            ..statements.add(declareFinal('index')
                .assign(generators.PrimitiveDescriptor.u8(1).decode(dirname))
                .statement)
            ..statements.add(Code('switch (index) {'))
            ..statements
                .add(Block.of(variant.variants.map((variant) => Block.of([
                      Code('case ${variant.index}:'),
                      Code(
                          'return ${className.symbol}.${generators.Field.toFieldName(variant.name)};')
                    ]))))
            ..statements.add(Code(
                'default: throw Exception(\'${className.symbol}: Invalid variant index: "\$index"\');'))
            ..statements.add(Code('}')))))
        ..methods.add(Method.returnsVoid((b) => b
          ..name = 'encodeTo'
          ..annotations.add(refer('override'))
          ..requiredParameters.addAll([
            Parameter((b) => b
              ..type = className
              ..name = 'value'),
            Parameter((b) => b
              ..type = refs.output
              ..name = 'output'),
          ])
          ..body = generators.PrimitiveDescriptor.u8(1)
              .encode(dirname, refer('value').property('codecIndex'))
              .statement));
    });

TypeDef createTypeDef({required String name, required Reference reference}) =>
    TypeDef((b) => b
      ..name = name
      ..definition = reference);

Class createTupleClass(
  int size,
) =>
    Class((classBuilder) {
      classBuilder
        ..name = 'Tuple$size'
        ..constructors.add(Constructor((b) => b
          ..constant = true
          ..requiredParameters.addAll(List.generate(
              size,
              (index) => Parameter((b) => b
                ..toThis = true
                ..required = false
                ..named = false
                ..name = 'value$index')))))
        ..types.addAll(List.generate(size, (index) => refer('T$index')))
        ..fields.addAll(List.generate(
            size,
            (index) => Field((b) => b
              ..name = 'value$index'
              ..type = refer('T$index')
              ..modifier = FieldModifier.final$)));
    });

Class createTupleCodec(
  int size,
) =>
    Class((classBuilder) {
      final tupleType = TypeReference((b) => b
        ..symbol = 'Tuple$size'
        ..types.addAll(List.generate(size, (index) => refer('T$index'))));

      classBuilder
        ..name = 'Tuple${size}Codec'
        ..mixins.add(refs.codec(ref: tupleType))
        ..constructors.add(Constructor((b) => b
          ..constant = true
          ..requiredParameters.addAll(List.generate(
              size,
              (index) => Parameter((b) => b
                ..toThis = true
                ..required = false
                ..named = false
                ..name = 'codec$index')))))
        ..types.addAll(List.generate(size, (index) => refer('T$index')))
        ..fields.addAll(List.generate(
            size,
            (index) => Field((b) => b
              ..name = 'codec$index'
              ..type = refs.codec(ref: refer('T$index'))
              ..modifier = FieldModifier.final$)))
        ..methods.add(Method.returnsVoid((b) => b
          ..name = 'encodeTo'
          ..annotations.add(refer('override'))
          ..requiredParameters.addAll([
            Parameter((b) => b
              ..type = tupleType
              ..name = 'tuple'),
            Parameter((b) => b
              ..type = refs.output
              ..name = 'output'),
          ])
          ..body = Block((b) => b
            ..statements.addAll(List.generate(
                size,
                (index) => Code(
                    'codec$index.encodeTo(tuple.value$index, output);'))))))
        ..methods.add(Method((b) => b
          ..name = 'decode'
          ..annotations.add(refer('override'))
          ..returns = tupleType
          ..requiredParameters.addAll([
            Parameter((b) => b
              ..type = refs.input
              ..name = 'input'),
          ])
          ..body = Block((b) => b
            ..statements.add(Code('return Tuple$size('))
            ..statements.addAll(List.generate(
                size, (index) => Code('codec$index.decode(input),')))
            ..statements.add(Code(');')))))
        ..methods.add(Method((b) => b
          ..name = 'sizeHint'
          ..annotations.add(refer('override'))
          ..returns = refer('int')
          ..requiredParameters.addAll([
            Parameter((b) => b
              ..type = tupleType
              ..name = 'tuple'),
          ])
          ..body = Block((b) => b
            ..statements.add(Code('int size = 0;'))
            ..statements.addAll(List.generate(
                size,
                (index) =>
                    Code('size += codec$index.sizeHint(tuple.value$index);')))
            ..statements.add(Code('return size;')))));
    });
