import 'package:analyzer/dart/element/element.dart';
import 'package:source_gen/source_gen.dart';

/// utilities methods which helps with error handling

/// Check if the [ClassElement] is not abstract.
void assertClassIsNotAbstract(ClassElement element) {
  if (element.isAbstract) {
    throw InvalidGenerationSourceError(
      '[ERROR] Class ${element.name} cannot be abstract',
      element: element,
    );
  }
}

/// Check if the class has only `one` default `const factory` constructor.
///
/// Used to avoid errors when decoding `Substrate` classes data.
void assertOneConstFactoryConstructor(ClassElement element) {
  final constructorElements = element.constructors;

  if (constructorElements.length != 1) {
    throw InvalidGenerationSourceError(
      '[ERROR] To many constructors in ${element.name} class. Class can have only one constructor',
      element: element,
    );
  }
}
