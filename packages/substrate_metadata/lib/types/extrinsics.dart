part of metadata_types;

class ExtrinsicsCodec with Codec<Map<String, dynamic>> {
  final ChainInfo chainInfo;

  const ExtrinsicsCodec({required this.chainInfo});

  @override
  Map<String, dynamic> decode(Input input) {
    final result = <String, dynamic>{};

    result['hash'] = ExtrinsicsCodec.computeHash(input.buffer);

    result['extrinsic_length'] = CompactCodec.codec.decode(input);

    if (result['extrinsic_length'] != input.remainingLength) {
      result['extrinsic_length'] = 0;
      input.resetOffset();
    }

    final meta = input.read();

    //
    // 0b01111111 ~ 127 in BigInt
    final version = meta & BigInt.from(127).toInt();

    assertion(version == 4, 'unsupported extrinsic version');

    result['version'] = 4;

    //
    // 0b10000000 ~ 128 in BigInt
    final signed = meta & BigInt.from(128).toInt();

    if (signed != 0) {
      result['signature'] =
          chainInfo.scaleCodec.decode('ExtrinsicSignatureCodec', input);
    }

    result['calls'] = chainInfo.scaleCodec.decode('Call', input);

    return result;
  }

  @override
  void encodeTo(Map<String, dynamic> value, Output output) {
    assertion(value['version'] == 4,
        'Unsupported extrinsic version, Expected 4 but got ${value['version']}');
    assertion(value['calls'] != null, 'No calls found to encode.');

    final ByteOutput tempOutput = ByteOutput();

    int meta = 4;

    if (value['signature'] != null) {
      //
      // 0b10000000 ~ 128 in BigInt
      meta |= BigInt.from(128).toInt();

      //
      // Start encoding the signature
      chainInfo.scaleCodec
          .encodeTo('ExtrinsicSignatureCodec', value['signature'], tempOutput);
    }

    chainInfo.scaleCodec.encodeTo('Call', value['calls'], tempOutput);

    CompactCodec.codec.encodeTo(tempOutput.length + 1, output);

    output
      ..pushByte(meta)
      ..write(tempOutput.toBytes());
  }

  static String computeHash(Uint8List extrinsicBytes, [int digestSize = 32]) {
    return encodeHex(
        Blake2bDigest(digestSize: digestSize).process(extrinsicBytes));
  }

  static String computeHashFromString(String extrinsic, [int digestSize = 32]) {
    return computeHash(decodeHex(extrinsic), digestSize);
  }
}
