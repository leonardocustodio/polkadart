part of derived_codecs;

/// Codec for encoding and decoding Substrate event records
///
/// This is the main codec that orchestrates the encoding/decoding of complete
/// event records which include phase information, the event itself, and topics.
/// It delegates to specialized codecs for each component.
///
/// Example:
/// ```dart
/// final registry = MetadataTypeRegistry(prefixed);
/// final eventsRecordCodec = EventsRecordCodec(registry);
///
/// // Decode events from a block
/// final events = eventsRecordCodec.decode(eventBytes);
/// for (final event in events) {
///   print('${event.event.palletName}.${event.event.eventName}: ${event.event.data}');
/// }
/// ```
class EventsRecordCodec with Codec<List<EventRecord>> {
  final MetadataTypeRegistry registry;
  late final RuntimeEventCodec _eventCodec;
  late final PhaseCodec _phaseCodec;
  late final TopicsCodec _topicsCodec;

  EventsRecordCodec(this.registry) {
    _eventCodec = RuntimeEventCodec(registry);
    _phaseCodec = const PhaseCodec();
    _topicsCodec = const TopicsCodec();
  }

  /// Decode event records from storage (System.Events)
  ///
  /// This decodes the full Vec<EventRecord> structure that includes
  /// phase information and topics for each event.
  @override
  List<EventRecord> decode(Input input) {
    // Events are stored as Vec<EventRecord>
    final length = CompactCodec.codec.decode(input);
    final events = <EventRecord>[];

    for (int i = 0; i < length; i++) {
      events.add(_decodeEventRecord(input));
    }

    return events;
  }

  /// Encode a list of event records
  @override
  void encodeTo(List<EventRecord> value, Output output) {
    // Encode as Vec<EventRecord>
    CompactCodec.codec.encodeTo(value.length, output);

    for (final record in value) {
      _encodeEventRecord(record, output);
    }
  }

  /// Calculate size hint for a list of event records
  @override
  int sizeHint(List<EventRecord> value) {
    int size = CompactCodec.codec.sizeHint(value.length);

    for (final record in value) {
      size += _sizeHintEventRecord(record);
    }

    return size;
  }

  @override
  bool isSizeZero() {
    // This class directly encodes a compact length prefix
    // So it's never zero-size
    return false;
  }

  /// Decode a single EventRecord
  EventRecord _decodeEventRecord(Input input) {
    // EventRecord structure:
    // - phase: Phase
    // - event: RuntimeEvent
    // - topics: Vec<Hash>

    final phase = _phaseCodec.decode(input);
    final event = _eventCodec.decode(input);
    final topics = _topicsCodec.decode(input);

    return EventRecord(
      phase: phase,
      event: event,
      topics: topics,
    );
  }

  /// Encode a single EventRecord
  void _encodeEventRecord(EventRecord record, Output output) {
    _phaseCodec.encodeTo(record.phase, output);
    _eventCodec.encodeTo(record.event, output);
    _topicsCodec.encodeTo(record.topics, output);
  }

  /// Calculate size hint for a single EventRecord
  int _sizeHintEventRecord(EventRecord record) {
    return _phaseCodec.sizeHint(record.phase) +
        _eventCodec.sizeHint(record.event) +
        _topicsCodec.sizeHint(record.topics);
  }

  // ======================================================================
  // METADATA QUERIES (preserved from original implementation)
  // ======================================================================

  /// Get event metadata information
  EventInfo? getEventInfo(String palletName, String eventName) {
    final pallet = registry.palletByName(palletName);
    if (pallet?.event == null) return null;

    final eventTypeId = pallet!.event!.type;
    final variant = registry.getVariant(eventTypeId, eventName);
    if (variant == null) return null;

    return EventInfo(
      name: eventName,
      palletName: palletName,
      index: variant.index,
      fields: variant.fields
          .map((f) => FieldInfo(
                name: f.name,
                type: f.type,
                typeName: f.typeName,
                docs: f.docs,
              ))
          .toList(),
      docs: variant.docs,
    );
  }

  /// Get all events for a pallet
  List<EventInfo> getPalletEvents(String palletName) {
    final pallet = registry.palletByName(palletName);
    if (pallet?.event == null) return [];

    final eventTypeId = pallet!.event!.type;
    final eventType = registry.typeById(eventTypeId);

    if (eventType.type.typeDef is! TypeDefVariant) {
      return [];
    }

    final variants = (eventType.type.typeDef as TypeDefVariant).variants;

    return variants
        .map((variant) => EventInfo(
              name: variant.name,
              palletName: palletName,
              index: variant.index,
              fields: variant.fields
                  .map((f) => FieldInfo(
                        name: f.name,
                        type: f.type,
                        typeName: f.typeName,
                        docs: f.docs,
                      ))
                  .toList(),
              docs: variant.docs,
            ))
        .toList();
  }

  /// Get all events across all pallets
  Map<String, List<EventInfo>> getAllEvents() {
    final allEvents = <String, List<EventInfo>>{};

    for (final pallet in registry.pallets) {
      if (pallet.event != null) {
        allEvents[pallet.name] = getPalletEvents(pallet.name);
      }
    }

    return allEvents;
  }
}
