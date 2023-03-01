part of models;

/// Stores the block number with the list of events for this block.
class DecodedBlockEvents {
  final int blockNumber;
  final List<Map<String, dynamic>> events;
  const DecodedBlockEvents({required this.blockNumber, required this.events});
}
