part of derived_codecs;

class ExtrinsicsCodec with Codec<List<UncheckedExtrinsic>> {
  final MetadataTypeRegistry registry;
  late final Codec<List<UncheckedExtrinsic>> _codec;

  ExtrinsicsCodec(this.registry) {
    _codec = SequenceCodec(LengthPrefixedCodec(UncheckedExtrinsicCodec(registry)));
  }

  @override
  List<UncheckedExtrinsic> decode(final Input input) => _codec.decode(input);

  @override
  void encodeTo(final List<UncheckedExtrinsic> value, final Output output) =>
      _codec.encodeTo(value, output);

  @override
  int sizeHint(final List<UncheckedExtrinsic> value) => _codec.sizeHint(value);
}
