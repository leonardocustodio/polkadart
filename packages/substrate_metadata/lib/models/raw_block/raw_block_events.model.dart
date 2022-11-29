part of models;

/// Holds the blockNumber with the encoded events from the chain.
class RawBlockEvents extends Equatable {
  final int blockNumber;
  final String events;
  const RawBlockEvents({required this.blockNumber, required this.events});

  @override
  List<Object?> get props => [blockNumber, events];
}
