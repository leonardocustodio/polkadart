part of models;

class ModuleMetadataV9 {
  final String name;
  StorageMetadataV9? storage;
  List<FunctionMetadataV9>? calls;
  List<EventMetadataV9>? events;
  final List<ModuleConstantMetadataV9> constants;
  final List<ErrorMetadataV9> errors;

  ModuleMetadataV9(
      {required this.name,
      this.storage,
      this.calls,
      this.events,
      required this.constants,
      required this.errors});

  /// Creates Class Object from `Json`
  static ModuleMetadataV9 fromJson(Map<String, dynamic> map) {
    var obj = ModuleMetadataV9(
      name: map['name'],
      constants: (map['constants'] as List)
          .map((val) => ModuleConstantMetadataV9.fromJson(val))
          .toList(),
      errors: (map['errors'] as List)
          .map((val) => ErrorMetadataV9.fromJson(val))
          .toList(),
    );

    if (map['storage'] != null) {
      obj.storage = StorageMetadataV9.fromJson(map['storage']);
    }

    if (map['calls'] != null) {
      obj.calls = (map['calls'] as List)
          .map((val) => FunctionMetadataV9.fromJson(val))
          .toList();
    }

    if (map['events'] != null) {
      obj.events = (map['events'] as List)
          .map((val) => EventMetadataV9.fromJson(val))
          .toList();
    }
    return obj;
  }
}

class ModuleMetadataV10 {
  final String name;
  StorageMetadataV10? storage;
  List<FunctionMetadataV9>? calls;
  List<EventMetadataV9>? events;
  final List<ModuleConstantMetadataV9> constants;
  final List<ErrorMetadataV9> errors;

  ModuleMetadataV10(
      {required this.name,
      this.storage,
      this.calls,
      this.events,
      required this.constants,
      required this.errors});

  /// Creates Class Object from `Json`
  static ModuleMetadataV10 fromJson(Map<String, dynamic> map) {
    var obj = ModuleMetadataV10(
      name: map['name'],
      constants: (map['constants'] as List)
          .map((val) => ModuleConstantMetadataV9.fromJson(val))
          .toList(),
      errors: (map['errors'] as List)
          .map((val) => ErrorMetadataV9.fromJson(val))
          .toList(),
    );

    if (map['storage'] != null) {
      obj.storage = StorageMetadataV10.fromJson(map['storage']);
    }

    if (map['calls'] != null) {
      obj.calls = (map['calls'] as List)
          .map((val) => FunctionMetadataV9.fromJson(val))
          .toList();
    }

    if (map['events'] != null) {
      obj.events = (map['events'] as List)
          .map((val) => EventMetadataV9.fromJson(val))
          .toList();
    }
    return obj;
  }
}

class ModuleMetadataV11 {
  final String name;
  StorageMetadataV11? storage;
  List<FunctionMetadataV9>? calls;
  List<EventMetadataV9>? events;
  List<ModuleConstantMetadataV9> constants;
  List<ErrorMetadataV9> errors;

  ModuleMetadataV11(
      {required this.name,
      this.storage,
      this.calls,
      this.events,
      required this.constants,
      required this.errors});

  /// Creates Class Object from `Json`
  static ModuleMetadataV11 fromJson(Map<String, dynamic> map) {
    var obj = ModuleMetadataV11(
      name: map['name'],
      constants: (map['constants'] as List)
          .map((val) => ModuleConstantMetadataV9.fromJson(val))
          .toList(),
      errors: (map['errors'] as List)
          .map((val) => ErrorMetadataV9.fromJson(val))
          .toList(),
    );

    if (map['storage'] != null) {
      obj.storage = StorageMetadataV11.fromJson(map['storage']);
    }

    if (map['calls'] != null) {
      obj.calls = (map['calls'] as List)
          .map((val) => FunctionMetadataV9.fromJson(val))
          .toList();
    }

    if (map['events'] != null) {
      obj.events = (map['events'] as List)
          .map((val) => EventMetadataV9.fromJson(val))
          .toList();
    }
    return obj;
  }
}

class ModuleConstantMetadataV9 {
  final String name;
  final String type;
  final Uint8List value;
  final List<String> docs;

  const ModuleConstantMetadataV9({
    required this.name,
    required this.type,
    required this.value,
    required this.docs,
  });

  /// Creates Class Object from `Json`
  static ModuleConstantMetadataV9 fromJson(Map<String, dynamic> map) =>
      ModuleConstantMetadataV9(
        name: map['name'],
        type: map['type'],
        value: Uint8List.fromList(map['value'] as List<int>),
        docs: (map['docs'] as List).cast<String>(),
      );
}
