// ignore_for_file: overridden_fields

part of models;

abstract class AnyLegacyModule {
  final String name;
  List<FunctionMetadataV9>? calls;
  List<EventMetadataV9>? events;
  final List<ModuleConstantMetadataV9> constants;
  final List<ErrorMetadataV9> errors;

  AnyLegacyModule(
      {required this.name,
      this.calls,
      this.events,
      required this.constants,
      required this.errors});
}

class ModuleMetadataV9 extends AnyLegacyModule {
  StorageMetadataV9? storage;

  ModuleMetadataV9(
      {required super.name,
      this.storage,
      super.calls,
      super.events,
      required super.constants,
      required super.errors});

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

    if (map['storage'] != null &&
        map['storage'] is scale_codec.Some &&
        (map['storage'] as scale_codec.Some).value != null) {
      obj.storage = StorageMetadataV9.fromJson(map['storage'].value);
    }

    if (map['calls'] != null &&
        map['calls'] is scale_codec.Some &&
        (map['calls'] as scale_codec.Some).value != null) {
      obj.calls = (map['calls'].value as List)
          .map((val) => FunctionMetadataV9.fromJson(val))
          .toList();
    }

    if (map['events'] != null &&
        map['events'] is scale_codec.Some &&
        (map['events'] as scale_codec.Some).value != null) {
      obj.events = (map['events'].value as List)
          .map((val) => EventMetadataV9.fromJson(val))
          .toList();
    }
    return obj;
  }
}

class ModuleMetadataV10 extends AnyLegacyModule {
  StorageMetadataV10? storage;

  ModuleMetadataV10(
      {required super.name,
      this.storage,
      super.calls,
      super.events,
      required super.constants,
      required super.errors});

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

    if (map['storage'] != null &&
        map['storage'] is scale_codec.Some &&
        (map['storage'] as scale_codec.Some).value != null) {
      obj.storage = StorageMetadataV10.fromJson(map['storage'].value);
    }

    if (map['calls'] != null &&
        map['calls'] is scale_codec.Some &&
        (map['calls'] as scale_codec.Some).value != null) {
      obj.calls = (map['calls'].value as List)
          .map((val) => FunctionMetadataV9.fromJson(val))
          .toList();
    }

    if (map['events'] != null &&
        map['events'] is scale_codec.Some &&
        (map['events'] as scale_codec.Some).value != null) {
      obj.events = (map['events'].value as List)
          .map((val) => EventMetadataV9.fromJson(val))
          .toList();
    }
    return obj;
  }
}

class ModuleMetadataV11 extends AnyLegacyModule {
  StorageMetadataV11? storage;

  ModuleMetadataV11(
      {required super.name,
      this.storage,
      super.calls,
      super.events,
      required super.constants,
      required super.errors});

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

    if (map['storage'] != null &&
        map['storage'] is scale_codec.Some &&
        (map['storage'] as scale_codec.Some).value != null) {
      obj.storage = StorageMetadataV11.fromJson(map['storage'].value);
    }

    if (map['calls'] != null &&
        map['calls'] is scale_codec.Some &&
        (map['calls'] as scale_codec.Some).value != null) {
      obj.calls = (map['calls'].value as List)
          .map((val) => FunctionMetadataV9.fromJson(val))
          .toList();
    }

    if (map['events'] != null &&
        map['events'] is scale_codec.Some &&
        (map['events'] as scale_codec.Some).value != null) {
      obj.events = (map['events'].value as List)
          .map((val) => EventMetadataV9.fromJson(val))
          .toList();
    }
    return obj;
  }
}

class ModuleMetadataV12 extends AnyLegacyModule {
  final int index;
  StorageMetadataV11? storage;

  ModuleMetadataV12(
      {required super.name,
      required this.index,
      this.storage,
      super.calls,
      super.events,
      required super.constants,
      required super.errors});

  /// Creates Class Object from `Json`
  static ModuleMetadataV12 fromJson(Map<String, dynamic> map) {
    var obj = ModuleMetadataV12(
      name: map['name'],
      index: map['index'],
      constants: (map['constants'] as List)
          .map((val) => ModuleConstantMetadataV9.fromJson(val))
          .toList(),
      errors: (map['errors'] as List)
          .map((val) => ErrorMetadataV9.fromJson(val))
          .toList(),
    );

    if (map['storage'] != null &&
        map['storage'] is scale_codec.Some &&
        (map['storage'] as scale_codec.Some).value != null) {
      obj.storage = StorageMetadataV11.fromJson(map['storage'].value);
    }

    if (map['calls'] != null &&
        map['calls'] is scale_codec.Some &&
        (map['calls'] as scale_codec.Some).value != null) {
      obj.calls = (map['calls'].value as List)
          .map((val) => FunctionMetadataV9.fromJson(val))
          .toList();
    }

    if (map['events'] != null &&
        map['events'] is scale_codec.Some &&
        (map['events'] as scale_codec.Some).value != null) {
      obj.events = (map['events'].value as List)
          .map((val) => EventMetadataV9.fromJson(val))
          .toList();
    }
    return obj;
  }
}

class ModuleMetadataV13 extends AnyLegacyModule {
  final int index;
  StorageMetadataV13? storage;

  ModuleMetadataV13(
      {required super.name,
      required this.index,
      this.storage,
      super.calls,
      super.events,
      required super.constants,
      required super.errors});

  /// Creates Class Object from `Json`
  static ModuleMetadataV13 fromJson(Map<String, dynamic> map) {
    var obj = ModuleMetadataV13(
      name: map['name'],
      index: map['index'],
      constants: (map['constants'] as List)
          .map((val) => ModuleConstantMetadataV9.fromJson(val))
          .toList(),
      errors: (map['errors'] as List)
          .map((val) => ErrorMetadataV9.fromJson(val))
          .toList(),
    );

    if (map['storage'] != null &&
        map['storage'] is scale_codec.Some &&
        (map['storage'] as scale_codec.Some).value != null) {
      obj.storage = StorageMetadataV13.fromJson(map['storage'].value);
    }

    if (map['calls'] != null &&
        map['calls'] is scale_codec.Some &&
        (map['calls'] as scale_codec.Some).value != null) {
      obj.calls = (map['calls'].value as List)
          .map((val) => FunctionMetadataV9.fromJson(val))
          .toList();
    }

    if (map['events'] != null &&
        map['events'] is scale_codec.Some &&
        (map['events'] as scale_codec.Some).value != null) {
      obj.events = (map['events'].value as List)
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
