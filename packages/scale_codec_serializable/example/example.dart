import 'package:scale_codec_annotation/scale_codec_annotation.dart';

part 'example.g.dart';

@ScaleCodecSerializable()
class Person {
  final String firstName;
  final String lastName;
  final bool isYoung;

  Person(
      {required this.firstName, required this.lastName, this.isYoung = false});
}
