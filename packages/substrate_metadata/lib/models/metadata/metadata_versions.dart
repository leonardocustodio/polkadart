// ignore_for_file: camel_case_types, overridden_fields

part of models;

class Metadata_V9 extends Metadata {
  const Metadata_V9({super.value}) : super(version: 9);

  /// Creates Class Object from `Json`
  static Metadata_V9 fromJson(Map<String, dynamic> map) =>
      Metadata_V9(value: MetadataV9.fromJson(map));

  /// Creates `Map` from Class Object
  Map<String, dynamic> toJson() => value.toJson();
}

class Metadata_V10 extends Metadata {
  const Metadata_V10({super.value}) : super(version: 10);

  /// Creates Class Object from `Json`
  static Metadata_V10 fromJson(Map<String, dynamic> map) =>
      Metadata_V10(value: MetadataV10.fromJson(map));

  /// Creates `Map` from Class Object
  Map<String, dynamic> toJson() => value.toJson();
}

class Metadata_V11 extends Metadata {
  const Metadata_V11({super.value}) : super(version: 11);

  /// Creates Class Object from `Json`
  static Metadata_V11 fromJson(Map<String, dynamic> map) =>
      Metadata_V11(value: MetadataV11.fromJson(map));

  /// Creates `Map` from Class Object
  Map<String, dynamic> toJson() => value.toJson();
}

class Metadata_V12 extends Metadata {
  const Metadata_V12({super.value}) : super(version: 12);

  /// Creates Class Object from `Json`
  static Metadata_V12 fromJson(Map<String, dynamic> map) =>
      Metadata_V12(value: MetadataV12.fromJson(map));

  /// Creates `Map` from Class Object
  Map<String, dynamic> toJson() => value.toJson();
}

class Metadata_V13 extends Metadata {
  const Metadata_V13({super.value}) : super(version: 13);

  /// Creates Class Object from `Json`
  static Metadata_V13 fromJson(Map<String, dynamic> map) =>
      Metadata_V13(value: MetadataV13.fromJson(map));

  /// Creates `Map` from Class Object
  Map<String, dynamic> toJson() => value.toJson();
}

class Metadata_V14 extends Metadata {
  const Metadata_V14({super.value}) : super(version: 14);

  /// Creates Class Object from `Json`
  static Metadata_V14 fromJson(Map<String, dynamic> map) =>
      Metadata_V14(value: MetadataV14.fromJson(map));

  /// Creates `Map` from Class Object
  Map<String, dynamic> toJson() => value.toJson();
}

class MetadataV14 {
  PortableRegistryV14? lookup;
  List<PalletMetadataV14>? pallets;
  ExtrinsicMetadataV14? extrinsic;
  int? type;

  MetadataV14({this.lookup, this.pallets, this.extrinsic, this.type});

  /// Creates Class Object from `Json`
  static MetadataV14 fromJson(Map<String, dynamic> map) {
    final obj = MetadataV14(type: map['type']);

    if (map['lookup'] != null) {
      obj.lookup = PortableRegistryV14.fromJson(map['lookup']);
    }

    if (map['extrinsic'] != null) {
      obj.extrinsic = ExtrinsicMetadataV14.fromJson(map['extrinsic']);
    }

    if (map['pallets'] != null) {
      obj.pallets = (map['pallets'] as List)
          .map((value) => PalletMetadataV14.fromJson(value))
          .toList();
    }

    return obj;
  }

  /// Creates `Map` from Class Object
  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};

    if (lookup != null) {
      data['lookup'] = lookup!.toJson();
    }

    if (pallets != null) {
      data['pallets'] = pallets!.map((value) => value.toJson()).toList();
    }

    if (extrinsic != null) {
      data['extrinsic'] = extrinsic!.toJson();
    }

    data['type'] = type;

    return data;
  }
}

class MetadataV9 {
  final List<ModuleMetadataV9> modules;
  const MetadataV9({required this.modules});

  /// Creates Class Object from `Json`
  static MetadataV9 fromJson(Map<String, dynamic> map) => MetadataV9(
      modules: (map['modules'] as List)
          .map((value) => ModuleMetadataV9.fromJson(value))
          .toList());

  /// Creates `Map` from Class Object
  Map<String, dynamic> toJson() => <String, dynamic>{
        'modules': modules.map((value) => value.toJson()).toList(),
      };
}

class MetadataV10 {
  final List<ModuleMetadataV10> modules;
  const MetadataV10({required this.modules});

  /// Creates Class Object from `Json`
  static MetadataV10 fromJson(Map<String, dynamic> map) => MetadataV10(
      modules: (map['modules'] as List)
          .map((value) => ModuleMetadataV10.fromJson(value))
          .toList());

  /// Creates `Map` from Class Object
  Map<String, dynamic> toJson() => <String, dynamic>{
        'modules': modules.map((value) => value.toJson()).toList(),
      };
}

class MetadataV11 {
  final ExtrinsicMetadataV11 extrinsic;
  final List<ModuleMetadataV11> modules;
  const MetadataV11({required this.modules, required this.extrinsic});

  /// Creates Class Object from `Json`
  static MetadataV11 fromJson(Map<String, dynamic> map) => MetadataV11(
      modules: (map['modules'] as List)
          .map((value) => ModuleMetadataV11.fromJson(value))
          .toList(),
      extrinsic: ExtrinsicMetadataV11.fromJson(map['extrinsic']));

  /// Creates `Map` from Class Object
  Map<String, dynamic> toJson() => <String, dynamic>{
        'modules': modules.map((value) => value.toJson()).toList(),
        'extrinsic': extrinsic.toJson(),
      };
}

class MetadataV12 {
  final ExtrinsicMetadataV11 extrinsic;
  final List<ModuleMetadataV12> modules;
  const MetadataV12({required this.modules, required this.extrinsic});

  /// Creates Class Object from `Json`
  static MetadataV12 fromJson(Map<String, dynamic> map) => MetadataV12(
      modules: (map['modules'] as List)
          .map((value) => ModuleMetadataV12.fromJson(value))
          .toList(),
      extrinsic: ExtrinsicMetadataV11.fromJson(map['extrinsic']));

  /// Creates `Map` from Class Object
  Map<String, dynamic> toJson() => <String, dynamic>{
        'modules': modules.map((value) => value.toJson()).toList(),
        'extrinsic': extrinsic.toJson(),
      };
}

class MetadataV13 {
  final ExtrinsicMetadataV11 extrinsic;
  final List<ModuleMetadataV13> modules;
  const MetadataV13({required this.modules, required this.extrinsic});

  /// Creates Class Object from `Json`
  static MetadataV13 fromJson(Map<String, dynamic> map) => MetadataV13(
      modules: (map['modules'] as List)
          .map((value) => ModuleMetadataV13.fromJson(value))
          .toList(),
      extrinsic: ExtrinsicMetadataV11.fromJson(map['extrinsic']));

  /// Creates `Map` from Class Object
  Map<String, dynamic> toJson() => <String, dynamic>{
        'modules': modules.map((value) => value.toJson()).toList(),
        'extrinsic': extrinsic.toJson(),
      };
}