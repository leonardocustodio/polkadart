part of multisig;

/// Converter for Uint8List to/from JSON
class Uint8ListConverter extends JsonConverter<Uint8List, List<int>> {
  const Uint8ListConverter();

  @override
  Uint8List fromJson(List<int> json) => Uint8List.fromList(json);

  @override
  List<int> toJson(Uint8List object) => object.toList();
}

/// Converter for List<Uint8List> to/from JSON
class Uint8ListListConverter extends JsonConverter<List<Uint8List>, List<dynamic>> {
  const Uint8ListListConverter();

  @override
  List<Uint8List> fromJson(List<dynamic> json) =>
      json.map((e) => Uint8List.fromList((e as List).cast<int>())).toList();

  @override
  List<List<int>> toJson(List<Uint8List> object) => object.map((e) => e.toList()).toList();
}
