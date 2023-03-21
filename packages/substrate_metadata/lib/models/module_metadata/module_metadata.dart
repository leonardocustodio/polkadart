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

  /// Creates Map from Class Object
  Map<String, dynamic> toJson();
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
    final obj = ModuleMetadataV9(
      name: map['name'],
      constants: (map['constants'] as List)
          .map((val) => ModuleConstantMetadataV9.fromJson(val))
          .toList(growable: false),
      errors: (map['errors'] as List)
          .map((val) => ErrorMetadataV9.fromJson(val))
          .toList(growable: false),
    );

    if (map['storage'] != null &&
        map['storage'] is Option &&
        (map['storage'] as Option).value != null) {
      obj.storage = StorageMetadataV9.fromJson(map['storage'].value);
    }

    if (map['calls'] != null &&
        map['calls'] is Option &&
        (map['calls'] as Option).value != null) {
      obj.calls = (map['calls'].value as List)
          .map((val) => FunctionMetadataV9.fromJson(val))
          .toList(growable: false);
    }

    if (map['events'] != null &&
        map['events'] is Option &&
        (map['events'] as Option).value != null) {
      obj.events = (map['events'].value as List)
          .map((val) => EventMetadataV9.fromJson(val))
          .toList(growable: false);
    }
    return obj;
  }

  @override
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['name'] = name;

    final localStorage = storage?.toJson();
    map['storage'] = localStorage == null ? None : Option.some(localStorage);

    final localCalls = calls?.map((e) => e.toJson()).toList(growable: false);
    map['calls'] = localCalls == null ? None : Option.some(localCalls);

    final localEvents = events?.map((e) => e.toJson()).toList(growable: false);
    map['events'] = localEvents == null ? None : Option.some(localEvents);

    map['constants'] = constants.map((e) => e.toJson()).toList(growable: false);

    map['errors'] = errors.map((e) => e.toJson()).toList(growable: false);
    return map;
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
    final obj = ModuleMetadataV10(
      name: map['name'],
      constants: (map['constants'] as List)
          .map((val) => ModuleConstantMetadataV9.fromJson(val))
          .toList(growable: false),
      errors: (map['errors'] as List)
          .map((val) => ErrorMetadataV9.fromJson(val))
          .toList(growable: false),
    );

    if (map['storage'] != null &&
        map['storage'] is Option &&
        (map['storage'] as Option).value != null) {
      obj.storage = StorageMetadataV10.fromJson(map['storage'].value);
    }

    if (map['calls'] != null &&
        map['calls'] is Option &&
        (map['calls'] as Option).value != null) {
      obj.calls = (map['calls'].value as List)
          .map((val) => FunctionMetadataV9.fromJson(val))
          .toList(growable: false);
    }

    if (map['events'] != null &&
        map['events'] is Option &&
        (map['events'] as Option).value != null) {
      obj.events = (map['events'].value as List)
          .map((val) => EventMetadataV9.fromJson(val))
          .toList(growable: false);
    }
    return obj;
  }

  @override
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['name'] = name;

    final localStorage = storage?.toJson();
    map['storage'] = localStorage == null ? None : Option.some(localStorage);

    final localCalls = calls?.map((e) => e.toJson()).toList(growable: false);
    map['calls'] = localCalls == null ? None : Option.some(localCalls);

    final localEvents = events?.map((e) => e.toJson()).toList(growable: false);
    map['events'] = localEvents == null ? None : Option.some(localEvents);

    map['constants'] = constants.map((e) => e.toJson()).toList(growable: false);

    map['errors'] = errors.map((e) => e.toJson()).toList(growable: false);
    return map;
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
    final obj = ModuleMetadataV11(
      name: map['name'],
      constants: (map['constants'] as List)
          .map((val) => ModuleConstantMetadataV9.fromJson(val))
          .toList(growable: false),
      errors: (map['errors'] as List)
          .map((val) => ErrorMetadataV9.fromJson(val))
          .toList(growable: false),
    );

    if (map['storage'] != null &&
        map['storage'] is Option &&
        (map['storage'] as Option).value != null) {
      obj.storage = StorageMetadataV11.fromJson(map['storage'].value);
    }

    if (map['calls'] != null &&
        map['calls'] is Option &&
        (map['calls'] as Option).value != null) {
      obj.calls = (map['calls'].value as List)
          .map((val) => FunctionMetadataV9.fromJson(val))
          .toList(growable: false);
    }

    if (map['events'] != null &&
        map['events'] is Option &&
        (map['events'] as Option).value != null) {
      obj.events = (map['events'].value as List)
          .map((val) => EventMetadataV9.fromJson(val))
          .toList(growable: false);
    }
    return obj;
  }

  @override
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['name'] = name;

    final localStorage = storage?.toJson();
    map['storage'] = localStorage == null ? None : Option.some(localStorage);

    final localCalls = calls?.map((e) => e.toJson()).toList(growable: false);
    map['calls'] = localCalls == null ? None : Option.some(localCalls);

    final localEvents = events?.map((e) => e.toJson()).toList(growable: false);
    map['events'] = localEvents == null ? None : Option.some(localEvents);

    map['constants'] = constants.map((e) => e.toJson()).toList(growable: false);

    map['errors'] = errors.map((e) => e.toJson()).toList(growable: false);
    return map;
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
    final obj = ModuleMetadataV12(
      name: map['name'],
      index: map['index'],
      constants: (map['constants'] as List)
          .map((val) => ModuleConstantMetadataV9.fromJson(val))
          .toList(growable: false),
      errors: (map['errors'] as List)
          .map((val) => ErrorMetadataV9.fromJson(val))
          .toList(growable: false),
    );

    if (map['storage'] != null &&
        map['storage'] is Option &&
        (map['storage'] as Option).value != null) {
      obj.storage = StorageMetadataV11.fromJson(map['storage'].value);
    }

    if (map['calls'] != null &&
        map['calls'] is Option &&
        (map['calls'] as Option).value != null) {
      obj.calls = (map['calls'].value as List)
          .map((val) => FunctionMetadataV9.fromJson(val))
          .toList(growable: false);
    }

    if (map['events'] != null &&
        map['events'] is Option &&
        (map['events'] as Option).value != null) {
      obj.events = (map['events'].value as List)
          .map((val) => EventMetadataV9.fromJson(val))
          .toList(growable: false);
    }
    return obj;
  }

  @override
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['name'] = name;

    final localStorage = storage?.toJson();
    map['storage'] = localStorage == null ? None : Option.some(localStorage);

    final localCalls = calls?.map((e) => e.toJson()).toList(growable: false);
    map['calls'] = localCalls == null ? None : Option.some(localCalls);

    final localEvents = events?.map((e) => e.toJson()).toList(growable: false);
    map['events'] = localEvents == null ? None : Option.some(localEvents);

    map['constants'] = constants.map((e) => e.toJson()).toList(growable: false);

    map['errors'] = errors.map((e) => e.toJson()).toList(growable: false);

    map['index'] = index;
    return map;
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
    final obj = ModuleMetadataV13(
      name: map['name'],
      index: map['index'],
      constants: (map['constants'] as List)
          .map((val) => ModuleConstantMetadataV9.fromJson(val))
          .toList(growable: false),
      errors: (map['errors'] as List)
          .map((val) => ErrorMetadataV9.fromJson(val))
          .toList(growable: false),
    );

    if (map['storage'] != null &&
        map['storage'] is Option &&
        (map['storage'] as Option).value != null) {
      obj.storage = StorageMetadataV13.fromJson(map['storage'].value);
    }

    if (map['calls'] != null &&
        map['calls'] is Option &&
        (map['calls'] as Option).value != null) {
      obj.calls = (map['calls'].value as List)
          .map((val) => FunctionMetadataV9.fromJson(val))
          .toList(growable: false);
    }

    if (map['events'] != null &&
        map['events'] is Option &&
        (map['events'] as Option).value != null) {
      obj.events = (map['events'].value as List)
          .map((val) => EventMetadataV9.fromJson(val))
          .toList(growable: false);
    }
    return obj;
  }

  @override
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['name'] = name;

    final localStorage = storage?.toJson();
    map['storage'] = localStorage == null ? None : Option.some(localStorage);

    final localCalls = calls?.map((e) => e.toJson()).toList(growable: false);
    map['calls'] = localCalls == null ? None : Option.some(localCalls);

    final localEvents = events?.map((e) => e.toJson()).toList(growable: false);
    map['events'] = localEvents == null ? None : Option.some(localEvents);

    map['constants'] = constants.map((e) => e.toJson()).toList(growable: false);

    map['errors'] = errors.map((e) => e.toJson()).toList(growable: false);

    map['index'] = index;
    return map;
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
        value: Uint8List.fromList((map['value'] as List<dynamic>).cast<int>()),
        docs: (map['docs'] as List).cast<String>(),
      );

  /// Creates Map Object from Class Object
  Map<String, dynamic> toJson() => {
        'name': name,
        'type': type,
        'value': value,
        'docs': docs,
      };
}
