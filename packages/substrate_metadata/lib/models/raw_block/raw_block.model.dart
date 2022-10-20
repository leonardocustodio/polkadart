part of models;

class RpcBlockDigest {
  final List<String> logs;
  const RpcBlockDigest({required this.logs});

  static RpcBlockDigest fromMap(Map<String, dynamic> map) =>
      RpcBlockDigest(logs: (map['logs'] as List).cast<String>());
}

class RpcBlockHeader {
  final String number;
  final String parentHash;
  final RpcBlockDigest digest;
  const RpcBlockHeader(
      {required this.number, required this.parentHash, required this.digest});

  static RpcBlockHeader fromMap(Map<String, dynamic> map) => RpcBlockHeader(
      number: map['number'],
      parentHash: map['parentHash'],
      digest: RpcBlockDigest.fromMap(map['digest']));
}

abstract class RpcBlock {
  final RpcBlockHeader? header;
  final List<String> extrinsics;

  const RpcBlock({this.header, required this.extrinsics});
}

class RawBlock extends RpcBlock {
  final int blockNumber;
  const RawBlock(
      {required this.blockNumber,
      RpcBlockHeader? header,
      required List<String> extrinsics})
      : super(header: header, extrinsics: extrinsics);

  static RawBlock fromMap(Map<String, dynamic> map) => RawBlock(
        blockNumber: map['blockNumber'],
        header: map['header'] == null
            ? null
            : RpcBlockHeader.fromMap(map['header']),
        extrinsics: (map['extrinsics'] as List).cast<String>(),
      );
}
