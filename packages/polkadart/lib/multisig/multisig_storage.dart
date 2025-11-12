part of multisig;

/// Represents the on-chain storage state of a multisig transaction
///
/// This class decodes and manages the storage data for pending multisig
/// transactions. It helps check approval status before submitting transactions
/// to avoid wasting gas fees.
///
/// Example:
/// ```dart
/// // Fetch storage for a pending transaction
/// final storage = await MultisigStorage.fetch(
///   provider: provider,
///   multisigAddress: signatories.multisigAddress,
///   callHash: callHash,
///   registry: chainInfo.registry,
/// );
///
/// if (storage == null) {
///   print('No pending transaction found');
/// } else if (storage.hasApproved(alice.address)) {
///   print('Alice already approved');
/// } else {
///   print('Alice can approve');
/// }
/// ```
class MultisigStorage extends Equatable {
  /// When the multisig transaction was initiated
  final TimePoint when;

  /// Amount deposited for storage (refunded on execution/cancel)
  final BigInt deposit;

  /// Address of who initiated the transaction (gets deposit back)
  final String depositor;

  /// List of addresses that have approved so far
  final List<String> approvals;

  /// The raw depositor bytes for comparison
  final Uint8List _depositorBytes;

  /// The raw approval bytes for comparison
  final List<Uint8List> _approvalBytes;

  const MultisigStorage._({
    required this.when,
    required this.deposit,
    required this.depositor,
    required this.approvals,
    required final Uint8List depositorBytes,
    required final List<Uint8List> approvalBytes,
  })  : _depositorBytes = depositorBytes,
        _approvalBytes = approvalBytes;

  /// Fetch multisig storage from chain
  ///
  /// Returns null if no pending transaction exists.
  ///
  /// Parameters:
  /// - [provider]: Chain connection
  /// - [multisigAddress]: The multisig account address
  /// - [callHash]: Hash of the call being executed
  /// - [registry]: Type registry for decoding
  ///
  /// Example:
  /// ```dart
  /// final storage = await MultisigStorage.fetch(
  ///   provider: provider,
  ///   multisigAddress: signatories.multisigAddress,
  ///   callHash: Hasher.blake2b256.hash(callData),
  ///   registry: chainInfo.registry,
  /// );
  ///
  /// if (storage == null) {
  ///   // No pending transaction - this would be the first approval
  /// }
  /// ```
  static Future<MultisigStorage?> fetch({
    required final Provider provider,
    required final String multisigAddress,
    required final Uint8List callHash,
    required final MetadataTypeRegistry registry,
  }) async {
    // Decode multisig address to get public key
    final multisigPubkey = Address.decode(multisigAddress).pubkey;

    // Create storage key
    final storageKey = _createStorageKey(multisigPubkey, callHash);

    // Fetch from chain
    final storageData = await StateApi(provider).getStorage(storageKey);

    if (storageData == null || storageData.isEmpty) {
      return null;
    }

    // Decode the storage
    return _decode(storageData, registry);
  }

  /// Check if an address has already approved
  ///
  /// Parameters:
  /// - [address]: Address to check
  ///
  /// Returns: true if already approved
  ///
  /// Example:
  /// ```dart
  /// if (storage.hasApproved(bob.address)) {
  ///   print('Bob already approved this transaction');
  ///   return; // Don't submit duplicate approval
  /// }
  /// ```
  bool hasApproved(final String address) {
    try {
      final pubkey = Address.decode(address).pubkey;
      return _approvalBytes.any((final approval) => _bytesEqual(approval, pubkey));
    } catch (_) {
      return false;
    }
  }

  /// Check if this is the depositor (transaction initiator)
  ///
  /// The depositor can cancel the transaction and gets the deposit back.
  ///
  /// Parameters:
  /// - [address]: Address to check
  ///
  /// Example:
  /// ```dart
  /// if (storage.isDepositor(alice.address)) {
  ///   print('Alice can cancel this transaction');
  /// }
  /// ```
  bool isDepositor(final String address) {
    try {
      final pubkey = Address.decode(address).pubkey;
      return _bytesEqual(_depositorBytes, pubkey);
    } catch (_) {
      return false;
    }
  }

  /// Check if this would be the final approval
  ///
  /// Parameters:
  /// - [threshold]: The multisig threshold
  ///
  /// Returns: true if one more approval would execute
  ///
  /// Example:
  /// ```dart
  /// if (storage.isFinalApproval(signatories.threshold)) {
  ///   // Next approval will execute the transaction
  ///   print('This will be the final approval');
  /// }
  /// ```
  bool isFinalApproval(final int threshold) {
    return approvals.length == threshold - 1;
  }

  /// Check if already fully approved
  ///
  /// This shouldn't happen normally but check to be safe.
  ///
  /// Parameters:
  /// - [threshold]: The multisig threshold
  ///
  /// Example:
  /// ```dart
  /// if (storage.isComplete(signatories.threshold)) {
  ///   print('Transaction already fully approved!');
  /// }
  /// ```
  bool isComplete(final int threshold) {
    return approvals.length >= threshold;
  }

