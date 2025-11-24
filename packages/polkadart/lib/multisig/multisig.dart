part of multisig;

/// Main class for managing multisig operations on a Substrate-based blockchain.
///
/// This class provides methods for creating, funding, and managing multisig accounts,
/// as well as approving and executing multisig transactions. It handles the complete
/// lifecycle of multisig operations including initiating transfers, collecting approvals,
/// and executing transactions when the threshold is met.
///
/// Example:
/// ```dart
/// final multisig = Multisig(
///   provider: provider,
///   chainInfo: chainInfo,
///   multisigAccount: multisigAccount,
/// );
///
/// // Fund the multisig account
/// await multisig.createAndFundMultisig(
///   fundingAmount: BigInt.from(1000000000000),
///   depositorAddress: alice.address,
///   signingCallback: alice.sign,
/// );
/// ```
class Multisig {
  /// The provider for connecting to the blockchain
  final Provider provider;

  /// The chain metadata and configuration information
  final ChainInfo chainInfo;

  /// The multisig account configuration with signatories and threshold
  final MultisigAccount multisigAccount;

  /// Creates a new Multisig instance.
  ///
  /// Parameters:
  /// - [provider]: The blockchain connection provider
  /// - [chainInfo]: Chain metadata and configuration
  /// - [multisigAccount]: The multisig account configuration
  const Multisig({required this.provider, required this.chainInfo, required this.multisigAccount});

  /// Creates and funds a multisig account by transferring the specified amount from the depositor's account.
  ///
  /// This method performs a `transferKeepAlive` operation to fund the multisig account while ensuring
  /// the depositor's account remains above the existential deposit.
  ///
  /// Parameters:
  /// - [fundingAmount]: The amount to transfer to the multisig account (in smallest units)
  /// - [depositorAddress]: The address of the account funding the multisig
  /// - [signingCallback]: Callback function to sign the transaction
  /// - [eraPeriod]: The era period for transaction mortality (default: 64 blocks)
  /// - [tip]: Optional tip to prioritize transaction inclusion
  ///
  /// Returns:
  /// A [MultisigResponse] containing the multisig account details, call data, and transaction hash.
  ///
  /// Throws:
  /// - [Exception] if the transaction submission fails
  /// - [ArgumentError] if the depositor address is invalid
  ///
  /// Example:
  /// ```dart
  /// final response = await multisig.createAndFundMultisig(
  ///   fundingAmount: BigInt.from(1000000000000), // 1 unit with 12 decimals
  ///   depositorAddress: alice.address,
  ///   signingCallback: alice.sign,
  ///   eraPeriod: 64,
  /// );
  /// print('Transaction hash: ${response.txHash}');
  /// ```
  Future<MultisigResponse> createAndFundMultisig({
    required final BigInt fundingAmount,
    required final String depositorAddress,
    required final SigningCallback signingCallback,
    final int eraPeriod = 64,
    final BigInt? tip,
  }) async {
    final RuntimeCall fundingCall = Balances.transferKeepAlive
        .toAccountId(amount: fundingAmount, destination: multisigAccount.multisigPubkey)
        .toRuntimeCall(chainInfo);
    final Uint8List fundingCallData = chainInfo.callsCodec.encode(fundingCall);

    final chainData = await ChainDataFetcher(provider).fetchStandardData();

    final extrinsicBuilder = ExtrinsicBuilder.fromChainData(
      chainInfo: chainInfo,
      callData: fundingCallData,
      chainData: chainData,
      eraPeriod: eraPeriod,
      tip: tip,
    );

    final Uint8List txHash = await extrinsicBuilder.signBuildAndSubmit(
      signingCallback: signingCallback,
      provider: provider,
      signerAddress: depositorAddress,
    );

    return MultisigResponse(
      multisigAccount: multisigAccount,
      callData: fundingCallData,
      txHash: txHash,
    );
  }

