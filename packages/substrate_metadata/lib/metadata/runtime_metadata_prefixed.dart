part of metadata;

/// Magic number prefix for metadata: 'meta' in ASCII (0x6174656d)
const int metaReserved = 0x6174656d;

/// Wrapper for prefixed runtime metadata
///
/// This is the top-level structure returned by the `state_getMetadata` RPC call.
/// It includes a magic number and version before the actual metadata.
///
/// Example:
/// ```dart
/// final input = Input.fromHex('0x6d657461...');
/// final prefixed = RuntimeMetadataPrefixed.codec.decode(input);
///
/// if (prefixed.isValidMagicNumber) {
///   switch (prefixed.metadata) {
///     case RuntimeMetadataV14Variant():
///       final v14 = prefixed.metadata.metadata;
///       print('V14 with ${v14.pallets.length} pallets');
///     case RuntimeMetadataV15Variant():
///       final v15 = prefixed.metadata.metadata;
///       print('V15 with ${v15.pallets.length} pallets');
///     case RuntimeMetadataOpaque():
///       print('Unsupported version: ${prefixed.metadata.version}');
///   }
/// }
/// ```
class RuntimeMetadataPrefixed {
  /// Magic number (should be [metaReserved]: 0x6174656d / "meta")
  final int magicNumber;

  /// The actual metadata (versioned enum)
  final RuntimeMetadata metadata;

  const RuntimeMetadataPrefixed({
    required this.magicNumber,
    required this.metadata,
  });

  /// Codec instance for RuntimeMetadataPrefixed
  static const $RuntimeMetadataPrefixed codec = $RuntimeMetadataPrefixed._();

  /// Check if the magic number is valid
  bool get isValidMagicNumber => magicNumber == metaReserved;

  Map<String, dynamic> toJson() => {
        'magicNumber': magicNumber,
        'metadata': {'V${metadata.version}': metadata.toJson()},
      };
}

/// Versioned metadata enum
///
/// Substrate uses this enum to support multiple metadata versions.
/// This allows nodes to upgrade their metadata format while maintaining
/// backward compatibility.
sealed class RuntimeMetadata {
  const RuntimeMetadata();

  /// Get the metadata version number
  int get version;

  Map<String, dynamic> toJson();
}

/// Metadata Version 14 variant
class RuntimeMetadataV14Variant extends RuntimeMetadata {
  final RuntimeMetadataV14 metadata;

  const RuntimeMetadataV14Variant(this.metadata);

  @override
  int get version => 14;

  @override
  Map<String, dynamic> toJson() => metadata.toJson();
}

/// Metadata Version 15 variant
class RuntimeMetadataV15Variant extends RuntimeMetadata {
  final RuntimeMetadataV15 metadata;

  const RuntimeMetadataV15Variant(this.metadata);

  @override
  int get version => 15;

  @override
  Map<String, dynamic> toJson() => metadata.toJson();
}

/// Opaque metadata (for unsupported versions)
///
/// When a metadata version is not supported, it's stored as raw bytes
/// that can be processed later or by another tool.
class RuntimeMetadataOpaque extends RuntimeMetadata {
  @override
  final int version;

  final Uint8List bytes;

  const RuntimeMetadataOpaque({
    required this.version,
    required this.bytes,
  });

  @override
  Map<String, dynamic> toJson() => {
        'version': version,
        'bytes': bytes,
      };
}

/// Codec for RuntimeMetadataPrefixed
///
/// Handles decoding of the prefixed metadata structure including
/// version detection and routing to appropriate version-specific codecs.
class $RuntimeMetadataPrefixed with Codec<RuntimeMetadataPrefixed> {
  const $RuntimeMetadataPrefixed._();

  @override
  RuntimeMetadataPrefixed decode(Input input) {
    // Decode magic number
    final magicNumber = U32Codec.codec.decode(input);

    // Decode version
    final version = U8Codec.codec.decode(input);

    // Decode metadata based on version
    final RuntimeMetadata metadata;
    switch (version) {
      case 14:
        metadata = RuntimeMetadataV14Variant(RuntimeMetadataV14.codec.decode(input));
        break;

      case 15:
        metadata = RuntimeMetadataV15Variant(RuntimeMetadataV15.codec.decode(input));
        break;

      default:
        // For unsupported versions, read remaining bytes as opaque
        final remaining = input.remainingLength ?? 0;
        final bytes = remaining > 0 ? input.readBytes(remaining) : Uint8List(0);
        metadata = RuntimeMetadataOpaque(version: version, bytes: bytes);
    }

    return RuntimeMetadataPrefixed(magicNumber: magicNumber, metadata: metadata);
  }

  @override
  void encodeTo(RuntimeMetadataPrefixed value, Output output) {
    // Encode magic number
    U32Codec.codec.encodeTo(value.magicNumber, output);

    // Encode version and metadata based on variant
    switch (value.metadata) {
      case final RuntimeMetadataV14Variant v14:
        U8Codec.codec.encodeTo(14, output);
        RuntimeMetadataV14.codec.encodeTo(v14.metadata, output);

      case final RuntimeMetadataV15Variant v15:
        U8Codec.codec.encodeTo(15, output);
        RuntimeMetadataV15.codec.encodeTo(v15.metadata, output);

      case final RuntimeMetadataOpaque opaque:
        U8Codec.codec.encodeTo(value.metadata.version, output);
        output.write(opaque.bytes);
    }
  }

  @override
  int sizeHint(RuntimeMetadataPrefixed value) {
    var size = 0;
    size += U32Codec.codec.sizeHint(value.magicNumber);
    size += 1; // version byte

    switch (value.metadata) {
      case final RuntimeMetadataV14Variant v14:
        size += RuntimeMetadataV14.codec.sizeHint(v14.metadata);

      case final RuntimeMetadataV15Variant v15:
        size += RuntimeMetadataV15.codec.sizeHint(v15.metadata);

      case final RuntimeMetadataOpaque opaque:
        size += opaque.bytes.length;
    }

    return size;
  }
}
