import 'dart:core' show String, List, bool, int;
import 'package:recase/recase.dart' show ReCase;
import 'package:polkadart_scale_codec/polkadart_scale_codec.dart' as scale_codec
    show Input, ByteInput;
import 'package:code_builder/code_builder.dart'
    show
        Class,
        Code,
        declareFinal,
        literalList,
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
        TypeDef,
        TypeReference,
        MethodModifier;
import './generators/base.dart' as generator show Field;
import './generators/variant.dart' as v show Variant, VariantGenerator;
import './generators/primitive.dart' show PrimitiveGenerator;
import './generators/pallet.dart' as pallet;
import './generators/polkadart.dart' show PolkadartGenerator;
import './constants.dart' as constants;
import './utils.dart' show sanitize;

List<String> sanitizeDocs(List<String> docs) => docs.map((doc) {
      if (doc.startsWith('///')) return doc;
      if (!doc.startsWith(' ')) {
        doc = ' $doc';
      }
      return '///${doc.replaceAll('\n', '\n///')}';
    }).toList();

Class createCompositeClass(
  String typeName,
  List<generator.Field> fields, {
  List<String> docs = const [],
  bool implDecode = false,
  String? staticCodec,
  String? extension,
  bool abstract = false,
}) =>
    Class((classBuilder) {
      final classType = TypeReference((b) => b..symbol = typeName);

      classBuilder
        ..name = typeName
        ..extend = extension == null ? null : refer(extension)
        ..docs.addAll(sanitizeDocs(docs))
        ..constructors.add(Constructor((b) => b
          ..constant = true
          ..optionalParameters.addAll(fields.map((field) => Parameter((b) => b
            ..toThis = true
            ..required = field.codec.primitive().isNullable != true
            ..named = true
            ..name = field.name)))))
        ..fields.addAll(fields.map((field) => Field((b) => b
          ..name = field.name
          ..type = field.codec.primitive()
          ..docs.addAll(sanitizeDocs(field.docs))
          ..modifier = FieldModifier.final$)));

      // Generate static codec
      if (staticCodec != null) {
        classBuilder.fields.add(Field((b) => b
          ..name = 'codec'
          ..static = true
          ..type = constants.codec(ref: classType)
          ..modifier = FieldModifier.constant
          ..assignment = Code('$staticCodec()')));
      }

      // Generate decode factory
      if (staticCodec != null && implDecode) {
        classBuilder
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
            ..body = Code('return codec.encode(this);')));
      }
    });

Class createCompositeCodec(
    String codecName, Reference typeName, List<generator.Field> fields) {
  return Class((classBuilder) {
    classBuilder
      ..name = codecName
      ..mixins.add(constants.codec(ref: typeName))
      ..constructors.add(Constructor((b) => b..constant = true))
      ..methods.add(Method.returnsVoid((b) => b
        ..name = 'encodeTo'
        ..annotations.add(refer('override'))
        ..requiredParameters.addAll([
          Parameter((b) => b
            ..type = typeName
            ..name = 'obj'),
          Parameter((b) => b
            ..type = constants.output
            ..name = 'output'),
        ])
        ..body = Block.of(fields.map((field) =>
            field.codec.encode(refer('obj').property(field.name)).statement))))
      ..methods.add(Method((b) => b
        ..name = 'decode'
        ..returns = typeName
        ..annotations.add(refer('override'))
        ..requiredParameters.add(Parameter((b) => b
          ..type = constants.input
          ..name = 'input'))
        ..body = Block((b) => b
          ..statements.add(typeName
              .newInstance([],
                  {for (var field in fields) field.name: field.codec.decode()})
              .returned
              .statement))))
      ..methods.add(Method((b) => b
        ..name = 'sizeHint'
        ..returns = constants.int
        ..annotations.add(refer('override'))
        ..requiredParameters.add(
          Parameter((b) => b
            ..type = typeName
            ..name = 'obj'),
        )
        ..body = Block((b) => b
          ..statements.add(Code('int size = 0;'))
          ..statements.addAll(fields.map((field) => refer('size')
              .assign(refer('size').operatorAdd(field.codec
                  .codecInstance()
                  .property('sizeHint')
                  .call([refer('obj').property(field.name)])))
              .statement))
          ..statements.add(refer('size').returned.statement))));
  });
}

