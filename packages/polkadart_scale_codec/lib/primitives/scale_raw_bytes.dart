part of primitives;

/// A wrapper for raw SCALE-encoded bytes that should be written as-is
/// during encoding, bypassing the normal encode/decode cycle.
///
/// This is useful when you already have SCALE-encoded bytes and want to
/// include them in a larger SCALE-encoded structure without decoding and
/// re-encoding them.
///
/// Example:
/// ```dart
/// // You have already-encoded call data
/// final callData = someCall.encode(); // Uint8List
///
/// // You want to wrap it in another call without decode/re-encode
/// final wrappedCall = RuntimeCall(
///   palletName: 'Multisig',
///   callName: 'as_multi',
///   args: {
///     'call': ScaleRawBytes(callData), // Use bytes directly
///     ...
///   },
/// );
/// ```
class ScaleRawBytes extends Equatable {
  /// The raw SCALE-encoded bytes
  final Uint8List bytes;

  /// Creates a wrapper for raw SCALE-encoded bytes
  const ScaleRawBytes(this.bytes);

  static const _$ScaleRawBytesCodec codec = _$ScaleRawBytesCodec._();

  @override
  List<Object> get props => [bytes];
}

/// Codec for ScaleRawBytes that writes the bytes directly without any encoding
class _$ScaleRawBytesCodec with Codec<ScaleRawBytes> {
  const _$ScaleRawBytesCodec._();

  @override
  void encodeTo(final ScaleRawBytes value, final Output output) {
    // Write the raw bytes directly without any encoding
    output.write(value.bytes);
  }

  @override
  ScaleRawBytes decode(final Input input) {
    throw UnimplementedError(
      'ScaleRawBytes.decode() is not supported. '
      'ScaleRawBytes is designed for encoding already-encoded data only. '
      'To decode, you must know the expected type and use the appropriate codec.',
    );
  }

  @override
  int sizeHint(final ScaleRawBytes value) {
    return value.bytes.length;
  }

  @override
  bool isSizeZero() {
    // Size depends on the actual bytes, not known statically
    return false;
  }
}
