import 'package:scale_codec_annotation/scale_codec_annotation.dart';
import 'package:source_gen_test/annotations.dart';

@ShouldThrow('`@ScaleCodecSerializable` can only be used on classes.')
@ScaleCodecSerializable()
enum EnumExample {
  test,
  test2;
}

@ShouldThrow(
    '[ERROR] To many constructors in MultipleConstructors class. Class can have only one constructor')
@ScaleCodecSerializable()
class MultipleConstructors {
  MultipleConstructors();

  factory MultipleConstructors.test() => MultipleConstructors();
}

@ShouldThrow(
    '[ERROR] Class FactoryConstructor cant have one factory constructor')
@ScaleCodecSerializable()
class FactoryConstructor {
  factory FactoryConstructor() => FactoryConstructor();
}

@ShouldThrow('[ERROR] Class AbstractClass cannot be abstract')
@ScaleCodecSerializable()
abstract class AbstractClass {
  AbstractClass();
}

@ShouldGenerate(
    '''extension _\$ValidClassWithAllMethodsExtension on ValidClassWithAllMethods {
  String encode() => '';

  ValidClassWithAllMethods decode(String encodedData) =>
      ValidClassWithAllMethods();
}
''')
@ScaleCodecSerializable()
class ValidClassWithAllMethods {
  ValidClassWithAllMethods();
}

@ShouldGenerate(
    '''extension _\$ValidClassWithEncodeMethodExtension on ValidClassWithEncodeMethod {
  String encode() => '';
}
''')
@ScaleCodecSerializable(shouldCreateDecodeMethod: false)
class ValidClassWithEncodeMethod {
  ValidClassWithEncodeMethod();
}

@ShouldGenerate(
    '''extension _\$ValidClassWithDecodeMethodExtension on ValidClassWithDecodeMethod {
  ValidClassWithDecodeMethod decode(String encodedData) =>
      ValidClassWithDecodeMethod();
}
''')
@ScaleCodecSerializable(shouldCreateEncodeMethod: false)
class ValidClassWithDecodeMethod {
  ValidClassWithDecodeMethod();
}

@ShouldGenerate(
    '''extension _\$ValidClassWithoutMethodsExtension on ValidClassWithoutMethods {}
''')
@ScaleCodecSerializable(
    shouldCreateEncodeMethod: false, shouldCreateDecodeMethod: false)
class ValidClassWithoutMethods {
  ValidClassWithoutMethods();
}

@ShouldGenerate('''extension _\$ValidClassExtension on ValidClass {
  String encode() => '';

  ValidClass decode(String encodedData) => ValidClass();
}
''')
@ScaleCodecSerializable(
    shouldCreateEncodeMethod: true, shouldCreateDecodeMethod: true)
class ValidClass {
  ValidClass();
}
