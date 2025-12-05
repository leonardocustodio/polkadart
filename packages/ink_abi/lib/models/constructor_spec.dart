part of ink_abi;

/// Represents an ink! constructor specification
///
/// Constructors are used to initialize a new contract instance.
/// This class provides complete metadata about a constructor including
/// its selector, arguments, return type, and payment properties.
@JsonSerializable(explicitToJson: true)
class ConstructorSpec extends Equatable {
  /// Constructor name/label
  final String label;

  /// 4-byte selector for identifying the constructor
  final String selector;

  /// List of arguments this constructor accepts
  final List<ArgSpec> args;

  /// Return type specification (typically a ConstructorResult)
  /// Null for v3 metadata where constructors don't specify return types
  final TypeSpec? returnType;

  /// Whether this constructor accepts payment
  final bool payable;

  /// Optional documentation for this constructor
  final List<String>? docs;

  const ConstructorSpec({
    required this.label,
    required this.selector,
    required this.args,
    this.returnType,
    required this.payable,
    this.docs,
  });

  factory ConstructorSpec.fromJson(final Map<String, dynamic> json) =>
      _$ConstructorSpecFromJson(json);
  Map<String, dynamic> toJson() => _$ConstructorSpecToJson(this);

  /// Get codec type ID for the return type
  /// Returns null if returnType is not specified (v3 metadata)
  int? get codecTypeId => returnType?.typeId;

  @override
  String toString() => 'ConstructorSpec(label: $label, selector: $selector, '
      'args: ${args.length}, payable: $payable)';

  @override
  List<Object?> get props => [label, selector, args, returnType, payable, docs];
}
