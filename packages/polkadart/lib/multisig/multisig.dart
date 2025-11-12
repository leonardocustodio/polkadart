part of multisig;

/// Main entry point for multisig operations
///
/// This class provides convenient static methods for common multisig operations
/// and helper functions to simplify the workflow.
///
/// Example:
/// ```dart
/// // Quick multisig creation
/// final multisig = Multisig.create(
///   addresses: [alice.adshow ExtrinsicBuilder, SigningCallbackharlie.address],
///   threshold: 2,
/// );
///
/// // Create and fund in one go
/// final tx = await Multisig.createAndFund(
///   provider: provider,
///   depositor: alice.address,
///   signatories: [alice.address, bob.address, charlie.address],
///   threshold: 2,
///   amount: BigInt.from(1000000000000),
///   signCallback: (payload) => alice.sign(payload),
///   chainInfo: chainInfo,
/// );
/// ```
class Multisig {
  // Private constructor to prevent instantiation
  Multisig._();

  /// Create a multisig configuration
  ///
  /// This is the simplest way to create a multisig address.
  ///
  /// Parameters:
  /// - [addresses]: List of signatory addresses
  /// - [threshold]: Number of approvals required
  /// - [ss58Format]: Address format (default: 42)
  ///
  /// Returns: Signatories configuration with the multisig address
  ///
  /// Example:
  /// ```dart
  /// final multisig = Multisig.create(
  ///   addresses: [alice.address, bob.address, charlie.address],
  ///   threshold: 2,
  /// );
  ///
  /// print('Multisig address: ${multisig.multisigAddress}');
  /// print('Send funds to this address before creating transactions');
  /// ```
  static Signatories create({
    required List<String> addresses,
    required int threshold,
    final int ss58Format = 42,
  }) {
    return Signatories(
      addresses: addresses,
      threshold: threshold,
      ss58Format: ss58Format,
    );
  }

  /// Create and fund a multisig account
  ///
  /// This helper creates a multisig and funds it in one transaction.
  /// The depositor sends funds to the multisig address.
  ///
  /// Parameters:
  /// - [provider]: Chain connection
  /// - [depositor]: Address funding the multisig
  /// - [signatories]: List of all signatory addresses
  /// - [threshold]: Number of approvals required
  /// - [amount]: Amount to fund the multisig with
  /// - [depositorSignCallback]: Callback to sign the funding transaction
  /// - [chainInfo]: Chain metadata
  ///
  /// Returns: Signatories configuration after funding
  ///
  /// Example:
  /// ```dart
  /// final multisig = await Multisig.createAndFund(
  ///   provider: provider,
  ///   chainInfo: chainInfo,
  ///   depositor: alice.address,
  ///   signatories: [alice.address, bob.address, charlie.address],
  ///   threshold: 2,
  ///   amount: BigInt.from(10000000000000), // 10 tokens
  ///   signCallback: (payload) => aliceWallet.sign(payload),
  /// );
  /// ```
  static Future<Signatories> createAndFundMultisig({
    required final Provider provider,
    required final ChainInfo chainInfo,
    required final List<String> signatories,
    required final int threshold,
    required final String depositor,
    required final SigningCallback depositorSignCallback,
    required final BigInt amount,
    final int ss58Format = 42,
    final int eraPeriod = 64,
    final BigInt? tip,
  }) async {
    final multisig = create(
      addresses: <String>[depositor, ...signatories],
      threshold: threshold,
      ss58Format: ss58Format,
    );

    final RuntimeCall fundingCall = Balances.transferKeepAlive
        .toAccountId(amount: amount, destination: multisig.multisigPublicKey)
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

    final depositorPubkey = Address.decode(depositor).pubkey;
    await extrinsicBuilder.signBuildAndSubmit(
      signerPublicKey: depositorPubkey,
      signingCallback: depositorSignCallback,
      provider: provider,
      signerAddress: depositor,
    );

    return multisig;
  }

