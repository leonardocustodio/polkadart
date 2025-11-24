part of multisig;

/// JSON converter for Uint8List byte arrays.
///
/// This converter enables automatic JSON serialization and deserialization of Uint8List
/// objects in classes annotated with @JsonSerializable. Uint8List objects are converted
/// to List<int> for JSON compatibility.
///
/// Used with the @Uint8ListConverter() annotation on fields:
/// ```dart
/// @JsonSerializable()
/// class MyClass {
///   @Uint8ListConverter()
///   final Uint8List publicKey;
/// }
/// ```
class Uint8ListConverter extends JsonConverter<Uint8List, List<int>> {
  /// Creates a const Uint8ListConverter.
  const Uint8ListConverter();

  /// Converts a JSON list of integers to a Uint8List.
  ///
  /// Parameters:
  /// - [json]: The JSON representation as a List<int>
  ///
  /// Returns:
  /// A [Uint8List] constructed from the JSON data.
  @override
  Uint8List fromJson(List<int> json) => Uint8List.fromList(json);

  /// Converts a Uint8List to a JSON-compatible list of integers.
  ///
  /// Parameters:
  /// - [object]: The Uint8List to convert
  ///
  /// Returns:
  /// A [List<int>] suitable for JSON serialization.
  @override
  List<int> toJson(Uint8List object) => object.toList();
}

/// JSON converter for lists of Uint8List byte arrays.
///
/// This converter enables automatic JSON serialization and deserialization of
/// List<Uint8List> objects in classes annotated with @JsonSerializable. Each
/// Uint8List in the list is converted to List<int> for JSON compatibility.
///
/// Used with the @Uint8ListListConverter() annotation on fields:
/// ```dart
/// @JsonSerializable()
/// class MyClass {
///   @Uint8ListListConverter()
///   final List<Uint8List> publicKeys;
/// }
/// ```
class Uint8ListListConverter extends JsonConverter<List<Uint8List>, List<dynamic>> {
  /// Creates a const Uint8ListListConverter.
  const Uint8ListListConverter();

  /// Converts a JSON list of integer lists to a List<Uint8List>.
  ///
  /// Parameters:
  /// - [json]: The JSON representation as List<List<int>>
  ///
  /// Returns:
  /// A [List<Uint8List>] constructed from the JSON data.
  ///
  /// Throws:
  /// - [TypeError] if any element cannot be cast to List<int>
  @override
  List<Uint8List> fromJson(List<dynamic> json) =>
      json.map((e) => Uint8List.fromList((e as List).cast<int>())).toList();

  /// Converts a List<Uint8List> to a JSON-compatible list of integer lists.
  ///
  /// Parameters:
  /// - [object]: The List<Uint8List> to convert
  ///
  /// Returns:
  /// A [List<List<int>>] suitable for JSON serialization.
  @override
  List<List<int>> toJson(List<Uint8List> object) => object.map((e) => e.toList()).toList();
}
