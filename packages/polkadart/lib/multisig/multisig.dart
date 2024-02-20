part of multisig;

class Multisig {
  ///
  /// This creates the multisig account on the chain and funds it.
  static Future<MultisigResponse> createAndFundMultisig({
    required KeyPair depositorKeyPair,
    required int threshold,
    required String recipientAddress,
    required BigInt amount,
    required Provider provider,
    required List<String> otherSignatoriesAddressList,
    int tip = 0,
    int assetId = 0,
    int eraPeriod = 64,
  }) async {
    final meta = await MultiSigMeta.fromProvider(provider: provider);

    /// Make Signatories
    final Signatories signatories = Signatories.fromAddresses(
        [depositorKeyPair.address, ...otherSignatoriesAddressList], threshold);
    final Uint8List mutisigBytes = signatories.mutiSigBytes;

    //
    // Create and Fund the Multisig Account
    {
      await _createAndSubmitPayload(
        meta: meta,
        method: Transfers.transferKeepAlive.encode(
          meta.runtimeMetadata.chainInfo,
          mutisigBytes,
          amount,
        ),
        tip: tip,
        assetId: assetId,
        eraPeriod: eraPeriod,
        signer: depositorKeyPair,
        provider: provider,
      );
    }

    // Making the callData
    final Uint8List callData = Transfers.transferKeepAlive.encode(
      meta.runtimeMetadata.chainInfo,
      Address.decode(recipientAddress).pubkey,
      amount,
    );

    return MultisigResponse(
      callData: callData.toHex(),
      callHash: Hasher.blake2b256.hash(callData).toHex(),
      threshold: threshold,
      allSignatories: signatories.sortedSignatoriesAddresses,
    );
  }

  ///
  /// Fetches the multisig storage from the chain.
  ///
  /// This will return null if first approval of type`ApproveAsMulti` is not yet done.
  static Future<MultisigStorage?> fetchMultisigStorage(
      Provider provider,
      Duration storageKeyDelay,
      Uint8List callHash,
      Uint8List multisigBytes) async {
    //
    // Multisig Storage creation
    MultisigStorage? decoded;
    {
      final Uint8List multisigStorageKey =
          MultisigStorage.createMultisigStorageKey(multisigBytes, callHash);

      //
      // Wait for sometime and let the storage be created on the chain.
      await Future.delayed(storageKeyDelay);

      //
      // Fetch the storage from the chain.
      final Uint8List? multisigStorage =
          await fetchStorage(provider, multisigStorageKey);

      if (multisigStorage != null) {
        decoded =
            MultisigStorage.decodeFrom(ByteInput.fromBytes(multisigStorage));
      }
    }
    return decoded;
  }

  static Future<Uint8List> _createAndSubmitPayload({
    required MultiSigMeta meta,
    required Uint8List method,
    required KeyPair signer,
    required Provider provider,
    required int tip,
    required int assetId,
    required int eraPeriod,
  }) async {
    final nonce = await SystemApi(provider).accountNextIndex(signer.address);

    ///
    /// Creating the first approveAsMulti from the account creator.
    final unsignedApprovalPayload = SigningPayload(
      method: method,
      assetId: assetId,
      blockHash: hex.encode(meta.blockHash),
      blockNumber: meta.blockNumber,
      eraPeriod: eraPeriod,
      genesisHash: hex.encode(meta.genesisHash),
      nonce: nonce,
      specVersion: meta.specVersion,
      tip: tip,
      transactionVersion: meta.transactionVersion,
    );

    final Uint8List signingPayload = unsignedApprovalPayload
        .encode(meta.runtimeMetadata.chainInfo.scaleCodec.registry);

    final Uint8List signature = sign(signer, signingPayload);

    final ExtrinsicPayload extrinsicPayload = ExtrinsicPayload.fromPayload(
        unsignedApprovalPayload,
        Address.decode(signer.address).pubkey,
        signature);

    final Uint8List signedTx = extrinsicPayload.encode(
      meta.runtimeMetadata.chainInfo.scaleCodec.registry,
      signer.signatureType,
    );

    final expectedTxHash = Hasher.blake2b256.hash(signedTx);
    final actualHash = await submitExtrinsic(provider, signedTx);

    final isMatched = hex.encode(expectedTxHash) == hex.encode(actualHash);
    assertion(isMatched,
        'The expected hash and the actual hash of the approval transaction does not match.');
    return actualHash;
  }

