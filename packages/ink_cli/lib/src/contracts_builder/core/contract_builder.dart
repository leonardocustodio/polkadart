part of ink_cli;

class ContractBuilder {
  static Future<Uint8List> signAndBuildExtrinsic({
    required final Provider provider,
    required final KeyPair signer,
    required final InstantiateWithCodeArgs methodArgs,
    required final scale_codec.Registry registry,
    final dynamic tip = 0,
    final int eraPeriod = 0,
  }) async {
    final Uint8List methodCall =
        ContractsMethod.instantiateWithCode(args: methodArgs).encode(registry);

    final ContractMeta meta = await ContractMeta.fromProvider(provider: provider);
    final int nonce = await SystemApi(provider).accountNextIndex(signer.address);

    /* bool? checkMetadataHash;
    final signedExtensions =
        meta.runtimeMetadata.extrinsic.signedExtensions;
    for (final extension in signedExtensions) {
      if (extension.identifier.toLowerCase() == 'checkmetadatahash') {
        checkMetadataHash = false;
        break;
      }
    } */
    bool? checkMetadataHash;
    final signedExtensions = meta.runtimeMetadata.metadata['extrinsic']?['signedExtensions'];
    if (signedExtensions != null && signedExtensions is List) {
      for (final extension in signedExtensions) {
        if (extension is Map &&
            extension['identifier'] != null &&
            extension['identifier'] is String &&
            (extension['identifier'] as String).toLowerCase() == 'checkmetadatahash') {
          checkMetadataHash = false;
          break;
        }
      }
    }

    final Uint8List unsignedPayload = ContractSigningPayload.encode(
      meta: meta,
      method: methodCall,
      tip: tip,
      nonce: nonce,
      checkMetadataHash: checkMetadataHash,
    );

    final Uint8List payloadSignature = ContractSigningPayload.sign(signer, unsignedPayload);

    final Uint8List signedContractTx = ContractExtrinsicPayload.encode(
      version: 132,
      signer: Address.decode(signer.address).pubkey,
      signatureType: signer.signatureType,
      meta: meta,
      method: methodCall,
      tip: tip,
      nonce: nonce,
      checkMetadataHash: checkMetadataHash,
      signature: payloadSignature,
    );
    return signedContractTx;
  }

  ///
  /// Submits the extrinsic to the chain and returns the hash of the transaction.
  ///
  static Future<Uint8List> submitExtrinsic(
      final Provider provider, final Uint8List extrinsic) async {
    return await AuthorApi(provider).submitExtrinsic(extrinsic);
  }
}
