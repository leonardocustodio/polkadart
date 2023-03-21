part of models;

/// Holds the blockNumber with the encoded events from the chain.
class RawBlockEvents extends Equatable {
  final int blockNumber;
  final String events;
  const RawBlockEvents({required this.blockNumber, required this.events});

  // Create RawBlockEvents Object
  static RawBlockEvents fromJson(Map<String, dynamic> map) => RawBlockEvents(
        blockNumber: map['blockNumber'],
        events: map['events'],
      );

  @override
  List<Object?> get props => [blockNumber, events];

  // read the events from filePath
  static List<RawBlockEvents> readEventsFromPath(String filePath) {
    return readLines(filePath)
        .map((dynamic map) => RawBlockEvents.fromJson(map))
        .toList(growable: false);
  }
}