Class createVariantBaseClass(
  v.VariantGenerator generator,
) =>
    Class((classBuilder) {
      final Reference variantNameRef = refer(generator.name);
      final Reference valueRef = refer('_${generator.name}');
      final Reference codecRef = refer('_\$${generator.name}Codec');

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
          ..body = Code('return codec.sizeHint(this);')));
    });

Class createVariantValuesClass(
  String typeName,
  List<v.Variant> variants,
) =>
    Class((classBuilder) {
      classBuilder
        ..name = typeName
        ..constructors.add(Constructor((b) => b..constant = true))
        ..methods.addAll(variants.map((variant) => Method((b) => b
          ..returns = refer(variant.name)
          ..name = generator.Field.toFieldName(variant.name)
          ..body = variant.fields.isEmpty
              ? Code('return const ${variant.name}();')
              : Block.of([
                  Code('return ${variant.name}('),
                  Block.of(variant.fields
                      .map((field) => Code('${field.name}: ${field.name},'))),
                  Code(');'),
                ])
          ..optionalParameters
              .addAll(variant.fields.map((field) => Parameter((b) => b
                ..required = field.codec.primitive().isNullable != true
                ..named = true
                ..type = field.codec.primitive()
                ..name = field.name))))));
    });

Class createVariantCodec(
  String codecName,
  String typeName,
  List<v.Variant> variants,
) =>
    Class((classBuilder) {
      classBuilder
        ..name = codecName
        ..constructors.add(Constructor((b) => b..constant = true))
        ..mixins.add(constants.codec(ref: refer(typeName)))
        ..methods.add(Method((b) => b
          ..name = 'decode'
          ..returns = refer(typeName)
          ..annotations.add(refer('override'))
          ..requiredParameters.add(Parameter((b) => b
            ..type = constants.input
            ..name = 'input'))
          ..body = Block.of([
            declareFinal('index')
                .assign(PrimitiveGenerator.u8.decode())
                .statement,
            Code('switch (index) {'),
            Block.of(variants.map((variant) => Block.of([
                  Code('case ${variant.index}:'),
                  variant.fields.isEmpty
                      ? Code('return const ${variant.name}();')
                      : Code('return ${variant.name}._decode(input);'),
                ]))),
            Code(
                'default: throw Exception(\'$typeName: Invalid variant index: "\$index"\');'),
            Code('}'),
          ])))
        ..methods.add(Method.returnsVoid((b) => b
          ..name = 'encodeTo'
          ..annotations.add(refer('override'))
          ..requiredParameters.addAll([
            Parameter((b) => b
              ..type = refer(typeName)
              ..name = 'value'),
            Parameter((b) => b
              ..type = constants.output
              ..name = 'output'),
          ])
          ..body = Block((b) => b
            ..statements.addAll([
              Code('switch (value.runtimeType) {'),
              Block.of(variants.map((variant) => Block.of([
                    Code('case ${variant.name}:'),
                    Code('(value as ${variant.name}).encodeTo(output);'),
                    Code('break;'),
                  ]))),
              Code(
                  'default: throw Exception(\'$typeName: Unsupported "\$value" of type "\${value.runtimeType}"\');'),
              Code('}'),
            ]))))
        ..methods.add(Method((b) => b
          ..name = 'sizeHint'
          ..returns = constants.int
          ..annotations.add(refer('override'))
          ..requiredParameters.add(Parameter((b) => b
            ..type = refer(typeName)
            ..name = 'value'))
          ..body = Block.of([
            Code('switch (value.runtimeType) {'),
            Block.of(variants.map((variant) => Block.of([
                  Code('case ${variant.name}:'),
                  variant.fields.isEmpty
                      ? Code('return 1;')
                      : Code('return (value as ${variant.name})._sizeHint();'),
                ]))),
            Code(
                'default: throw Exception(\'$typeName: Unsupported "\$value" of type "\${value.runtimeType}"\');'),
            Code('}'),
          ])));
    });

Class createVariantClass(
  String typeName,
  String codecName,
  v.Variant variant,
) =>
    Class((classBuilder) {
      classBuilder
        ..name = variant.name
        ..extend = refer(typeName)
        ..docs.addAll(sanitizeDocs(variant.docs))
        ..constructors.add(Constructor((b) => b
          ..constant = true
          ..optionalParameters
              .addAll(variant.fields.map((field) => Parameter((b) => b
                ..toThis = true
                ..required = field.codec.primitive().isNullable != true
                ..named = true
                ..name = field.name)))))
        ..fields.addAll(variant.fields.map((field) => Field((b) => b
          ..name = field.name
          ..type = field.codec.primitive()
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
                    Code('${field.name}: '),
                    field.codec.decode().code,
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
                      .codecInstance()
                      .property('sizeHint')
                      .call([refer(field.name)])))
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
            ..statements.add(PrimitiveGenerator.u8
                .encode(literalNum(variant.index))
                .statement)
            ..statements.addAll(variant.fields.map(
                (field) => field.codec.encode(refer(field.name)).statement)),
        )));
    });

