part of models;

/// Block header information
class BlockHeader {
  final Uint8List hash;
  final int number;

  const BlockHeader({
    required this.hash,
    required this.number,
  });
}
