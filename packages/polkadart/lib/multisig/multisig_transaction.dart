/* part of multisig;

/// Represents a multisig transaction that can be approved or executed
///
/// This is the main class for creating and managing multisig transactions.
/// It handles creating the appropriate calls (approveAsMulti, asMulti, cancelAsMulti)
/// and submitting them to the chain.
///
/// Example:
/// ```dart
/// // Create a transaction
/// final tx = MultisigTransaction(
///   signatories: signatories,
///   callData: transferCall.encode(chainInfo),
///   chainInfo: chainInfo,
/// );
///
/// // Alice initiates
/// await tx.approve(
///   provider: provider,
///   signer: alice.address,
///   signCallback: (payload) => alice.sign(payload),
/// );
///
/// // Share with others
/// final shareData = tx.toJson();
/// ```
class MultisigTransaction {
  /// The signatories configuration
  final Signatories signatories;

  /// The call to be executed (encoded)
  final Uint8List callData;

  /// Hash of the call
  final Uint8List callHash;

  /// Chain metadata info
  final ChainInfo chainInfo;

  /// Optional timepoint (set after first approval)
  TimePoint? timepoint;

  /// Weight for the call (can be customized)
  late final Weight maxWeight;

  /// Creates a new multisig transaction
  ///
  /// Parameters:
  /// - [signatories]: The multisig configuration
  /// - [callData]: Encoded call to execute
  /// - [chainInfo]: Chain metadata
  /// - [maxWeight]: Optional weight limit (uses defaults if not provided)
  ///
  /// Example:
  /// ```dart
  /// // Using raw bytes
  /// final tx = MultisigTransaction(
  ///   signatories: signatories,
  ///   callData: encodedCallBytes,
  ///   chainInfo: chainInfo,
  /// );
  ///
  /// // Or encoding a RuntimeCall
  /// final call = RuntimeCall(
  ///   palletName: 'Balances',
  ///   callName: 'transfer',
  ///   args: {'dest': dest, 'value': amount},
  /// );
  /// final output = ByteOutput();
  /// chainInfo.callsCodec.encodeTo(call, output);
  /// final tx = MultisigTransaction(
  ///   signatories: signatories,
  ///   callData: output.toBytes(),
  ///   chainInfo: chainInfo,
  /// );
  /// ```
  MultisigTransaction({
    required this.signatories,
    required this.callData,
    required this.chainInfo,
    final Weight? maxWeight,
  }) : callHash = Hasher.blake2b256.hash(callData) {
    // Set default weight if not provided
    this.maxWeight = maxWeight ??
        Weight(
          refTime: BigInt.from(1000000000), // 1 second of execution time
          proofSize: BigInt.from(10000), // 10KB proof size
        );
  }

  /// Create a transaction from a RuntimeCall
  ///
  /// Convenience factory for creating from a RuntimeCall object.
  ///
  /// Example:
  /// ```dart
  /// final call = Balances.transferKeepAlive.toAccountId(
  ///   destination: bobPubkey,
  ///   amount: amount,
  /// );
  ///
  /// final tx = MultisigTransaction.fromCall(
  ///   signatories: signatories,
  ///   call: call,
  ///   chainInfo: chainInfo,
  /// );
  /// ```
  factory MultisigTransaction.fromCall({
    required final Signatories signatories,
    required final RuntimeCall call,
    required final ChainInfo chainInfo,
    final Weight? maxWeight,
  }) {
    final Uint8List callData = chainInfo.callsCodec.encode(call);
    return MultisigTransaction(
      signatories: signatories,
      callData: callData,
      chainInfo: chainInfo,
      maxWeight: maxWeight,
    );
  }

  /// Approve or execute this transaction
  ///
  /// This method automatically determines whether to:
  /// - Create first approval (approveAsMulti)
  /// - Add another approval (approveAsMulti)
  /// - Execute as final approval (asMulti)
  ///
  /// Parameters:
  /// - [provider]: Chain connection
  /// - [signer]: Address of the signer
  /// - [signCallback]: Callback to sign the payload
  /// - [tip]: Optional tip for block producers
  /// - [eraPeriod]: Transaction eraPeriod (default: 64 blocks)
  /// - [nonce]: Optional nonce (fetched if not provided)
  ///
  /// Returns: Transaction hash
  ///
  /// Throws:
  /// - [StateError] if already approved by this signer
  /// - [StateError] if transaction is already complete
  ///
  /// Example:
  /// ```dart
  /// // Bob approves (automatically handles whether first/middle/final)
  /// final txHash = await tx.approve(
  ///   provider: provider,
  ///   signer: bob.address,
  ///   signCallback: (payload) => bobWallet.sign(payload),
  /// );
  /// print('Transaction: $txHash');
  /// ```
  Future<Uint8List> approve({
    required final Provider provider,
    required final String signer,
    required final SigningCallback signCallback,
    final BigInt? tip,
    final int eraPeriod = 64,
    final int? nonce,
  }) async {
    if (!signatories.contains(signer)) {
      throw ArgumentError('$signer is not a signatory of this multisig');
    }

    // Fetch current storage state
    final storage = await MultisigStorage.fetch(
      provider: provider,
      multisigPubkey: signatories.multisigPubkey,
      callHash: callHash,
      registry: chainInfo.registry,
    );

    // Determine what type of approval to do
    final RuntimeCall approvalCall;

    if (storage == null) {
      // First approval - no storage exists yet
      // Creating first approval for multisig transaction
      approvalCall = _createApproveAsMultiCall(
        signerAddress: signer,
        maybeTimepoint: null,
      );
    } else {
      if (storage.hasApproved(signer)) {
        throw StateError('Address $signer has already approved this transaction');
      }

      if (storage.isComplete(signatories.threshold)) {
        throw StateError(
            'Transaction is already complete with ${storage.approvals.length} approvals');
      }

      // Update our timepoint
      timepoint = storage.when;

      if (storage.isFinalApproval(signatories.threshold)) {
        // This will be the final approval - use asMulti to execute
        // Creating final approval to execute transaction
        approvalCall = _createAsMultiCall(
          signerAddress: signer,
          timepoint: storage.when,
        );
      } else {
        // Middle approval - use approveAsMulti
        // Adding approval ${storage.approvals.length + 1}/${signatories.threshold}
        approvalCall = _createApproveAsMultiCall(
          signerAddress: signer,
          maybeTimepoint: storage.when,
        );
      }
    }

    return await _submitCall(
      provider: provider,
      call: approvalCall,
      signerAddress: signer,
      signCallback: signCallback,
      tip: tip,
      eraPeriod: eraPeriod,
      nonce: nonce,
    );
  }

  /// Cancel this transaction (only depositor can cancel)
  ///
  /// Parameters:
  /// - [provider]: Chain connection
  /// - [signer]: Address of the signer (must be depositor)
  /// - [signCallback]: Callback to sign the payload
  /// - [tip]: Optional tip
  /// - [eraPeriod]: Transaction eraPeriod
  /// - [nonce]: Optional nonce
  ///
  /// Returns: Transaction hash
  ///
  /// Throws: [StateError] if signer is not the depositor
  ///
  /// Example:
  /// ```dart
  /// final txHash = await tx.cancel(
  ///   provider: provider,
  ///   signer: alice.address,
  ///   signCallback: (payload) => alice.sign(payload),
  /// );
  /// ```
  Future<Uint8List> cancel({
    required final Provider provider,
    required final String signer,
    required final SigningCallback signCallback,
    final BigInt? tip,
    final int eraPeriod = 64,
    final int? nonce,
  }) async {
    final storage = await MultisigStorage.fetch(
      provider: provider,
      multisigPubkey: signatories.multisigPubkey,
      callHash: callHash,
      registry: chainInfo.registry,
    );

    if (storage == null) {
      throw StateError('No pending transaction to cancel');
    }

    if (!storage.isDepositor(signer)) {
      throw StateError('Only the depositor (${storage.depositor}) can cancel');
    }

    final cancelCall = _createCancelAsMultiCall(
      signerAddress: signer,
      timepoint: storage.when,
    );

    return await _submitCall(
      provider: provider,
      call: cancelCall,
      signerAddress: signer,
      signCallback: signCallback,
      tip: tip,
      eraPeriod: eraPeriod,
      nonce: nonce,
    );
  }

  /// Check the current status of this transaction
  ///
  /// Returns null if no transaction exists on chain yet.
  ///
  /// Example:
  /// ```dart
  /// final status = await tx.getStatus(provider);
  /// if (status != null) {
  ///   print('Approvals: ${status.approvals.length}/${signatories.threshold}');
  /// }
  /// ```
  Future<MultisigStorage?> getStatus(Provider provider) async {
    return await MultisigStorage.fetch(
      provider: provider,
      multisigPubkey: signatories.multisigPubkey,
      callHash: callHash,
      registry: chainInfo.registry,
    );
  }

  /// Convert to JSON for sharing with other signatories
  ///
  /// Example:
  /// ```dart
  /// final json = tx.toJson();
  /// // Send to other signatories via any channel
  /// ```
  Map<String, dynamic> toJson() => {
        'signatories': signatories.toJson(),
        'callData': encodeHex(callData),
        'callHash': encodeHex(callHash),
        'timepoint': timepoint?.toJson(),
      };

  /// Reconstruct transaction from JSON
  ///
  /// Example:
  /// ```dart
  /// final tx = MultisigTransaction.fromJson(json, chainInfo);
  /// await tx.approve(...);
  /// ```
  factory MultisigTransaction.fromJson({
    required final ChainInfo chainInfo,
    required final Map<String, dynamic> json,
  }) {
    final tx = MultisigTransaction(
      signatories: Signatories.fromJson(json['signatories']),
      callData: decodeHex(json['callData']),
      chainInfo: chainInfo,
    );

    if (json['timepoint'] != null) {
      tx.timepoint = TimePoint.fromJson(json['timepoint']);
    }

    return tx;
  }

  /// Create approveAsMulti call
  RuntimeCall _createApproveAsMultiCall({
    required final String signerAddress,
    required final TimePoint? maybeTimepoint,
  }) {
    final otherSignatories = signatories.otherSignatoriesFor(signerAddress);

    final indices = CallIndicesLookup(chainInfo)
        .getPalletAndCallIndex(palletName: 'Multisig', callName: 'approve_as_multi');

    return RuntimeCall(
      palletName: 'Multisig',
      palletIndex: indices.palletIndex,
      callName: 'approve_as_multi',
      callIndex: indices.callIndex,
      args: {
        'threshold': signatories.threshold,
        'other_signatories': otherSignatories,
        'maybe_timepoint': maybeTimepoint?.toJson(),
        'call_hash': callHash,
        'max_weight': maxWeight.toJson(),
      },
    );
  }

  /// Create asMulti call (executes the transaction)
  RuntimeCall _createAsMultiCall({
    required final String signerAddress,
    required final TimePoint timepoint,
  }) {
    final otherSignatories = signatories.otherSignatoriesFor(signerAddress);

    final decodedCall = chainInfo.callsCodec.decode(Input.fromBytes(callData));

    final indices = CallIndicesLookup(chainInfo)
        .getPalletAndCallIndex(palletName: 'Multisig', callName: 'as_multi');

    return RuntimeCall(
      palletName: 'Multisig',
      palletIndex: indices.palletIndex,
      callName: 'as_multi',
      callIndex: indices.callIndex,
      args: {
        'threshold': signatories.threshold,
        'other_signatories': otherSignatories,
        'maybe_timepoint': timepoint.toJson(),
        'call': decodedCall,
        'max_weight': maxWeight.toJson(),
      },
    );
  }

  /// Create cancelAsMulti call
  RuntimeCall _createCancelAsMultiCall({
    required final String signerAddress,
    required final TimePoint timepoint,
  }) {
    final otherSignatories = signatories.otherSignatoriesFor(signerAddress);

    final indices = CallIndicesLookup(chainInfo)
        .getPalletAndCallIndex(palletName: 'Multisig', callName: 'cancel_as_multi');

    return RuntimeCall(
      palletName: 'Multisig',
      palletIndex: indices.palletIndex,
      callName: 'cancel_as_multi',
      callIndex: indices.callIndex,
      args: {
        'threshold': signatories.threshold,
        'other_signatories': otherSignatories,
        'timepoint': timepoint.toJson(),
        'call_hash': callHash,
      },
    );
  }

  /// Submit a call to the chain
  Future<Uint8List> _submitCall({
    required final Provider provider,
    required final RuntimeCall call,
    required final String signerAddress,
    required final SigningCallback signCallback,
    required final int? nonce,
    final int eraPeriod = 64,
    final BigInt? tip,
  }) async {
    final output = ByteOutput();
    chainInfo.callsCodec.encodeTo(call, output);
    final callData = output.toBytes();

    final signerPubkey = Address.decode(signerAddress).pubkey;
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

    return await extrinsic.signBuildAndSubmit(
      signerPublicKey: signerPubkey,
      signingCallback: signCallback,
      provider: provider,
      signerAddress: signerAddress,
    );
  }
}
 */
