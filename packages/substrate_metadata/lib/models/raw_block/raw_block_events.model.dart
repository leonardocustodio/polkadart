part of models;

class RawBlockEvents {
  final int blockNumber;
  final String events;
  const RawBlockEvents({required this.blockNumber, required this.events});

  @override
  bool operator ==(Object other) {
    return other is RawBlockEvents &&
        blockNumber == other.blockNumber &&
        events == other.events;
  }

  @override
  int get hashCode => blockNumber.hashCode ^ events.hashCode;
}