Enum createSimpleVariantEnum(v.VariantGenerator variant) => Enum((enumBuilder) {
      final Reference typeRef = refer(variant.name);
      final Reference codecRef = refer('_\$${variant.name}Codec');

      enumBuilder
        ..name = typeRef.symbol
        ..constructors.add(Constructor((b) => b
          ..constant = true
          ..requiredParameters.add(Parameter((b) => b
            ..toThis = true
            ..name = 'codecIndex'))))
        ..constructors.add(Constructor((b) => b
          ..name = 'decode'
          ..factory = true
          ..requiredParameters.add(Parameter((b) => b
            ..type = constants.input
            ..name = 'input'))
          ..body = Code('return codec.decode(input);')))
        ..fields.addAll([
          Field((b) => b
            ..modifier = FieldModifier.final$
            ..name = 'codecIndex'
            ..type = refer('int')),
          Field((b) => b
            ..name = 'codec'
            ..static = true
            ..modifier = FieldModifier.constant
            ..type = codecRef
            ..assignment = codecRef.newInstance([]).code),
        ])
        ..values.addAll(variant.variants.map((variant) => EnumValue((b) => b
          ..name = generator.Field.toFieldName(variant.name)
          ..arguments.add(literalNum(variant.index)))))
        ..methods.add(Method((b) => b
          ..name = 'encode'
          ..returns = constants.uint8List
          ..body = Code('return codec.encode(this);')));
    });

