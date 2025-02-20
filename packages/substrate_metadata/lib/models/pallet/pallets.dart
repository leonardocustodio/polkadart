part of models;

class PalletMetadataV14 {
  final String name;
  PalletStorageMetadataV14? storage;
  PalletCallMetadataV14? calls;
  PalletEventMetadataV14? events;
  final List<PalletConstantMetadataV14> constants;
  PalletErrorMetadataV14? errors;
  final int index;

  PalletMetadataV14(
      {required this.name,
      this.storage,
      this.calls,
      this.events,
      required this.constants,
      this.errors,
      required this.index});

  /// Creates Class Object from `Json`
  static PalletMetadataV14 fromJson(Map<String, dynamic> map) {
    final obj = PalletMetadataV14(
        name: map['name'],
        index: map['index'],
        constants: (map['constants'] as List)
            .map((value) => PalletConstantMetadataV14.fromJson(value))
            .toList(growable: false));

    if (map['storage'] != null &&
        map['storage'] is Option &&
        (map['storage'] as Option).value != null) {
      obj.storage = PalletStorageMetadataV14.fromJson(map['storage'].value);
    }

    if (map['calls'] != null &&
        map['calls'] is Option &&
        (map['calls'] as Option).value != null) {
      obj.calls = PalletCallMetadataV14.fromJson(map['calls'].value);
    }

    if (map['events'] != null &&
        map['events'] is Option &&
        (map['events'] as Option).value != null) {
      obj.events = PalletEventMetadataV14.fromJson(map['events'].value);
    }

    if (map['errors'] != null &&
        map['errors'] is Option &&
        (map['errors'] as Option).value != null) {
      obj.errors = PalletErrorMetadataV14.fromJson(map['errors'].value);
    }

    return obj;
  }

  /// Creates `Map` from Class Object
  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['name'] = name;

    final localStorage = storage?.toJson();
    data['storage'] = localStorage != null ? Option.some(localStorage) : None;

    final localCalls = calls?.toJson();
    data['calls'] = localCalls != null ? Option.some(localCalls) : None;

    final localEvents = events?.toJson();
    data['events'] = localEvents != null ? Option.some(localEvents) : None;

    data['constants'] = constants
        .map((PalletConstantMetadataV14 value) => value.toJson())
        .toList(growable: false);

    final localErrors = errors?.toJson();
    data['errors'] = localErrors != null ? Option.some(localErrors) : None;

    data['index'] = index;

    return data;
  }
}

class PalletStorageMetadataV14 {
  final String prefix;
  final List<StorageEntryMetadataV14> items;
  const PalletStorageMetadataV14({required this.prefix, required this.items});

  /// Creates Class Object from `Json`
  static PalletStorageMetadataV14 fromJson(Map<String, dynamic> map) =>
      PalletStorageMetadataV14(
          prefix: map['prefix'],
          items: (map['items'] as List)
              .map((value) => StorageEntryMetadataV14.fromJson(value))
              .toList(growable: false));

  /// Creates `Map` from Class Object
  Map<String, dynamic> toJson() => {
        'prefix': prefix,
        'items': items
            .map((StorageEntryMetadataV14 value) => value.toJson())
            .toList(growable: false),
      };
}

class PalletCallMetadataV14 {
  final int type;
  const PalletCallMetadataV14({required this.type});

  /// Creates Class Object from `Json`
  static PalletCallMetadataV14 fromJson(Map<String, dynamic> map) =>
      PalletCallMetadataV14(type: map['type']);

  /// Creates `Map` from Class Object
  Map<String, dynamic> toJson() => {
        'type': type,
      };
}

class PalletEventMetadataV14 {
  final int type;
  const PalletEventMetadataV14({required this.type});

  /// Creates Class Object from `Json`
  static PalletEventMetadataV14 fromJson(Map<String, dynamic> map) =>
      PalletEventMetadataV14(type: map['type']);

  /// Creates `Map` from Class Object
  Map<String, dynamic> toJson() => {
        'type': type,
      };
}

class PalletConstantMetadataV14 {
  final String name;
  final int type;
  final Uint8List value;
  final List<String> docs;

  const PalletConstantMetadataV14(
      {required this.name,
      required this.type,
      required this.value,
      required this.docs});

  /// Creates Class Object from `Json`
  static PalletConstantMetadataV14 fromJson(Map<String, dynamic> map) =>
      PalletConstantMetadataV14(
          name: map['name'],
          type: map['type'],
          value: Uint8List.fromList((map['value'] as List).cast<int>()),
          docs: (map['docs'] as List).cast<String>());

  /// Creates `Map` from Class Object
  Map<String, dynamic> toJson() => {
        'name': name,
        'type': type,
        'value': value.toList(growable: false),
        'docs': docs,
      };
}

class PalletErrorMetadataV14 {
  final int type;
  const PalletErrorMetadataV14({required this.type});

  /// Creates Class Object from `Json`
  static PalletErrorMetadataV14 fromJson(Map<String, dynamic> map) =>
      PalletErrorMetadataV14(type: map['type']);

  /// Creates `Map` from Class Object
  Map<String, dynamic> toJson() => {
        'type': type,
      };
}
