part of multisig;

@JsonSerializable(explicitToJson: true, constructor: '_')
class MultisigAccount extends Equatable {
  /// Number of approvals required for execution
  final int threshold;

  /// Sorted list of signatory public keys (32 bytes each)
  @Uint8ListListConverter()
  final List<Uint8List> publicKeys;

  /// The multisig account public key (32 bytes)
  @Uint8ListConverter()
  final Uint8List multisigPubkey;

  /// Private constructor
  const MultisigAccount._({
    required this.threshold,
    required this.publicKeys,
    required this.multisigPubkey,
  });

  /// Creates a new MultisigAccount instance
  ///
  /// Parameters:
  /// - [addresses]: List of signatory addresses (will be deduplicated and sorted)
  /// - [threshold]: Number of approvals required (must be between 2 and number of signatories)
  ///
  /// Example:
  /// ```dart
  /// final signatories = MultisigAccount(
  ///   addresses: [alice.address, bob.address, charlie.address],
  ///   threshold: 2,
  /// );
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
    pubkeysWithAddresses.sort((final a, final b) => _compareBytes(a, b));

    // Generate multisig address
    final multisigPubkey = _deriveMultisigAddress(pubkeysWithAddresses, threshold);

    return MultisigAccount._(
      threshold: threshold,
      publicKeys: pubkeysWithAddresses,
      multisigPubkey: multisigPubkey,
    );
  }

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
  /// final others = signatories.otherSignatoriesForAddress(alice.address);
  /// // Returns public keys of Bob and Charlie
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

  /// Get other signatories excluding the signer
  ///
  /// Used when creating multisig transactions. The current signer
  /// must be excluded from the "other_signatories" field.
  ///
  /// Parameters:
  /// - [signerPubkey]: The Pubkey of the current signer
  ///
  /// Returns: List of other signatories' public keys
  ///
  /// Throws: [ArgumentError] if signer is not a signatory
  ///
  /// Example:
  /// ```dart
  /// // Alice is signing
  /// final others = signatories.otherSignatoriesForPubkey(alice.pubKey);
  /// // Returns public keys of Bob and Charlie
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

  /// Check if an address is a signatory
  ///
  /// Example:
  /// ```dart
  /// if (!signatories.contains(alice.address)) {
  ///   throw Exception('Alice cannot sign this transaction');
  /// }
  /// ```
  bool containsAddress(final String address) {
    final searchPubkey = Address.decode(address).pubkey;
    return publicKeys.any((final key) => _matchesPubkey(key, searchPubkey));
  }

  /// Check if an Pubkey is a signatory
  ///
  /// Example:
  /// ```dart
  /// if (!signatories.containsPubkey(alice.pubKey)) {
  ///   throw Exception('Alice cannot sign this transaction');
  /// }
  bool containsPubkey(final Uint8List pubkey) {
    return publicKeys.any((final key) => _matchesPubkey(key, pubkey));
  }

  static bool _matchesPubkey(final Uint8List first, final Uint8List second) {
    return _compareBytes(first, second) == 0;
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

  /// Create from JSON
  factory MultisigAccount.fromJson(final Map<String, dynamic> json) =>
      _$MultisigAccountFromJson(json);

  /// Convert to JSON
  Map<String, dynamic> toJson() => _$MultisigAccountToJson(this);

  @override
  List<Object> get props => [threshold, publicKeys, multisigPubkey];
}
