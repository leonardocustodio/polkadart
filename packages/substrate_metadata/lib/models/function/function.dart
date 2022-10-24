part of models;

class FunctionMetadataV9 {
  final String name;
  final List<FunctionArgumentMetadataV9> args;
  final List<String> docs;

  const FunctionMetadataV9(
      {required this.name, required this.args, required this.docs});

  /// Creates Class Object from `Json`
  static FunctionMetadataV9 fromJson(Map<String, dynamic> map) =>
      FunctionMetadataV9(
          name: map['name'],
          docs: (map['docs'] as List).cast<String>(),
          args: (map['args'] as List)
              .map((value) => FunctionArgumentMetadataV9.fromJson(value))
              .toList());
}

class FunctionArgumentMetadataV9 {
  final String name;
  final String type;

  const FunctionArgumentMetadataV9({required this.name, required this.type});

  /// Creates Class Object from `Json`
  static FunctionArgumentMetadataV9 fromJson(Map<String, dynamic> map) =>
      FunctionArgumentMetadataV9(name: map['name'], type: map['type']);
}
