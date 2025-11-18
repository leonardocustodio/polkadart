part of multisig;

class Multisig {
  const Multisig._();

  static Future<void> createAndFundMultisig({
    required final Provider provider,
    required final ChainInfo chainInfo,
    required final MultisigAccount multisigAccount,
    required final String depositorAddress,
    required final BigInt fundingAmount,
    required final SigningCallback depositorSigningCallback,
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

    final _ = await extrinsicBuilder.signBuildAndSubmit(
      signingCallback: depositorSigningCallback,
      provider: provider,
      signerAddress: depositorAddress,
    );
  }

  static Future<MultisigResponse> initiateTransfer({
    required final Provider provider,
    required final ChainInfo chainInfo,
    required final MultisigAccount multisigAccount,
    required final String senderAddress,
    required final SigningCallback senderSigningCallback,
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

    await approveAsMulti(
      provider: provider,
      chainInfo: chainInfo,
      multisigAccount: multisigAccount,
      approverAddress: senderAddress,
      approverSigningCallback: senderSigningCallback,
      callData: callData,
      eraPeriod: eraPeriod,
      tip: tip,
      nonce: nonce,
      maxWeight: maxWeight,
    );

    return MultisigResponse(multisigAccount: multisigAccount, callData: callData);
  }

  static Future<void> approveAsMulti({
    required final Provider provider,
    required final ChainInfo chainInfo,
    required final MultisigAccount multisigAccount,
    required final String approverAddress,
    required final SigningCallback approverSigningCallback,
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
      registry: chainInfo.registry,
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
      chainInfo: chainInfo,
      multisigAccount: multisigAccount,
      signerAddress: approverAddress,
      maybeTimepoint: storage?.when,
      callHash: callHash,
      maxWeight: maxWeight,
    );

    await _submitCall(
      provider: provider,
      chainInfo: chainInfo,
      call: approvalCall,
      signerAddress: approverAddress,
      signCallback: approverSigningCallback,
      nonce: nonce,
      tip: tip,
      eraPeriod: eraPeriod,
    );
  }

  static Future<void> asMulti({
    required final Provider provider,
    required final ChainInfo chainInfo,
    required final MultisigAccount multisigAccount,
    required final String approverAddress,
    required final SigningCallback approverSigningCallback,
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

    final storage = await MultisigStorage.fetch(
      provider: provider,
      multisigPubkey: multisigAccount.multisigPubkey,
      callHash: callHash,
      registry: chainInfo.registry,
    );

    if (storage == null) {
      throw StateError(
        'Multisig Storage is null, indicating that the first-approval is not yet done',
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
          'Transaction is already complete with ${storage.approvals.length} approvals',
        );
      }
    }
    // This will be the final approval - use asMulti to execute
    // Creating final approval to execute transaction
    final RuntimeCall approvalCall = _createAsMultiRuntimeCall(
      chainInfo: chainInfo,
      multisigAccount: multisigAccount,
      signerAddress: approverAddress,
      maybeTimepoint: storage.when,
      callData: callData,
      maxWeight: maxWeight,
    );

    await _submitCall(
      provider: provider,
      chainInfo: chainInfo,
      call: approvalCall,
      signerAddress: approverAddress,
      signCallback: approverSigningCallback,
      nonce: nonce,
      eraPeriod: eraPeriod,
      tip: tip,
    );
  }

  static Future<Uint8List> cancel({
    required final Provider provider,
    required final ChainInfo chainInfo,
    required final MultisigAccount multisigAccount,
    required final String signerAddress,
    required final SigningCallback signerSignerCallback,
    required final Uint8List callHash,
    final int eraPeriod = 64,
    final int? nonce,
  }) async {
    final storage = await MultisigStorage.fetch(
      provider: provider,
      multisigPubkey: multisigAccount.multisigPubkey,
      callHash: callHash,
      registry: chainInfo.registry,
    );

    if (storage == null) {
      throw StateError('No pending transaction to cancel');
    }

    if (!storage.isDepositor(signerAddress)) {
      throw StateError('Only the depositor (${storage.depositor}) can cancel');
    }

    final cancelCall = _createCancelAsMultiRuntimeCall(
      chainInfo: chainInfo,
      multisigAccount: multisigAccount,
      signerAddress: signerAddress,
      maybeTimepoint: storage.when,
      callHash: callHash,
    );

    return await _submitCall(
      provider: provider,
      chainInfo: chainInfo,
      call: cancelCall,
      signerAddress: signerAddress,
      signCallback: signerSignerCallback,
      eraPeriod: eraPeriod,
      nonce: nonce,
    );
  }

  /// Create cancelAsMulti call
  static RuntimeCall _createCancelAsMultiRuntimeCall({
    required final MultisigAccount multisigAccount,
    required final ChainInfo chainInfo,
    required final String signerAddress,
    required final TimePoint maybeTimepoint,
    required final Uint8List callHash,
  }) {
    return _createRuntimeCall(
      palletName: 'Multisig',
      callName: 'cancel_as_multi',
      multisigAccount: multisigAccount,
      chainInfo: chainInfo,
      signerAddress: signerAddress,
      maybeTimepoint: maybeTimepoint,
    );
  }

  /// Create approveAsMulti call
  static RuntimeCall _createApproveAsMultiRuntimeCall({
    required final MultisigAccount multisigAccount,
    required final ChainInfo chainInfo,
    required final String signerAddress,
    required final Weight maxWeight,
    required final Uint8List callHash,
    final TimePoint? maybeTimepoint,
  }) {
    return _createRuntimeCall(
      palletName: 'Multisig',
      callName: 'approve_as_multi',
      multisigAccount: multisigAccount,
      chainInfo: chainInfo,
      signerAddress: signerAddress,
      maybeTimepoint: maybeTimepoint,
      extras: {'call_hash': callHash, 'max_weight': maxWeight.toJson()},
    );
  }

  /// Create asMulti call
  static RuntimeCall _createAsMultiRuntimeCall({
    required final MultisigAccount multisigAccount,
    required final ChainInfo chainInfo,
    required final String signerAddress,
    required final Uint8List callData,
    required final TimePoint maybeTimepoint,
    required final Weight maxWeight,
  }) {
    final decodedCall = chainInfo.callsCodec.decode(Input.fromBytes(callData));

    return _createRuntimeCall(
      palletName: 'Multisig',
      callName: 'as_multi',
      multisigAccount: multisigAccount,
      chainInfo: chainInfo,
      signerAddress: signerAddress,
      maybeTimepoint: maybeTimepoint,
      extras: {'call': decodedCall, 'max_weight': maxWeight.toJson()},
    );
  }

  static RuntimeCall _createRuntimeCall({
    required final String palletName,
    required final String callName,
    required final MultisigAccount multisigAccount,
    required final ChainInfo chainInfo,
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

  /// Submit a call to the chain
  static Future<Uint8List> _submitCall({
    required final Provider provider,
    required final ChainInfo chainInfo,
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

    return await extrinsic.signBuildAndSubmit(
      signingCallback: signCallback,
      provider: provider,
      signerAddress: signerAddress,
    );
  }
}
