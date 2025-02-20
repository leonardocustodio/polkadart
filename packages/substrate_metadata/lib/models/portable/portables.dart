part of models;

class PortableRegistryV14 {
  final List<PortableTypeV14> types;
  const PortableRegistryV14({required this.types});

  /// Creates Class Object from `Json`
  static PortableRegistryV14 fromJson(Map<String, dynamic> map) =>
      PortableRegistryV14(
          types: (map['types'] as List)
              .map((value) => PortableTypeV14.fromJson(value))
              .toList(growable: false));

  /// Creates `Map` from Class Object
  Map<String, dynamic> toJson() => {
        'types': types
            .map((PortableTypeV14 value) => value.toJson())
            .toList(growable: false),
      };
}

class PortableTypeV14 {
  final int id;
  final Si1Type type;
  const PortableTypeV14({required this.id, required this.type});

  /// Creates Class Object from `Json`
  static PortableTypeV14 fromJson(Map<String, dynamic> map) => PortableTypeV14(
        id: map['id'],
        type: Si1Type.fromJson(map['type']),
      );

  /// Creates `Map` from Class Object
  Map<String, dynamic> toJson() => {
        'id': id,
        'type': type.toJson(),
      };
}
