// ignore_for_file: camel_case_types, overridden_fields

part of models;

class Metadata_V14 extends Metadata {
  const Metadata_V14({super.value}) : super(version: 14);

  /// Creates Class Object from `Json`
  static Metadata_V14 fromJson(Map<String, dynamic> map) =>
      Metadata_V14(value: MetadataV14.fromJson(map));

  /// Creates `Map` from Class Object
  Map<String, dynamic> toJson() => value.toJson();
}

class MetadataV14 {
  final PortableRegistryV14 lookup;
  final List<PalletMetadataV14> pallets;
  final ExtrinsicMetadataV14 extrinsic;
  final int type;

  const MetadataV14({
    required this.lookup,
    required this.pallets,
    required this.extrinsic,
    required this.type,
  });

  /// Creates Class Object from `Json`
  static MetadataV14 fromJson(Map<String, dynamic> map) {
    return MetadataV14(
        type: map['type'],
        lookup: PortableRegistryV14.fromJson(map['lookup']),
        pallets: (map['pallets'] as List)
            .map((value) => PalletMetadataV14.fromJson(value))
            .toList(growable: false),
        extrinsic: ExtrinsicMetadataV14.fromJson(map['extrinsic']));
  }

  /// Creates `Map` from Class Object
  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'lookup': lookup.toJson(),
      'pallets': pallets.map((value) => value.toJson()).toList(growable: false),
      'extrinsic': extrinsic.toJson(),
      'type': type,
    };
  }
}
