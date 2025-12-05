part of ink_abi;

/// Represents an ink! event specification
///
/// Events are emitted by the contract during execution to communicate
/// important state changes or occurrences. This class provides metadata
/// about an event including its type ID, indexed field count, and signature.
@JsonSerializable(createFactory: false)
class EventSpec extends Equatable {
  /// Event name/label
  final String label;

  /// Type ID for the event's composite type in the registry
  final int typeId;

  /// Number of indexed fields in this event
  final int amountIndexed;

  /// Signature topic for v5 anonymous events (optional)
  final String? signatureTopic;

  /// Optional documentation for this event
  final List<String>? docs;

  const EventSpec({
    required this.label,
    required this.typeId,
    required this.amountIndexed,
    this.signatureTopic,
    this.docs,
  });

  /// The type ID is provided separately as it's constructed
  /// from the event's field structure.
  factory EventSpec.fromJson(final Map<String, dynamic> json, [final int? typeId]) {
    int amountIndexed = 0;
    final args = json['args'] as List?;
    if (args != null) {
      for (final arg in args) {
        if (arg['indexed'] == true) {
          amountIndexed++;
        }
      }
    }

    return EventSpec(
      label: json['label'] as String,
      typeId: typeId ?? json['typeId'] as int,
      amountIndexed: json['amountIndexed'] as int? ?? amountIndexed,
      signatureTopic: json['signatureTopic'] as String? ?? json['signature_topic'] as String?,
      docs: (json['docs'] as List?)?.cast<String>(),
    );
  }

  Map<String, dynamic> toJson() => _$EventSpecToJson(this);

  @override
  String toString() => 'EventSpec(label: $label, typeId: $typeId, '
      'indexed: $amountIndexed, signatureTopic: $signatureTopic)';

  @override
  List<Object?> get props => [label, typeId, amountIndexed, signatureTopic, docs];
}
