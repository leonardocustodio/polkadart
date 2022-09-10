// ignore_for_file: camel_case_types

part of models;

class Metadata_V14 extends Metadata {
  final MetadataV14 value;
  const Metadata_V14({required this.value}) : super(kind: 'V14');

  /// Creates Class Object from `Json`
  static Metadata_V14 fromJson(Map<String, dynamic> map) =>
      Metadata_V14(value: MetadataV14.fromJson(map));
}

class MetadataV14 {
  PortableRegistryV14? lookup;
  List<PalletMetadataV14>? pallets;
  ExtrinsicMetadataV14? extrinsic;
  int? type;

  MetadataV14({this.lookup, this.pallets, this.extrinsic, this.type});

  /// Creates Class Object from `Json`
  static MetadataV14 fromJson(Map<String, dynamic> map) {
    var obj = MetadataV14(type: map['type']);

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
}
