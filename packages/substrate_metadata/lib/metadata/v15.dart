part of metadata;

/// The metadata of a runtime.
class RuntimeMetadataV15 extends RuntimeMetadata {
  static const $RuntimeMetadataCodec codec = $RuntimeMetadataCodec._();

  RuntimeMetadataV15({
    required List<PortableType> types,
    required List<PalletMetadata> pallets,
    required ExtrinsicMetadata extrinsic,
    required TypeId runtimeTypeId,
    required List<ApiMetadata> apis,
    required OuterEnumMetadata outerEnums,
    required CustomMetadata custom,
  }) : super(
          types: types,
          pallets: pallets,
          extrinsic: extrinsic,
          runtimeTypeId: runtimeTypeId,
          apis: apis,
          outerEnums: outerEnums,
          custom: custom,
        );

  @override
  int runtimeMetadataVersion() {
    return 15;
  }
}
