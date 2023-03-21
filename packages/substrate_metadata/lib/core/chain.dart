import 'package:polkadart_scale_codec/polkadart_scale_codec.dart';
import 'package:substrate_metadata/core/metadata_decoder.dart';

import '../definitions/types_bundle.dart';
import '../exceptions/exceptions.dart';
import '../models/legacy_types.dart';
import '../models/models.dart';
import '../types/metadata_types.dart';
import '../utils/utils.dart';

class Chain {
  final LegacyTypesBundle? typesBundleDefinition;
  Chain([this.typesBundleDefinition]);

  ///
  /// To hold the parsed spec versions and metadata related information
  final _versionDescriptionMap = <int, VersionDescription>{};

  ///
  /// Returns `List<VersionDescription>`
  List<VersionDescription> get versioDescriptionList =>
      List<VersionDescription>.from(_versionDescriptionMap.values);

  ///
  /// Initialize the SpecVersions from a Json file path containing spec-versions
  ///
  /// After reading Spec Versions then it calls `addSpecVersion(spec)` with spec being the parsed Spec from file.
  void initSpecVersionFromFile(String filePath) {
    final list = readSpecVersionsFromFilePath(filePath);
    for (var spec in list) {
      addSpecVersion(spec);
    }
  }

  ///
  /// Returns the `VersionDescription` for the `blockNumber`
  ///
  /// If the `blockNumber` is not having any related `VersionDescription` then it returns `null`.
  VersionDescription? getVersionDescription(int blockNumber) {
    // List of block numbers
    final blockNumberList = _versionDescriptionMap.keys.toList(growable: false);

    int next = -1;
    for (var index = 0; index < blockNumberList.length; index++) {
      if (blockNumberList[index] >= blockNumber) {
        next = index;
        break;
      }
    }
    VersionDescription? vd;

    if (blockNumberList.isNotEmpty &&
        next != 0 &&
        next < blockNumberList.length) {
      // get the blocknumber from the index
      final int resultBlockNumber = next < 0
          ? blockNumberList[blockNumberList.length - 1]
          : blockNumberList[next - 1];

      vd = _versionDescriptionMap[resultBlockNumber];
    }
    return vd;
  }

  DecodedBlockExtrinsics decodeExtrinsics(
      RawBlockExtrinsics rawBlockExtrinsics) {
    final blockNumber = rawBlockExtrinsics.blockNumber;

    final VersionDescription? versionDescription =
        getVersionDescription(blockNumber);

    // Check if this is not empty, throw Exception if it is.
    if (versionDescription == null) {
      throw BlockNotFoundException(blockNumber);
    }
    assertion(blockNumber >= versionDescription.blockNumber);

    final List<Map<String, dynamic>> extrinsics = <Map<String, dynamic>>[];

    for (var extrinsic in rawBlockExtrinsics.extrinsics) {
      final extrinsicInput = Input.fromHex(extrinsic);
      final value = ExtrinsicsCodec(chainInfo: versionDescription.chainInfo)
          .decode(extrinsicInput);

      // Check if the extrinsic is fully consumed
      extrinsicInput.assertEndOfDataReached(' At block: $blockNumber');
      extrinsics.add(value);
    }

    return DecodedBlockExtrinsics(
        blockNumber: blockNumber, extrinsics: extrinsics);
  }

  RawBlockExtrinsics encodeExtrinsics(
      DecodedBlockExtrinsics decodedBlockExtrinsics) {
    final blockNumber = decodedBlockExtrinsics.blockNumber;

    final VersionDescription? versionDescription =
        getVersionDescription(blockNumber);

    // Check if this is not empty, throw Exception if it is.
    if (versionDescription == null) {
      throw BlockNotFoundException(blockNumber);
    }

    final List<String> encodedExtrinsicsHex =
        decodedBlockExtrinsics.extrinsics.map((extrinsic) {
      final output = HexOutput();
      ExtrinsicsCodec(chainInfo: versionDescription.chainInfo)
          .encodeTo(extrinsic, output);
      return output.toString();
    }).toList(growable: false);

    return RawBlockExtrinsics(
        blockNumber: blockNumber, extrinsics: encodedExtrinsicsHex);
  }

  DecodedBlockEvents decodeEvents(RawBlockEvents rawBlockEvents) {
    final blockNumber = rawBlockEvents.blockNumber;

    final VersionDescription? versionDescription =
        getVersionDescription(blockNumber);

    // Check if this is not empty, throw Exception if it is.
    if (versionDescription == null) {
      throw BlockNotFoundException(blockNumber);
    }

    assertion(blockNumber >= versionDescription.blockNumber);

    final input = Input.fromHex(rawBlockEvents.events);

    final List<dynamic> events =
        versionDescription.chainInfo.scaleCodec.decode('EventCodec', input);

    // Check if the event is fully consumed
    input.assertEndOfDataReached(' At block: $blockNumber');

    return DecodedBlockEvents(
      blockNumber: blockNumber,
      events: events,
    );
  }

  RawBlockEvents encodeEvents(DecodedBlockEvents decodedBlockEvents) {
    final blockNumber = decodedBlockEvents.blockNumber;

    final VersionDescription? versionDescription =
        getVersionDescription(blockNumber);

    // Check if this is not empty, throw Exception if it is.
    if (versionDescription == null) {
      throw BlockNotFoundException(blockNumber);
    }

    final output = HexOutput();

    versionDescription.chainInfo.scaleCodec
        .encodeTo('EventCodec', decodedBlockEvents.events, output);

    return RawBlockEvents(blockNumber: blockNumber, events: output.toString());
  }

  ///
  /// [SpecVersion]
  ///
  /// Processes the SpecVersion
  /// Creates VersionDescription from its Metadata and adds it to `_versionDescriptionList`
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

    final ChainInfo chainInfo = getChainInfoFromSpecVersion(specVersion);
    VersionDescription? versionDescription;
    versionDescription = VersionDescription(
      /// local to class params
      chainInfo: chainInfo,

      /// passing params for super-class i.e. SpecVersion
      metadata: specVersion.metadata,
      specName: specVersion.specName,
      specVersion: specVersion.specVersion,
      blockNumber: specVersion.blockNumber,
      blockHash: specVersion.blockHash,
    );

    _versionDescriptionMap[specVersion.blockNumber] = versionDescription;
  }

  ChainInfo getChainInfoFromSpecVersion(SpecVersion specVersion) {
    final DecodedMetadata decodedMetadata =
        MetadataDecoder.instance.decode(specVersion.metadata);

    LegacyTypes? types;

    // Pre checking helps to avoid extra computation for processing LegacyTypesBundle.
    if (decodedMetadata.isPreV14 && typesBundleDefinition != null) {
      types = getLegacyTypesFromBundle(
          typesBundleDefinition!, specVersion.specVersion);
    }

    final ChainInfo description =
        ChainInfo.fromMetadata(decodedMetadata, types);

    return description;
  }
}
