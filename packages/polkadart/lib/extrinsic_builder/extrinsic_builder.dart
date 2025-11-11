part of extrinsic_builder;

// Type for signing callback
typedef SigningCallback = Future<Uint8List> Function(Uint8List payload);

class ExtrinsicBuilder {
  final ChainInfo chainInfo;
  final Uint8List callData;
  final Uint8List _blockHash;
  final int _blockNumber;
  final int _eraPeriod;
  final BigInt _tip;

  // Extension builder for all config
  final ExtensionBuilder _extensionBuilder;

  // Track if nonce was set
  bool _nonceSet = false;

  ExtrinsicBuilder({
    required this.chainInfo,
    required this.callData,
    required final int specVersion,
    required final int transactionVersion,
    required final Uint8List genesisHash,
    required final Uint8List blockHash,
    required final int blockNumber,
    int eraPeriod = 64,
    BigInt? tip,
    int? nonce,
  })  : _blockHash = blockHash,
        _blockNumber = blockNumber,
        _eraPeriod = eraPeriod,
        _tip = tip ?? BigInt.zero,
        _extensionBuilder = ExtensionBuilder(chainInfo) {
    // Initialize with provided values
    _extensionBuilder.setStandardExtensions(
      specVersion: specVersion,
      transactionVersion: transactionVersion,
      genesisHash: genesisHash,
      blockHash: blockHash,
      blockNumber: blockNumber,
      nonce: nonce ?? 0, // Will be fetched later if needed
      eraPeriod: _eraPeriod, // Default mortal
      tip: _tip,
    );
    _nonceSet = nonce != null;
  }

  // From ChainData helper
  factory ExtrinsicBuilder.fromChainData({
    required final ChainInfo chainInfo,
    required final Uint8List callData,
    required final ChainData chainData,
    int eraPeriod = 64,
    BigInt? tip,
  }) {
    return ExtrinsicBuilder(
      chainInfo: chainInfo,
      callData: callData,
      specVersion: chainData.specVersion!,
      transactionVersion: chainData.transactionVersion!,
      genesisHash: chainData.genesisHash!,
      blockHash: chainData.blockHash!,
      blockNumber: chainData.blockNumber!,
      eraPeriod: eraPeriod,
      nonce: chainData.nonce,
      tip: tip,
    );
  }

  ExtrinsicBuilder nonce(final int nonce) {
    _extensionBuilder.nonce(nonce);
    _nonceSet = true;
    return this;
  }

  ExtrinsicBuilder tip(final BigInt tip) {
    _extensionBuilder.tip(tip);
    return this;
  }

  ExtrinsicBuilder era({required final int period, final Uint8List? blockHash}) {
    _extensionBuilder.era(
      period: period,
      blockHash: blockHash ?? _blockHash,
      blockNumber: _blockNumber,
    );
    return this;
  }

  ExtrinsicBuilder immortal() {
    _extensionBuilder.immortal();
    return this;
  }

  ExtrinsicBuilder specVersion(final int version) {
    _extensionBuilder.specVersion(version);
    return this;
  }

  ExtrinsicBuilder transactionVersion(final int version) {
    _extensionBuilder.transactionVersion(version);
    return this;
  }

  ExtrinsicBuilder blockHash(final Uint8List hash) {
    _extensionBuilder.blockHash(hash);
    return this;
  }

  ExtrinsicBuilder assetId(final dynamic assetId) {
    _extensionBuilder.assetId(assetId);
    return this;
  }

  ExtrinsicBuilder metadataHash({bool enabled = true, final Uint8List? hash}) {
    _extensionBuilder.metadataHash(enabled: enabled, hash: hash);
    return this;
  }

  ExtrinsicBuilder customExtension(final String identifier, final dynamic value,
      {final dynamic additional}) {
    _extensionBuilder.customExtension(identifier, value, additional: additional);
    return this;
  }

