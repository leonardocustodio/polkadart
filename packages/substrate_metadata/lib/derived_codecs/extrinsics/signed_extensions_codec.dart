part of derived_codecs;

class SignedExtensionsCodec with Codec<Map<String, dynamic>> {
  final MetadataTypeRegistry registry;
  late final List<SignedExtensionMetadata> extensions;
  late final List<Codec> codecs;

  SignedExtensionsCodec(this.registry) {
    extensions = registry.extrinsic.signedExtensions;
    codecs = extensions.map((e) => registry.codecFor(e.type)).toList();
  }

  @override
  Map<String, dynamic> decode(final Input input) {
    final extra = <String, dynamic>{};
    for (int i = 0; i < extensions.length; i++) {
      extra[extensions[i].identifier] = codecs[i].decode(input);
    }
    return extra;
  }

  @override
  void encodeTo(Map<String, dynamic> value, Output output) {
    for (int i = 0; i < extensions.length; i++) {
      final key = extensions[i].identifier;
      final val = value[key];

      if (val == null) {
        if (codecs[i] is! NullCodec && codecs[i].isSizeZero() == false) {
          throw MetadataException('Missing signed extension value for $key.');
        }
        // We can continue to next because this codec doesn't encode anything.
        // And even calling encode would not have any impact on the size
        continue;
      }
      try {
        codecs[i].encodeTo(val, output);
      } catch (_) {
        print('exception here at key:$key, value:$value, codec=${codecs[i]}');
      }
    }
  }

  @override
  int sizeHint(Map<String, dynamic> value) {
    int size = 0;

    for (int i = 0; i < extensions.length; i++) {
      final key = extensions[i].identifier;
      final val = value[key];

      if (val == null) {
        throw MetadataException('Missing signed extension value for $key');
      }

      size += codecs[i].sizeHint(val);
    }

    return size;
  }

  @override
  bool isSizeZero() => codecs.every((codec) => codec.isSizeZero());
}
