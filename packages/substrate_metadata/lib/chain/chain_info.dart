import 'dart:typed_data' show Uint8List;

import 'package:polkadart_scale_codec/polkadart_scale_codec.dart' show Input;
import 'package:substrate_metadata/derived_codecs/derived_codecs.dart'
    show EventsRecordCodec, ExtrinsicsCodec, RuntimeCallCodec, ConstantsCodec;
import 'package:substrate_metadata/metadata/metadata.dart'
    show RuntimeMetadataPrefixed, PalletMetadata;
import 'package:substrate_metadata/models/models.dart' show UncheckedExtrinsic, EventRecord;
import 'package:substrate_metadata/registry/metadata_type_registry.dart' show MetadataTypeRegistry;

/// Convenient facade for accessing metadata, registry, and derived codecs
///
/// ChainInfo acts as a one-stop shop for all chain-specific metadata
/// operations, providing easy access to:
/// - Type registry for custom codec operations
/// - Pre-built derived codecs (events, extrinsics, calls, constants)
/// - Metadata information (pallets, storage, etc.)
///
/// Example:
/// ```dart
/// final chainInfo = ChainInfo.fromMetadata(metadataBytes);
///
/// // Decode events
/// final events = chainInfo.eventsCodec.decode(eventBytes);
///
/// // Decode extrinsics
/// final extrinsics = chainInfo.extrinsicsCodec.decode(extrinsicBytes);
///
/// // Access registry for custom operations
/// final customCodec = chainInfo.registry.codecFor(typeId);
/// ```
class ChainInfo {
  /// Core metadata type registry
  final MetadataTypeRegistry registry;

  /// Derived codec for decoding event records
  late final EventsRecordCodec eventsCodec;

  /// Derived codec for decoding extrinsics
  late final ExtrinsicsCodec extrinsicsCodec;

  /// Derived codec for encoding/decoding runtime calls
  late final RuntimeCallCodec callsCodec;

  /// Derived codec for accessing constants
  late final ConstantsCodec constantsCodec;

  ChainInfo(this.registry) {
    eventsCodec = EventsRecordCodec(registry);
    extrinsicsCodec = ExtrinsicsCodec(registry);
    callsCodec = RuntimeCallCodec(registry);
    constantsCodec = ConstantsCodec(registry);
  }

  /// Create ChainInfo from raw metadata bytes
  factory ChainInfo.fromMetadata(Uint8List metadataBytes) {
    final input = Input.fromBytes(metadataBytes);
    final prefixed = RuntimeMetadataPrefixed.codec.decode(input);
    return ChainInfo.fromRuntimeMetadataPrefixed(prefixed);
  }

  /// Create ChainInfo from the RuntimeMetadataPrefixed
  factory ChainInfo.fromRuntimeMetadataPrefixed(final RuntimeMetadataPrefixed prefixed) {
    final registry = MetadataTypeRegistry(prefixed);
    return ChainInfo(registry);
  }

  /// Get metadata version
  int get version => registry.version;

  /// Get all pallets
  List<PalletMetadata> get pallets => registry.pallets;

  /// Get pallet by name
  PalletMetadata? pallet(String name) => registry.palletByName(name);

  /// Convenience: Decode events from storage
  List<EventRecord> decodeEvents(Uint8List bytes) {
    return eventsCodec.decode(Input.fromBytes(bytes));
  }

  /// Convenience: Decode extrinsics from a block
  List<UncheckedExtrinsic> decodeExtrinsics(Uint8List bytes) {
    return extrinsicsCodec.decode(Input.fromBytes(bytes));
  }

  /// Convenience: Get constant value
  dynamic getConstant(String palletName, String constantName) {
    return registry.getConstantValue(palletName, constantName);
  }
}
