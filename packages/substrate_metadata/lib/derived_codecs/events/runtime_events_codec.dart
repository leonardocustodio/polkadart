part of derived_codecs;

/// Codec for encoding and decoding RuntimeEvent
///
/// Handles the core event encoding/decoding logic for both V14 and V15 metadata.
/// This codec manages pallet indices, event indices, and event data fields.
class RuntimeEventCodec with Codec<RuntimeEvent> {
  final MetadataTypeRegistry registry;

  RuntimeEventCodec(this.registry);

  /// Decode a RuntimeEvent from input
  @override
  RuntimeEvent decode(Input input) {
    // For V15, we might have a direct outer enum type
    final outerEnums = registry.outerEnums;
    final PalletMetadata pallet;
    if (outerEnums != null) {
      pallet = _findPalletV15FromInput(input, outerEnums.eventType);
    } else {
      pallet = _findPalletV14FromInput(input);
    }

    final eventTypeId = pallet.event?.type;
    if (eventTypeId == null) throw MetadataException('Pallet ${pallet.name} has no events');

    final eventIndex = input.read();
    final eventVariant = registry.getVariantByIndex(eventTypeId, eventIndex);
    if (eventVariant == null) {
      throw MetadataException('Event with index $eventIndex not found in pallet ${pallet.name}');
    }

    final eventData = _decodeEventData(input, eventVariant);
    return RuntimeEvent(
      palletName: pallet.name,
      palletIndex: pallet.index,
      eventName: eventVariant.name,
      eventIndex: eventIndex,
      data: eventData,
    );
  }

  /// Encode a RuntimeEvent to output
  @override
  void encodeTo(RuntimeEvent value, Output output) {
    final outerEnums = registry.outerEnums;
    late final PalletMetadata pallet;
    if (outerEnums != null) {
      pallet = _findPalletV15FromRuntimeEvent(value, output, outerEnums.eventType);
    } else {
      pallet = _findPalletV14FromRuntimeEvent(value, output);
    }

    final eventTypeId = pallet.event?.type;
    if (eventTypeId == null) throw MetadataException('Pallet ${pallet.name} has no events');

    final eventVariant = registry.getVariantByIndex(eventTypeId, value.eventIndex);
    if (eventVariant == null) {
      throw MetadataException(
          'Event with index ${value.eventIndex} not found in pallet ${pallet.name}');
    }

    output.pushByte(value.eventIndex);
    _encodeEventData(output, eventVariant, value.data);
  }

  /// Calculate size hint for a RuntimeEvent
  @override
  int sizeHint(RuntimeEvent value) {
    final sizeTracker = SizeTracker();
    encodeTo(value, sizeTracker);
    return sizeTracker.size;
  }

  // ======================================================================
  // Find Pallet From RuntimeEvent ----------- Start -----------
  // ======================================================================
  PalletMetadata _findPalletV14FromRuntimeEvent(RuntimeEvent event, Output output) {
    final pallet = registry.palletByIndex(event.palletIndex);
    if (pallet == null) {
      throw MetadataException('Pallet with index ${event.palletIndex} not found');
    }
    output.pushByte(event.palletIndex);
    return pallet;
  }

  PalletMetadata _findPalletV15FromRuntimeEvent(
      RuntimeEvent event, Output output, int outerEventType) {
    final outerVariant = registry.getVariant(outerEventType, event.palletName);
    if (outerVariant == null) {
      throw MetadataException('Pallet ${event.palletName} not found in outer event enum');
    }

    final pallet = registry.palletByName(event.palletName);
    if (pallet == null) throw MetadataException('Pallet ${event.palletName} not found');
    output.pushByte(outerVariant.index);
    return pallet;
  }
  // ======================================================================
  // Find Pallet From RuntimeEvent ----------- End -----------
  // ======================================================================

  // ======================================================================
  // Fina Pallet From Input ----------- Start -----------
  // ======================================================================
  PalletMetadata _findPalletV14FromInput(Input input) {
    // Read pallet index
    final palletIndex = input.read();

    // Get pallet metadata
    final pallet = registry.palletByIndex(palletIndex);
    if (pallet == null) {
      throw MetadataException('Pallet with index $palletIndex not found');
    }
    return pallet;
  }

