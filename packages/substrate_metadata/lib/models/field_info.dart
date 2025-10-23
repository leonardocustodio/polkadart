part of models;

/// Metadata about a field
class FieldInfo {
  final String? name;
  final int type;
  final String? typeName;
  final List<String> docs;

  const FieldInfo({
    this.name,
    required this.type,
    this.typeName,
    this.docs = const [],
  });
}