  /// Creates SCALE-encoded call data for a balance transfer operation.
  ///
  /// This method generates the encoded call data that can be used in multisig transactions
  /// for transferring funds from the multisig account to a recipient.
  ///
  /// Parameters:
  /// - [recipientAddress]: The destination address for the transfer
  /// - [transferAmount]: The amount to transfer (in smallest units)
  /// - [keepAlive]: If true, uses transferKeepAlive to ensure sender stays above existential deposit (default: true)
  ///
  /// Returns:
  /// A [Uint8List] containing the SCALE-encoded call data.
  ///
  /// Throws:
  /// - [ArgumentError] if the recipient address is invalid
  ///
  /// Example:
  /// ```dart
  /// final callData = multisig.createCallData(
  ///   recipientAddress: bob.address,
  ///   transferAmount: BigInt.from(500000000000),
  ///   keepAlive: true,
  /// );
  /// ```
  Uint8List createCallData({
    required final String recipientAddress,
    required final BigInt transferAmount,
    final bool keepAlive = true,
  }) {
    late final RuntimeCall call;
    final recipient = Address.decode(recipientAddress).pubkey;
    if (keepAlive) {
      call = Balances.transferKeepAlive
          .toAccountId(amount: transferAmount, destination: recipient)
          .toRuntimeCall(chainInfo);
    } else {
      call = Balances.transfer
          .toAccountId(amount: transferAmount, destination: recipient)
          .toRuntimeCall(chainInfo);
    }
    final callData = chainInfo.callsCodec.encode(call);
    return callData;
  }

  /// Initiates a transfer from the multisig account by creating the first approval.
  ///
  /// This is a convenience method that creates call data for a balance transfer and
  /// submits the first approval in one step. Use this for the first signatory to
  /// initiate a new transfer transaction.
  ///
  /// Parameters:
  /// - [senderAddress]: The address of the signatory initiating the transfer (must be a signatory)
  /// - [signingCallback]: Callback function to sign the transaction
  /// - [recipientAddress]: The destination address for the transfer
  /// - [transferAmount]: The amount to transfer (in smallest units)
  /// - [keepAlive]: If true, uses transferKeepAlive (default: true)
  /// - [eraPeriod]: The era period for transaction mortality (default: 64 blocks)
  /// - [tip]: Optional tip to prioritize transaction inclusion
  /// - [nonce]: Optional nonce override for the transaction
  /// - [maxWeight]: Optional maximum weight for the call execution
  ///
  /// Returns:
  /// A [MultisigResponse] containing the multisig account details, call data, and transaction hash.
  ///
  /// Throws:
  /// - [ArgumentError] if the sender is not a signatory of the multisig account
  /// - [ArgumentError] if the recipient address is invalid
  /// - [StateError] if the sender has already approved this transaction
  /// - [StateError] if the transaction is already complete
  /// - [Exception] if the transaction submission fails
  ///
  /// Example:
  /// ```dart
  /// final response = await multisig.initiateTransfer(
  ///   senderAddress: alice.address,
  ///   signingCallback: alice.sign,
  ///   recipientAddress: bob.address,
  ///   transferAmount: BigInt.from(500000000000),
  ///   keepAlive: true,
  /// );
  /// ```
  Future<MultisigResponse> initiateTransfer({
    required final String senderAddress,
    required final SigningCallback signingCallback,
    required final String recipientAddress,
    required final BigInt transferAmount,
    final bool keepAlive = true,
    final int eraPeriod = 64,
    final BigInt? tip,
    final int? nonce,
    Weight? maxWeight,
  }) async {
    late final RuntimeCall call;
    final recipient = Address.decode(recipientAddress).pubkey;
    if (keepAlive) {
      call = Balances.transferKeepAlive
          .toAccountId(amount: transferAmount, destination: recipient)
          .toRuntimeCall(chainInfo);
    } else {
      call = Balances.transfer
          .toAccountId(amount: transferAmount, destination: recipient)
          .toRuntimeCall(chainInfo);
    }
    final callData = chainInfo.callsCodec.encode(call);

    return approveAsMulti(
      approverAddress: senderAddress,
      signingCallback: signingCallback,
      callData: callData,
      eraPeriod: eraPeriod,
      tip: tip,
      nonce: nonce,
      maxWeight: maxWeight,
    );
  }

