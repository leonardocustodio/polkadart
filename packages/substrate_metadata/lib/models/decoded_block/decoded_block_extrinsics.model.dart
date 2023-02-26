part of models;

/// Stores the block number with the list of extrinsics for this block.
class DecodedBlockExtrinsics {
  final int blockNumber;
  final List<Map<String, dynamic>> extrinsics;
  const DecodedBlockExtrinsics(
      {required this.blockNumber, required this.extrinsics});
}
