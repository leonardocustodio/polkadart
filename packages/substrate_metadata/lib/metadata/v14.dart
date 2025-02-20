part of metadata;

/// The metadata of a runtime.
class RuntimeMetadataV14 implements RuntimeMetadata {
  /// Type registry containing all types used in the metadata.
  @override
  final List<PortableType> types;

  /// Metadata of all the pallets.
  @override
  final List<PalletMetadataV14> pallets;

  /// Metadata of the extrinsic.
  @override
  final ExtrinsicMetadataV14 extrinsic;

  /// The type of the `Runtime`.
  @override
  final TypeId runtimeTypeId;

  @override
  final List<ApiMetadata> apis = [];

  @override
  final CustomMetadata custom = CustomMetadata(map: {});

  @override
  final OuterEnumMetadata outerEnums;

  static const $RuntimeMetadataCodecV14 codec = $RuntimeMetadataCodecV14._();

  RuntimeMetadataV14({
    required this.types,
    required this.pallets,
    required this.extrinsic,
    required this.runtimeTypeId,
    required this.outerEnums,
  });

  @override
  int runtimeMetadataVersion() {
    return 14;
  }

  @override
  PortableType typeById(int id) {
    return types.firstWhere((type) => type.id == id);
  }

  @override
  Map<String, dynamic> toJson() => {
        'types': types.map((type) => type.toJson()).toList(),
        'pallets': pallets.map((pallet) => pallet.toJson()).toList(),
        'extrinsic': extrinsic.toJson(),
        'ty': runtimeTypeId,
      };
}

class $RuntimeMetadataCodecV14 implements Codec<RuntimeMetadataV14> {
  const $RuntimeMetadataCodecV14._();

  OuterEnumMetadata generateOuterEnums(List<PortableType> types) {
    var callType = 0;
    var eventType = 0;
    var errorType = 0;

    for (final type in types) {
      if (type.type.path.contains('RuntimeCall')) {
        callType = type.id;
      }
      if (type.type.path.contains('RuntimeEvent')) {
        eventType = type.id;
      }
      if (type.type.path.contains('RuntimeError')) {
        errorType = type.id;
      }

      // TODO: It is possible that RuntimeError doesn't exists in the metadata
      // In that case, we should create a new type RuntimeError and add it
      // See: https://github.com/paritytech/subxt/blob/2d9de19040c862e1a7c97d572839983e43f336ea/metadata/src/from_into/v14.rs#L354-L389
    }

    return OuterEnumMetadata(
      callType: callType,
      eventType: eventType,
      errorType: errorType,
    );
  }

  @override
  RuntimeMetadataV14 decode(Input input) {
    final types = SequenceCodec(PortableType.codec).decode(input);
    final pallets = SequenceCodec(PalletMetadataV14.codec).decode(input);
    final extrinsic = ExtrinsicMetadataV14.codec.decode(input, types: types);
    final outerEnums = generateOuterEnums(types);

    final runtimeTypeId = TypeIdCodec.codec.decode(input);
    return RuntimeMetadataV14(
      types: types,
      pallets: pallets,
      extrinsic: extrinsic,
      runtimeTypeId: runtimeTypeId,
      outerEnums: outerEnums,
    );
  }

  @override
  Uint8List encode(RuntimeMetadataV14 metadata) {
    final output = ByteOutput(sizeHint(metadata));
    encodeTo(metadata, output);
    return output.toBytes(copy: false);
  }

  @override
  void encodeTo(RuntimeMetadataV14 metadata, Output output) {
    SequenceCodec(PortableType.codec).encodeTo(metadata.types, output);
    SequenceCodec(PalletMetadataV14.codec).encodeTo(metadata.pallets, output);
    ExtrinsicMetadataV14.codec.encodeTo(metadata.extrinsic, output);
    TypeIdCodec.codec.encodeTo(metadata.runtimeTypeId, output);
  }

  @override
  int sizeHint(RuntimeMetadataV14 metadata) {
    int size = SequenceCodec(PortableType.codec).sizeHint(metadata.types);
    size += SequenceCodec(PalletMetadataV14.codec).sizeHint(metadata.pallets);
    size += ExtrinsicMetadataV14.codec.sizeHint(metadata.extrinsic);
    size += TypeIdCodec.codec.sizeHint(metadata.runtimeTypeId);
    return size;
  }
}