  /// Approves a pending multisig transaction (non-final approval).
  ///
  /// This method is used for all approvals except the final one. It adds the approver's
  /// signature to the pending transaction. When the approval count reaches threshold-1,
  /// you must use [asMulti] instead for the final approval that will execute the transaction.
  ///
  /// The method automatically:
  /// - Checks if the approver is a valid signatory
  /// - Verifies the approver hasn't already approved
  /// - Ensures the transaction isn't already complete
  /// - Prevents using approveAsMulti for the final approval (use asMulti instead)
  ///
  /// Parameters:
  /// - [approverAddress]: The address of the signatory approving the transaction (must be a signatory)
  /// - [signingCallback]: Callback function to sign the approval transaction
  /// - [callData]: The SCALE-encoded call data to approve
  /// - [eraPeriod]: The era period for transaction mortality (default: 64 blocks)
  /// - [tip]: Optional tip to prioritize transaction inclusion
  /// - [nonce]: Optional nonce override for the transaction
  /// - [maxWeight]: Maximum weight for the call execution (defaults to refTime: 1s, proofSize: 10KB)
  ///
  /// Returns:
  /// A [MultisigResponse] containing the multisig account details, call data, and transaction hash.
  ///
  /// Throws:
  /// - [ArgumentError] if the approver is not a signatory of the multisig account
  /// - [StateError] if the approver has already approved this transaction
  /// - [StateError] if the transaction is already complete with enough approvals
  /// - [StateError] if this would be the final approval (must use asMulti instead)
  /// - [Exception] if the transaction submission fails
  ///
  /// Example:
  /// ```dart
  /// // Alice initiated the transaction, now Bob approves
  /// final response = await multisig.approveAsMulti(
  ///   approverAddress: bob.address,
  ///   signingCallback: bob.sign,
  ///   callData: callData, // From the initial response
  /// );
  /// ```
  Future<MultisigResponse> approveAsMulti({
    required final String approverAddress,
    required final SigningCallback signingCallback,
    required final Uint8List callData,
    final int eraPeriod = 64,
    final BigInt? tip,
    final int? nonce,
    Weight? maxWeight,
  }) async {
    maxWeight ??= Weight(
      refTime: BigInt.from(1000000000), // 1 second of execution time
      proofSize: BigInt.from(10000), // 10KB proof size
    );

    if (!multisigAccount.containsAddress(approverAddress)) {
      throw ArgumentError('$approverAddress is not a signatory of this multisig');
    }

    final callHash = Hasher.blake2b256.hash(callData);
    // Fetch current storage state
    final storage = await MultisigStorage.fetch(
      provider: provider,
      multisigPubkey: multisigAccount.multisigPubkey,
      callHash: callHash,
    );

    if (storage != null) {
      if (storage.hasApproved(approverAddress)) {
        throw StateError('Address $approverAddress has already approved this transaction');
      }

      if (storage.isComplete(multisigAccount.threshold)) {
        throw StateError(
          'Transaction is already complete with ${storage.approvals.length} approvals',
        );
      }
      if (storage.isFinalApproval(multisigAccount.threshold)) {
        throw StateError(
          'Can\'t call `approveAsMulti`. Final approval required for this transaction, use `asMulti` to approve this transaction.',
        );
      }
    }

    // First/Middle approval - use approveAsMulti
    // approvals-till-now = (storage?.approvals.length ?? 0)
    // Adding approval ${approvals-till-now + 1} / ${signatories.threshold}
    final RuntimeCall approvalCall = _createApproveAsMultiRuntimeCall(
      signerAddress: approverAddress,
      maybeTimepoint: storage?.when,
      callHash: callHash,
      maxWeight: maxWeight,
    );

    final txHash = await _submitCall(
      call: approvalCall,
      signerAddress: approverAddress,
      signCallback: signingCallback,
      nonce: nonce,
      tip: tip,
      eraPeriod: eraPeriod,
    );

    return MultisigResponse(multisigAccount: multisigAccount, callData: callData, txHash: txHash);
  }

