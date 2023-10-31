part of primitives;

class Events {
  List<EventRecord> eventRecord = <EventRecord>[];

  Events._({required this.eventRecord});

  factory Events.fromJson(Map<String, dynamic> value, ChainInfo chainInfo) {
    final List<dynamic> events = chainInfo.scaleCodec.decode('EventCodec',
        ByteInput.fromBytes(hex.decode(value['changes'][0][1].substring(2))));

    return Events._(
      eventRecord: ToJson(events)
          .toJson()
          .map(
              (event) => EventRecord.fromJson(Map<String, dynamic>.from(event)))
          .toList(),
    );
  }
}

class EventRecord {
  final Map<String, dynamic> phase;
  final Map<String, dynamic> event;
  final List<String> topics;

  EventRecord._(
      {required this.phase, required this.event, required this.topics});

  factory EventRecord.fromJson(Map<String, dynamic> value) {
    return EventRecord._(
      phase: Map<String, dynamic>.from(value['phase']),
      event: Map<String, dynamic>.from(value['event']),
      topics: List<String>.from(value['topics']),
    );
  }

  @override
  String toString() {
    return 'EventRecord{phase: $phase, event: $event, topics: $topics}';
  }
}
