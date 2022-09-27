import 'package:scale_codec_annotation/scale_codec_annotation.dart';
import 'package:source_gen_test/annotations.dart';

/// [EnumExample] is not a class, so the builder must throw if
/// `@ScaleCodecSerializable` was used with `Enum` types.
///
/// Testing `Enum` edge case.
@ShouldThrow('`@ScaleCodecSerializable` can only be used on classes.')
@ScaleCodecSerializable()
enum EnumExample {
  test,
  test2;
}

/// `@ScaleCodecSerializble` is not supposed to work with class that
/// have `multiple constructors`. So in this case, the builder must
/// throw.
///
/// Testing [MultipleConstructors]` edge case.
@ShouldThrow(
    '[ERROR] To many constructors in MultipleConstructors class. Class can have only one constructor')
@ScaleCodecSerializable()
class MultipleConstructors {
  MultipleConstructors();

  factory MultipleConstructors.test() => MultipleConstructors();
}

/// `@ScaleCodecSerializble` is not supposed to work with class that
/// have `factory constructors`. So in this case, the builder must
/// throw error `Class cant have factory constructors`.
///
/// Testing [FactoryConstructor] edge case.
@ShouldThrow(
    '[ERROR] Class FactoryConstructor cant have one factory constructor')
@ScaleCodecSerializable()
class FactoryConstructor {
  factory FactoryConstructor() => FactoryConstructor();
}

/// `@ScaleCodecSerializble` is not supposed to work with `abstract` classes.
/// So in this case, the builder must
/// throw error `Class cannot be abstract`.
///
/// Testing `FactoryConstructor` edge case.
@ShouldThrow('[ERROR] Class AbstractClass cannot be abstract')
@ScaleCodecSerializable()
abstract class AbstractClass {
  AbstractClass();
}

/// [ValidClassWithAllMethods] test the defaults values of `ClassConfig`.
///
/// The builder must generate the class extension with the two methods:
/// `decode` and `encode` because of the default value of [ClassConfig.default]
/// used in `class_generation_test.dart`.
///
/// The generated file must be equal to `@ShouldGenerate`.
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

/// [ValidClassWithEncodeMethod] test the case when `shouldCreateDecodeMethod`
/// is `false`. Only the encode method should be generated.
///
/// The generated file must be equal to `@ShouldGenerate`.
@ShouldGenerate(
    '''extension _\$ValidClassWithEncodeMethodExtension on ValidClassWithEncodeMethod {
  String encode() => '';
}
''')
@ScaleCodecSerializable(shouldCreateDecodeMethod: false)
class ValidClassWithEncodeMethod {
  ValidClassWithEncodeMethod();
}

/// [ValidClassWithDecodeMethod] test the case when `shouldCreateDecodeMethod`
/// is `false`. Only the encode method should be generated.
///
/// The generated file must be equal to `@ShouldGenerate`.
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

/// [ValidClassWithoutMethods] test the case when `shouldCreateDecodeMethod`
/// is `false` and `shouldCreateEncodeMethod` is `false`.
///
/// Encode method *should not* be generated.
///
/// Decode method *should not* be generated.
///
/// The generated file must be equal to `@ShouldGenerate`.
@ShouldGenerate(
    '''extension _\$ValidClassWithoutMethodsExtension on ValidClassWithoutMethods {}
''')
@ScaleCodecSerializable(
    shouldCreateEncodeMethod: false, shouldCreateDecodeMethod: false)
class ValidClassWithoutMethods {
  ValidClassWithoutMethods();
}

/// [ValidClassWithoutMethods] test the case when `shouldCreateDecodeMethod`
/// is `true` and `shouldCreateEncodeMethod` is `true`.
///
/// Encode method *should* be generated.
///
/// Decode method *should* be generated.
///
/// The generated file must be equal to `@ShouldGenerate`.
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

/// [OnlyEncodeMethod] test the case when `shouldCreateDecodeMethod`
/// is `false` and `shouldCreateEncodeMethod` is `true`.
///
/// Encode method *should* be generated.
///
/// Decode method *should not* be generated.
///
/// The generated file must be equal to `@ShouldGenerate`.
@ShouldGenerate('''extension _\$OnlyEncodeMethodExtension on OnlyEncodeMethod {
  String encode() => '';
}
''')
@ScaleCodecSerializable(
    shouldCreateEncodeMethod: true, shouldCreateDecodeMethod: false)
class OnlyEncodeMethod {
  const OnlyEncodeMethod();
}

/// [OnlyEncodeMethod] test the case when `shouldCreateDecodeMethod`
/// is `true` and `shouldCreateEncodeMethod` is `false`.
///
/// Encode method *should not* be generated.
///
/// Decode method *should* be generated.
///
/// The generated file must be equal to `@ShouldGenerate`.
@ShouldGenerate('''extension _\$OnlyDecodeMethodExtension on OnlyDecodeMethod {
  OnlyDecodeMethod decode(String encodedData) => OnlyDecodeMethod();
}
''')
@ScaleCodecSerializable(
    shouldCreateEncodeMethod: false, shouldCreateDecodeMethod: true)
class OnlyDecodeMethod {
  const OnlyDecodeMethod();
}