  /// Submits the final approval and executes the multisig transaction.
  ///
  /// This method must be used for the final approval (when approval count equals threshold-1).
  /// Unlike [approveAsMulti], this method not only adds the approval but also executes the
  /// pending call on-chain. The transaction will be executed immediately upon successful
  /// approval.
  ///
  /// The method automatically:
  /// - Verifies that prior approvals exist (storage must not be null)
  /// - Checks if the approver is a valid signatory
  /// - Ensures the approver hasn't already approved
  /// - Confirms this is the final approval needed
  /// - Executes the call upon successful approval
  ///
  /// Parameters:
  /// - [callData]: The SCALE-encoded call data to execute
  /// - [approverAddress]: The address of the signatory providing the final approval (must be a signatory)
  /// - [signingCallback]: Callback function to sign the execution transaction
  /// - [eraPeriod]: The era period for transaction mortality (default: 64 blocks)
  /// - [tip]: Optional tip to prioritize transaction inclusion
  /// - [nonce]: Optional nonce override for the transaction
  /// - [maxWeight]: Maximum weight for the call execution (defaults to refTime: 1s, proofSize: 10KB)
  ///
  /// Returns:
  /// A [MultisigResponse] containing the multisig account details, call data, and transaction hash.
  ///
  /// Throws:
  /// - [StateError] if no prior approvals exist (storage is null)
  /// - [ArgumentError] if the approver is not a signatory of the multisig account
  /// - [StateError] if the approver has already approved this transaction
  /// - [StateError] if the transaction is already complete
  /// - [StateError] if this is not the final approval (use approveAsMulti instead)
  /// - [Exception] if the transaction submission or execution fails
  ///
  /// Example:
  /// ```dart
  /// // Charlie provides the final approval and executes the transaction
  /// // (assuming threshold is 3 and Alice & Bob have already approved)
  /// final response = await multisig.asMulti(
  ///   callData: callData,
  ///   approverAddress: charlie.address,
  ///   signingCallback: charlie.sign,
  /// );
  /// print('Transaction executed with hash: ${response.txHash}');
  /// ```
  Future<MultisigResponse> asMulti({
    required final Uint8List callData,
    required final String approverAddress,
    required final SigningCallback signingCallback,
    final int eraPeriod = 64,
    final BigInt? tip,
    final int? nonce,
    Weight? maxWeight,
  }) async {
    maxWeight ??= Weight(
      refTime: BigInt.from(1000000000), // 1 second of execution time
      proofSize: BigInt.from(10000), // 10KB proof size
    );

    if (!multisigAccount.containsAddress(approverAddress)) {
      throw ArgumentError('$approverAddress is not a signatory of this multisig');
    }

    final callHash = Hasher.blake2b256.hash(callData);

    final storage = await MultisigStorage.fetch(
      provider: provider,
      multisigPubkey: multisigAccount.multisigPubkey,
      callHash: callHash,
    );

    if (storage == null) {
      throw StateError(
        'Multisig Storage is null, indicating that the first approval has not been submitted yet',
      );
    } else {
      if (storage.hasApproved(approverAddress)) {
        throw StateError('Address $approverAddress has already approved this transaction');
      }
      if (storage.isComplete(multisigAccount.threshold)) {
        throw StateError(
          'Transaction is already complete with ${storage.approvals.length} approvals',
        );
      }
      if (storage.isFinalApproval(multisigAccount.threshold) == false) {
        throw StateError(
          'Not enough approvals for final execution. Current approvals: ${storage.approvals.length}, Required for asMulti: ${multisigAccount.threshold - 1}. Use approveAsMulti instead.',
        );
      }
    }
    // This will be the final approval - use asMulti to execute
    // Creating final approval to execute transaction
    final RuntimeCall approvalCall = _createAsMultiRuntimeCall(
      signerAddress: approverAddress,
      maybeTimepoint: storage.when,
      callData: callData,
      maxWeight: maxWeight,
    );

    final txHash = await _submitCall(
      call: approvalCall,
      signerAddress: approverAddress,
      signCallback: signingCallback,
      nonce: nonce,
      eraPeriod: eraPeriod,
      tip: tip,
    );
    return MultisigResponse(multisigAccount: multisigAccount, callData: callData, txHash: txHash);
  }

