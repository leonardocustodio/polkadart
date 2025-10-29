part of primitives;

class ExtrinsicStatus extends Equatable {
  final String type;
  final dynamic value;

  const ExtrinsicStatus({
    required this.type,
    required this.value,
  });

  factory ExtrinsicStatus.fromJson(dynamic json) {
    String type;
    dynamic value;

    if (json is String) {
      type = json;
      value = null;
    } else if (json is Map<String, dynamic>) {
      type = json.keys.first;
      value = json[type];
    } else {
      throw Exception('ExtrinsicStatus: Invalid json value "$json"');
    }

    return ExtrinsicStatus(
      type: type,
      value: value,
    );
  }

  // ============================================================================
  // Status Check Helpers
  // ============================================================================

  /// Returns `true` if the transaction is validated and ready in the transaction pool.
  ///
  /// This is typically the first status after submitting a transaction.
  bool get isReady => type.toLowerCase() == 'ready';

  /// Returns `true` if the transaction has been broadcast to network peers.
  ///
  /// The transaction is being propagated across the network.
  bool get isBroadcast => type.toLowerCase() == 'broadcast';

  /// Returns `true` if the transaction is included in a block (but not yet finalized).
  ///
  /// The block may still be reorganized, so this is not a guarantee of finality.
  /// Use [blockHash] to get the block hash.
  bool get isInBlock => type.toLowerCase() == 'inblock';

  /// Returns `true` if the transaction is included in a finalized block.
  ///
  /// This is the final confirmation that the transaction has been permanently
  /// included in the blockchain. Use [blockHash] to get the block hash.
  bool get isFinalized => type.toLowerCase() == 'finalized';

  /// Returns `true` if the transaction was retracted from a block.
  ///
  /// This can happen during block reorganization. The transaction may be
  /// re-included in a different block.
  bool get isRetracted => type.toLowerCase() == 'retracted';

  /// Returns `true` if the transaction is invalid.
  ///
  /// The transaction failed validation and will not be included in any block.
  /// Use [error] to get the error details if available.
  bool get isInvalid => type.toLowerCase() == 'invalid';

  /// Returns `true` if the transaction was dropped from the transaction pool.
  ///
  /// This can happen due to pool limits or other reasons.
  /// Use [error] to get the error details if available.
  bool get isDropped => type.toLowerCase() == 'dropped';

  /// Returns `true` if the transaction was usurped by another transaction.
  ///
  /// Another transaction with the same nonce but higher priority replaced this one.
  /// Use [error] to get the error details if available.
  bool get isUsurped => type.toLowerCase() == 'usurped';

  /// Returns `true` if the transaction is a future transaction.
  ///
  /// The transaction's nonce is higher than the current account nonce.
  /// It will become valid once prior transactions are processed.
  bool get isFuture => type.toLowerCase() == 'future';

  /// Returns `true` if the status represents any error state.
  ///
  /// Error states include: invalid, dropped, or usurped.
  /// Use [error] to get the error details if available.
  bool get isError => isInvalid || isDropped || isUsurped;

  // ============================================================================
  // Data Accessors
  // ============================================================================

  /// Returns the block hash if the transaction is in a block or finalized.
  ///
  /// Returns `null` for other status types or if the block hash is not available.
  ///
  /// Example:
  /// ```dart
  /// if (status.isFinalized) {
  ///   print('Finalized in block: ${status.blockHash}');
  /// }
  /// ```
  String? get blockHash {
    if (value is String) return value as String;
    if (value is Map && value.containsKey('blockHash')) {
      return value['blockHash'] as String;
    }
    return null;
  }

  /// Returns the error message if the status represents an error state.
  ///
  /// Returns `null` if there is no error or no error message is available.
  ///
  /// Example:
  /// ```dart
  /// if (status.isError) {
  ///   print('Transaction failed: ${status.error}');
  /// }
  /// ```
  String? get error {
    if (value is String && isError) return value as String;
    if (value is Map && value.containsKey('error')) {
      return value['error'].toString();
    }
    return null;
  }

  // ============================================================================
  // Object Methods
  // ============================================================================

  /// Returns a user-friendly string representation of the extrinsic status.
  ///
  /// Example outputs:
  /// - `ExtrinsicStatus(ready)`
  /// - `ExtrinsicStatus(finalized, blockHash: 0x123...)`
  /// - `ExtrinsicStatus(invalid, error: Invalid signature)`
  @override
  String toString() {
    final buffer = StringBuffer('ExtrinsicStatus($type');
    if (blockHash != null) {
      buffer.write(', blockHash: $blockHash');
    }
    if (error != null) {
      buffer.write(', error: $error');
    }
    buffer.write(')');
    return buffer.toString();
  }

  @override
  List<dynamic> get props => [type, value];
}
