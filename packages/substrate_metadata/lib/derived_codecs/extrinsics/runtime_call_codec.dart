part of derived_codecs;

/// Codec for RuntimeCall
class RuntimeCallCodec with Codec<RuntimeCall> {
  final MetadataTypeRegistry registry;

  RuntimeCallCodec(this.registry);

  @override
  RuntimeCall decode(final Input input) {
    final palletIndex = input.read();
    final pallet = registry.palletByIndex(palletIndex);

    if (pallet == null) {
      throw MetadataException('Pallet with index $palletIndex not found');
    }

    final calls = pallet.calls;
    if (calls == null) {
      throw MetadataException('Pallet ${pallet.name} has no calls');
    }

    // Read call index
    final callIndex = input.read();
    final callVariant = registry.getVariantByIndex(calls.type, callIndex);

    if (callVariant == null) {
      throw MetadataException(
          'Call with index $callIndex not found in pallet ${pallet.name}');
    }

    // Decode arguments
    final args = <String, dynamic>{};
    for (final field in callVariant.fields) {
      final codec = registry.codecFor(field.type);
      args[field.name ?? 'unnamed'] = codec.decode(input);
    }

    return RuntimeCall(
      palletName: pallet.name,
      palletIndex: palletIndex,
      callName: callVariant.name,
      callIndex: callIndex,
      args: args,
    );
  }

  @override
  void encodeTo(final RuntimeCall value, final Output output) {
    output.pushByte(value.palletIndex);
    output.pushByte(value.callIndex);

    // Find the call variant to encode arguments properly
    final pallet = registry.palletByIndex(value.palletIndex);
    if (pallet == null) {
      throw MetadataException(
          'Pallet with index ${value.palletIndex} not found');
    }

    final calls = pallet.calls;
    if (calls == null)
      throw MetadataException('Pallet ${pallet.name} has no calls');

    final callVariant = registry.getVariantByIndex(calls.type, value.callIndex);
    if (callVariant == null) {
      throw MetadataException('Call with index ${value.callIndex} not found');
    }

    // Encode arguments
    for (final field in callVariant.fields) {
      final fieldName = field.name ?? 'unnamed';
      final fieldValue = value.args[fieldName];

      if (fieldValue == null && field.typeName?.contains('Option<') != true) {
        throw MetadataException('Missing required argument: $fieldName');
      }

      // Check if the value is ScaleRawBytes - if so, write bytes directly
      if (fieldValue is ScaleRawBytes) {
        ScaleRawBytes.codec.encodeTo(fieldValue, output);
        continue;
      }

      final codec = registry.codecFor(field.type);
      codec.encodeTo(fieldValue, output);
    }
  }

  @override
  int sizeHint(final RuntimeCall value) {
    int size = 2; // Pallet index + call index

    // Find the call variant to calculate argument sizes
    final pallet = registry.palletByIndex(value.palletIndex);
    if (pallet == null) {
      throw MetadataException(
          'Pallet with index ${value.palletIndex} not found');
    }

    final calls = pallet.calls;
    if (calls == null) {
      throw MetadataException('Pallet ${pallet.name} has no calls');
    }

    final callVariant = registry.getVariantByIndex(calls.type, value.callIndex);
    if (callVariant == null) {
      throw MetadataException('Call with index ${value.callIndex} not found');
    }

    // Calculate size of arguments
    for (final field in callVariant.fields) {
      final fieldName = field.name ?? 'unnamed';
      final fieldValue = value.args[fieldName];

      if (fieldValue == null && field.typeName?.contains('Option<') != true) {
        throw MetadataException('Missing required argument: $fieldName');
      }

      // Check if the value is ScaleRawBytes - use its length directly
      if (fieldValue is ScaleRawBytes) {
        size += fieldValue.bytes.length;
        continue;
      }

      final codec = registry.codecFor(field.type);
      size += codec.sizeHint(fieldValue);
    }

    return size;
  }

  @override
  bool isSizeZero() {
    // This class directly encodes pallet index + call index
    return false;
  }
}
