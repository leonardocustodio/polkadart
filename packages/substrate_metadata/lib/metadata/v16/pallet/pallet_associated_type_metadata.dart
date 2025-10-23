part of metadata;

/// Metadata for associated types from Config traits (new in V16)
class PalletAssociatedTypeMetadata {
  /// Name of the associated type
  final String name;

  /// Type ID
  final int type;

  /// Documentation
  final List<String> docs;

  const PalletAssociatedTypeMetadata({
    required this.name,
    required this.type,
    this.docs = const <String>[],
  });

  static const $PalletAssociatedTypeMetadata codec = $PalletAssociatedTypeMetadata._();

  Map<String, dynamic> toJson() => {
        'name': name,
        'type': type,
        'docs': docs,
      };
}

class $PalletAssociatedTypeMetadata with Codec<PalletAssociatedTypeMetadata> {
  const $PalletAssociatedTypeMetadata._();

  @override
  PalletAssociatedTypeMetadata decode(Input input) {
    final name = StrCodec.codec.decode(input);
    final type = CompactCodec.codec.decode(input);
    final docs = SequenceCodec(StrCodec.codec).decode(input);

    return PalletAssociatedTypeMetadata(
      name: name,
      type: type,
      docs: docs,
    );
  }

  @override
  void encodeTo(PalletAssociatedTypeMetadata value, Output output) {
    StrCodec.codec.encodeTo(value.name, output);
    CompactCodec.codec.encodeTo(value.type, output);
    SequenceCodec(StrCodec.codec).encodeTo(value.docs, output);
  }

  @override
  int sizeHint(PalletAssociatedTypeMetadata value) {
    var size = 0;
    size += StrCodec.codec.sizeHint(value.name);
    size += CompactCodec.codec.sizeHint(value.type);
    size += SequenceCodec(StrCodec.codec).sizeHint(value.docs);
    return size;
  }
}
