/// Spec Version Record holds the block and other info of the parachains.
class SpecVersionRecord {
  final String specName;
  final int specVersion;

  /// The height of the block where the given spec version was first introduced.
  final int blockNumber;

  ///The hash of the block where the given spec version was first introduced.
  final String blockHash;

  const SpecVersionRecord({
    required this.specName,
    required this.specVersion,
    required this.blockNumber,
    required this.blockHash,
  });

  static SpecVersionRecord fromJson(Map<String, dynamic> json) {
    return SpecVersionRecord(
      specName: json['specName'],
      specVersion: json['specVersion'],
      blockNumber: json['blockNumber'],
      blockHash: json['blockHash'],
    );
  }

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'specName': specName,
      'specVersion': specVersion,
      'blockNumber': blockNumber,
      'blockHash': blockHash,
    };
  }
}

/// `Spec Version` holds the metadata of the parachains with `Spec Version Record`.
class SpecVersion extends SpecVersionRecord {
  /// Chain metadata for this version of spec
  final String metadata;
  const SpecVersion({
    required this.metadata,
    required super.specName,
    required super.specVersion,
    required super.blockNumber,
    required super.blockHash,
  });

  static SpecVersion fromJson(Map<String, dynamic> json) {
    return SpecVersion(
      metadata: json['metadata'],
      specName: json['specName'],
      specVersion: json['specVersion'],
      blockNumber: json['blockNumber'],
      blockHash: json['blockHash'],
    );
  }

  @override
  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'metadata': metadata,
      'specName': specName,
      'specVersion': specVersion,
      'blockNumber': blockNumber,
      'blockHash': blockHash,
    };
  }
}
