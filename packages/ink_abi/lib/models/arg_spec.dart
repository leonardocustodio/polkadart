import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

import 'type_spec.dart';

part 'arg_spec.g.dart';

/// Represents an argument specification for messages and constructors
///
/// Describes a single parameter including its name, type, and documentation.
@JsonSerializable(explicitToJson: true)
class ArgSpec extends Equatable {
  /// Argument name/label
  final String label;

  /// Type specification for this argument
  final TypeSpec type;

  /// Optional documentation for this argument
  final List<String>? docs;
  const ArgSpec({required this.label, required this.type, this.docs});

  factory ArgSpec.fromJson(final Map<String, dynamic> json) => _$ArgSpecFromJson(json);
  Map<String, dynamic> toJson() => _$ArgSpecToJson(this);

  @override
  String toString() => 'ArgSpec(label: $label, type: ${type.displayNameString})';

  @override
  List<Object?> get props => [label, type, docs];
}
