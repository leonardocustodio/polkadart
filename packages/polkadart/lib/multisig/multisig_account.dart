part of multisig;

/// Represents a multisig account configuration with signatories and approval threshold.
///
/// This class manages the creation and configuration of multisig accounts on Substrate-based
/// blockchains. It handles signatory validation, automatic sorting of public keys, and
/// derivation of the multisig account address using Substrate's standard algorithm.
///
/// The multisig address is deterministically derived from:
/// - The sorted list of signatory public keys
/// - The approval threshold
///
/// This ensures that all signatories derive the same multisig address regardless of the
/// order in which addresses were provided.
///
/// Example:
/// ```dart
/// final multisigAccount = MultisigAccount(
///   addresses: [alice.address, bob.address, charlie.address],
///   threshold: 2,
/// );
/// print('Multisig address: ${Address.encode(multisigAccount.multisigPubkey)}');
/// ```
@JsonSerializable(constructor: '_', createToJson: true)
class MultisigAccount extends Equatable {
  /// Number of approvals required for transaction execution.
  ///
  /// Must be at least 2 and cannot exceed the total number of signatories.
  final int threshold;

  /// Sorted list of signatory public keys (32 bytes each).
  ///
  /// This list is automatically sorted by public key bytes during construction
  /// to ensure deterministic multisig address derivation.
  @Uint8ListListConverter()
  final List<Uint8List> publicKeys;

  /// The derived multisig account public key (32 bytes).
  ///
  /// This is deterministically derived using blake2b256 hash of:
  /// "modlpy/utilisuba" + encode(sorted_signatories) + threshold
  @Uint8ListConverter()
  final Uint8List multisigPubkey;

  /// Private constructor used internally after validation and derivation.
  const MultisigAccount._({
    required this.threshold,
    required this.publicKeys,
    required this.multisigPubkey,
  });

  /// Creates a new MultisigAccount instance with automatic address derivation.
  ///
  /// This factory constructor performs the following operations:
  /// 1. Validates the threshold (must be ≥2 and ≤ number of signatories)
  /// 2. Deduplicates the provided addresses
  /// 3. Validates the signatory count (2-100 signatories)
  /// 4. Converts addresses to public keys
  /// 5. Sorts public keys deterministically
  /// 6. Derives the multisig account address using Substrate's algorithm
  ///
  /// Parameters:
  /// - [addresses]: List of signatory addresses (SS58 encoded). Duplicates are automatically removed.
  /// - [threshold]: Number of approvals required for execution (must be between 2 and number of signatories)
  ///
  /// Returns:
  /// A [MultisigAccount] instance with the derived multisig address.
  ///
  /// Throws:
  /// - [ArgumentError] if threshold is less than 2
  /// - [ArgumentError] if fewer than 2 unique addresses are provided
  /// - [ArgumentError] if more than 100 addresses are provided
  /// - [ArgumentError] if threshold exceeds the number of signatories
  /// - [ArgumentError] if any address is invalid or cannot be decoded
  ///
  /// Example:
  /// ```dart
  /// final multisigAccount = MultisigAccount(
  ///   addresses: [alice.address, bob.address, charlie.address],
  ///   threshold: 2,
  /// );
  /// // Any 2 of the 3 signatories can approve transactions
  /// ```
  factory MultisigAccount({required final List<String> addresses, required final int threshold}) {
    // Validate threshold
    if (threshold < 2) {
      throw ArgumentError('Threshold must be at least 2, got $threshold');
    }

    // Remove duplicates
    final uniqueAddresses = addresses.toSet().toList(growable: false);

    // Validate count
    if (uniqueAddresses.length < 2) {
      throw ArgumentError('At least 2 signatories required, got ${uniqueAddresses.length}');
    }

    if (uniqueAddresses.length > 100) {
      throw ArgumentError('Maximum 100 signatories allowed, got ${uniqueAddresses.length}');
    }

    if (threshold > uniqueAddresses.length) {
      throw ArgumentError(
        'Threshold ($threshold) cannot exceed signatories (${uniqueAddresses.length})',
      );
    }

    // Convert to public keys and sort
    final pubkeysWithAddresses = <Uint8List>[];

    for (final address in uniqueAddresses) {
      try {
        final pubkey = Address.decode(address).pubkey;
        pubkeysWithAddresses.add(pubkey);
      } catch (e) {
        throw ArgumentError('Invalid address: $address');
      }
    }

    // Sort by public key bytes
    pubkeysWithAddresses.sort((final a, final b) => a.compareBytes(b));

    // Generate multisig address
    final multisigPubkey = _deriveMultisigAddress(pubkeysWithAddresses, threshold);

    return MultisigAccount._(
      threshold: threshold,
      publicKeys: pubkeysWithAddresses,
      multisigPubkey: multisigPubkey,
    );
  }

  /// Returns the list of other signatories excluding the current signer.
  ///
  /// This method is essential for constructing multisig extrinsics, as Substrate requires
  /// the "other_signatories" field to contain all signatories except the current signer.
  /// The list maintains the same sorted order as the original public keys.
  ///
  /// Parameters:
  /// - [signerAddress]: The SS58-encoded address of the current signer
  ///
  /// Returns:
  /// A [List<Uint8List>] containing the public keys of all other signatories in sorted order.
  ///
  /// Throws:
  /// - [ArgumentError] if the signer address is invalid or cannot be decoded
  /// - [ArgumentError] if the signer is not a signatory of this multisig account
  ///
  /// Example:
  /// ```dart
  /// // Alice is signing a transaction
  /// final others = multisigAccount.otherSignatoriesForAddress(alice.address);
  /// // Returns public keys of Bob and Charlie (sorted)
  /// ```
  List<Uint8List> otherSignatoriesForAddress(final String signerAddress) {
    late final Uint8List signerPubkey;
    try {
      signerPubkey = Address.decode(signerAddress).pubkey;
    } catch (e) {
      throw ArgumentError('Invalid signer address: $signerAddress');
    }

    return otherSignatoriesForPubkey(signerPubkey);
  }

