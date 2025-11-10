part of extrinsic_builder;

/// Encoder for creating the final extrinsic bytes
///
/// This class takes signed data and encodes it into the final extrinsic format
/// that can be submitted to the chain. It handles version bytes, MultiAddress,
/// MultiSignature, extensions, and the compact length prefix.
class ExtrinsicEncoder {
  final ChainInfo chainInfo;

  /// Version bit flags
  static const int _EXTRINSIC_VERSION = 4; // Current version
  static const int _SIGNED_MASK = 0x80; // Bit 7: 1 = signed, 0 = unsigned
  static const int _VERSION_MASK = 0x7F; // Bits 0-6: version

  ExtrinsicEncoder(this.chainInfo);

  /// Encode a signed extrinsic ready for submission
  ///
  /// Returns the complete extrinsic bytes including:
  /// - Compact length prefix
  /// - Version byte (0x84 for signed v4)
  /// - Signer address (MultiAddress)
  /// - Signature (MultiSignature)
  /// - Extension values
  /// - Call data
  Uint8List encode(SignedData signedData) {
    // First encode the extrinsic without length prefix
    final extrinsicBytes = _encodeExtrinsicWithoutPrefix(signedData);

    // Add compact length prefix
    final output = ByteOutput();
    CompactCodec.codec.encodeTo(extrinsicBytes.length, output);
    output.write(extrinsicBytes);

    return output.toBytes();
  }

  /// Encode extrinsic without the length prefix
  ///
  /// Useful for calculating the extrinsic hash or for custom use cases
  Uint8List encodeWithoutPrefix(SignedData signedData) {
    return _encodeExtrinsicWithoutPrefix(signedData);
  }

  /// Get the extrinsic hash (Blake2b-256 of encoded extrinsic)
  Uint8List getHash(SignedData signedData) {
    final encoded = encode(signedData);
    return Hasher.blake2b256.hash(encoded);
  }

  /// Get hex representation of the extrinsic
  String toHex(SignedData signedData) {
    final bytes = encode(signedData);
    return '0x${bytes.map((b) => b.toRadixString(16).padLeft(2, '0')).join()}';
  }

  /// Internal method to encode extrinsic without length prefix
  Uint8List _encodeExtrinsicWithoutPrefix(SignedData signedData) {
    final output = ByteOutput();

    // 1. Version byte (0x84 for signed V4)
    final versionByte = _SIGNED_MASK | (_EXTRINSIC_VERSION & _VERSION_MASK);
    output.pushByte(versionByte);

    // 2. Encode signer address (MultiAddress)
    _encodeMultiAddress(signedData.signer, output);

    // 3. Encode signature (MultiSignature)
    _encodeMultiSignature(signedData.signature, signedData.signatureType, output);

    // 4. Encode extension values (in metadata order, skip zero-sized)
    _encodeExtensions(signedData.extensions, output);

    // 5. Encode call data
    output.write(signedData.callData);

    return output.toBytes();
  }

  /// Encode MultiAddress
  ///
  /// Substrate uses MultiAddress enum with variants:
  /// - Id (index 0): AccountId32
  /// - Index (index 1): Compact<AccountIndex>
  /// - Raw (index 2): Vec<u8>
  /// - Address32 (index 3): [u8; 32]
  /// - Address20 (index 4): [u8; 20]
  void _encodeMultiAddress(Uint8List address, Output output) {
    // Determine address type based on length
    switch (address.length) {
      case 32:
        // Id variant (most common)
        output.pushByte(0x00);
        output.write(address);
        break;
      case 20:
        // Address20 variant (Ethereum-style)
        output.pushByte(0x04);
        output.write(address);
        break;
      default:
        // Raw variant for other sizes
        output.pushByte(0x02);
        // Encode as Vec<u8>
        CompactCodec.codec.encodeTo(address.length, output);
        output.write(address);
    }
  }

