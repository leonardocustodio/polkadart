part of metadata;

abstract class RuntimeMetadata {
  int runtimeMetadataVersion();
  Map<String, dynamic> toJson();
}

/// Metadata prefixed by 4-bytes for reserved usage (currently magic number)
class RuntimeMetadataPrefixed {
  final int magicNumber;
  final RuntimeMetadata metadata;

  static const RuntimeMetadataPrefixedCodec codec =
      RuntimeMetadataPrefixedCodec();

  RuntimeMetadataPrefixed({required this.magicNumber, required this.metadata});

  factory RuntimeMetadataPrefixed.fromHex(String hexString) {
    List<int> rawData;
    if (hexString.startsWith('0x')) {
      rawData = hex.decode(hexString.substring(2));
    } else {
      rawData = hex.decode(hexString);
    }
    final input = ByteInput.fromBytes(rawData);
    return codec.decode(input);
  }

  Map<String, dynamic> toJson() => {
        'magicNumber': magicNumber,
        'metadata': {
          'V${metadata.runtimeMetadataVersion()}': metadata.toJson()
        },
      };
}

/// Current prefix of metadata
const META_RESERVED = 0x6174656d; // 'meta' warn endianness

class RuntimeMetadataPrefixedCodec implements Codec<RuntimeMetadataPrefixed> {
  const RuntimeMetadataPrefixedCodec();

  @override
  decode(Input input) {
    final magicNumber = U32Codec.codec.decode(input);
    if (magicNumber != META_RESERVED) {
      throw Exception(
          'Invalid magic number: got $magicNumber expected $META_RESERVED');
    }
    final version = U8Codec.codec.decode(input);

    return switch (version) {
      15 => RuntimeMetadataPrefixed(
          magicNumber: magicNumber,
          metadata: RuntimeMetadataV15.codec.decode(input),
        ),
      14 => RuntimeMetadataPrefixed(
          magicNumber: magicNumber,
          metadata: RuntimeMetadataV14.codec.decode(input),
        ),
      _ => throw Exception('Unsupported metadata version: $version'),
    };
  }

  @override
  Uint8List encode(RuntimeMetadataPrefixed metadata) {
    final output = Output.byteOutput();
    U32Codec.codec.encodeTo(META_RESERVED, output);
    U8Codec.codec.encodeTo(metadata.metadata.runtimeMetadataVersion(), output);
    return output.toBytes();
  }

  @override
  void encodeTo(RuntimeMetadataPrefixed metadata, Output output) {
    U32Codec.codec.encodeTo(META_RESERVED, output);
    U8Codec.codec.encodeTo(metadata.metadata.runtimeMetadataVersion(), output);
  }

  @override
  int sizeHint(RuntimeMetadataPrefixed value) {
    return 40;
  }
}
