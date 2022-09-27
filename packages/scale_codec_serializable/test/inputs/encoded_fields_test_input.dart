import 'package:scale_codec_annotation/scale_codec_annotation.dart';
import 'package:source_gen_test/annotations.dart';

/// Testing `generateEncodedFields()` in `../templates/all_params_template.dart`.
/// The generated file must be equal to `@ShouldGenerate`.
//TODO: add all substrate types scenarios

/// [OneStringField] should generate one class extension without
/// `decode` and `encode` methods.
///
/// [OneStringField] should generate a new param called
/// `exampleEncoded` with [example] value encoded.
@ShouldGenerate('''extension _\$OneStringFieldExtension on OneStringField {
  String get exampleEncoded => 'TODO: encode example';
}
''')
@ScaleCodecSerializable(
  shouldCreateDecodeMethod: false,
  shouldCreateEncodeMethod: false,
)
class OneStringField {
  final String example;

  const OneStringField(this.example);
}

/// [TwoStringFields] should generate one class extension without
/// `decode` and `encode` methods.
///
/// [TwoStringFields] should generate `two` new params called:
///
///   -`exampleEncoded` with [example] `string` value encoded.
///
///    -`example2Encoded` with [example2] `string` value encoded.
@ShouldGenerate('''extension _\$TwoStringFieldsExtension on TwoStringFields {
  String get exampleEncoded => 'TODO: encode example';
  String get example2Encoded => 'TODO: encode example2';
}
''')
@ScaleCodecSerializable(
  shouldCreateDecodeMethod: false,
  shouldCreateEncodeMethod: false,
)
class TwoStringFields {
  final String example;
  final String example2;

  const TwoStringFields(this.example, this.example2);
}

/// [DoubleField] should generate one class extension without
/// `decode` and `encode` methods.
///
/// [DoubleField] should generate a new param called
/// `exampleEncoded` with [example] `double` value encoded.
@ShouldGenerate('''extension _\$DoubleFieldExtension on DoubleField {
  String get exampleEncoded => 'TODO: encode example';
}
''')
@ScaleCodecSerializable(
  shouldCreateDecodeMethod: false,
  shouldCreateEncodeMethod: false,
)
class DoubleField {
  final double example;

  const DoubleField(this.example);
}

/// [BooleanField] should generate one class extension without
/// `decode` and `encode` methods.
///
/// [BooleanField] should generate a new param called
/// `exampleEncoded` with [example] `bool` value encoded.
@ShouldGenerate('''extension _\$BooleanFieldExtension on BooleanField {
  String get exampleEncoded => 'TODO: encode example';
}
''')
@ScaleCodecSerializable(
  shouldCreateDecodeMethod: false,
  shouldCreateEncodeMethod: false,
)
class BooleanField {
  final bool example;

  const BooleanField(this.example);
}

/// [IntegerField] should generate one class extension without
/// `decode` and `encode` methods.
///
/// [IntegerField] should generate a new param called
/// `exampleEncoded` with [example] `int` value encoded.
@ShouldGenerate('''extension _\$IntegerFieldExtension on IntegerField {
  String get exampleEncoded => 'TODO: encode example';
}
''')
@ScaleCodecSerializable(
  shouldCreateDecodeMethod: false,
  shouldCreateEncodeMethod: false,
)
class IntegerField {
  final int example;

  const IntegerField(this.example);
}

/// [BigIntField] should generate one class extension without
/// `decode` and `encode` methods.
///
/// [BigIntField] should generate a new param called
/// `exampleEncoded` with [example] `BigInt` value encoded.
@ShouldGenerate('''extension _\$BigIntFieldExtension on BigIntField {
  String get exampleEncoded => 'TODO: encode example';
}
''')
@ScaleCodecSerializable(
  shouldCreateDecodeMethod: false,
  shouldCreateEncodeMethod: false,
)
class BigIntField {
  final BigInt example;

  const BigIntField(this.example);
}

/// [MapField] should generate one class extension without
/// `decode` and `encode` methods.
///
/// [MapField] should generate a new param called
/// `exampleEncoded` with [example] `Map<dynamic, dynamic>`
///  value encoded.
@ShouldGenerate('''extension _\$MapFieldExtension on MapField {
  String get exampleEncoded => 'TODO: encode example';
}
''')
@ScaleCodecSerializable(
  shouldCreateDecodeMethod: false,
  shouldCreateEncodeMethod: false,
)
class MapField {
  final Map<dynamic, dynamic> example;

  const MapField(this.example);
}

/// [ListField] should generate one class extension without
/// `decode` and `encode` methods.
///
/// [ListField] should generate a new param called
/// `exampleEncoded` with [example] `List<dynamic>` value encoded.
@ShouldGenerate('''extension _\$ListFieldExtension on ListField {
  String get exampleEncoded => 'TODO: encode example';
}
''')
@ScaleCodecSerializable(
  shouldCreateDecodeMethod: false,
  shouldCreateEncodeMethod: false,
)
class ListField {
  final List<dynamic> example;

  const ListField(this.example);
}

/// [NumberField] should generate one class extension without
/// `decode` and `encode` methods.
///
/// [NumberField] should generate a new param called
/// `exampleEncoded` with [example] `num` value encoded.
@ShouldGenerate('''extension _\$NumberFieldExtension on NumberField {
  String get exampleEncoded => 'TODO: encode example';
}
''')
@ScaleCodecSerializable(
  shouldCreateDecodeMethod: false,
  shouldCreateEncodeMethod: false,
)
class NumberField {
  final num example;

  const NumberField(this.example);
}

/// [SetField] should generate one class extension without
/// `decode` and `encode` methods.
///
/// [SetField] should generate a new param called
/// `exampleEncoded` with [example] `Set<dynamic>` value encoded.
@ShouldGenerate('''extension _\$SetFieldExtension on SetField {
  String get exampleEncoded => 'TODO: encode example';
}
''')
@ScaleCodecSerializable(
  shouldCreateDecodeMethod: false,
  shouldCreateEncodeMethod: false,
)
class SetField {
  final Set<dynamic> example;

  const SetField(this.example);
}
