import 'package:scale_codec_annotation/scale_codec_annotation.dart';

void main() {}

@ScaleCodecSerializable()
class Person {
  final String firstName, lastName;

  Person({required this.firstName, required this.lastName});
}