  ///
  /// CancelAsMulti (Only the owner can cancel the multisig call.)
  ///
  /// It cancels the multisig transaction.
  static Future<bool> cancelAsMulti({
    required MultisigResponse multisigResponse,
    required Provider provider,
    required KeyPair signer,
    Duration storageKeyDelay = const Duration(seconds: 20),
    int tip = 0,
    int assetId = 0,
    int eraPeriod = 64,
  }) async {
    final MultisigStorage? multisigStorage = await fetchMultisigStorage(
        provider,
        storageKeyDelay,
        multisigResponse.callHash.hexToUint8List(),
        multisigResponse.multisigBytes);

    assertion(multisigStorage != null,
        'The multisig storage does not exist on the chain.');

    if (multisigStorage!
        .isApprovedByAll(multisigResponse.allSignatories.length)) {
      return false;
    }

    if (multisigStorage.isOwner(signer.publicKey.bytes.toUint8List()) ==
        false) {
      throw OwnerCallException('Only the owner can cancel the multisig call.');
    }

    final meta = await MultiSigMeta.fromProvider(provider: provider);
    final signatories = Signatories.fromAddresses(
        multisigResponse.allSignatories, multisigResponse.threshold);

    await _createAndSubmitPayload(
      meta: meta,
      method: cancelAsMultiMethod(
        chainInfo: meta.runtimeMetadata.chainInfo,
        otherSignatories:
            signatories.signatoriesExcludeBytes(signer.publicKey.bytes),
        threshold: multisigResponse.threshold,
        callHash: Uint8List.fromList(hex.decode(multisigResponse.callHash)),
        multiSigStorage: multisigStorage,
      ),
      tip: tip,
      assetId: assetId,
      eraPeriod: eraPeriod,
      signer: signer,
      provider: provider,
    );
    return true;
  }

  ///
  /// ApproveAsMulti
  ///
  /// It approves the multisig transaction and sends for further approval to other signatories.
  static Future<bool> approveAsMulti({
    required MultisigResponse multisigResponse,
    required Provider provider,
    required KeyPair signer,
    Duration storageKeyDelay = const Duration(seconds: 20),
    int tip = 0,
    int assetId = 0,
    int eraPeriod = 64,
  }) async {
    final MultisigStorage? multisigStorage = await fetchMultisigStorage(
        provider,
        storageKeyDelay,
        multisigResponse.callHash.hexToUint8List(),
        multisigResponse.multisigBytes);

    if (multisigStorage != null) {
      if (multisigStorage
          .isApprovedByAll(multisigResponse.allSignatories.length)) {
        return true;
      }

      if (multisigStorage
          .isAlreadyApprovedBy(signer.publicKey.bytes.toUint8List())) {
        return true;
      }

      // Cannot do approveAsMulti if only one approval is left.
      // The last approval should be done with asMulti.
      if (multisigStorage
          .isOnlyOneApprovalLeft(multisigResponse.allSignatories.length)) {
        throw FinalApprovalException(
            'The final approval call should be done with method `asMulti(...)` to execute the transaction.');
      }
    }

    final meta = await MultiSigMeta.fromProvider(provider: provider);
    final signatories = Signatories.fromAddresses(
        multisigResponse.allSignatories, multisigResponse.threshold);

    await _createAndSubmitPayload(
      meta: meta,
      method: approveAsMultiMethod(
        chainInfo: meta.runtimeMetadata.chainInfo,
        otherSignatories:
            signatories.signatoriesExcludeBytes(signer.publicKey.bytes),
        threshold: multisigResponse.threshold,
        callHash: Uint8List.fromList(hex.decode(multisigResponse.callHash)),
        maxWeight: Weight(
          refTime: BigInt.from(640000000),
          proofSize: BigInt.from(0),
        ),
        multiSigStorage: multisigStorage,
      ),
      tip: tip,
      assetId: assetId,
      eraPeriod: eraPeriod,
      signer: signer,
      provider: provider,
    );
    return true;
  }

  ///
  /// AsMulti
  ///
  /// It approves the multisig transaction and sends for further approval to other signatories.
  static Future<bool> asMulti({
    required MultisigResponse multisigResponse,
    required Provider provider,
    required KeyPair signer,
    Duration storageKeyDelay = const Duration(seconds: 25),
    int tip = 0,
    int assetId = 0,
    int eraPeriod = 64,
  }) async {
    final MultisigStorage? multisigStorage = await fetchMultisigStorage(
        provider,
        storageKeyDelay,
        multisigResponse.callHash.hexToUint8List(),
        multisigResponse.multisigBytes);

    assertion(multisigStorage != null,
        'The multisig storage does not exist on the chain. At least one approval with `approveAsMulti` should be done by signatory before calling `asMulti`.');

    if (multisigStorage!
        .isApprovedByAll(multisigResponse.allSignatories.length)) {
      return true;
    }

    if (multisigStorage
        .isAlreadyApprovedBy(signer.publicKey.bytes.toUint8List())) {
      return true;
    }

    final meta = await MultiSigMeta.fromProvider(provider: provider);
    final signatories = Signatories.fromAddresses(
        multisigResponse.allSignatories, multisigResponse.threshold);

    await _createAndSubmitPayload(
      meta: meta,
      method: asMultiMethod(
        chainInfo: meta.runtimeMetadata.chainInfo,
        otherSignatories:
            signatories.signatoriesExcludeBytes(signer.publicKey.bytes),
        threshold: multisigResponse.threshold,
        callData: Uint8List.fromList(hex.decode(multisigResponse.callData)),
        maxWeight: Weight(
          refTime: BigInt.from(160771000),
          proofSize: BigInt.from(3593),
        ),
        multiSigStorage: multisigStorage,
      ),
      signer: signer,
      tip: tip,
      assetId: assetId,
      eraPeriod: eraPeriod,
      provider: provider,
    );
    return true;
  }

