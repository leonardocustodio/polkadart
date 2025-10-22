part of metadata;

/// Extension methods to provide a common interface for RuntimeMetadata variants
extension RuntimeMetadataExtensions on RuntimeMetadata {
  /// Get the list of pallets
  List<PalletMetadata> get pallets {
    return switch (this) {
      final RuntimeMetadataV14 v14 => v14.pallets,
      final RuntimeMetadataV15 v15 => v15.pallets,
    };
  }

  ExtrinsicMetadata get extrinsic {
    return switch (this) {
      final RuntimeMetadataV14 v14 => v14.extrinsic,
      final RuntimeMetadataV15 v15 => v15.extrinsic,
    };
  }

  List<PortableType> get types {
    return switch (this) {
      final RuntimeMetadataV14 v14 => v14.types,
      final RuntimeMetadataV15 v15 => v15.types,
    };
  }
}