  /// Sign and build with a callback (for external signing)
  Future<EncodedExtrinsic> signAndBuild({
    required final Uint8List signerPublicKey,
    required final SigningCallback signingCallback,
    final Provider? provider,
    final String? signerAddress,
  }) async {
    // Fetch nonce if needed
    await _fetchNonceIfNeeded(
      provider: provider,
      address: signerAddress,
    );

    // Create signing builder
    final signingBuilder = SigningBuilder(
      chainInfo: chainInfo,
      extensionBuilder: _extensionBuilder,
    );

    // Get the payload to sign
    final payloadToSign = signingBuilder.createPayloadToSign(callData);

    // Call the external signing callback
    final signature = await signingCallback(payloadToSign);

    // Create signed data manually
    final signedData = SignedData(
      signer: signerPublicKey,
      signature: signature,
      extensions: Map<String, dynamic>.from(_extensionBuilder.extensions),
      additionalSigned: Map<String, dynamic>.from(_extensionBuilder.additionalSigned),
      callData: callData,
      signingPayload: payloadToSign,
    );

    // Encode the extrinsic
    return EncodedExtrinsic.fromSignedData(chainInfo, signedData);
  }

  /// Sign, build and submit with callback
  Future<String> signBuildAndSubmit({
    required final Uint8List signerPublicKey,
    required final SigningCallback signingCallback,
    required final Provider provider,
    final String? signerAddress,
  }) async {
    final extrinsic = await signAndBuild(
      signerPublicKey: signerPublicKey,
      signingCallback: signingCallback,
      provider: provider,
      signerAddress: signerAddress,
    );
    return extrinsic.submit(provider);
  }

  /// Sign, build and submit with callback
  Future<StreamSubscription<ExtrinsicStatus>> signBuildAndSubmitWatch({
    required final Uint8List signerPublicKey,
    required final SigningCallback signingCallback,
    required final Provider provider,
    required final ExtrinsicListener onStatusChange,
    final String? signerAddress,
  }) async {
    final extrinsic = await signAndBuild(
      signerPublicKey: signerPublicKey,
      signingCallback: signingCallback,
      provider: provider,
      signerAddress: signerAddress,
    );

    return await extrinsic.submitAndWatch(provider, onStatusChange);
  }

  /// Get the payload that would be signed (useful for debugging or external signing)
  Uint8List getSigningPayload() {
    final signingBuilder = SigningBuilder(
      chainInfo: chainInfo,
      extensionBuilder: _extensionBuilder,
    );
    return signingBuilder.createPayloadToSign(callData);
  }

  /// Quick send with external signing
  static Future<String> quickSend({
    required final Provider provider,
    required final ChainInfo chainInfo,
    required final Uint8List callData,
    required final Uint8List signerPublicKey,
    required final SigningCallback signingCallback,
    final String? signerAddress,
    final int? eraPeriod,
    final BigInt? tip,
    bool immortal = false,
  }) async {
    // An Immortal transaction so expect eraPeriod to be null.
    assert(immortal && eraPeriod == null,
        'For immortal transactions, eraPeriod must be null and immortal must be true.');

    // Not an Immortal transaction so expect eraPeriod to non-null.
    assert(immortal == false && eraPeriod != null,
        'For mortal transactions, eraPeriod must not be null and immortal must be false.');
    // Fetch chain data
    final fetcher = ChainDataFetcher(provider);
    final chainData = await fetcher.fetchStandardData(
      accountAddress: signerAddress,
    );

    // Build and submit
    ExtrinsicBuilder builder = ExtrinsicBuilder.fromChainData(
      chainInfo: chainInfo,
      callData: callData,
      chainData: chainData,
    );

    if (tip != null) builder = builder.tip(tip);
    if (immortal) builder = builder.immortal();

    return builder.signBuildAndSubmit(
      signerPublicKey: signerPublicKey,
      signingCallback: signingCallback,
      provider: provider,
      signerAddress: signerAddress,
    );
  }

  // ===== Private Helpers =====

  Future<void> _fetchNonceIfNeeded({
    final Provider? provider,
    final String? address,
  }) async {
    if (_nonceSet) return;
    if (provider == null || address == null) {
      throw Exception(
          'Cannot fetch nonce: Both the provider & address is needed to fetch nonce for the sender or please set nonce manually.');
    }

    final fetcher = SystemApi(provider);
    final nonce = await fetcher.accountNextIndex(address);
    _extensionBuilder.nonce(nonce);
    _nonceSet = true;
  }
}
