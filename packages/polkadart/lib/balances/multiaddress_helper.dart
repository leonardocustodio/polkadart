part of balances_calls;

/// Helper for creating MultiAddress variants
///
/// MultiAddress is commonly used in Substrate for specifying accounts
/// and has several variants:
/// - Id (index 0): Raw AccountId
/// - Index (index 1): Account index
/// - Raw (index 2): Raw bytes
/// - Address32 (index 3): 32-byte address
/// - Address20 (index 4): 20-byte address (for Ethereum compatibility)
class MultiAddress extends Equatable {
  final String key;
  final dynamic destination;
  const MultiAddress._(this.key, this.destination);

  MapEntry<String, dynamic> get destinationArgs {
    return MapEntry<String, dynamic>(key, destination);
  }

  /// Create MultiAddress::Id variant
  static MultiAddress id(final Uint8List accountId) {
    return MultiAddress._('Id', accountId);
  }

  /// Create MultiAddress::Index variant
  static MultiAddress index(final int accountIndex) {
    return MultiAddress._('Index', accountIndex);
  }

  /// Create MultiAddress::Raw variant
  static MultiAddress raw(final Uint8List bytes) {
    return MultiAddress._('Raw', bytes);
  }

  /// Create MultiAddress::Address32 variant
  static MultiAddress address32(final Uint8List address) {
    if (address.length != 32) {
      throw ArgumentError('Address32 requires exactly 32 bytes');
    }
    return MultiAddress._('Address32', address);
  }

  /// Create MultiAddress::Address20 variant (Ethereum)
  static MultiAddress address20(final Uint8List address) {
    if (address.length != 20) {
      throw ArgumentError('Address20 requires exactly 20 bytes');
    }
    return MultiAddress._('Address20', address);
  }

  /// Auto-detect and create appropriate MultiAddress
  static MultiAddress auto(final Uint8List bytes) {
    switch (bytes.length) {
      case 32:
        return id(bytes); // Most common - AccountId32
      case 20:
        return address20(bytes); // Ethereum compatibility
      default:
        return raw(bytes); // Fallback to raw
    }
  }

  MapEntry<String, dynamic> toJson() {
    return destinationArgs;
  }

  @override
  List<Object> get props => [key, destination];
}
