part of ink_cli;

class ContractExtrinsicPayload {
  static Uint8List encode({
    required final ContractMeta meta,
    required final Uint8List method,
    required final Uint8List signer,
    required final Uint8List signature,
    required final dynamic tip,
    required final int version,
    required final int nonce,
    // making it required intentionally so that the end-developer knows that this is supported
    // and has to pass null explicitly.
    required final bool? checkMetadataHash,
    required final SignatureType signatureType,
    final int eraPeriod = 0,
  }) {
    final output = ByteOutput();

    // version
    output.pushByte(version);
    // MultiAddress -> Id  {is at index 0}
    output.pushByte(0);
    // now push the signer bytes
    output.write(signer);
    // Signature type byte
    output.pushByte(signatureType.type);

    // Write Signature
    output.write(signature);

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

    // Add the method call -> transfer.....
    output.write(method);

    return U8SequenceCodec.codec.encode(output.toBytes());
  }
}