Class createSimpleVariantCodec(
  String codecName,
  String typeName,
  List<v.Variant> variants,
) =>
    Class((classBuilder) {
      classBuilder
        ..name = codecName
        ..constructors.add(Constructor((b) => b..constant = true))
        ..mixins.add(constants.codec(ref: refer(typeName)))
        ..methods.add(Method((b) => b
          ..name = 'decode'
          ..returns = refer(typeName)
          ..annotations.add(refer('override'))
          ..requiredParameters.add(Parameter((b) => b
            ..type = constants.input
            ..name = 'input'))
          ..body = Block((b) => b
            ..statements.add(declareFinal('index')
                .assign(PrimitiveGenerator.u8.decode())
                .statement)
            ..statements.add(Code('switch (index) {'))
            ..statements.add(Block.of(variants.map((variant) => Block.of([
                  Code('case ${variant.index}:'),
                  Code(
                      'return $typeName.${generator.Field.toFieldName(variant.name)};')
                ]))))
            ..statements.add(Code(
                'default: throw Exception(\'$typeName: Invalid variant index: "\$index"\');'))
            ..statements.add(Code('}')))))
        ..methods.add(Method.returnsVoid((b) => b
          ..name = 'encodeTo'
          ..annotations.add(refer('override'))
          ..requiredParameters.addAll([
            Parameter((b) => b
              ..type = refer(typeName)
              ..name = 'value'),
            Parameter((b) => b
              ..type = constants.output
              ..name = 'output'),
          ])
          ..body = PrimitiveGenerator.u8
              .encode(refer('value').property('codecIndex'))
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
  pallet.PalletGenerator generator,
) =>
    Class((classBuilder) {
      classBuilder
        ..name = 'Queries'
        ..constructors.add(Constructor((b) => b
          ..constant = true
          ..requiredParameters.add(Parameter((b) => b
            ..toThis = true
            ..required = false
            ..named = false
            ..name = 'provider'))))
        ..fields.add(Field((b) => b
          ..name = 'provider'
          ..type = constants.provider
          ..modifier = FieldModifier.final$))
        ..fields.addAll(generator.storages.map((storage) => Field((b) => b
          ..name = '_${ReCase(storage.name).camelCase}'
          ..type = storage.type()
          ..modifier = FieldModifier.final$
          ..assignment = storage.instance(generator.name).code)))
        ..methods.addAll(generator.storages.map((storage) => Method((builder) {
              final storageName = ReCase(storage.name).camelCase;
              builder
                ..name = sanitize(storageName)
                ..docs.addAll(sanitizeDocs(storage.docs))
                ..returns = constants.future(storage.valueCodec.primitive(),
                    nullable: storage.isNullable)
                ..modifier = MethodModifier.async
                ..requiredParameters
                    .addAll(storage.hashers.map((hasher) => Parameter((b) => b
                      ..type = hasher.codec.primitive()
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
                  // final value = await provider.queryStorage([hashedKey]).then((values) => values.first);
                  ..statements.add(declareFinal('value')
                      .assign(refer('provider')
                          .property('queryStorage')
                          .call([
                            literalList([refer('hashedKey')])
                          ])
                          .property('then')
                          .call([
                            Method.returnsVoid((b) => b
                                  ..requiredParameters
                                      .add(Parameter((b) => b..name = 'values'))
                                  ..lambda = true
                                  ..body =
                                      refer('values').property('first').code)
                                .closure
                          ])
                          .awaited)
                      .statement)
                  ..statements.add(Code('if (value != null) {'))
                  ..statements
                      .add(Code('  return _$storageName.decodeValue(value);'))
                  ..statements.add(Code('}'))
                  ..statements.add(storage.isNullable
                      ? Code('return null; /* Nullable */')
                      : storage.valueCodec
                          .valueFrom(
                              scale_codec.ByteInput(storage.defaultValue))
                          .returned
                          .statement)
                  ..statements.add(
                      storage.isNullable ? Code('') : Code('/* Default */')));
            })));
    });

Class createPalletConstants(
  pallet.PalletGenerator generator,
) =>
    Class((classBuilder) {
      classBuilder
        ..name = 'Constants'
        ..constructors.add(Constructor((b) => b..constant = false))
        ..fields.addAll(generator.constants.map((constant) => Field((b) => b
          ..name = sanitize(ReCase(constant.name).camelCase)
          ..type = constant.codec.primitive()
          ..modifier = FieldModifier.final$
          ..docs.addAll(sanitizeDocs(constant.docs))
          ..assignment = constant.codec
              .valueFrom(scale_codec.ByteInput(constant.value))
              .code)));
    });

Class createPolkadartQueries(
  PolkadartGenerator generator,
) =>
    Class((classBuilder) {
      classBuilder
        ..name = 'Queries'
        ..constructors.add(Constructor((b) => b
          ..constant = false
          ..requiredParameters.add(Parameter((b) => b
            ..toThis = false
            ..required = false
            ..named = false
            ..type = constants.provider
            ..name = 'provider'))
          ..initializers.addAll(generator.pallets
              .where((pallet) => pallet.storages.isNotEmpty)
              .map((pallet) => Code.scope((a) =>
                  '${sanitize(ReCase(pallet.name).camelCase)} = ${a(pallet.queries())}(provider)')))))
        ..fields.addAll(generator.pallets
            .where((pallet) => pallet.storages.isNotEmpty)
            .map((pallet) => Field((b) => b
              ..name = sanitize(ReCase(pallet.name).camelCase)
              ..type = pallet.queries()
              ..modifier = FieldModifier.final$)));
    });

Class createPolkadartConstants(
  PolkadartGenerator generator,
) =>
    Class((classBuilder) {
      classBuilder
        ..name = 'Constants'
        ..constructors.add(Constructor((b) => b..constant = false))
        ..fields.addAll(generator.pallets
            .where((pallet) => pallet.constants.isNotEmpty)
            .map((pallet) => Field((b) => b
              ..name = sanitize(ReCase(pallet.name).camelCase)
              ..type = pallet.constantsType()
              ..modifier = FieldModifier.final$
              ..assignment = pallet.constantsType().newInstance([]).code)));
    });

Class createPolkadartClass(
  PolkadartGenerator generator,
) =>
    Class((classBuilder) {
      classBuilder
        ..name = generator.name
        ..constructors.add(Constructor((b) => b
          ..constant = false
          ..requiredParameters.add(Parameter((b) => b
            ..toThis = false
            ..required = false
            ..named = false
            ..type = constants.provider
            ..name = 'provider'))
          ..initializers.addAll([
            Code('query = Queries(provider)'),
            Code('constant = Constants()'),
          ])))
        ..fields.addAll([
          Field((b) => b
            ..name = 'query'
            ..type = refer('Queries')
            ..modifier = FieldModifier.final$),
          Field((b) => b
            ..name = 'constant'
            ..type = refer('Constants')
            ..modifier = FieldModifier.final$)
        ]);
    });