  ///
  /// Creates the approval method call for the multisig transaction.
  ///
  /// Note: [It does not submit the transaction to the chain.]
  static Uint8List cancelAsMultiMethod(
      {required ChainInfo chainInfo,
      required List<Uint8List> otherSignatories,
      required int threshold,
      required Uint8List callHash,
      required MultisigStorage? multiSigStorage}) {
    final cancelArgument = MapEntry(
      'Multisig',
      MapEntry(
        'cancel_as_multi',
        {
          'threshold': threshold,
          'other_signatories': otherSignatories,
          'timepoint': multiSigStorage!.timePoint.toMap(),
          'call_hash': callHash,
        },
      ),
    );
    final ByteOutput output = ByteOutput();

    chainInfo.scaleCodec.registry.codecs['Call']!
        .encodeTo(cancelArgument, output);
    return output.toBytes();
  }

  ///
  /// Creates the approval method call for the multisig transaction.
  ///
  /// Note: [It does not submit the transaction to the chain.]
  static Uint8List approveAsMultiMethod(
      {required ChainInfo chainInfo,
      required List<Uint8List> otherSignatories,
      required int threshold,
      required Uint8List callHash,
      required Weight maxWeight,
      required MultisigStorage? multiSigStorage}) {
    final approvalArgument = MapEntry(
      'Multisig',
      MapEntry(
        'approve_as_multi',
        {
          'threshold': threshold,
          'other_signatories': otherSignatories,
          'maybe_timepoint': multiSigStorage?.timePoint != null
              ? Option<Map<String, dynamic>>.some(
                  multiSigStorage!.timePoint.toMap())
              : Option<Map<String, dynamic>>.none(),
          'call_hash': callHash,
          'max_weight': maxWeight.toMap(),
        },
      ),
    );
    final ByteOutput output = ByteOutput();

    chainInfo.scaleCodec.registry.codecs['Call']!
        .encodeTo(approvalArgument, output);
    return output.toBytes();
  }

  ///
  /// Creates the `asMulti` approval method call for the multisig transaction.
  static Uint8List asMultiMethod(
      {required ChainInfo chainInfo,
      required List<Uint8List> otherSignatories,
      required int threshold,
      required Uint8List callData,
      required Weight maxWeight,
      required MultisigStorage multiSigStorage}) {
    final decodedCall = chainInfo.scaleCodec.registry.codecs['Call']!
        .decode(ByteInput.fromBytes(callData));
    final approvalArgument = MapEntry(
      'Multisig',
      MapEntry(
        'as_multi',
        {
          'threshold': threshold,
          'other_signatories': otherSignatories,
          'maybe_timepoint': Option<Map<String, dynamic>>.some(
              multiSigStorage.timePoint.toMap()),
          'call': decodedCall,
          'max_weight': maxWeight.toMap(),
        },
      ),
    );
    final ByteOutput output = ByteOutput();

    chainInfo.scaleCodec.registry.codecs['Call']!
        .encodeTo(approvalArgument, output);
    return output.toBytes();
  }

  ///
  /// Signs the payload with the keypair.
  ///
  /// If the payload is greater than 256 bytes, it will be hashed with blake2b256 before signing.
  static Uint8List sign(KeyPair keyPair, Uint8List payload) {
    if (payload.length > 256) {
      payload = Hasher.blake2b256.hash(payload);
    }
    return keyPair.sign(payload);
  }

  ///
  /// Submits the extrinsic to the chain and returns the hash of the transaction.
  ///
  static Future<Uint8List> submitExtrinsic(
      Provider provider, Uint8List extrinsic) async {
    return await AuthorApi(provider).submitExtrinsic(extrinsic);
  }

  ///
  /// Returns the multisig storage from the chain.
  ///
  /// If the storage does not exist, it will return null.
  static Future<Uint8List?> fetchStorage(
      Provider provider, Uint8List storageKey) async {
    return await StateApi(provider).getStorage(storageKey);
  }
}
