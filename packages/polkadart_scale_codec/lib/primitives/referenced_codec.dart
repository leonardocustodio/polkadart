part of primitives;

class ReferencedCodec with Codec<dynamic> {
  final String referencedType;
  final Registry registry;

  const ReferencedCodec({required this.referencedType, required this.registry});

  @override
  dynamic decode(Input input) {
    final codec = registry.getCodec(referencedType);
    assertion(codec != null, 'codec should not be null.');
    return codec!.decode(input);
  }

  @override
  void encodeTo(dynamic value, Output output) {
    final codec = registry.getCodec(referencedType);
    assertion(codec != null, 'codec should not be null.');
    codec!.encodeTo(value, output);
  }
}
