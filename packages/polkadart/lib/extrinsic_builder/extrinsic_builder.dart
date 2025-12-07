part of extrinsic_builder;

/// Callback function type for signing transaction payloads.
///
/// This function receives the payload to be signed and must return the signature.
///
/// Parameters:
/// - [payload]: The SCALE-encoded signing payload (typically 32 bytes after hashing)
///
/// Returns:
/// A [Uint8List] containing the signature (typically 64 bytes for Sr25519/Ed25519)
typedef SigningCallback = Uint8List Function(Uint8List payload);

/// Main builder class for constructing and submitting blockchain extrinsics.
///
/// This class provides a fluent interface for building extrinsics with proper
/// signed extensions, creating signing payloads, and submitting transactions to
/// the blockchain. It handles:
///
/// - Automatic nonce fetching when not provided
/// - Era configuration (mortal vs immortal transactions)
/// - Tip management for transaction prioritization
/// - Integration with external signing callbacks
/// - Transaction submission with optional status watching
///
/// ## Example Usage:
///
/// ```dart
/// // Create from chain data
/// final builder = ExtrinsicBuilder.fromChainData(
///   chainInfo: chainInfo,
///   callData: encodedCall,
///   chainData: chainData,
///   eraPeriod: 64,
/// );
///
/// // Configure and submit
/// final txHash = await builder
///   .tip(BigInt.from(1000))
///   .signBuildAndSubmit(
///     provider: provider,
///     signerAddress: alice.address,
///     signingCallback: alice.sign,
///   );
/// ```
class ExtrinsicBuilder {
  /// Chain metadata and configuration information.
  final ChainInfo chainInfo;

  /// The SCALE-encoded call data to execute.
  final Uint8List callData;

  /// The block hash at which this extrinsic is valid.
  final Uint8List _blockHash;

  /// The block number at which this extrinsic is valid.
  final int _blockNumber;

  /// The era period in blocks (0 for immortal).
  final int _eraPeriod;

  /// The tip amount for transaction prioritization.
  final BigInt _tip;

  /// Internal extension builder managing all signed extensions.
  final ExtensionBuilder _extensionBuilder;

  /// Tracks whether the nonce has been explicitly set or fetched.
  bool _nonceSet = false;

