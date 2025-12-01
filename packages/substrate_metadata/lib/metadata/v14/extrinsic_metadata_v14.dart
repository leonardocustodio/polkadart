part of metadata;

/// Metadata of the extrinsic used by the runtime (Version 14)
///
/// In V14, the extrinsic metadata contains a single type ID that points to
/// the complete extrinsic type (usually UncheckedExtrinsic<Address, Call, Signature, Extra>).
/// The individual component types (Address, Call, Signature, Extra) must be extracted
/// from this type's parameters.
class ExtrinsicMetadataV14 extends ExtrinsicMetadata {
  /// The type ID of the complete extrinsic type
  ///
  /// This typically points to a type like:
  /// `UncheckedExtrinsic<Address, Call, Signature, Extra>`
  ///
  /// The individual component types are extracted from this type's generic parameters.
  final int type;

  const ExtrinsicMetadataV14({
    required this.type,
    required super.version,
    required super.addressType,
    required super.callType,
    required super.signatureType,
    required super.extraType,
    required super.signedExtensions,
  });

  /// Codec instance for ExtrinsicMetadataV14
  static const $ExtrinsicMetadataV14 codec = $ExtrinsicMetadataV14._();

  @override
  Map<String, dynamic> toJson() => {
        'type': type,
        ...super.toJson(),
      };
}

class $ExtrinsicMetadataV14 with Codec<ExtrinsicMetadataV14> {
  const $ExtrinsicMetadataV14._();

  (int address, int call, int signature, int extra) extractExtrinsicPartTypes(
    int extrinsicTypeId,
    List<PortableType> types,
  ) {
    try {
      final extrinsicType = types.firstWhere((t) => t.id == extrinsicTypeId);
      final paramsMap = <String, int>{};

      for (var param in extrinsicType.type.params) {
        if (param.type != null) {
          paramsMap[param.name] = param.type!;
        }
      }
      return (
        paramsMap['Address'] ?? 0,
        paramsMap['Call'] ?? 0,
        paramsMap['Signature'] ?? 0,
        paramsMap['Extra'] ?? 0,
      );
    } catch (e) {
      return (0, 0, 0, 0);
    }
  }

  /// Decodes ExtrinsicMetadataV14 with type extraction
  @override
  ExtrinsicMetadataV14 decode(Input input, {List<PortableType> types = const <PortableType>[]}) {
    // Decode type ID (Compact<u32>)
    final type = CompactCodec.codec.decode(input);

    // Decode version (u8)
    final version = U8Codec.codec.decode(input);

    // Decode signed extensions
    final signedExtensions = SequenceCodec(SignedExtensionMetadata.codec).decode(input);

    final (address, call, signature, extra) = extractExtrinsicPartTypes(type, types);

    return ExtrinsicMetadataV14(
      type: type,
      version: version,
      addressType: address,
      callType: call,
      signatureType: signature,
      extraType: extra,
      signedExtensions: signedExtensions,
    );
  }

  @override
  void encodeTo(ExtrinsicMetadataV14 value, Output output) {
    // Encode extrinsic type ID
    CompactCodec.codec.encodeTo(value.type, output);

    // Encode extrinsic version
    U8Codec.codec.encodeTo(value.version, output);

    // Encode signed extensions
    SequenceCodec(SignedExtensionMetadata.codec).encodeTo(value.signedExtensions, output);
  }

  @override
  int sizeHint(ExtrinsicMetadataV14 value) {
    var size = 0;
    size += CompactCodec.codec.sizeHint(value.type);
    size += U8Codec.codec.sizeHint(value.version);
    size += SequenceCodec(SignedExtensionMetadata.codec).sizeHint(value.signedExtensions);
    return size;
  }
}
