part of multisig;

/// Manages signatories for a multisig account
///
/// This class handles the creation of multisig addresses and manages
/// the signatories list for multisig operations.
///
/// Example:
/// ```dart
/// final signatories = Signatories(
///   addresses: [alice.address, bob.address, charlie.address],
///   threshold: 2,
/// );
///
/// print('Multisig address: ${signatories.multisigAddress}');
/// ```
class Signatories extends Equatable {
  /// Number of approvals required for execution
  final int threshold;

  /// Sorted list of signatory addresses
  final List<String> addresses;

  /// Sorted list of signatory public keys (32 bytes each)
  final List<Uint8List> publicKeys;

  /// The multisig account address
  final String multisigAddress;

  /// The multisig account public key (32 bytes)
  final Uint8List multisigPublicKey;

  /// Creates a new Signatories instance
  ///
  /// Parameters:
  /// - [addresses]: List of signatory addresses (will be deduplicated and sorted)
  /// - [threshold]: Number of approvals required (must be between 2 and number of signatories)
  /// - [ss58Format]: Address format (default: 42 for generic Substrate)
  ///
  /// Example:
  /// ```dart
  /// final signatories = Signatories(
  ///   addresses: [alice.address, bob.address, charlie.address],
  ///   threshold: 2,
  /// );
  /// ```
  factory Signatories({
    required final List<String> addresses,
    required final int threshold,
    final int ss58Format = 42,
  }) {
    // Validate threshold
    if (threshold < 2) {
      throw ArgumentError('Threshold must be at least 2, got $threshold');
    }

    // Remove duplicates
    final uniqueAddresses = addresses.toSet().toList();

    // Validate count
    if (uniqueAddresses.length < 2) {
      throw ArgumentError('At least 2 signatories required, got ${uniqueAddresses.length}');
    }

    if (uniqueAddresses.length > 100) {
      throw ArgumentError('Maximum 100 signatories allowed, got ${uniqueAddresses.length}');
    }

    if (threshold > uniqueAddresses.length) {
      throw ArgumentError(
          'Threshold ($threshold) cannot exceed signatories (${uniqueAddresses.length})');
    }

    // Convert to public keys and sort
    final pubkeysWithAddresses = <(Uint8List, String)>[];

    for (final address in uniqueAddresses) {
      try {
        final pubkey = Address.decode(address).pubkey;
        pubkeysWithAddresses.add((pubkey, address));
      } catch (e) {
        throw ArgumentError('Invalid address: $address');
      }
    }

    // Sort by public key bytes
    pubkeysWithAddresses.sort((final a, final b) => _compareBytes(a.$1, b.$1));

    // Extract sorted data
    final sortedPubkeys = pubkeysWithAddresses.map((final e) => e.$1).toList();
    final sortedAddresses = pubkeysWithAddresses.map((final e) => e.$2).toList();

    // Generate multisig address
    final multisigPubkey = _deriveMultisigAddress(sortedPubkeys, threshold);
    final multisigAddr = Address(
      prefix: ss58Format,
      pubkey: multisigPubkey,
    ).encode();

    return Signatories._(
      threshold: threshold,
      addresses: sortedAddresses,
      publicKeys: sortedPubkeys,
      multisigAddress: multisigAddr,
      multisigPublicKey: multisigPubkey,
    );
  }

  /// Private constructor
  const Signatories._({
    required this.threshold,
    required this.addresses,
    required this.publicKeys,
    required this.multisigAddress,
    required this.multisigPublicKey,
  });

  /// Get other signatories excluding the signer
  ///
  /// Used when creating multisig transactions. The current signer
  /// must be excluded from the "other_signatories" field.
  ///
  /// Parameters:
  /// - [signerAddress]: The address of the current signer
  ///
  /// Returns: List of other signatories' public keys
  ///
  /// Throws: [ArgumentError] if signer is not a signatory
  ///
  /// Example:
  /// ```dart
  /// // Alice is signing
  /// final others = signatories.otherSignatoriesFor(alice.address);
  /// // Returns public keys of Bob and Charlie
  /// ```
  List<Uint8List> otherSignatoriesFor(final String signerAddress) {
    Uint8List signerPubkey;
    try {
      signerPubkey = Address.decode(signerAddress).pubkey;
    } catch (e) {
      throw ArgumentError('Invalid signer address: $signerAddress');
    }

    // Find and exclude the signer
    final others = <Uint8List>[];
    bool foundSigner = false;

    for (final pubkey in publicKeys) {
      if (_compareBytes(pubkey, signerPubkey) == 0) {
        foundSigner = true;
      } else {
        others.add(pubkey);
      }
    }

    if (!foundSigner) {
      throw ArgumentError('Address $signerAddress is not a signatory of this multisig');
    }

    return others;
  }

  /// Check if an address is a signatory
  ///
  /// Example:
  /// ```dart
  /// if (!signatories.contains(alice.address)) {
  ///   throw Exception('Alice cannot sign this transaction');
  /// }
  /// ```
  bool contains(final String address) {
    try {
      final pubkey = Address.decode(address).pubkey;
      return publicKeys.any((final p) => _compareBytes(p, pubkey) == 0);
    } catch (_) {
      return false;
    }
  }

  /// Create shareable JSON representation
  ///
  /// Example:
  /// ```dart
  /// final json = signatories.toJson();
  /// // Share with other signatories
  /// ```
  Map<String, dynamic> toJson() => {
        'signatories': addresses,
        'threshold': threshold,
        'multisigAddress': multisigAddress,
      };

  /// Reconstruct from JSON
  ///
  /// Example:
  /// ```dart
  /// final signatories = Signatories.fromJson(json);
  /// ```
  factory Signatories.fromJson(
    final Map<String, dynamic> json, {
    final int ss58Format = 42,
  }) {
    return Signatories(
      addresses: List<String>.from(json['signatories']),
      threshold: json['threshold'] as int,
      ss58Format: ss58Format,
    );
  }

  /// Derive multisig address using Substrate's algorithm
  ///
  /// Formula: blake2b256("modlpy/utilisuba" + encode(signatories) + threshold)
  static Uint8List _deriveMultisigAddress(
    final List<Uint8List> sortedPubkeys,
    final int threshold,
  ) {
    final output = ByteOutput();

    // Module prefix
    output.write(utf8.encode('modlpy/utilisuba'));

    // Number of signatories (compact encoded)
    CompactCodec.codec.encodeTo(sortedPubkeys.length, output);

    // Each public key
    for (final pubkey in sortedPubkeys) {
      output.write(pubkey);
    }

    // Threshold as u16 little-endian
    final thresholdBytes = Uint8List(2);
    thresholdBytes[0] = threshold & 0xFF;
    thresholdBytes[1] = (threshold >> 8) & 0xFF;
    output.write(thresholdBytes);

    // Hash to get address
    return Hasher.blake2b256.hash(output.toBytes());
  }

  /// Compare byte arrays
  static int _compareBytes(final Uint8List a, final Uint8List b) {
    final minLength = a.length < b.length ? a.length : b.length;

    for (int i = 0; i < minLength; i++) {
      if (a[i] != b[i]) {
        return a[i] < b[i] ? -1 : 1;
      }
    }

    if (a.length != b.length) {
      return a.length < b.length ? -1 : 1;
    }

    return 0;
  }

  @override
  List<Object?> get props => [
        threshold,
        addresses,
        publicKeys,
        multisigAddress,
        multisigPublicKey,
      ];
}
