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
    var obj = PalletMetadataV14(
        name: map['name'],
        index: map['index'],
        constants: (map['constants'] as List)
            .map((value) => PalletConstantMetadataV14.fromJson(value))
            .toList());

    if (map['storage'] != null &&
        map['storage'] is scale_codec.Some &&
        (map['storage'] as scale_codec.Some).value != null) {
      obj.storage = PalletStorageMetadataV14.fromJson(map['storage'].value);
    }

    if (map['calls'] != null &&
        map['calls'] is scale_codec.Some &&
        (map['calls'] as scale_codec.Some).value != null) {
      obj.calls = PalletCallMetadataV14.fromJson(map['calls'].value);
    }

    if (map['events'] != null &&
        map['events'] is scale_codec.Some &&
        (map['events'] as scale_codec.Some).value != null) {
      obj.events = PalletEventMetadataV14.fromJson(map['events'].value);
    }

    if (map['errors'] != null &&
        map['errors'] is scale_codec.Some &&
        (map['errors'] as scale_codec.Some).value != null) {
      obj.errors = PalletErrorMetadataV14.fromJson(map['errors'].value);
    }

    return obj;
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
              .toList());
}

class PalletCallMetadataV14 {
  final int type;
  const PalletCallMetadataV14({required this.type});

  /// Creates Class Object from `Json`
  static PalletCallMetadataV14 fromJson(Map<String, dynamic> map) =>
      PalletCallMetadataV14(type: map['type']);
}

class PalletEventMetadataV14 {
  final int type;
  const PalletEventMetadataV14({required this.type});

  /// Creates Class Object from `Json`
  static PalletEventMetadataV14 fromJson(Map<String, dynamic> map) =>
      PalletEventMetadataV14(type: map['type']);
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
}

class PalletErrorMetadataV14 {
  final int type;
  const PalletErrorMetadataV14({required this.type});

  /// Creates Class Object from `Json`
  static PalletErrorMetadataV14 fromJson(Map<String, dynamic> map) =>
      PalletErrorMetadataV14(type: map['type']);
}
