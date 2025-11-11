part of models;

/// Container for standard chain data
class ChainData extends Equatable {
  final Uint8List? genesisHash;
  final Uint8List? blockHash;
  final int? blockNumber;
  final int? specVersion;
  final int? transactionVersion;
  final int? nonce;

  const ChainData({
    this.genesisHash,
    this.blockHash,
    this.blockNumber,
    this.specVersion,
    this.transactionVersion,
    this.nonce,
  });

  /// Check if all required data is present
  bool get hasAllRequiredData =>
      genesisHash != null &&
      blockHash != null &&
      blockNumber != null &&
      specVersion != null &&
      transactionVersion != null;

  /// Get a summary of fetched data
  Map<String, dynamic> summary() {
    return {
      'genesisHash': genesisHash != null
          ? '0x${genesisHash!.map((b) => b.toRadixString(16).padLeft(2, '0')).join()}'
          : null,
      'blockHash': blockHash != null
          ? '0x${blockHash!.map((b) => b.toRadixString(16).padLeft(2, '0')).join()}'
          : null,
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