  /// Creates a new ExtrinsicBuilder with all required chain parameters.
  ///
  /// This constructor requires all chain data to be provided upfront. For a more
  /// convenient API that automatically fetches data, use [ExtrinsicBuilder.fromChainData].
  ///
  /// Parameters:
  /// - [chainInfo]: Chain metadata and configuration
  /// - [callData]: SCALE-encoded call to execute
  /// - [specVersion]: Runtime specification version
  /// - [transactionVersion]: Transaction version from runtime
  /// - [genesisHash]: Genesis block hash (32 bytes)
  /// - [blockHash]: Current block hash for era calculation (32 bytes)
  /// - [blockNumber]: Current block number for era calculation
  /// - [eraPeriod]: Era period in blocks (default: 64, 0 for immortal)
  /// - [tip]: Optional tip for transaction prioritization
  /// - [nonce]: Optional nonce (will be fetched if not provided)
  ///
  /// Example:
  /// ```dart
  /// final builder = ExtrinsicBuilder(
  ///   chainInfo: chainInfo,
  ///   callData: callData,
  ///   specVersion: 1000,
  ///   transactionVersion: 1,
  ///   genesisHash: genesisHash,
  ///   blockHash: currentBlockHash,
  ///   blockNumber: currentBlockNumber,
  ///   eraPeriod: 64,
  /// );
  /// ```
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
  }) : _blockHash = blockHash,
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

  /// Creates an ExtrinsicBuilder from fetched chain data.
  ///
  /// This is the recommended way to create an ExtrinsicBuilder as it automatically
  /// extracts all required parameters from a ChainData object obtained from
  /// [ChainDataFetcher.fetchStandardData].
  ///
  /// Parameters:
  /// - [chainInfo]: Chain metadata and configuration
  /// - [callData]: SCALE-encoded call to execute
  /// - [chainData]: Chain data object with all required blockchain state
  /// - [eraPeriod]: Era period in blocks (default: 64, 0 for immortal)
  /// - [tip]: Optional tip for transaction prioritization
  ///
  /// Returns:
  /// A [ExtrinsicBuilder] instance ready for signing and submission.
  ///
  /// Example:
  /// ```dart
  /// final chainData = await ChainDataFetcher(provider).fetchStandardData(
  ///   accountAddress: alice.address,
  /// );
  ///
  /// final builder = ExtrinsicBuilder.fromChainData(
  ///   chainInfo: chainInfo,
  ///   callData: callData,
  ///   chainData: chainData,
  ///   eraPeriod: 64,
  ///   tip: BigInt.from(1000),
  /// );
  /// ```
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
      specVersion: chainData.specVersion,
      transactionVersion: chainData.transactionVersion,
      genesisHash: chainData.genesisHash,
      blockHash: chainData.blockHash,
      blockNumber: chainData.blockNumber,
      eraPeriod: eraPeriod,
      nonce: chainData.nonce,
      tip: tip,
    );
  }

  /// Sets the transaction nonce explicitly.
  ///
  /// If not set, the nonce will be automatically fetched from the chain when
  /// [signAndBuild] or related methods are called.
  ///
  /// Parameters:
  /// - [nonce]: The account nonce to use
  ///
  /// Returns:
  /// This builder instance for method chaining.
  ExtrinsicBuilder nonce(final int nonce) {
    _extensionBuilder.nonce(nonce);
    _nonceSet = true;
    return this;
  }

  /// Sets the transaction tip for prioritization.
  ///
  /// A higher tip incentivizes block producers to include your transaction sooner.
  ///
  /// Parameters:
  /// - [tip]: The tip amount in smallest units (e.g., planck for DOT)
  ///
  /// Returns:
  /// This builder instance for method chaining.
  ExtrinsicBuilder tip(final BigInt tip) {
    _extensionBuilder.tip(tip);
    return this;
  }

  /// Configures the transaction era (mortality period).
  ///
  /// Mortal transactions are only valid for a specific number of blocks,
  /// preventing replay attacks across forks.
  ///
  /// Parameters:
  /// - [period]: Number of blocks the transaction is valid for
  /// - [blockHash]: Optional block hash to use (defaults to construction block hash)
  ///
  /// Returns:
  /// This builder instance for method chaining.
  ExtrinsicBuilder era({required final int period, final Uint8List? blockHash}) {
    _extensionBuilder.era(
      period: period,
      blockHash: blockHash ?? _blockHash,
      blockNumber: _blockNumber,
    );
    return this;
  }

  /// Makes the transaction immortal (valid indefinitely).
  ///
  /// Immortal transactions remain valid across all future blocks and forks.
  /// Use with caution as this can enable replay attacks.
  ///
  /// Returns:
  /// This builder instance for method chaining.
  ExtrinsicBuilder immortal() {
    _extensionBuilder.immortal();
    return this;
  }

  /// Sets the runtime specification version.
  ///
  /// Parameters:
  /// - [version]: The runtime spec version
  ///
  /// Returns:
  /// This builder instance for method chaining.
  ExtrinsicBuilder specVersion(final int version) {
    _extensionBuilder.specVersion(version);
    return this;
  }

  /// Sets the transaction version.
  ///
  /// Parameters:
  /// - [version]: The transaction version
  ///
  /// Returns:
  /// This builder instance for method chaining.
  ExtrinsicBuilder transactionVersion(final int version) {
    _extensionBuilder.transactionVersion(version);
    return this;
  }

  /// Sets the block hash for era calculation.
  ///
  /// Parameters:
  /// - [hash]: The block hash (32 bytes)
  ///
  /// Returns:
  /// This builder instance for method chaining.
  ExtrinsicBuilder blockHash(final Uint8List hash) {
    _extensionBuilder.blockHash(hash);
    return this;
  }

  /// Sets the asset ID for chains that support multi-asset transaction fees.
  ///
  /// Parameters:
  /// - [assetId]: The asset ID to use for fee payment
  ///
  /// Returns:
  /// This builder instance for method chaining.
  ExtrinsicBuilder assetId(final dynamic assetId) {
    _extensionBuilder.assetId(assetId);
    return this;
  }

  /// Configures metadata hash checking.
  ///
  /// When enabled, the transaction includes a hash of the metadata it was
  /// constructed with, allowing runtime verification.
  ///
  /// Parameters:
  /// - [enabled]: Whether to enable metadata hash checking (default: true)
  /// - [hash]: The metadata hash (required if enabled)
  ///
  /// Returns:
  /// This builder instance for method chaining.
  ExtrinsicBuilder metadataHash({bool enabled = true, final Uint8List? hash}) {
    _extensionBuilder.metadataHash(enabled: enabled, hash: hash);
    return this;
  }

  /// Sets a custom signed extension value.
  ///
  /// This allows setting values for chain-specific or custom signed extensions.
  ///
  /// Parameters:
  /// - [identifier]: The extension identifier
  /// - [value]: The extension value
  /// - [additional]: Optional additional signed data
  ///
  /// Returns:
  /// This builder instance for method chaining.
  ExtrinsicBuilder customExtension(
    final String identifier,
    final dynamic value, {
    final dynamic additional,
  }) {
    _extensionBuilder.customExtension(identifier, value, additional: additional);
    return this;
  }

  /// Signs and builds the extrinsic using an external signing callback.
  ///
  /// This method:
  /// 1. Fetches the nonce from the chain if not already set
  /// 2. Creates the signing payload
  /// 3. Calls the signing callback to obtain the signature
  /// 4. Constructs and returns the fully encoded extrinsic
  ///
  /// The extrinsic can then be submitted using `extrinsic.submit(provider)` or
  /// watched using `extrinsic.submitAndWatch(provider, listener)`.
  ///
  /// Parameters:
  /// - [provider]: Blockchain connection provider
  /// - [signerAddress]: SS58-encoded address of the signer
  /// - [signingCallback]: Function that signs the payload and returns the signature
  ///
  /// Returns:
  /// An [EncodedExtrinsic] ready for submission to the blockchain.
  ///
  /// Throws:
  /// - [Exception] if nonce fetching fails when required
  /// - [Exception] if the signing callback fails
  ///
  /// Example:
  /// ```dart
  /// final extrinsic = await builder.signAndBuild(
  ///   provider: provider,
  ///   signerAddress: alice.address,
  ///   signingCallback: (payload) => alice.sign(payload),
  /// );
  ///
  /// final txHash = await extrinsic.submit(provider);
  /// ```
  Future<EncodedExtrinsic> signAndBuild({
    required final Provider provider,
    required final String signerAddress,
    required final SigningCallback signingCallback,
  }) async {
    // Fetch nonce if needed
    await _fetchNonceIfNeeded(provider: provider, address: signerAddress);

    // Create signing builder
    final signingBuilder = SigningBuilder(
      chainInfo: chainInfo,
      extensionBuilder: _extensionBuilder,
    );

    // Get the payload to sign
    final payloadToSign = signingBuilder.createPayloadToSign(callData);

    // Call the external signing callback
    final signature = signingCallback(payloadToSign);

    final signerPublicKey = Address.decode(signerAddress).pubkey;
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

  /// Signs, builds, and submits the extrinsic in one call.
  ///
  /// This is a convenience method that combines [signAndBuild] and submission.
  /// It's the most common way to execute transactions.
  ///
  /// Parameters:
  /// - [provider]: Blockchain connection provider
  /// - [signerAddress]: SS58-encoded address of the signer
  /// - [signingCallback]: Function that signs the payload and returns the signature
  ///
  /// Returns:
  /// A [Uint8List] containing the transaction hash (extrinsic hash).
  ///
  /// Throws:
  /// - [Exception] if nonce fetching fails when required
  /// - [Exception] if the signing callback fails
  /// - [Exception] if submission to the blockchain fails
  ///
  /// Example:
  /// ```dart
  /// final txHash = await builder.signBuildAndSubmit(
  ///   provider: provider,
  ///   signerAddress: alice.address,
  ///   signingCallback: (payload) => alice.sign(payload),
  /// );
  /// print('Transaction submitted with hash: ${encodeHex(txHash)}');
  /// ```
  Future<Uint8List> signBuildAndSubmit({
    required final Provider provider,
    required final String signerAddress,
    required final SigningCallback signingCallback,
  }) async {
    final extrinsic = await signAndBuild(
      provider: provider,
      signerAddress: signerAddress,
      signingCallback: signingCallback,
    );
    return extrinsic.submit(provider);
  }

  /// Signs, builds, and submits the extrinsic with status watching.
  ///
  /// This method is similar to [signBuildAndSubmit] but provides real-time status
  /// updates as the transaction progresses through validation, inclusion in a block,
  /// and finalization.
  ///
  /// Parameters:
  /// - [provider]: Blockchain connection provider
  /// - [signerAddress]: SS58-encoded address of the signer
  /// - [signingCallback]: Function that signs the payload and returns the signature
  /// - [onStatusChange]: Callback function to receive status updates
  ///
  /// Returns:
  /// A [StreamSubscription] that can be cancelled to stop receiving updates.
  ///
  /// Throws:
  /// - [Exception] if nonce fetching fails when required
  /// - [Exception] if the signing callback fails
  /// - [Exception] if submission to the blockchain fails
  ///
  /// Example:
  /// ```dart
  /// final subscription = await builder.signBuildAndSubmitWatch(
  ///   provider: provider,
  ///   signerAddress: alice.address,
  ///   signingCallback: (payload) => alice.sign(payload),
  ///   onStatusChange: (status) {
  ///     print('Status: ${status.type}');
  ///     if (status.isInBlock) {
  ///       print('Included in block: ${status.inBlock}');
  ///     }
  ///   },
  /// );
  /// ```
  Future<StreamSubscription<ExtrinsicStatus>> signBuildAndSubmitWatch({
    required final Provider provider,
    required final String signerAddress,
    required final SigningCallback signingCallback,
    required final ExtrinsicListener onStatusChange,
  }) async {
    final extrinsic = await signAndBuild(
      signerAddress: signerAddress,
      signingCallback: signingCallback,
      provider: provider,
    );

    return await extrinsic.submitAndWatch(provider, onStatusChange);
  }

  /// Returns the signing payload without actually signing or submitting.
  ///
  /// This is useful for:
  /// - Debugging and inspecting the payload before signing
  /// - External signing workflows where you need the payload separately
  /// - Testing and validation
  ///
  /// Note: This does not fetch the nonce, so ensure it's set before calling
  /// this method if you want an accurate payload.
  ///
  /// Returns:
  /// A [Uint8List] containing the SCALE-encoded signing payload.
  ///
  /// Example:
  /// ```dart
  /// final payload = builder.getSigningPayload();
  /// print('Payload to sign: ${encodeHex(payload)}');
  /// ```
  Uint8List getSigningPayload() {
    final signingBuilder = SigningBuilder(
      chainInfo: chainInfo,
      extensionBuilder: _extensionBuilder,
    );
    return signingBuilder.createPayloadToSign(callData);
  }

  /// Convenience method to quickly build and submit an extrinsic.
  ///
  /// This static method handles all the steps in one call:
  /// 1. Fetches chain data
  /// 2. Creates an ExtrinsicBuilder
  /// 3. Signs and submits the transaction
  ///
  /// Perfect for simple one-off transactions where you don't need fine control
  /// over the building process.
  ///
  /// Parameters:
  /// - [provider]: Blockchain connection provider
  /// - [chainInfo]: Chain metadata and configuration
  /// - [callData]: SCALE-encoded call to execute
  /// - [signerAddress]: SS58-encoded address of the signer
  /// - [signingCallback]: Function that signs the payload and returns the signature
  /// - [eraPeriod]: Optional era period (required for mortal transactions)
  /// - [tip]: Optional tip for transaction prioritization
  /// - [immortal]: Whether to make the transaction immortal (default: false)
  ///
  /// Returns:
  /// A [Uint8List] containing the transaction hash.
  ///
  /// Throws:
  /// - [AssertionError] if immortal is true but eraPeriod is not null
  /// - [AssertionError] if immortal is false but eraPeriod is null
  /// - [Exception] if chain data fetching fails
  /// - [Exception] if signing or submission fails
  ///
  /// Example:
  /// ```dart
  /// // Mortal transaction (recommended)
  /// final txHash = await ExtrinsicBuilder.quickSend(
  ///   provider: provider,
  ///   chainInfo: chainInfo,
  ///   callData: callData,
  ///   signerAddress: alice.address,
  ///   signingCallback: alice.sign,
  ///   eraPeriod: 64,
  ///   tip: BigInt.from(1000),
  /// );
  ///
  /// // Immortal transaction (use with caution)
  /// final txHash = await ExtrinsicBuilder.quickSend(
  ///   provider: provider,
  ///   chainInfo: chainInfo,
  ///   callData: callData,
  ///   signerAddress: alice.address,
  ///   signingCallback: alice.sign,
  ///   immortal: true,
  /// );
  /// ```
  static Future<Uint8List> quickSend({
    required final Provider provider,
    required final ChainInfo chainInfo,
    required final Uint8List callData,
    required final String signerAddress,
    required final SigningCallback signingCallback,
    final int? eraPeriod,
    final BigInt? tip,
    bool immortal = false,
  }) async {
    // An Immortal transaction so expect eraPeriod to be null.
    assert(
      immortal && eraPeriod == null,
      'For immortal transactions, eraPeriod must be null and immortal must be true.',
    );

    // Not an Immortal transaction so expect eraPeriod to non-null.
    assert(
      immortal == false && eraPeriod != null,
      'For mortal transactions, eraPeriod must not be null and immortal must be false.',
    );
    // Fetch chain data
    final fetcher = ChainDataFetcher(provider);
    final chainData = await fetcher.fetchStandardData(accountAddress: signerAddress);

    // Build and submit
    ExtrinsicBuilder builder = ExtrinsicBuilder.fromChainData(
      chainInfo: chainInfo,
      callData: callData,
      chainData: chainData,
    );

    if (tip != null) builder = builder.tip(tip);
    if (immortal) builder = builder.immortal();

    return builder.signBuildAndSubmit(
      provider: provider,
      signingCallback: signingCallback,
      signerAddress: signerAddress,
    );
  }

  // ===== Private Helpers =====

  Future<void> _fetchNonceIfNeeded({final Provider? provider, final String? address}) async {
    if (_nonceSet) return;
    if (provider == null || address == null) {
      throw Exception(
        'Cannot fetch nonce: Both the provider & address is needed to fetch nonce for the sender or please set nonce manually.',
      );
    }

    final fetcher = SystemApi(provider);
    final nonce = await fetcher.accountNextIndex(address);
    _extensionBuilder.nonce(nonce);
    _nonceSet = true;
  }
}
