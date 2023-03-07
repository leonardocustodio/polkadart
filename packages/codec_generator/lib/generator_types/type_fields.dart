part of generator_types;

class TypeFields {
  final String fieldType;
  final String fieldVariableName;
  final bool isNullable;
  final bool isGeneric;
  final List<String> docs;

  const TypeFields({
    required this.fieldType,
    required this.fieldVariableName,
    this.isNullable = false,
    this.isGeneric = false,
    this.docs = const <String>[],
  });
}
