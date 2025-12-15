part of multisig;

/// Type alias for future callback functions.
typedef FutureCallback = Future<Function>;

/// Response object returned by multisig operations.
///
/// This class encapsulates the result of multisig operations, including the multisig
/// account configuration, the call data being executed, and the transaction hash.
/// It provides convenient methods to check the status of pending multisig transactions.
///
/// Example:
/// ```dart
/// final response = await multisig.approveAsMulti(
///   approverAddress: alice.address,
///   signingCallback: alice.sign,
///   callData: callData,
/// );
///
/// print('Transaction hash: ${response.txHash}');
/// print('Call hash: ${response.callHash}');
///
/// // Check status
/// final status = await response.getStatus(provider);
/// if (status != null) {
///   print('Approvals: ${status.approvalCount}/${status.threshold}');
/// }
/// ```
@JsonSerializable()
class MultisigResponse extends Equatable {
  /// The multisig account configuration for this transaction.
  @JsonKey(toJson: MultisigAccount.toJsonMethod)
  final MultisigAccount multisigAccount;

  /// The SCALE-encoded call data for the transaction.
  ///
  /// This is the actual call that will be executed when the threshold is reached.
  @Uint8ListConverter()
  final Uint8List callData;

  /// The transaction hash of the submitted approval/execution transaction.
  ///
  /// This is excluded from JSON serialization as it's transaction-specific
  /// and not part of the persistent multisig configuration.
  @JsonKey(includeToJson: false, includeFromJson: false)
  final Uint8List? txHash;

  /// Creates a new MultisigResponse.
  ///
  /// Parameters:
  /// - [multisigAccount]: The multisig account configuration
  /// - [callData]: The SCALE-encoded call data
  /// - [txHash]: Optional transaction hash of the submitted transaction
  MultisigResponse({required this.multisigAccount, required this.callData, this.txHash});

  /// Creates a MultisigResponse from a JSON representation.
  ///
  /// This is useful for deserializing multisig operation results from storage.
  /// Note that txHash is not included in JSON serialization/deserialization.
  ///
  /// Parameters:
  /// - [json]: The JSON map containing multisigAccount and callData
  ///
  /// Returns:
  /// A [MultisigResponse] instance reconstructed from the JSON data.
  ///
  /// Throws:
  /// - [Exception] if the JSON is malformed or missing required fields
  factory MultisigResponse.fromJson(final Map<String, dynamic> json) =>
      _$MultisigResponseFromJson(json);

  /// Converts this MultisigResponse to a JSON representation.
  ///
  /// This is useful for serializing multisig operation results for storage.
  /// Note that txHash is excluded from the JSON output.
  ///
  /// Returns:
  /// A [Map<String, dynamic>] containing the multisigAccount and callData.
  Map<String, dynamic> toJson() => _$MultisigResponseToJson(this);

  /// Returns the blake2b256 hash of the call data.
  ///
  /// This hash is used to identify the transaction in on-chain storage and is
  /// required for operations like checking status or cancelling the transaction.
  ///
  /// Returns:
  /// A 32-byte [Uint8List] containing the blake2b256 hash of the call data.
  ///
  /// Example:
  /// ```dart
  /// final callHash = response.callHash;
  /// // Use this hash to cancel the transaction or check its status
  /// await multisig.cancel(
  ///   signerAddress: alice.address,
  ///   signingCallback: alice.sign,
  ///   callHash: callHash,
  /// );
  /// ```
  Uint8List get callHash {
    return Hasher.blake2b256.hash(callData);
  }

  /// Fetches the current status of this multisig transaction from the blockchain.
  ///
  /// This method queries the on-chain storage to get information about:
  /// - Number of approvals received
  /// - Whether the transaction is complete
  /// - Whether this is waiting for the final approval
  /// - Whether a specific signer has already approved (if signerAddress is provided)
  /// - Whether a specific signer can approve or cancel (if signerAddress is provided)
  ///
  /// Parameters:
  /// - [provider]: The blockchain connection provider
  /// - [signerAddress]: Optional address to check specific signer permissions
  ///
  /// Returns:
  /// A [MultisigStorageStatus] if the transaction is pending, or `null` if no
  /// approvals have been recorded yet (first approval hasn't been submitted).
  ///
  /// Throws:
  /// - [Exception] if the storage query fails
  ///
  /// Example:
  /// ```dart
  /// final status = await response.getStatus(provider, signerAddress: bob.address);
  /// if (status != null) {
  ///   print('Approvals: ${status.approvalCount}/${status.threshold}');
  ///   print('Bob can approve: ${status.canApprove}');
  ///   print('Waiting for final approval: ${status.isWaitingForFinalApproval}');
  /// } else {
  ///   print('No approvals yet - this is the first one');
  /// }
  /// ```
  Future<MultisigStorageStatus?> getStatus(
    final Provider provider, {
    final String? signerAddress,
  }) async {
    final storage = await MultisigStorage.fetch(
      provider: provider,
      multisigPubkey: multisigAccount.multisigPubkey,
      callHash: callHash,
    );
    return storage?.getStatus(threshold: multisigAccount.threshold, signerAddress: signerAddress);
  }

  @override
  List<Object> get props => [multisigAccount, callData];
}
