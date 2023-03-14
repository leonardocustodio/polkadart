import 'dart:core' show String, List, int;
import 'dart:typed_data' show Uint8List;
import 'package:recase/recase.dart' show ReCase;
import 'package:polkadart_scale_codec/polkadart_scale_codec.dart' as scale_codec
    show ByteInput;
import 'package:path/path.dart' as p;
import 'package:code_builder/code_builder.dart'
    show
        Class,
        Code,
        declareFinal,
        Block,
        refer,
        Reference,
        Method,
        Field,
        FieldModifier,
        Parameter,
        Constructor,
        Enum,
        EnumValue,
        literalNum,
        literalString,
        TypeDef,
        TypeReference,
        MethodModifier;
import './generators/generators.dart' as generators show Field, Variant, VariantGenerator, PrimitiveGenerator, CompositeGenerator, PolkadartGenerator, PalletGenerator;
import './constants.dart' as constants;
import './utils.dart' show sanitize;

List<String> sanitizeDocs(List<String> docs) => docs.map((doc) {
      if (doc.startsWith('///')) return doc;
      if (!doc.startsWith(' ')) {
        doc = ' $doc';
      }
      return '///${doc.replaceAll('\n', '\n///')}';
    }).toList();

String classToCodecName(String className) {
  return '\$${className}Codec';
}

