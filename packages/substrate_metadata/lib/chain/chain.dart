import 'package:substrate_metadata/chain_description/chain_description.model.dart';
import 'package:substrate_metadata/event_registry.dart';
import 'package:substrate_metadata/exceptions/exceptions.dart';
import 'package:substrate_metadata/extrinsic.dart';
import 'package:substrate_metadata/metadata_decoder.dart';
import 'package:substrate_metadata/models/models.dart';
import 'package:substrate_metadata/old/types_bundle.dart';
import 'package:substrate_metadata/old/legacy_types_model.dart';
import 'package:substrate_metadata/spec_version/spec_version.model.dart';
import 'package:substrate_metadata/utils/spec_version_maker.dart';
import 'package:polkadart_scale_codec/polkadart_scale_codec.dart'
    as scale_codec;

class Chain {
  ///
  /// Chain([LegacyTypesBundle? typesBundleDefinition])
  ///
  /// When:
  /// `typesBundleDefinition` == null and `specVersion.metadata` == V14, it throws UnsupportedMetadataException
  ///
  /// ```dart
  /// final typesBundleDefinition = LegacyTypesBundle.fromJson(chainDefinitionJson);
  ///
  /// final chain = Chain(typesBundleDefinition);
  ///
  /// ```
  Chain([this.typesBundleDefinition]);

  ///
  /// Type Definition of the chain
  ///
  /// ```dart
  /// final typeBundleDefinition = LegacyTypeDefinition.fromJson(chainDefinitionJson);
  /// ```
  final LegacyTypesBundle? typesBundleDefinition;

  ///
  /// To hold the parsed spec versions and metadata related information
  final _versionDescriptionMap = <int, VersionDescription>{};

  ///
  /// Initialize the SpecVersions from a Json file path containing spec-versions
  ///
  /// After reading Spec Versions then it calls `addSpecVersion(spec)` with spec being the parsed Spec from file.
  void initSpecVersionFromFile(String filePath) {
    for (var spec in readSpecVersionsFromFilePath(filePath)) {
      addSpecVersion(spec);
    }
  }

  ///
  /// Returns the `VersionDescription` for the `blockNumber`
  ///
  /// If the `blockNumber` is not having any related `VersionDescription` then it returns `null`.
  VersionDescription? getVersionDescription(int blockNumber) {
    return _versionDescriptionMap[blockNumber];
  }

  ///
  /// Decodes Extrinsic from RawBlock
  ///
  /// ```dart
  /// final chainDefinitions = LegacyTypesBundle.fromJson(chainJson);
  ///
  /// final chain = Chain(chainDefinitions);
  ///
  /// // Preferred to provide all the available Spec-Version information.
  /// chain.initSpecVersionFromFile('../chain/versions.json');
  ///
  /// final rawBlock = RawBlock.fromJson( { blockJson } );
  ///
  /// final decodedExtrinsic = chain.decodeExtrinsics(rawBlock);
  /// ```
  DecodedBlockExtrinsics decodeExtrinsics(RawBlock rawBlock) {
    final VersionDescription? versionDescription =
        getVersionDescription(rawBlock.blockNumber);

    // Check if this is not empty, throw Exception if it is.
    if (versionDescription == null) {
      throw UnexpectedCaseException(
          'Metadata not found for block: ${rawBlock.blockNumber}.');
    }

    final List<dynamic> extrinsics = rawBlock.extrinsics.map((hex) {
      return Extrinsic.decodeExtrinsic(
          hex, versionDescription.description, versionDescription.codec);
    }).toList();

    return DecodedBlockExtrinsics(
        blockNumber: rawBlock.blockNumber, extrinsics: extrinsics);
  }

  ///
  /// ```dart
  /// final chainDefinitions = LegacyTypesBundle.fromJson(chainJson);
  ///
  /// final chain = Chain(chainDefinitions);
  ///
  /// // Preferred to provide all the available Spec-Version information.
  /// chain.initSpecVersionFromFile('../chain/versions.json');
  ///
  /// final rawBlock = RawBlock.fromJson( { blockJson } );
  ///
  /// final decodedExtrinsic = chain.decodeExtrinsics(rawBlock);
  ///
  /// final encodedExtrinsic = chain.encodeExtrinsics(decodedExtrinsic);
  /// print(rawBlock == encodedExtrinsic);
  /// ```
  RawBlock encodeExtrinsics(DecodedBlockExtrinsics decodedBlockExtrinsics) {
    final blockNumber = decodedBlockExtrinsics.blockNumber;

    final VersionDescription? versionDescription =
        getVersionDescription(blockNumber);

    // Check if this is not empty, throw Exception if it is.
    if (versionDescription == null) {
      throw UnexpectedCaseException(
          'Metadata not found for block: $blockNumber.');
    }

    final List<String> extrinsics =
        decodedBlockExtrinsics.extrinsics.map((extrinsic) {
      return scale_codec.encodeHex(Extrinsic.encodeExtrinsic(
          extrinsic, versionDescription.description, versionDescription.codec));
    }).toList();

    return RawBlock(blockNumber: blockNumber, extrinsics: extrinsics);
  }

  ///
  /// [SpecVersion]
  ///
  /// Processes the SpecVersion
  /// Creates VersionDescription from its Metadata and adds it to `_versionDescriptionMap`
  void addSpecVersion(SpecVersion specVersion) {
    if (_versionDescriptionMap[specVersion.blockNumber] != null) {
      return;
    }

    final MetadataDecoder metadataDecoder = MetadataDecoder();

    final Metadata metadata =
        metadataDecoder.decodeAsMetadata(specVersion.metadata);
    final LegacyTypes? types = typesBundleDefinition != null
        ? getLegacyTypesFromBundle(
            typesBundleDefinition!, specVersion.specVersion)
        : null;
    final ChainDescription description =
        ChainDescription.getFromMetadata(metadata, types);

    final versionDescription = VersionDescription(
      /// local to class params
      description: description,
      codec: scale_codec.Codec(description.types),
      events: EventRegistry(description.types, description.event),
      calls: EventRegistry(description.types, description.call),

      /// passing params for super-class i.e. SpecVersion
      metadata: specVersion.metadata,
      specName: specVersion.specName,
      specVersion: specVersion.specVersion,
      blockNumber: specVersion.blockNumber,
      blockHash: specVersion.blockHash,
    );
    _versionDescriptionMap[versionDescription.blockNumber] = versionDescription;
  }
}
