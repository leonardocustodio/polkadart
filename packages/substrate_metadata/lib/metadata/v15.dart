part of metadata;

/// The metadata of a runtime.
class RuntimeMetadataV15 extends RuntimeMetadata {
  static const $RuntimeMetadataCodec codec = $RuntimeMetadataCodec._();

  RuntimeMetadataV15({
    required super.types,
    required super.pallets,
    required super.extrinsic,
    required super.runtimeTypeId,
    required super.apis,
    required super.outerEnums,
    required super.custom,
  });

  @override
  int runtimeMetadataVersion() {
    return 15;
  }
}
