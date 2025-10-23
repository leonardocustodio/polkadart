part of extended_codecs;

/// Generic codec wrapper that adds length prefix to any codec
///
/// This is useful for types that are encoded as Compact<u32> + bytes
/// which is common in Substrate for variable-length items.
class LengthPrefixedCodec<T> with Codec<T> {
  final Codec<T> inner;

  const LengthPrefixedCodec(this.inner);

  @override
  T decode(final Input input) {
    final length = CompactCodec.codec.decode(input);
    final bytes = input.readBytes(length);
    return inner.decode(Input.fromBytes(bytes));
  }

  @override
  void encodeTo(final T value, final Output output) {
    // Encode to temporary buffer to get length
    final temp = ByteOutput();
    inner.encodeTo(value, temp);
    final bytes = temp.toBytes();

    // Write length prefix
    CompactCodec.codec.encodeTo(bytes.length, output);

    // Write the actual bytes
    output.write(bytes);
  }

  @override
  int sizeHint(final T value) {
    final innerSize = inner.sizeHint(value);
    return CompactCodec.codec.sizeHint(innerSize) + innerSize;
  }
}
