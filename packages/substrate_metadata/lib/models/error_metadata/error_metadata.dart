part of models;

class ErrorMetadataV9 {
  final String name;
  final List<String> docs;

  const ErrorMetadataV9({required this.name, required this.docs});

  /// Creates Class Object from `Json`
  static ErrorMetadataV9 fromJson(Map<String, dynamic> map) => ErrorMetadataV9(
        name: map['name'],
        docs: (map['docs'] as List).cast<String>(),
      );

  /// Creates `Map` from Class Object
  Map<String, dynamic> toJson() => {
        'name': name,
        'docs': docs,
      };
}