  /// Encode MultiSignature
  ///
  /// Substrate uses MultiSignature enum with variants:
  /// - Ed25519 (index 0): [u8; 64]
  /// - Sr25519 (index 1): [u8; 64]
  /// - Ecdsa (index 2): [u8; 65]
  void _encodeMultiSignature(Uint8List signature, SignatureType type, Output output) {
    switch (type) {
      case SignatureType.ed25519:
        output.pushByte(0x00);
        break;
      case SignatureType.sr25519:
        output.pushByte(0x01);
        break;
      case SignatureType.ecdsa:
        output.pushByte(0x02);
        break;
      case SignatureType.unknown:
        // Default to Sr25519 for unknown
        output.pushByte(0x01);
        break;
    }
    output.write(signature);
  }

  /// Encode extension values in metadata order
  void _encodeExtensions(Map<String, dynamic> extensions, Output output) {
    // Extensions must be encoded in the exact order specified in metadata
    for (final ext in chainInfo.registry.signedExtensions) {
      final codec = chainInfo.registry.codecFor(ext.type);

      // Skip zero-sized extensions
      if (codec is NullCodec || codec.isSizeZero()) {
        continue;
      }

      final value = extensions[ext.identifier];
      if (value == null) {
        throw EncodingError('Missing extension value for ${ext.identifier}. '
            'This should have been set by ExtensionBuilder.');
      }

      try {
        // Special handling for CheckMortality/CheckEra
        // Era uses custom encoding (1 or 2 bytes), not standard SCALE enum
        if (ext.identifier == 'CheckMortality' || ext.identifier == 'CheckEra') {
          if (value is Uint8List) {
            // Pre-encoded era bytes from Era.codec
            output.write(value);
          } else {
            throw EncodingError(
                'CheckMortality/CheckEra value must be Uint8List (pre-encoded era bytes)');
          }
        } else {
          // Use standard codec for other extensions
          codec.encodeTo(value, output);
        }
      } catch (e) {
        throw EncodingError('Failed to encode extension ${ext.identifier}: $e\n'
            'Value: $value\n'
            'Codec: ${codec.runtimeType}');
      }
    }
  }

  /// Create an unsigned extrinsic (for inherents or unsigned transactions)
  Uint8List encodeUnsigned(Uint8List callData) {
    final output = ByteOutput();

    // Version byte (0x04 for unsigned V4)
    final versionByte = _EXTRINSIC_VERSION & _VERSION_MASK;
    output.pushByte(versionByte);

    // Just the call data for unsigned
    output.write(callData);

    // Add compact length prefix
    final extrinsicBytes = output.toBytes();
    final finalOutput = ByteOutput();
    CompactCodec.codec.encodeTo(extrinsicBytes.length, finalOutput);
    finalOutput.write(extrinsicBytes);

    return finalOutput.toBytes();
  }

  /// Get information about the encoded extrinsic
  EncodedExtrinsicInfo getExtrinsicInfo(SignedData signedData) {
    final encoded = encode(signedData);
    final encodedWithoutPrefix = _encodeExtrinsicWithoutPrefix(signedData);
    final hash = Hasher.blake2b256.hash(encoded);

    // Calculate sizes of different components
    final lengthPrefixSize = encoded.length - encodedWithoutPrefix.length;

    // Calculate extension size
    final extensionOutput = ByteOutput();
    _encodeExtensions(signedData.extensions, extensionOutput);
    final extensionSize = extensionOutput.toBytes().length;

    return EncodedExtrinsicInfo(
      totalSize: encoded.length,
      lengthPrefixSize: lengthPrefixSize,
      versionByteSize: 1,
      addressSize: signedData.signer.length + 1, // +1 for variant byte
      signatureSize: signedData.signature.length + 1, // +1 for variant byte
      extensionSize: extensionSize,
      callDataSize: signedData.callData.length,
      hash: hash,
      signatureType: signedData.signatureType,
      isSigned: true,
    );
  }
}

/// Error thrown during encoding
class EncodingError implements Exception {
  final String message;

  EncodingError(this.message);

  @override
  String toString() => 'EncodingError: $message';
}
