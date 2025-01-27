part of ink_cli;

class ContractSigningPayload {
  static Uint8List encode({
    required final ContractMeta meta,
    required final Uint8List method,
    required final dynamic tip,
    required final int nonce,
    // making it required intentionally so that the end-developer knows that this is supported
    // and has to pass null explicitly.
    required final bool? checkMetadataHash,
    final int eraPeriod = 0,
  }) {
    final output = ByteOutput();

    // method_call
    output.write(method);

    // era
    if (eraPeriod == 0) {
      output.pushByte(0);
    } else {
      Era.codec.encodeMortal(meta.blockNumber, eraPeriod);
    }

    // nonce
    CompactCodec.codec.encode(nonce);

    // tip
    if (tip is int) {
      CompactCodec.codec.encodeTo(tip, output);
    } else if (tip is BigInt) {
      CompactBigIntCodec.codec.encodeTo(tip, output);
    } else {
      throw Exception('tip can either be int or BigInt.');
    }

    // CheckMetadata Hash
    if (checkMetadataHash != null) {
      BoolCodec.codec.encodeTo(checkMetadataHash, output);
    }

    // specVersion
    U32Codec.codec.encode(meta.specVersion);

    // transactionVersion
    U32Codec.codec.encode(meta.transactionVersion);

    // genesisHash
    output.write(meta.genesisHash);

    // blockHash
    output.write(meta.blockHash);

    // CheckMetadata Hash
    if (checkMetadataHash != null) {
      BoolCodec.codec.encodeTo(checkMetadataHash, output);
    }

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
}
