import 'package:scale_codec_annotation/scale_codec_annotation.dart';

part 'example.g.dart';

@ScaleCodecSerializable(
  shouldCreateDecodeMethod: true,
  shouldCreateEncodeMethod: true,
)
class Person {
  final String firstName, lastName;

  Person(this.firstName, this.lastName);
}