  /// Quick transfer from multisig
  ///
  /// Convenience method for creating a transfer transaction from a multisig.
  ///
  /// Parameters:
  /// - [signatories]: The multisig configuration
  /// - [to]: Destination address
  /// - [amount]: Amount to transfer
  /// - [chainInfo]: Chain metadata
  ///
  /// Returns: MultisigTransaction ready to be approved
  ///
  /// Example:
  /// ```dart
  /// final tx = Multisig.transfer(
  ///   signatories: multisig,
  ///   to: dave.address,
  ///   amount: BigInt.from(1000000000),
  ///   chainInfo: chainInfo,
  /// );
  ///
  /// await tx.approve(
  ///   provider: provider,
  ///   signer: alice.address,
  ///   signCallback: (payload) => alice.sign(payload),
  /// );
  /// ```
  static MultisigTransaction transfer({
    required final ChainInfo chainInfo,
    required final Signatories signatories,
    required final Uint8List to,
    required final BigInt amount,
    final bool keepAlive = true,
    final Weight? maxWeight,
  }) {
    late final RuntimeCall call;
    if (keepAlive) {
      call = Balances.transferKeepAlive
          .toAccountId(amount: amount, destination: to)
          .toRuntimeCall(chainInfo);
    } else {
      call =
          Balances.transfer.toAccountId(amount: amount, destination: to).toRuntimeCall(chainInfo);
    }

    return MultisigTransaction.fromCall(
      signatories: signatories,
      call: call,
      chainInfo: chainInfo,
      maxWeight: maxWeight,
    );
  }

  /// Check if a multisig transaction is pending
  ///
  /// Useful for checking before creating a new transaction.
  ///
  /// Parameters:
  /// - [provider]: Chain connection
  /// - [multisigAddress]: The multisig account address
  /// - [callHash]: Hash of the call to check
  /// - [chainInfo]: Chain metadata
  ///
  /// Returns: Storage data if pending, null otherwise
  ///
  /// Example:
  /// ```dart
  /// final isPending = await Multisig.isPending(
  ///   provider: provider,
  ///   chainInfo: chainInfo,
  ///   multisigAddress: multisig.multisigAddress,
  ///   callHash: callHash,
  /// );
  ///
  /// if (isPending != null) {
  ///   print('Transaction already pending with ${isPending.approvals.length} approvals');
  /// }
  /// ```
  static Future<MultisigStorage?> isPending({
    required final Provider provider,
    required final ChainInfo chainInfo,
    required final String multisigAddress,
    required final Uint8List callHash,
  }) async {
    return await MultisigStorage.fetch(
      provider: provider,
      multisigAddress: multisigAddress,
      callHash: callHash,
      registry: chainInfo.registry,
    );
  }

  /// Compute multisig address without creating full Signatories
  ///
  /// Useful for quickly checking what a multisig address would be.
  ///
  /// Parameters:
  /// - [addresses]: List of signatory addresses
  /// - [threshold]: Number of approvals required
  /// - [ss58Format]: Address format
  ///
  /// Returns: The multisig address
  ///
  /// Example:
  /// ```dart
  /// final address = Multisig.computeAddress(
  ///   addresses: [alice.address, bob.address],
  ///   threshold: 2,
  /// );
  /// print('Multisig would be: $address');
  /// ```
  static String computeAddress({
    required final List<String> addresses,
    required final int threshold,
    final int ss58Format = 42,
  }) {
    final signatories = create(
      addresses: addresses,
      threshold: threshold,
      ss58Format: ss58Format,
    );

    return signatories.multisigAddress;
  }

  /// Validate multisig parameters
  ///
  /// Checks if the given parameters would create a valid multisig.
  /// Useful for UI validation before attempting to create.
  ///
  /// Parameters:
  /// - [addresses]: List of signatory addresses
  /// - [threshold]: Number of approvals required
  ///
  /// Returns: Validation result with error message if invalid
  ///
  /// Example:
  /// ```dart
  /// final validation = Multisig.validate(
  ///   addresses: addresses,
  ///   threshold: threshold,
  /// );
  ///
  /// if (!validation.isValid) {
  ///   showError(validation.error!);
  /// }
  /// ```
  static ({bool isValid, String? error}) validate({
    required final List<String> addresses,
    required final int threshold,
  }) {
    // Check threshold
    if (threshold < 2) {
      return (isValid: false, error: 'Threshold must be at least 2');
    }

    // Remove duplicates for counting
    final unique = addresses.toSet();

    if (unique.length < 2) {
      return (isValid: false, error: 'At least 2 unique signatories required');
    }

    if (unique.length > 100) {
      return (isValid: false, error: 'Maximum 100 signatories allowed');
    }

    if (threshold > unique.length) {
      return (isValid: false, error: 'Threshold cannot exceed number of signatories');
    }

    // Validate addresses
    for (final address in addresses) {
      try {
        Address.decode(address);
      } catch (e) {
        return (isValid: false, error: 'Invalid address: $address');
      }
    }

    return (isValid: true, error: null);
  }
}
