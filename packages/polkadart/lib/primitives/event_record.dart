part of primitives;

class Events {
  List<EventRecord> eventRecord = <EventRecord>[];

  Events._({required this.eventRecord});

  factory Events.fromJson(final Map<String, dynamic> value, ChainInfo chainInfo) {
    final String hex = value['changes'][0][1];
    final input = Input.fromHex(hex);
    final List<EventRecord> eventsRecordList = chainInfo.eventsCodec.decode(input);
    return Events._(eventRecord: eventsRecordList);
  }
}
