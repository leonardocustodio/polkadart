part of models;

/// Represents a runtime event
class RuntimeEvent {
  /// Name of the pallet that emitted the event
  final String palletName;

  /// Index of the pallet
  final int palletIndex;

  /// Name of the event
  final String eventName;

  /// Index of the event within the pallet
  final int eventIndex;

  /// Event data (field values)
  final Map<String, dynamic> data;

  const RuntimeEvent({
    required this.palletName,
    required this.palletIndex,
    required this.eventName,
    required this.eventIndex,
    required this.data,
  });

  /// Get a formatted event identifier
  String get identifier => '$palletName.$eventName';

  Map<String, dynamic> toJson() => {
        'pallet': palletName,
        'palletIndex': palletIndex,
        'event': eventName,
        'eventIndex': eventIndex,
        'data': data.toJson(),
      };

  @override
  String toString() =>
      'RuntimeEvent(palletName: \'$palletName\', palletIndex: $palletIndex, eventName: \'$eventName\', eventIndex: $eventIndex,  data: ${ToJson(data).toJson().toHuman()})';
}
