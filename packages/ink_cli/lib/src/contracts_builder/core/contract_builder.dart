part of ink_cli;

/// ContractBuilder provides methods for building and submitting contract extrinsics.
///
/// This class has been migrated to use polkadart's ExtrinsicBuilder infrastructure
/// for better maintainability and consistency with the main polkadart library.
class ContractBuilder {
  /// Signs and builds an extrinsic using polkadart's ExtrinsicBuilder.
  ///
  /// This method uses the modern ExtrinsicBuilder API which provides:
  /// - Automatic nonce fetching
  /// - Proper era/mortality handling
  /// - Consistent signed extension encoding
  /// - Better error handling
  ///
  /// Example:
  /// ```dart
  /// final extrinsic = await ContractBuilder.signAndBuildExtrinsic(
  ///   provider: provider,
  ///   signer: keypair,
  ///   methodCall: encodedMethodCall,
  ///   tip: BigInt.from(1000),
  ///   eraPeriod: 64,
  /// );
  /// ```
  static Future<Uint8List> signAndBuildExtrinsic({
    required final Provider provider,
    required final KeyPair signer,
    required final Uint8List methodCall,
    ChainInfo? chainInfo,
    final dynamic tip = 0,
    final int eraPeriod = 0,
  }) async {
    // Fetch metadata and chain info
    if (chainInfo == null) {
      final runtimeMetadata = await StateApi(provider).getMetadata();
      chainInfo = runtimeMetadata.buildChainInfo();
    }

    // Fetch chain data for the extrinsic
    final ChainDataFetcher fetcher = ChainDataFetcher(provider);
    final ChainData chainData = await fetcher.fetchStandardData(accountAddress: signer.address);

    // Convert tip to BigInt if needed
    final BigInt tipAmount;
    if (tip is int) {
      tipAmount = BigInt.from(tip);
    } else if (tip is BigInt) {
      tipAmount = tip;
    } else {
      throw ArgumentError('tip must be either int or BigInt, got ${tip.runtimeType}');
    }

    // Create the ExtrinsicBuilder
    ExtrinsicBuilder builder = ExtrinsicBuilder.fromChainData(
      chainInfo: chainInfo,
      callData: methodCall,
      chainData: chainData,
      eraPeriod: eraPeriod,
      tip: tipAmount,
    );

    // If era period is 0, make it immortal
    if (eraPeriod == 0) {
      builder = builder.immortal();
    }

    // Sign and build the extrinsic
    final encodedExtrinsic = await builder.signAndBuild(
      provider: provider,
      signerAddress: signer.address,
      signingCallback: (Uint8List payload) {
        // The payload is already hashed if > 256 bytes by the ExtrinsicBuilder
        return signer.sign(payload);
      },
    );

    return encodedExtrinsic.bytes;
  }

  /// Submits the extrinsic to the chain and returns the hash of the transaction.
  ///
  /// This is a convenience method that wraps the AuthorApi.submitExtrinsic call.
  ///
  /// Example:
  /// ```dart
  /// final txHash = await ContractBuilder.submitExtrinsic(provider, extrinsic);
  /// print('Transaction hash: ${encodeHex(txHash)}');
  /// ```
  static Future<Uint8List> submitExtrinsic(
      final Provider provider, final Uint8List extrinsic) async {
    return await AuthorApi(provider).submitExtrinsic(extrinsic);
  }
}
