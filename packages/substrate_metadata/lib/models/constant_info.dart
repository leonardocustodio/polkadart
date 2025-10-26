part of models;

class ConstantInfo {
  final String name;
  final PortableType type;
  final int typeId;
  final Uint8List value;
  final List<String> docs;
  final String palletName;

  const ConstantInfo({
    required this.name,
    required this.type,
    required this.typeId,
    required this.value,
    required this.docs,
    required this.palletName,
  });

  /// Get a human-readable type string
  String get typeString {
    final pathString = type.type.pathString;
    if (pathString != null && pathString.isNotEmpty) {
      return pathString;
    }
    return 'Type#$typeId';
  }

  /// Get the documentation as a single string
  String get documentation => docs.join('\n');

  Map<String, dynamic> toJson() => {
        'name': name,
        'type': typeString,
        'typeId': typeId,
        'value': value.toHexString(),
        'docs': docs,
        'palletName': palletName,
      };
}