  PalletMetadata _findPalletV15FromInput(Input input, int outerEventType) {
    // For V15, all events are in a single outer enum
    // Read the outer enum discriminant
    final outerIndex = input.read();

    // Get the variant from the outer enum
    final outerVariant = registry.getVariantByIndex(outerEventType, outerIndex);
    if (outerVariant == null) {
      throw MetadataException('Event with outer index $outerIndex not found');
    }

    // The variant name format is usually "PalletName"
    // The variant has a single field which is the actual pallet event enum
    final palletName = outerVariant.name;

    final pallet = registry.palletByName(palletName);
    if (pallet == null) throw MetadataException('Pallet $palletName not found');
    return pallet;
  }
  // ======================================================================
  // Find Pallet From Input ----------- End -----------
  // ======================================================================

  // ======================================================================
  // EVENT DATA HANDLING
  // ======================================================================

  /// Decode event data based on variant fields
  Map<String, dynamic> _decodeEventData(Input input, VariantDef variant) {
    if (variant.fields.isEmpty) {
      return <String, dynamic>{};
    }

    final data = <String, dynamic>{};

    for (int i = 0; i < variant.fields.length; i++) {
      final field = variant.fields[i];
      final fieldCodec = registry.codecFor(field.type);

      // Use field name if available, otherwise use index
      final fieldName = field.name ?? 'field$i';
      data[fieldName] = fieldCodec.decode(input);
    }

    return data;
  }

  /// Encode event data based on variant fields
  void _encodeEventData(
    Output output,
    VariantDef variant,
    Map<String, dynamic> data,
  ) {
    for (int i = 0; i < variant.fields.length; i++) {
      final field = variant.fields[i];
      final fieldName = field.name ?? 'field$i';

      if (!data.containsKey(fieldName)) {
        throw MetadataException('Missing field $fieldName for event ${variant.name}');
      }

      final fieldCodec = registry.codecFor(field.type);
      fieldCodec.encodeTo(data[fieldName], output);
    }
  }

  // ======================================================================
  // UTILITY METHODS
  // ======================================================================

  /// Encode a RuntimeEvent with specific pallet and event names
  /// This is a convenience method for encoding events when you know the names
  Uint8List encodeEvent({
    required String palletName,
    required String eventName,
    required Map<String, dynamic> data,
  }) {
    // Get pallet
    final pallet = registry.palletByName(palletName);
    if (pallet == null) {
      throw MetadataException('Pallet $palletName not found');
    }

    // Get event variant
    final eventTypeId = pallet.event?.type;
    if (eventTypeId == null) {
      throw MetadataException('Pallet $palletName has no events');
    }

    final eventVariant = registry.getVariant(eventTypeId, eventName);
    if (eventVariant == null) {
      throw MetadataException('Event $eventName not found in pallet $palletName');
    }

    // Create RuntimeEvent
    final event = RuntimeEvent(
      palletName: palletName,
      palletIndex: pallet.index,
      eventName: eventName,
      eventIndex: eventVariant.index,
      data: data,
    );

    // Encode and return
    return encode(event);
  }

  /// Decode event from specific pallet (when you know the pallet)
  /// This is useful when you already know which pallet the event is from
  Map<String, dynamic> decodePalletEvent(String palletName, int eventIndex, Input input) {
    final pallet = registry.palletByName(palletName);
    if (pallet == null) {
      throw MetadataException('Pallet $palletName not found');
    }

    if (pallet.event == null) {
      throw MetadataException('Pallet $palletName has no events');
    }

    final eventTypeId = pallet.event!.type;
    final eventVariant = registry.getVariantByIndex(eventTypeId, eventIndex);

    if (eventVariant == null) {
      throw MetadataException('Event with index $eventIndex not found in pallet $palletName');
    }

    return _decodeEventData(input, eventVariant);
  }
}
