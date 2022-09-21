import 'package:analyzer/dart/element/element.dart';

class Param {
  final String name;
  final String type;
  final bool isNamed;
  final bool isOptional;
  final String? defaultValue;

  const Param({
    required this.type,
    required this.isNamed,
    required this.isOptional,
    this.defaultValue,
    required this.name,
  });

  factory Param.fromElement(ParameterElement element) => Param(
      type: element.type.getDisplayString(withNullability: true),
      isNamed: element.isNamed,
      isOptional: element.isOptional,
      name: element.name);

  bool get isPositional => !isNamed;

  bool get isRequired => !isOptional;

  bool get isRequiredNamed => isRequired && isNamed;

  bool get isRequiredPositional => isRequired && isPositional;

  bool get isOptionalPositional => isOptional && isPositional;

  bool get isOptionalNamed => isOptional && isNamed;

  String get typeWithName => '$type $name';
}