  /// Cancels a pending multisig transaction and refunds the deposit.
  ///
  /// Only the depositor (the signatory who initiated the transaction) can cancel it.
  /// Cancelling refunds the storage deposit to the depositor and removes the pending
  /// transaction from chain storage.
  ///
  /// Parameters:
  /// - [signerAddress]: The address of the depositor cancelling the transaction
  /// - [signingCallback]: Callback function to sign the cancellation transaction
  /// - [callHash]: The hash of the call to cancel (obtained from MultisigResponse.callHash)
  /// - [eraPeriod]: The era period for transaction mortality (default: 64 blocks)
  /// - [nonce]: Optional nonce override for the transaction
  ///
  /// Returns:
  /// A [Uint8List] containing the transaction hash of the cancellation.
  ///
  /// Throws:
  /// - [StateError] if no pending transaction exists for the given call hash
  /// - [StateError] if the signer is not the depositor (only depositor can cancel)
  /// - [Exception] if the transaction submission fails
  ///
  /// Example:
  /// ```dart
  /// // Alice initiated the transaction and wants to cancel it
  /// final txHash = await multisig.cancel(
  ///   signerAddress: alice.address,
  ///   signingCallback: alice.sign,
  ///   callHash: response.callHash,
  /// );
  /// print('Transaction cancelled with hash: $txHash');
  /// ```
  Future<Uint8List> cancel({
    required final String signerAddress,
    required final SigningCallback signingCallback,
    required final Uint8List callHash,
    final int eraPeriod = 64,
    final int? nonce,
  }) async {
    final storage = await MultisigStorage.fetch(
      provider: provider,
      multisigPubkey: multisigAccount.multisigPubkey,
      callHash: callHash,
    );

    if (storage == null) {
      throw StateError('No pending transaction to cancel');
    }

    if (!storage.isDepositor(signerAddress)) {
      throw StateError('Only the depositor can cancel this transaction');
    }

    final cancelCall = _createCancelAsMultiRuntimeCall(
      signerAddress: signerAddress,
      maybeTimepoint: storage.when,
      callHash: callHash,
    );

    final txHash = await _submitCall(
      call: cancelCall,
      signerAddress: signerAddress,
      signCallback: signingCallback,
      eraPeriod: eraPeriod,
      nonce: nonce,
    );

    return txHash;
  }

  /// Creates a RuntimeCall for cancelling a multisig transaction.
  ///
  /// This is an internal helper method that constructs the cancel_as_multi extrinsic.
  ///
  /// Parameters:
  /// - [signerAddress]: The address of the signer (must be the depositor)
  /// - [maybeTimepoint]: The timepoint when the transaction was initiated
  /// - [callHash]: The hash of the call being cancelled
  ///
  /// Returns:
  /// A [RuntimeCall] configured for the cancel_as_multi extrinsic.
  RuntimeCall _createCancelAsMultiRuntimeCall({
    required final String signerAddress,
    required final TimePoint maybeTimepoint,
    required final Uint8List callHash,
  }) {
    return _createRuntimeCall(
      palletName: 'Multisig',
      callName: 'cancel_as_multi',
      signerAddress: signerAddress,
      maybeTimepoint: maybeTimepoint,
    );
  }

  /// Creates a RuntimeCall for approving a multisig transaction (non-final approval).
  ///
  /// This is an internal helper method that constructs the approve_as_multi extrinsic
  /// which adds an approval without executing the call.
  ///
  /// Parameters:
  /// - [signerAddress]: The address of the signer providing the approval
  /// - [maxWeight]: Maximum computational weight for the eventual execution
  /// - [callHash]: The hash of the call being approved
  /// - [maybeTimepoint]: Optional timepoint from previous approvals (null for first approval)
  ///
  /// Returns:
  /// A [RuntimeCall] configured for the approve_as_multi extrinsic.
  RuntimeCall _createApproveAsMultiRuntimeCall({
    required final String signerAddress,
    required final Weight maxWeight,
    required final Uint8List callHash,
    final TimePoint? maybeTimepoint,
  }) {
    return _createRuntimeCall(
      palletName: 'Multisig',
      callName: 'approve_as_multi',
      signerAddress: signerAddress,
      maybeTimepoint: maybeTimepoint,
      extras: {'call_hash': callHash, 'max_weight': maxWeight.toEncodableObject()},
    );
  }

