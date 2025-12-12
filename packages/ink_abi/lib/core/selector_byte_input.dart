part of ink_abi;

/// Type alias for selector-to-index mapping
///
/// Maps 4-byte selectors (as hex strings with "0x" prefix) to their
/// corresponding index in the messages or constructors list.
typedef SelectorsMap = Map<String, int>;

/// Specialized ByteInput for decoding ink! contract input data
///
/// This class handles the selector-based decoding pattern used in ink! contracts.
/// Input data format: [4-byte selector][SCALE-encoded arguments]
///
/// The selector is extracted from the first 4 bytes, validated against a known
/// selector map, and the corresponding index is stored. On the first call to
/// [read()], this index is returned instead of reading from the buffer, allowing
/// the caller to identify which message/constructor is being invoked.
///
/// Subsequent reads proceed normally from byte 4 onwards to decode the arguments.
///
/// Example:
/// ```dart
/// // Input: "0x633aa55164000000" (selector + u32 argument)
/// final input = SelectorByteInput.fromHex(data, messageSelectors);
/// final index = input.read(); // Returns message index
/// final arg = U32Codec.codec.decode(input); // Returns 100
/// ```
class SelectorByteInput extends ByteInput {
  int? index;
  SelectorByteInput._(super.buffer);

  /// Create SelectorByteInput from hex-encoded data
  ///
  /// Extracts the 4-byte selector from [hex] and looks it up in [selectors].
  /// The remaining bytes (from position 4 onwards) become the read buffer.
  ///
  /// Throws [DecodingException] if:
  /// - The hex data is too short (< 4 bytes)
  /// - The selector is not found in the selectors map
  ///
  /// Parameters:
  /// - [hex]: Hex-encoded data including "0x" prefix (e.g., "0x633aa55164000000")
  /// - [selectors]: Map of known selectors to their indices
  static SelectorByteInput fromHex(final String hex, final SelectorsMap selectors) {
    try {
      final Uint8List buffer = decodeHex(hex);
      if (buffer.length < 4) {
        throw DecodingException.insufficientBytes(4, buffer.length);
      }

      final String selector = '0x${encodeHex(buffer.sublist(0, 4))}';
      final int? index = selectors[selector];
      if (index == null) {
        throw DecodingException.selectorNotFound(
          selector,
          selectors.isEmpty ? 'empty selector map' : 'available selectors',
        );
      }

      final SelectorByteInput selectorByteInput = SelectorByteInput._(buffer.sublist(4));
      selectorByteInput.index = index;
      return selectorByteInput;
    } catch (e) {
      if (e is DecodingException) {
        rethrow;
      }
      throw DecodingException('Failed to parse hex data: $e', context: {'hex': hex});
    }
  }

  /// Read a byte from the input
  ///
  /// On the first call, returns the index associated with the selector.
  /// Subsequent calls read normally from the buffer.
  @override
  int read() {
    if (index == null) {
      return super.read();
    } else {
      final int idx = index!;
      index = null;
      return idx;
    }
  }
}