/// All metadata about an runtime pallet.
class PalletMetadataV14 implements PalletMetadata {
  /// Pallet name.
  @override
  final String name;

  /// Pallet storage metadata.
  @override
  final PalletStorageMetadata? storage;

  /// Pallet calls metadata.
  @override
  final PalletCallMetadata? calls;

  /// Pallet calls metadata.
  @override
  final PalletEventMetadata? event;

  /// Pallet constants metadata.
  @override
  final List<PalletConstantMetadata> constants;

  /// Pallet constants metadata.
  @override
  final PalletErrorMetadata? error;

  /// Define the index of the pallet, this index will be used for the encoding of pallet event,
  /// call and origin variants.
  @override
  final int index;

  @override
  List<String> get docs => [];

  static const $PalletMetadataCodecV14 codec = $PalletMetadataCodecV14._();

  PalletMetadataV14({
    required this.name,
    required this.storage,
    required this.constants,
    required this.index,
    this.calls,
    this.event,
    this.error,
  });

  @override
  Map<String, dynamic> toJson() => {
        'name': name,
        'storage': storage?.toJson(),
        'calls': calls?.toJson(),
        'event': event?.toJson(),
        'constants': constants.map((c) => c.toJson()).toList(),
        'error': error?.toJson(),
        'index': index,
      };
}

class $PalletMetadataCodecV14 implements Codec<PalletMetadataV14> {
  const $PalletMetadataCodecV14._();

  @override
  PalletMetadataV14 decode(Input input) {
    final name = StrCodec.codec.decode(input);
    final storage = OptionCodec(PalletStorageMetadata.codec).decode(input);
    final calls = OptionCodec(PalletCallMetadata.codec).decode(input);
    final event = OptionCodec(PalletEventMetadata.codec).decode(input);
    final constants = SequenceCodec(PalletConstantMetadata.codec).decode(input);
    final error = OptionCodec(PalletErrorMetadata.codec).decode(input);
    final index = U8Codec.codec.decode(input);
    return PalletMetadataV14(
      name: name,
      storage: storage,
      calls: calls,
      event: event,
      constants: constants,
      error: error,
      index: index,
    );
  }

  @override
  Uint8List encode(PalletMetadataV14 metadata) {
    final output = ByteOutput(sizeHint(metadata));
    encodeTo(metadata, output);
    return output.toBytes(copy: false);
  }

  @override
  void encodeTo(PalletMetadataV14 metadata, Output output) {
    StrCodec.codec.encodeTo(metadata.name, output);
    OptionCodec(PalletStorageMetadata.codec).encodeTo(metadata.storage, output);
    OptionCodec(PalletCallMetadata.codec).encodeTo(metadata.calls, output);
    OptionCodec(PalletEventMetadata.codec).encodeTo(metadata.event, output);
    SequenceCodec(PalletConstantMetadata.codec).encodeTo(metadata.constants, output);
    OptionCodec(PalletErrorMetadata.codec).encodeTo(metadata.error, output);
    U8Codec.codec.encodeTo(metadata.index, output);
  }

  @override
  int sizeHint(PalletMetadataV14 metadata) {
    int size = StrCodec.codec.sizeHint(metadata.name);
    size += OptionCodec(PalletStorageMetadata.codec).sizeHint(metadata.storage);
    size += OptionCodec(PalletCallMetadata.codec).sizeHint(metadata.calls);
    size += OptionCodec(PalletEventMetadata.codec).sizeHint(metadata.event);
    size += SequenceCodec(PalletConstantMetadata.codec).sizeHint(metadata.constants);
    size += OptionCodec(PalletErrorMetadata.codec).sizeHint(metadata.error);
    size += U8Codec.codec.sizeHint(metadata.index);
    return size;
  }
}

/// Metadata of the extrinsic used by the runtime.
class ExtrinsicMetadataV14 implements ExtrinsicMetadata {
  /// The type of the extrinsic.
  final TypeId type;

