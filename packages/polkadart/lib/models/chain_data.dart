part of models;

/// Container for standard chain data
class ChainData extends Equatable {
  final Uint8List genesisHash;
  final Uint8List blockHash;
  final int blockNumber;
  final int specVersion;
  final int transactionVersion;
  final int? nonce;

  const ChainData({
    required this.genesisHash,
    required this.blockHash,
    required this.blockNumber,
    required this.specVersion,
    required this.transactionVersion,
    this.nonce,
  });

  /// Get a summary of fetched data
  Map<String, dynamic> summary() {
    return {
      'genesisHash': '0x${encodeHex(genesisHash)}',
      'blockHash': '0x${encodeHex(blockHash)}',
      'blockNumber': blockNumber,
      'specVersion': specVersion,
      'transactionVersion': transactionVersion,
      'nonce': nonce,
    };
  }

  @override
  List<Object?> get props => [
    genesisHash,
    blockHash,
    blockNumber,
    specVersion,
    transactionVersion,
    nonce,
  ];
}
