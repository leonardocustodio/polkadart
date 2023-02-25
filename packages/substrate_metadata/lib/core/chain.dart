import '../definitions/legacy_types_model.dart';
import '../models/models.dart';
import '../utils/utils.dart';

class Chain {
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
    if (_versionDescriptionList.isEmpty) {
      _versionDescriptionList.add(version);
      return;
    }
    final List<dynamic> result = _findVersionDescriptionIndex(blockNumber);
    _versionDescriptionList.insert(result[1], version);
  }

  ///
  /// Here we're doing a binary search to find the index of the VersionDescription
  /// which has the blockNumber less than the given blockNumber.
  ///
  /// If the blockNumber is not found then it returns VersionDescription of the next bigger index of the blockNumber.
  List<dynamic> _findVersionDescriptionIndex(int blockNumber) {
    if (versioDescriptionList.isEmpty) {
      return [false, -1];
    }
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
      if (mid == next || mid == prev) {
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
  void addSpecVersion(SpecVersion specVersion) {
    VersionDescription? versionDescription =
        getVersionDescription(specVersion.blockNumber);
    if (versionDescription != null) {
      return;
    }

    versionDescription = VersionDescription(
      /// local to class params

      /// passing params for super-class i.e. SpecVersion
      metadata: specVersion.metadata,
      specName: specVersion.specName,
      specVersion: specVersion.specVersion,
      blockNumber: specVersion.blockNumber,
      blockHash: specVersion.blockHash,
    );

    // insert the version description at proper index according to blockNumber
    //
    // while inserting the binary search is used to cut the time out and insert with divide and conquer approach.
    // Why?
    //
    // because the list stays sorted accoring to blockNumber and we can use the approach of binary search to find the nearest index for the blockNumber.
    insertVersionDescription(
        versionDescription.blockNumber, versionDescription);
  }
}
