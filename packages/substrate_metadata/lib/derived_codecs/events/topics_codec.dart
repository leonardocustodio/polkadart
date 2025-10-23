part of derived_codecs;

/// Codec for encoding and decoding event topics
///
/// Topics are hashes (typically H256/32 bytes) used for indexed event filtering.
/// They are stored as a Vec<[u8; 32]> in the EventRecord structure.
/// This codec uses SequenceCodec with U8ArrayCodec internally for proper SCALE encoding.
class TopicsCodec with Codec<List<String>> {
  /// Size of each topic hash in bytes (H256 = 32 bytes)
  static const int HASH_SIZE = 32;

  /// Internal codec for Vec<[u8; 32]>
  static const SequenceCodec<List<int>> _codec = SequenceCodec(U8ArrayCodec(HASH_SIZE));

  const TopicsCodec();

  /// Decode topics from input
  @override
  List<String> decode(Input input) {
    // Use SequenceCodec to decode Vec<[u8; 32]>
    final byteArrays = _codec.decode(input);

    // Convert each byte array to hex string
    return byteArrays.map((bytes) => '0x${hex.encode(bytes)}').toList();
  }

  /// Encode topics to output
  @override
  void encodeTo(List<String> value, Output output) {
    // Convert hex strings to byte arrays
    final byteArrays = value.map((hash) {
      // Remove '0x' prefix if present
      final cleanHash = hash.startsWith('0x') ? hash.substring(2) : hash;

      // Validate hash length
      if (cleanHash.length != HASH_SIZE * 2) {
        throw MetadataException(
            'Invalid hash length: expected ${HASH_SIZE * 2} hex characters, got ${cleanHash.length}');
      }

      // Validate hex characters
      if (!RegExp(r'^[0-9a-fA-F]+$').hasMatch(cleanHash)) {
        throw MetadataException('Invalid hash: contains non-hex characters');
      }

      // Convert to bytes
      return Uint8List.fromList(hex.decode(cleanHash));
    }).toList();

    // Use SequenceCodec to encode
    _codec.encodeTo(byteArrays, output);
  }

  /// Calculate size hint for topics
  @override
  int sizeHint(List<String> value) {
    final byteArrays = List.generate(value.length, (_) => Uint8List(HASH_SIZE));
    return _codec.sizeHint(byteArrays);
  }
}