  /// Get approval progress
  ///
  /// Returns: Current approvals and required threshold
  ///
  /// Example:
  /// ```dart
  /// final progress = storage.progress(signatories.threshold);
  /// print('${progress.current}/${progress.required} approvals');
  /// ```
  ({int current, int requiredApprovals}) progress(final int threshold) {
    return (current: approvals.length, requiredApprovals: threshold);
  }

  /// Create storage status summary
  ///
  /// Useful for displaying transaction status to users.
  ///
  /// Parameters:
  /// - [threshold]: The multisig threshold
  /// - [signerAddress]: Optional address to check their status
  ///
  /// Example:
  /// ```dart
  /// final status = storage.getStatus(
  ///   threshold: signatories.threshold,
  ///   signerAddress: bob.address,
  /// );
  ///
  /// print('Approvals: ${status.approvalCount}/${status.threshold}');
  /// print('Can approve: ${status.canApprove}');
  /// print('Is final: ${status.isFinal}');
  /// ```
  MultisigStorageStatus getStatus({
    required final int threshold,
    final String? signerAddress,
  }) {
    return MultisigStorageStatus(
      approvalCount: approvals.length,
      threshold: threshold,
      isComplete: isComplete(threshold),
      isWaitingForFinalApproval: isFinalApproval(threshold),
      depositor: depositor,
      deposit: deposit,
      when: when,
      approvals: approvals,
      hasApproved: signerAddress != null ? hasApproved(signerAddress) : null,
      canApprove:
          signerAddress != null ? !hasApproved(signerAddress) && !isComplete(threshold) : null,
      canCancel: signerAddress != null ? isDepositor(signerAddress) : null,
    );
  }

  /// Create storage key for multisig
  ///
  /// Format: xxhash128("Multisig") + xxhash128("Multisigs") +
  ///         xxhash64(address) + address + blake2_128(callHash) + callHash
  static Uint8List _createStorageKey(final Uint8List multisigPubkey, final Uint8List callHash) {
    final output = ByteOutput();

    // Pallet hash
    output.write(Hasher.twoxx128.hashString('Multisig'));

    // Storage item hash
    output.write(Hasher.twoxx128.hashString('Multisigs'));

    // First key (multisig address) - hashed + raw
    output.write(Hasher.twoxx64.hash(multisigPubkey));
    output.write(multisigPubkey);

    // Second key (call hash) - hashed + raw
    output.write(Hasher.blake2b128.hash(callHash));
    output.write(callHash);

    return output.toBytes();
  }

  /// Decode storage data
  static MultisigStorage _decode(final Uint8List data, final MetadataTypeRegistry registry) {
    final input = Input.fromBytes(data);

    // The storage structure is:
    // {
    //   when: { height: u32, index: u32 },
    //   deposit: u128,
    //   depositor: [u8; 32],
    //   approvals: Vec<[u8; 32]>
    // }

    // Decode timepoint
    final height = U32Codec.codec.decode(input);
    final index = U32Codec.codec.decode(input);
    final TimePoint when = TimePoint(height: height, index: index);

    // Decode deposit
    final BigInt deposit = U128Codec.codec.decode(input);

    // Decode depositor (32 bytes)
    final List<int> depositorBytesRaw = ArrayCodec(U8Codec.codec, 32).decode(input);
    final Uint8List depositorBytes = Uint8List.fromList(depositorBytesRaw);

    // Decode approvals (Vec<[u8; 32]>)
    final List<List<int>> approvalBytesRaw =
        SequenceCodec(ArrayCodec(U8Codec.codec, 32)).decode(input);
    final List<Uint8List> approvalBytes = approvalBytesRaw.map(Uint8List.fromList).toList();

    // Convert to addresses (using generic SS58 format)
    final String depositorAddress = Address(prefix: 42, pubkey: depositorBytes).encode();

    final List<String> approvalAddresses =
        approvalBytes.map((final bytes) => Address(prefix: 42, pubkey: bytes).encode()).toList();

    return MultisigStorage._(
      when: when,
      deposit: deposit,
      depositor: depositorAddress,
      approvals: approvalAddresses,
      depositorBytes: depositorBytes,
      approvalBytes: approvalBytes,
    );
  }

  /// Compare byte arrays for equality
  static bool _bytesEqual(final Uint8List a, final Uint8List b) {
    if (a.length != b.length) {
      return false;
    }
    for (int i = 0; i < a.length; i++) {
      if (a[i] != b[i]) {
        return false;
      }
    }
    return true;
  }

  @override
  List<Object> get props => [
        when,
        deposit,
        depositor,
        approvals,
        _depositorBytes,
        _approvalBytes,
      ];
}
