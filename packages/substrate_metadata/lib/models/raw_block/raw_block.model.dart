part of models;

class RpcBlockDigest implements Equatable {
  final List<String> logs;
  const RpcBlockDigest({required this.logs});

  static RpcBlockDigest fromJson(Map<String, dynamic> map) =>
      RpcBlockDigest(logs: (map['logs'] as List).cast<String>());

  @override
  List<Object?> get props => [logs];

  @override
  bool? get stringify => true;
}

class RpcBlockHeader implements Equatable {
  final String number;
  final String parentHash;
  final RpcBlockDigest digest;
  const RpcBlockHeader(
      {required this.number, required this.parentHash, required this.digest});

  static RpcBlockHeader fromJson(Map<String, dynamic> map) => RpcBlockHeader(
      number: map['number'],
      parentHash: map['parentHash'],
      digest: RpcBlockDigest.fromJson(map['digest']));

  @override
  List<Object?> get props => [number, parentHash, digest];

  @override
  bool? get stringify => true;
}

abstract class RpcBlock {
  final RpcBlockHeader? header;
  final List<String> extrinsics;

  const RpcBlock({this.header, required this.extrinsics});
}

class RawBlockExtrinsics extends RpcBlock implements Equatable {
  final int blockNumber;
  const RawBlockExtrinsics(
      {required this.blockNumber, super.header, required super.extrinsics});

  static RawBlockExtrinsics fromJson(Map<String, dynamic> map) =>
      RawBlockExtrinsics(
        blockNumber: map['blockNumber'],
        header: map['header'] == null
            ? null
            : RpcBlockHeader.fromJson(map['header']),
        extrinsics: (map['extrinsics'] as List).cast<String>(),
      );

  @override
  List<Object?> get props => [blockNumber, header, extrinsics];

  @override
  bool? get stringify => true;

  // read the blocks from filePath
  static List<RawBlockExtrinsics> readBlocksFromPath(String filePath) {
    return readLines(filePath)
        .map((dynamic map) => RawBlockExtrinsics.fromJson(map))
        .toList(growable: false);
  }
}