  /// Creates a RuntimeCall for the final multisig approval and execution.
  ///
  /// This is an internal helper method that constructs the as_multi extrinsic which
  /// both approves and executes the pending call. The callData is wrapped in ScaleRawBytes
  /// to avoid unnecessary decode/re-encode cycles since it's already SCALE-encoded.
  ///
  /// Parameters:
  /// - [signerAddress]: The address of the signer providing the final approval
  /// - [callData]: The SCALE-encoded call to execute
  /// - [maybeTimepoint]: The timepoint when the transaction was initiated (from storage)
  /// - [maxWeight]: Maximum computational weight for execution
  ///
  /// Returns:
  /// A [RuntimeCall] configured for the as_multi extrinsic.
  RuntimeCall _createAsMultiRuntimeCall({
    required final String signerAddress,
    required final Uint8List callData,
    required final TimePoint maybeTimepoint,
    required final Weight maxWeight,
  }) {
    // Use ScaleRawBytes to avoid decode/re-encode cycle
    // The callData is already SCALE-encoded, so we wrap it to be written as-is
    return _createRuntimeCall(
      palletName: 'Multisig',
      callName: 'as_multi',
      signerAddress: signerAddress,
      maybeTimepoint: maybeTimepoint,
      extras: {'call': ScaleRawBytes(callData), 'max_weight': maxWeight.toEncodableObject()},
    );
  }

  /// Creates a generic RuntimeCall for multisig operations.
  ///
  /// This is an internal helper method that constructs RuntimeCall objects for various
  /// multisig extrinsics. It automatically:
  /// - Calculates other signatories by excluding the current signer
  /// - Looks up pallet and call indices from the chain metadata
  /// - Includes the threshold and timepoint in the arguments
  ///
  /// Parameters:
  /// - [palletName]: The name of the pallet (usually 'Multisig')
  /// - [callName]: The name of the extrinsic (e.g., 'approve_as_multi', 'as_multi', 'cancel_as_multi')
  /// - [signerAddress]: The address of the current signer
  /// - [maybeTimepoint]: Optional timepoint for the transaction
  /// - [extras]: Additional parameters specific to the extrinsic type
  ///
  /// Returns:
  /// A [RuntimeCall] configured with all necessary parameters.
  RuntimeCall _createRuntimeCall({
    required final String palletName,
    required final String callName,
    required final String signerAddress,
    required final TimePoint? maybeTimepoint,
    final Map<String, dynamic>? extras,
  }) {
    final otherSignatories = multisigAccount.otherSignatoriesForAddress(signerAddress);

    final indices = CallIndicesLookup(
      chainInfo,
    ).getPalletAndCallIndex(palletName: palletName, callName: callName);

    return RuntimeCall(
      palletName: palletName,
      palletIndex: indices.palletIndex,
      callName: callName,
      callIndex: indices.callIndex,
      args: {
        'threshold': multisigAccount.threshold,
        'other_signatories': otherSignatories,
        'maybe_timepoint': maybeTimepoint?.toJson(),
        ...?extras,
      },
    );
  }

  /// Submits a RuntimeCall to the blockchain.
  ///
  /// This is an internal helper method that handles the complete transaction submission process:
  /// 1. Encodes the RuntimeCall to SCALE-encoded bytes
  /// 2. Fetches current chain data (genesis hash, block hash, etc.)
  /// 3. Builds the extrinsic with proper era period and tip
  /// 4. Signs and submits the transaction
  ///
  /// Parameters:
  /// - [call]: The RuntimeCall to submit
  /// - [signerAddress]: The address signing the transaction
  /// - [signCallback]: Callback function to sign the transaction
  /// - [nonce]: Optional nonce override (uses chain state if not provided)
  /// - [eraPeriod]: Transaction mortality period (default: 64 blocks)
  /// - [tip]: Optional tip to prioritize transaction inclusion
  ///
  /// Returns:
  /// A [Uint8List] containing the transaction hash.
  ///
  /// Throws:
  /// - [Exception] if encoding, signing, or submission fails
  Future<Uint8List> _submitCall({
    required final RuntimeCall call,
    required final String signerAddress,
    required final SigningCallback signCallback,
    required final int? nonce,
    final int eraPeriod = 64,
    final BigInt? tip,
  }) async {
    final output = ByteOutput();
    final codec = chainInfo.callsCodec;
    codec.encodeTo(call, output);
    final callData = output.toBytes();

    final chainData = await ChainDataFetcher(provider).fetchStandardData();

    final extrinsic = ExtrinsicBuilder.fromChainData(
      chainInfo: chainInfo,
      callData: callData,
      chainData: chainData,
      eraPeriod: eraPeriod,
      tip: tip,
    );

    if (nonce != null) {
      extrinsic.nonce(nonce);
    }

    final txHash = await extrinsic.signBuildAndSubmit(
      signingCallback: signCallback,
      provider: provider,
      signerAddress: signerAddress,
    );
    return txHash;
  }
}