Class createCompositeClass(generators.CompositeGenerator compositeGenerator) =>
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
            ..type = constants.input
            ..name = 'input'))
          ..body = Code('return codec.decode(input);')))
        ..methods.add(Method((b) => b
          ..name = 'encode'
          ..returns = constants.uint8List
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

Class createCompositeCodec(generators.CompositeGenerator compositeGenerator) {
  return Class((classBuilder) {
    final dirname = p.dirname(compositeGenerator.filePath);
    final classType = TypeReference((b) => b..symbol = compositeGenerator.name);
    classBuilder
      ..name = classToCodecName(compositeGenerator.name)
      ..mixins.add(constants.codec(ref: classType))
      ..constructors.add(Constructor((b) => b..constant = true))
      ..methods.add(Method.returnsVoid((b) => b
        ..name = 'encodeTo'
        ..annotations.add(refer('override'))
        ..requiredParameters.addAll([
          Parameter((b) => b
            ..type = classType
            ..name = 'obj'),
          Parameter((b) => b
            ..type = constants.output
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
          ..type = constants.input
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
        ..returns = constants.int
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
  generators.VariantGenerator generator,
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
            ..type = constants.input
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
          ..returns = constants.uint8List
          ..body = Block.of([
            Code.scope((a) =>
                'final output = ${a(constants.byteOutput)}(codec.sizeHint(this));'),
            Code('codec.encodeTo(this, output);'),
            Code('return output.buffer.toBytes();'),
          ])))
        ..methods.add(Method((b) => b
          ..name = 'sizeHint'
          ..returns = constants.int
          ..body = Code('return codec.sizeHint(this);')))
        ..methods.add(Method((b) => b
          ..name = 'toJson'
          ..returns = jsonType));
    });

Class createVariantValuesClass(
  generators.VariantGenerator variantGenerator,
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

Class createVariantCodec(generators.VariantGenerator variantGenerator) =>
    Class((classBuilder) {
      final dirname = p.dirname(variantGenerator.filePath);
      final Reference classType = refer(variantGenerator.name);

      classBuilder
        ..name = classToCodecName(variantGenerator.name)
        ..constructors.add(Constructor((b) => b..constant = true))
        ..mixins.add(constants.codec(ref: classType))
        ..methods.add(Method((b) => b
          ..name = 'decode'
          ..returns = classType
          ..annotations.add(refer('override'))
          ..requiredParameters.add(Parameter((b) => b
            ..type = constants.input
            ..name = 'input'))
          ..body = Block.of([
            declareFinal('index')
                .assign(generators.PrimitiveGenerator.u8.decode(dirname))
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
              ..type = constants.output
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
          ..returns = constants.int
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
              ..type = constants.input
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
            ..returns = constants.int
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
            ..type = constants.output
            ..name = 'output'),
        ])
        ..body = Block(
          (b) => b
            ..statements.add(generators.PrimitiveGenerator.u8
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

Enum createSimpleVariantEnum(generators.VariantGenerator variant) => Enum((enumBuilder) {
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
            ..type = constants.input
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
            ..type = constants.string),
          Field((b) => b
            ..modifier = FieldModifier.final$
            ..name = 'codecIndex'
            ..type = constants.int),
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
          ..returns = constants.uint8List
          ..body = Code('return codec.encode(this);')));
    });

Class createSimpleVariantCodec(
  generators.VariantGenerator variant,
) =>
    Class((classBuilder) {
      final className = refer(variant.name);
      final dirname = p.dirname(variant.filePath);

      classBuilder
        ..name = classToCodecName(variant.name)
        ..constructors.add(Constructor((b) => b..constant = true))
        ..mixins.add(constants.codec(ref: className))
        ..methods.add(Method((b) => b
          ..name = 'decode'
          ..returns = className
          ..annotations.add(refer('override'))
          ..requiredParameters.add(Parameter((b) => b
            ..type = constants.input
            ..name = 'input'))
          ..body = Block((b) => b
            ..statements.add(declareFinal('index')
                .assign(generators.PrimitiveGenerator.u8.decode(dirname))
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
              ..type = constants.output
              ..name = 'output'),
          ])
          ..body = generators.PrimitiveGenerator.u8
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
        ..mixins.add(constants.codec(ref: tupleType))
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
              ..type = constants.codec(ref: refer('T$index'))
              ..modifier = FieldModifier.final$)))
        ..methods.add(Method.returnsVoid((b) => b
          ..name = 'encodeTo'
          ..annotations.add(refer('override'))
          ..requiredParameters.addAll([
            Parameter((b) => b
              ..type = tupleType
              ..name = 'tuple'),
            Parameter((b) => b
              ..type = constants.output
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
              ..type = constants.input
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

Class createPalletQueries(
  generators.PalletGenerator generator,
) =>
    Class((classBuilder) {
      final dirname = p.dirname(generator.filePath);
      classBuilder
        ..name = 'Queries'
        ..constructors.add(Constructor((b) => b
          ..constant = true
          ..requiredParameters.add(Parameter((b) => b
            ..toThis = true
            ..required = false
            ..named = false
            ..name = '__api'))))
        ..fields.add(Field((b) => b
          ..name = '__api'
          ..type = constants.stateApi
          ..modifier = FieldModifier.final$))
        ..fields.addAll(generator.storages.map((storage) => Field((b) => b
          ..name = '_${ReCase(storage.name).camelCase}'
          ..type = storage.type(dirname)
          ..modifier = FieldModifier.final$
          ..assignment = storage.instance(dirname, generator.name).code)))
        ..methods.addAll(generator.storages.map((storage) => Method((builder) {
              final storageName = ReCase(storage.name).camelCase;
              final Reference primitive;
              if (storage.isNullable) {
                primitive = storage.valueCodec.primitive(dirname).asNullable();
              } else {
                primitive = storage.valueCodec.primitive(dirname);
              }
              builder
                ..name = sanitize(storageName, recase: false)
                ..docs.addAll(sanitizeDocs(storage.docs))
                ..returns = constants.future(primitive)
                ..modifier = MethodModifier.async
                ..optionalParameters.add(Parameter((b) => b
                  ..type = constants.blockHash.asNullable()
                  ..named = true
                  ..name = 'at'))
                ..requiredParameters
                    .addAll(storage.hashers.map((hasher) => Parameter((b) => b
                      ..type = hasher.codec.primitive(dirname)
                      ..name = 'key${storage.hashers.indexOf(hasher) + 1}')))
                ..body = Block((b) => b
                  // final hashedKey = _storageName.hashedKeyFor(key1);
                  ..statements.add(declareFinal('hashedKey')
                      .assign(refer('_$storageName')
                          .property(storage.hashers.isEmpty
                              ? 'hashedKey'
                              : 'hashedKeyFor')
                          .call(storage.hashers.map((hasher) => refer(
                              'key${storage.hashers.indexOf(hasher) + 1}'))))
                      .statement)
                  // final bytes = await api.queryStorage([hashedKey]);
                  ..statements.add(declareFinal('bytes')
                      .assign(refer('__api').property('getStorage').call(
                          [refer('hashedKey')], {'at': refer('at')}).awaited)
                      .statement)
                  ..statements.add(Code('if (bytes != null) {'))
                  ..statements
                      .add(Code('  return _$storageName.decodeValue(bytes);'))
                  ..statements.add(Code('}'))
                  ..statements.add(storage.isNullable
                      ? Code('return null; /* Nullable */')
                      : storage.valueCodec
                          .valueFrom(
                            dirname,
                            scale_codec.ByteInput(Uint8List.fromList(storage.defaultValue)),
                          )
                          .returned
                          .statement)
                  ..statements.add(
                      storage.isNullable ? Code('') : Code('/* Default */')));
            })));
    });

Class createPalletConstants(
  generators.PalletGenerator generator,
) =>
    Class((classBuilder) {
      final dirname = p.dirname(generator.filePath);
      classBuilder
        ..name = 'Constants'
        ..constructors.add(Constructor((b) => b..constant = false))
        ..fields.addAll(generator.constants.map((constant) => Field((b) => b
          ..name = sanitize(constant.name)
          ..type = constant.codec.primitive(dirname)
          ..modifier = FieldModifier.final$
          ..docs.addAll(sanitizeDocs(constant.docs))
          ..assignment = constant.codec
              .valueFrom(dirname, scale_codec.ByteInput(Uint8List.fromList(constant.value)),
                  constant: true)
              .code)));
    });

Class createPolkadartQueries(
  generators.PolkadartGenerator generator,
) =>
    Class((classBuilder) {
      final dirname = p.dirname(generator.filePath);
      classBuilder
        ..name = 'Queries'
        ..constructors.add(Constructor((b) => b
          ..constant = false
          ..requiredParameters.add(Parameter((b) => b
            ..toThis = false
            ..required = false
            ..named = false
            ..type = constants.stateApi
            ..name = 'api'))
          ..initializers.addAll(generator.pallets
              .where((pallet) => pallet.storages.isNotEmpty)
              .map((pallet) => Code.scope((a) =>
                  '${sanitize(pallet.name)} = ${a(pallet.queries(dirname))}(api)')))))
        ..fields.addAll(generator.pallets
            .where((pallet) => pallet.storages.isNotEmpty)
            .map((pallet) => Field((b) => b
              ..name = sanitize(pallet.name)
              ..type = pallet.queries(dirname)
              ..modifier = FieldModifier.final$)));
    });

Class createPolkadartConstants(
  generators.PolkadartGenerator generator,
) =>
    Class((classBuilder) {
      final dirname = p.dirname(generator.filePath);
      classBuilder
        ..name = 'Constants'
        ..constructors.add(Constructor((b) => b..constant = false))
        ..fields.addAll(generator.pallets
            .where((pallet) => pallet.constants.isNotEmpty)
            .map((pallet) => Field((b) => b
              ..name = sanitize(pallet.name)
              ..type = pallet.constantsType(dirname)
              ..modifier = FieldModifier.final$
              ..assignment =
                  pallet.constantsType(dirname).newInstance([]).code)));
    });

Class createPolkadartRpc(
  generators.PolkadartGenerator generator,
) =>
    Class((classBuilder) {
      classBuilder
        ..name = 'Rpc'
        ..constructors.add(Constructor((b) => b
          ..constant = true
          ..optionalParameters.add(Parameter((b) => b
            ..toThis = true
            ..required = true
            ..named = true
            ..name = 'state'))))
        ..fields.addAll([
          Field((b) => b
            ..name = 'state'
            ..type = constants.stateApi
            ..modifier = FieldModifier.final$)
        ]);
    });

Class createPolkadartClass(
  generators.PolkadartGenerator generator,
) =>
    Class((classBuilder) {
      classBuilder
        ..name = generator.name
        ..constructors.addAll([
          Constructor((b) => b
            ..name = '_'
            ..constant = false
            ..requiredParameters.addAll([
              Parameter((b) => b
                ..toThis = true
                ..required = false
                ..named = false
                ..name = '_provider'),
              Parameter((b) => b
                ..toThis = true
                ..required = false
                ..named = false
                ..name = 'rpc'),
            ])
            ..initializers.addAll([
              Code.scope((a) => 'query = Queries(rpc.state)'),
              Code('constant = Constants()'),
            ])),
          Constructor((b) => b
            ..factory = true
            ..requiredParameters.addAll([
              Parameter((b) => b
                ..toThis = false
                ..required = false
                ..named = false
                ..type = constants.provider
                ..name = 'provider'),
            ])
            ..body = Block.of([
              declareFinal('rpc')
                  .assign(refer('Rpc').newInstance([], {
                    'state': constants.stateApi.newInstance([refer('provider')])
                  }))
                  .statement,
              refer(generator.name)
                  .newInstanceNamed('_', [refer('provider'), refer('rpc')])
                  .returned
                  .statement,
            ])),
          Constructor((b) => b
            ..name = 'url'
            ..constant = false
            ..factory = true
            ..requiredParameters.add(Parameter((b) => b
              ..toThis = false
              ..required = false
              ..named = false
              ..type = constants.string
              ..name = 'url'))
            ..body = Block.of([
              declareFinal('provider')
                  .assign(constants.provider.newInstance([refer('url')]))
                  .statement,
              refer(generator.name)
                  .newInstance([refer('provider')])
                  .returned
                  .statement,
            ])),
        ])
        ..fields.addAll([
          Field((b) => b
            ..name = '_provider'
            ..type = constants.provider
            ..modifier = FieldModifier.final$),
          Field((b) => b
            ..name = 'query'
            ..type = refer('Queries')
            ..modifier = FieldModifier.final$),
          Field((b) => b
            ..name = 'constant'
            ..type = refer('Constants')
            ..modifier = FieldModifier.final$),
          Field((b) => b
            ..name = 'rpc'
            ..type = refer('Rpc')
            ..modifier = FieldModifier.final$),
        ])
        ..methods.addAll([
          Method(
            (b) => b
              ..name = 'connect'
              ..returns = constants.future()
              ..modifier = MethodModifier.async
              ..body = refer('_provider')
                  .property('connect')
                  .call([])
                  .awaited
                  .returned
                  .statement,
          ),
          Method(
            (b) => b
              ..name = 'disconnect'
              ..returns = constants.future()
              ..modifier = MethodModifier.async
              ..body = refer('_provider')
                  .property('disconnect')
                  .call([])
                  .awaited
                  .returned
                  .statement,
          ),
        ]);
    });
