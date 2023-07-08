part of primitives;

/// The state of the syncing of the node.
class SyncState {
  const SyncState({
    required this.startingBlock,
    required this.currentBlock,
    required this.highestBlock,
  });

  factory SyncState.fromJson(Map<String, dynamic> json) {
    return SyncState(
      startingBlock: json['startingBlock'] as int,
      currentBlock: json['currentBlock'] as int,
      highestBlock: json['highestBlock'] as int,
    );
  }

  /// Height of the block at which syncing started.
  final int startingBlock;

  /// Height of the current best block of the node.
  final int currentBlock;

  /// Height of the highest block in the network.
  final int highestBlock;

  Map<String, int> toJson() => {
        'startingBlock': startingBlock,
        'currentBlock': currentBlock,
        'highestBlock': highestBlock,
      };

  @override
  bool operator ==(Object other) =>
      other is SyncState &&
      other.runtimeType == runtimeType &&
      other.startingBlock == startingBlock &&
      other.currentBlock == currentBlock &&
      other.highestBlock == highestBlock;

  @override
  int get hashCode => Object.hash(startingBlock, currentBlock, highestBlock);
}

/// SyncState Scale Codec
class SyncStateCodec with Codec<SyncState> {
  final Codec<int> numberCodec;

  const SyncStateCodec({required this.numberCodec});

  @override
  void encodeTo(
    SyncState value,
    Output output,
  ) {
    numberCodec.encodeTo(
      value.startingBlock,
      output,
    );
    numberCodec.encodeTo(
      value.currentBlock,
      output,
    );
    numberCodec.encodeTo(
      value.highestBlock,
      output,
    );
  }

  @override
  SyncState decode(Input input) {
    return SyncState(
      startingBlock: numberCodec.decode(input),
      currentBlock: numberCodec.decode(input),
      highestBlock: numberCodec.decode(input),
    );
  }

  @override
  int sizeHint(SyncState value) {
    int size = numberCodec.sizeHint(value.startingBlock);
    size += numberCodec.sizeHint(value.currentBlock);
    size = numberCodec.sizeHint(value.highestBlock);
    return size;
  }
}
