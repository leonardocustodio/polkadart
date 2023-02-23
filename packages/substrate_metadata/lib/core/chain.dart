import 'package:polkadart_scale_codec/io/io.dart';

import '../definitions/legacy_types_model.dart';
import '../models/models.dart';
import '../utils/utils.dart';
import 'metadata_decoder.dart';

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
  final _versionDescriptionList = <VersionDescription>[];

  ///
  /// Returns `List<VersionDescription>`
  List<VersionDescription> get versioDescriptionList =>
      List<VersionDescription>.from(_versionDescriptionList);

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
    final List<dynamic> result = _findVersionDescriptionIndex(blockNumber);
    if (result[0] == false || result[1] == 0) {
      return null;
    }
    final foundAtIndex = result[1];
    return _versionDescriptionList[foundAtIndex];
  }

  ///
  /// Insert the `VersionDescription` at the `blockNumber`
  void insertVersionDescription(int blockNumber, VersionDescription version) {
    final List<dynamic> result = _findVersionDescriptionIndex(blockNumber);
    _versionDescriptionList.insert(result[1], version);

    // temporary check. Remove this after testing
    {
      for (var i = 0; i < _versionDescriptionList.length - 1; i++) {
        if (_versionDescriptionList[i].blockNumber >
            _versionDescriptionList[i + 1].blockNumber) {
          throw Exception('VersionDescriptionList is not sorted');
        }
      }
    }
  }

  List<dynamic> _findVersionDescriptionIndex(int blockNumber) {
    final result = <dynamic>[]..length = 2;
    result[0] = false;
    result[1] = -1;

    int prev = -1;
    int next = _versionDescriptionList.length;
    int mid = (next / 2).floor();

    while (true) {
      if (_versionDescriptionList[mid].blockNumber == blockNumber) {
        // found at index mid
        return [true, mid];
      } else if (_versionDescriptionList[mid].blockNumber > blockNumber) {
        next = mid;
        mid = (prev + mid) ~/ 2;
      } else {
        prev = mid;
        mid = (mid + next) ~/ 2;
      }
      if (mid == prev) {
        // not found
        return [false, prev];
      }
      if (mid == next) {
        // not found
        return [false, next];
      }
    }
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
  VersionDescription addSpecVersion(SpecVersion specVersion) {
    VersionDescription? versionDescription =
        getVersionDescription(specVersion.blockNumber);
    if (versionDescription != null) {
      return versionDescription;
    }

    final chainInfo = getChainInfoFromSpecVersion(specVersion);

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

    // insert the version description at proper index according to blockNumber
    //
    // while inserting the merge sort is used to cut the time out and insert with divide and conquer approach
    // Why?
    // because the stays sorted accoring to blockNumber and we can use the approach of merge sort to find the nearest index for the blockNumber.
    insertVersionDescription(
        versionDescription.blockNumber, versionDescription);
    return versionDescription;
  }

  ///
  /// ## Create `ChainInfo` from `SpecVersion`
  ///
  /// Parses the SpecVersion and creates ChainInfo
  ///
  /// ```dart
  /// final specJson = {'specName': 'polkadot', 'specVersion':......};
  ///
  /// final specVersion = SpecVersion.fromJson(specJson);
  ///
  /// final chainInfo = chainObject.getChainInfoFromSpecVersion(specVersion);
  /// ```
  ChainInfo getChainInfoFromSpecVersion(SpecVersion specVersion) {
    final MetadataDecoder metadataDecoder = MetadataDecoder();

    final metadata = metadataDecoder.decodeFromHex(specVersion.metadata);

    final bool isPreV14 = ChainInfo.isPreV14(metadata);

    LegacyTypes? types;

    // Pre checking helps to avoid extra computation for processing LegacyTypesBundle.
    if (isPreV14 && typesBundleDefinition != null) {
      types = getLegacyTypesFromBundle(
          typesBundleDefinition!, specVersion.specVersion);
    }

    final ChainDescription description =
        ChainDescription.fromMetadata(metadata, types);

    return description;
  }
}
