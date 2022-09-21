import 'package:scale_codec_annotation/scale_codec_annotation.dart';
import 'package:source_gen_test/annotations.dart';

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
