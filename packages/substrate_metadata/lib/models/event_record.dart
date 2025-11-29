part of models;

/// Represents a complete event record from storage
class EventRecord {
  /// Phase when the event was emitted
  final Phase phase;

  /// The actual event
  final RuntimeEvent event;

  /// Topics for indexed event filtering
  final List<String> topics;

  const EventRecord({
    required this.phase,
    required this.event,
    required this.topics,
  });

  Map<String, dynamic> toJson() => {
        'phase': phase.toJson(),
        'event': event.toJson(),
        'topics': topics,
      };

  @override
  String toString() => 'EventRecord(phase: $phase, event: $event, topics: $topics)';
}