  /// Extrinsic version.
  @override
  final int version;

  @override
  TypeId addressType;

  @override
  TypeId callType;

  @override
  TypeId extraType;

  @override
  TypeId signatureType;

  /// The signed extensions in the order they appear in the extrinsic.
  @override
  final List<SignedExtensionMetadata> signedExtensions;

  static const $ExtrinsicMetadataCodecV14 codec = $ExtrinsicMetadataCodecV14._();

  ExtrinsicMetadataV14({
    required this.type,
    required this.version,
    required this.signedExtensions,
    required this.addressType,
    required this.callType,
    required this.signatureType,
    required this.extraType,
  });

  factory ExtrinsicMetadataV14.fromJson(Map<String, dynamic> json) {
    final signedExtensions = (json['signedExtensions'] as List)
        .cast<Map<String, dynamic>>()
        .map((json) => SignedExtensionMetadata.fromJson(json))
        .toList();

    return ExtrinsicMetadataV14(
      type: json['type'],
      version: json['version'],
      signedExtensions: signedExtensions,
      addressType: 0,
      callType: 0,
      signatureType: 0,
      extraType: 0,
    );
  }

  @override
  Map<String, dynamic> toJson() => {
        'version': version,
        'address_type': addressType,
        'call_type': callType,
        'signature_type': signatureType,
        'extra_type': extraType,
        'signed_extensions': signedExtensions.map((e) => e.toJson()).toList(),
      };
}

class ExtrinsicPartTypeIds {
  final int addressType;
  final int callType;
  final int signatureType;
  final int extraType;

  ExtrinsicPartTypeIds({
    required this.addressType,
    required this.callType,
    required this.signatureType,
    required this.extraType,
  });
}

class $ExtrinsicMetadataCodecV14 implements Codec<ExtrinsicMetadataV14> {
  const $ExtrinsicMetadataCodecV14._();

  ExtrinsicPartTypeIds extractExtrinsicParts(TypeId extrinsicId, List<PortableType> types) {
    final extrinsicType = types.firstWhere((t) => t.id == extrinsicId);
    final paramsMap = {for (var p in extrinsicType.type.params) p.name: p.type};

    return ExtrinsicPartTypeIds(
      addressType: paramsMap['Address'] ?? 0,
      callType: paramsMap['Call'] ?? 0,
      signatureType: paramsMap['Signature'] ?? 0,
      extraType: paramsMap['Extra'] ?? 0,
    );
  }

  @override
  ExtrinsicMetadataV14 decode(Input input, {types = List<PortableType>}) {
    final type = TypeIdCodec.codec.decode(input);
    final version = U8Codec.codec.decode(input);
    final signedExtensions = SequenceCodec(SignedExtensionMetadata.codec).decode(input);
    final extrinsicPartTypeIds = extractExtrinsicParts(type, types);

    return ExtrinsicMetadataV14(
      type: type,
      version: version,
      signedExtensions: signedExtensions,
      addressType: extrinsicPartTypeIds.addressType,
      callType: extrinsicPartTypeIds.callType,
      signatureType: extrinsicPartTypeIds.signatureType,
      extraType: extrinsicPartTypeIds.extraType,
    );
  }

  @override
  Uint8List encode(ExtrinsicMetadataV14 value) {
    final output = ByteOutput(sizeHint(value));
    encodeTo(value, output);
    return output.toBytes(copy: false);
  }

  @override
  void encodeTo(ExtrinsicMetadataV14 metadata, Output output) {
    TypeIdCodec.codec.encodeTo(metadata.type, output);
    U8Codec.codec.encodeTo(metadata.version, output);
    SequenceCodec(SignedExtensionMetadata.codec).encodeTo(metadata.signedExtensions, output);
  }

  @override
  int sizeHint(ExtrinsicMetadataV14 metadata) {
    int size = TypeIdCodec.codec.sizeHint(metadata.type);
    size += U8Codec.codec.sizeHint(metadata.version);
    size += SequenceCodec(SignedExtensionMetadata.codec).sizeHint(metadata.signedExtensions);
    return size;
  }
}
