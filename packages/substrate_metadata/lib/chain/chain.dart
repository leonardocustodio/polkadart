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
  /// `typesBundleDefinition` == null and `specVersion.metadata` != V14, it throws UnsupportedMetadataException
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
  /// ## Decodes Extrinsic from RawBlock
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
    final blockNumber = rawBlock.blockNumber;

    final VersionDescription? versionDescription =
        getVersionDescription(rawBlock.blockNumber);

    // Check if this is not empty, throw Exception if it is.
    if (versionDescription == null) {
      throw BlockNotFoundException(blockNumber);
    }

    final List<dynamic> extrinsics = rawBlock.extrinsics.map((hex) {
      return Extrinsic.decodeExtrinsic(
          hex, versionDescription.description, versionDescription.codec);
    }).toList();

    return DecodedBlockExtrinsics(
        blockNumber: rawBlock.blockNumber, extrinsics: extrinsics);
  }

  ///
  /// ## Decodes Constants from `ChainDescription`
  ///
  /// ```dart
  /// final chainDefinitions = LegacyTypesBundle.fromJson(chainJson);
  ///
  /// final chain = Chain(chainDefinitions);
  ///
  /// // Preferred to provide all the available Spec-Version information.
  /// chain.initSpecVersionFromFile('../chain/versions.json');
  ///
  /// final chainDescription = chain.getChainDescriptionFromSpecVersion()
  ///
  /// final constants = chain.decodeConstants(chainDescription);
  /// ```
  Map<String, Map<String, dynamic>> decodeConstants(
      ChainDescription chainDescription) {
    final result = <String, Map<String, dynamic>>{};

    for (var pallet in chainDescription.constants.keys) {
      result[pallet] ??= <String, dynamic>{};

      for (var name in chainDescription.constants[pallet]!.keys) {
        final Constant? def = chainDescription.constants[pallet]![name];

        final decodedValue = scale_codec.Codec(chainDescription.types)
            .decode(def!.type, def.value);

        result[pallet]![name] = decodedValue;
      }
    }
    return result;
  }

  ///
  /// ## Encodes Extrinsic from DecodedBlockExtrinsics
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
  /// // rawBlock.hashCode == encodedExtrinsic.hashCode
  /// final encodedExtrinsic = chain.encodeExtrinsics(decodedExtrinsic);
  /// ```
  RawBlock encodeExtrinsics(DecodedBlockExtrinsics decodedBlock) {
    final blockNumber = decodedBlock.blockNumber;

    final VersionDescription? versionDescription =
        getVersionDescription(blockNumber);

    // Check if this is not empty, throw Exception if it is.
    if (versionDescription == null) {
      throw BlockNotFoundException(blockNumber);
    }

    final List<String> extrinsics = decodedBlock.extrinsics.map((extrinsic) {
      return scale_codec.encodeHex(Extrinsic.encodeExtrinsic(
          extrinsic, versionDescription.description, versionDescription.codec));
    }).toList();

    return RawBlock(blockNumber: blockNumber, extrinsics: extrinsics);
  }

  ///
  /// ## Decodes Events from RawBlockEvents
  ///
  /// ```dart
  /// final chainDefinitions = LegacyTypesBundle.fromJson(chainJson);
  ///
  /// final chain = Chain(chainDefinitions);
  ///
  /// // Preferred to provide all the available Spec-Version information.
  /// chain.initSpecVersionFromFile('../chain/versions.json');
  ///
  /// final rawBlockEvents = RawBlockEvents.fromJson( { blockJson } );
  ///
  /// final decodedEvents = chain.decodeEvents(rawBlockEvents);
  /// ```
  DecodedBlockEvents decodeEvents(RawBlockEvents rawBlockEvents) {
    final blockNumber = rawBlockEvents.blockNumber;

    final VersionDescription? versionDescription =
        getVersionDescription(blockNumber);

    // Check if this is not empty, throw Exception if it is.
    if (versionDescription == null) {
      throw BlockNotFoundException(blockNumber);
    }

    final events = versionDescription.codec.decode(
        versionDescription.description.eventRecordList, rawBlockEvents.events);
    return DecodedBlockEvents(blockNumber: blockNumber, events: events);
  }

  ///
  /// ## Decodes Events from RawBlockEvents
  ///
  /// ```dart
  /// final chainDefinitions = LegacyTypesBundle.fromJson(chainJson);
  ///
  /// final chain = Chain(chainDefinitions);
  ///
  /// // Preferred to provide all the available Spec-Version information.
  /// chain.initSpecVersionFromFile('../chain/versions.json');
  ///
  /// RawBlockEvents rawBlockEvents = RawBlockEvents.fromJson( { blockJson } );
  ///
  /// DecodedBlockEvents decodedEvents = chain.decodeEvents(rawBlockEvents);
  ///
  /// // rawBlockEvents.hashCode == encodedEvents.hashCode
  /// RawBlockEvents encodedEvents = chain.encodeEvents(decodedEvents);
  /// ```
  RawBlockEvents encodeEvents(DecodedBlockEvents decodedBlockEvents) {
    final int blockNumber = decodedBlockEvents.blockNumber;

    final VersionDescription? versionDescription =
        getVersionDescription(blockNumber);

    // Check if this is not empty, throw UnexpectedCaseException if it is.
    if (versionDescription == null) {
      throw BlockNotFoundException(blockNumber);
    }

    final String events = versionDescription.codec.encode(
        versionDescription.description.eventRecordList,
        decodedBlockEvents.events);
    return RawBlockEvents(blockNumber: blockNumber, events: events);
  }

  ///
  /// [SpecVersion]
  ///
  /// Processes the SpecVersion
  /// Creates VersionDescription from its Metadata and adds it to `_versionDescriptionMap`
  ///
  /// ```dart
  /// final specJson = {'specName': 'polkadot', 'specVersion':......};
  ///
  /// final specVersion = SpecVersion.fromJson(specJson);
  ///
  /// chainObject.addSpecVersion(specVersion);
  /// ```
  void addSpecVersion(SpecVersion specVersion) {
    if (_versionDescriptionMap[specVersion.blockNumber] != null) {
      return;
    }

    final chainDescription = getChainDescriptionFromSpecVersion(specVersion);

    final versionDescription = VersionDescription(
      /// local to class params
      description: chainDescription,
      codec: scale_codec.Codec(chainDescription.types),
      events: EventRegistry(chainDescription.types, chainDescription.event),
      calls: EventRegistry(chainDescription.types, chainDescription.call),

      /// passing params for super-class i.e. SpecVersion
      metadata: specVersion.metadata,
      specName: specVersion.specName,
      specVersion: specVersion.specVersion,
      blockNumber: specVersion.blockNumber,
      blockHash: specVersion.blockHash,
    );
    _versionDescriptionMap[versionDescription.blockNumber] = versionDescription;
  }

  ///
  /// ## Create `ChainDescription` from `SpecVersion`
  ///
  /// Parses the SpecVersion and creates Chain Description
  ///
  /// ```dart
  /// final specJson = {'specName': 'polkadot', 'specVersion':......};
  ///
  /// final specVersion = SpecVersion.fromJson(specJson);
  ///
  /// final chainDescription = chainObject.getChainDescriptionFromSpecVersion(specVersion);
  /// ```
  ChainDescription getChainDescriptionFromSpecVersion(SpecVersion specVersion) {
    final MetadataDecoder metadataDecoder = MetadataDecoder();

    final Metadata metadata =
        metadataDecoder.decodeAsMetadata(specVersion.metadata);
    final LegacyTypes? types = typesBundleDefinition != null
        ? getLegacyTypesFromBundle(
            typesBundleDefinition!, specVersion.specVersion)
        : null;
    final ChainDescription description =
        ChainDescription.getFromMetadata(metadata, types);

    return description;
  }
}