  /// Returns the list of other signatories excluding the current signer (using public key).
  ///
  /// This is the public key variant of [otherSignatoriesForAddress]. Use this when you
  /// already have the public key and want to avoid address decoding overhead.
  ///
  /// Parameters:
  /// - [signerPubkey]: The 32-byte public key of the current signer
  ///
  /// Returns:
  /// A [List<Uint8List>] containing the public keys of all other signatories in sorted order.
  ///
  /// Throws:
  /// - [ArgumentError] if the signer public key is not found in the signatories list
  ///
  /// Example:
  /// ```dart
  /// // Alice is signing, using her public key directly
  /// final others = multisigAccount.otherSignatoriesForPubkey(alice.pubKey);
  /// // Returns public keys of Bob and Charlie (sorted)
  /// ```
  List<Uint8List> otherSignatoriesForPubkey(final Uint8List signerPubkey) {
    // Find and exclude the signer
    final others = <Uint8List>[];
    bool foundSigner = false;

    for (final pubkey in publicKeys) {
      if (_matchesPubkey(pubkey, signerPubkey)) {
        foundSigner = true;
      } else {
        others.add(pubkey);
      }
    }

    if (!foundSigner) {
      throw ArgumentError('Address $signerPubkey is not a signatory of this multisig');
    }

    return others;
  }

  /// Checks if an address is a signatory of this multisig account.
  ///
  /// This method validates whether a given address is authorized to participate
  /// in multisig operations for this account.
  ///
  /// Parameters:
  /// - [address]: The SS58-encoded address to check
  ///
  /// Returns:
  /// `true` if the address is a signatory, `false` otherwise.
  ///
  /// Throws:
  /// - [ArgumentError] if the address is invalid or cannot be decoded
  ///
  /// Example:
  /// ```dart
  /// if (!multisigAccount.containsAddress(alice.address)) {
  ///   throw Exception('Alice is not authorized to sign this transaction');
  /// }
  /// ```
  bool containsAddress(final String address) {
    final searchPubkey = Address.decode(address).pubkey;
    return publicKeys.any((final key) => _matchesPubkey(key, searchPubkey));
  }

  /// Checks if a public key is a signatory of this multisig account.
  ///
  /// This is the public key variant of [containsAddress]. Use this when you
  /// already have the public key to avoid address decoding overhead.
  ///
  /// Parameters:
  /// - [pubkey]: The 32-byte public key to check
  ///
  /// Returns:
  /// `true` if the public key is a signatory, `false` otherwise.
  ///
  /// Example:
  /// ```dart
  /// if (!multisigAccount.containsPubkey(alice.pubKey)) {
  ///   throw Exception('Alice is not authorized to sign this transaction');
  /// }
  /// ```
  bool containsPubkey(final Uint8List pubkey) {
    return publicKeys.any((final key) => _matchesPubkey(key, pubkey));
  }

  /// Internal helper to compare two public keys for equality.
  static bool _matchesPubkey(final Uint8List first, final Uint8List second) {
    return first.equals(second);
  }

  /// Derives the multisig account address using Substrate's standard algorithm.
  ///
  /// This internal method implements the deterministic multisig address derivation:
  /// 1. Start with the module prefix: "modlpy/utilisuba"
  /// 2. Append the compact-encoded count of signatories
  /// 3. Append each public key in sorted order
  /// 4. Append the threshold as a u16 (little-endian)
  /// 5. Hash the entire payload with blake2b256
  ///
  /// The result is a 32-byte public key that serves as the multisig account address.
  ///
  /// Parameters:
  /// - [sortedPubkeys]: The list of signatory public keys (must be pre-sorted)
  /// - [threshold]: The approval threshold
  ///
  /// Returns:
  /// A 32-byte [Uint8List] representing the multisig account public key.
  ///
  /// Formula: `blake2b256("modlpy/utilisuba" + encode(signatories) + threshold)`
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

  /// Creates a MultisigAccount from a JSON representation.
  ///
  /// This is useful for deserializing multisig configurations from storage or network.
  ///
  /// Parameters:
  /// - [json]: The JSON map containing threshold, publicKeys, and multisigPubkey
  ///
  /// Returns:
  /// A [MultisigAccount] instance reconstructed from the JSON data.
  ///
  /// Throws:
  /// - [Exception] if the JSON is malformed or missing required fields
  factory MultisigAccount.fromJson(final Map<String, dynamic> json) =>
      _$MultisigAccountFromJson(json);

  /// Converts this MultisigAccount to a JSON representation.
  ///
  /// This is useful for serializing multisig configurations for storage or transmission.
  ///
  /// Returns:
  /// A [Map<String, dynamic>] containing the threshold, publicKeys, and multisigPubkey.
  Map<String, dynamic> toJson() => _$MultisigAccountToJson(this);

  /// Static helper method for JSON serialization.
  ///
  /// This method is used by JsonSerializable for custom serialization logic.
  static Map<String, dynamic> toJsonMethod(final MultisigAccount multisigAccount) =>
      multisigAccount.toJson();

  @override
  List<Object> get props => [threshold, publicKeys, multisigPubkey];
}
