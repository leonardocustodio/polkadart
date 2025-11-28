part of ink_abi;

/// Represents a type specification from ink! metadata
///
/// Associates a type ID with its display name for clear type identification.
/// The type ID references a PortableType in the metadata type registry.
@JsonSerializable()
class TypeSpec extends Equatable {
  /// Type ID in the portable registry
  @JsonKey(name: 'type')
  final int typeId;

  /// Display name components (e.g., ['ink', 'MessageResult'])
  final List<String> displayName;

  const TypeSpec({
    required this.typeId,
    required this.displayName,
  });

  factory TypeSpec.fromJson(final Map<String, dynamic> json) => _$TypeSpecFromJson(json);
  Map<String, dynamic> toJson() => _$TypeSpecToJson(this);

  /// Get display name as a single string (e.g., 'ink::MessageResult')
  String get displayNameString => displayName.join('::');

  @override
  String toString() => 'TypeSpec(typeId: $typeId, displayName: $displayNameString)';

  @override
  List<Object?> get props => [typeId, displayName];
}
