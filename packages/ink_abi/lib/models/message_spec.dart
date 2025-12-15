part of ink_abi;

/// Represents an ink! message (function) specification
///
/// Messages are the callable functions on an ink! smart contract.
/// This class provides complete metadata about a message including
/// its selector, arguments, return type, and execution properties.
@JsonSerializable(explicitToJson: true)
class MessageSpec extends Equatable {
  /// Message name/label
  final String label;

  /// 4-byte selector for identifying the message
  final String selector;

  /// List of arguments this message accepts
  final List<ArgSpec> args;

  /// Return type specification
  final TypeSpec returnType;

  /// Whether this message mutates contract state
  final bool mutates;

  /// Whether this message accepts payment
  final bool payable;

  /// Optional documentation for this message
  final List<String>? docs;

  const MessageSpec({
    required this.label,
    required this.selector,
    required this.args,
    required this.returnType,
    required this.mutates,
    required this.payable,
    this.docs,
  });

  factory MessageSpec.fromJson(final Map<String, dynamic> json) => _$MessageSpecFromJson(json);
  Map<String, dynamic> toJson() => _$MessageSpecToJson(this);

  int get codecTypeId => returnType.typeId;

  @override
  String toString() =>
      'MessageSpec(label: $label, selector: $selector, '
      'args: ${args.length}, mutates: $mutates, payable: $payable)';

  @override
  List<Object?> get props => [label, selector, args, returnType, mutates, payable, docs];
}
