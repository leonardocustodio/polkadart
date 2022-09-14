import 'package:scale_codec_annotation/scale_codec_annotation.dart';

part 'example.g.dart';

@ScaleCodecSerializable()
class Person {
  final String firstName, lastName;

  Person(this.firstName, this.lastName);
}

void main() {
  //final teste = Person(firstName: 'Gabriel', lastName: 'Okura');
}
