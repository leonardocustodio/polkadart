part of metadata;

/// Metadata about a runtime API (V15)
///
/// Runtime APIs are interfaces exposed by the runtime that can be called
/// via the state_call RPC method. They provide versioned access to runtime
/// functionality.
class RuntimeApiMetadataV15 {
  /// Name of the runtime API
  ///
  /// Examples: "Core", "Metadata", "BlockBuilder", "TaggedTransactionQueue"
  final String name;

  /// List of methods in this API
  final List<RuntimeApiMethodMetadataV15> methods;

  /// Documentation for this API
  final List<String> docs;

  const RuntimeApiMetadataV15({
    required this.name,
    required this.methods,
    this.docs = const [],
  });

  /// Codec instance for RuntimeApiMetadataV15
  static const $RuntimeApiMetadataV15 codec = $RuntimeApiMetadataV15._();

  Map<String, dynamic> toJson() => {
        'name': name,
        'methods': methods.map((m) => m.toJson()).toList(),
        'docs': docs,
      };
}

/// Codec for RuntimeApiMetadataV15
class $RuntimeApiMetadataV15 with Codec<RuntimeApiMetadataV15> {
  const $RuntimeApiMetadataV15._();

  @override
  RuntimeApiMetadataV15 decode(Input input) {
    final name = StrCodec.codec.decode(input);
    final methods = SequenceCodec(RuntimeApiMethodMetadataV15.codec).decode(input);
    final docs = SequenceCodec(StrCodec.codec).decode(input);

    return RuntimeApiMetadataV15(
      name: name,
      methods: methods,
      docs: docs,
    );
  }

  @override
  void encodeTo(RuntimeApiMetadataV15 value, Output output) {
    StrCodec.codec.encodeTo(value.name, output);
    SequenceCodec(RuntimeApiMethodMetadataV15.codec).encodeTo(value.methods, output);
    SequenceCodec(StrCodec.codec).encodeTo(value.docs, output);
  }

  @override
  int sizeHint(RuntimeApiMetadataV15 value) {
    return StrCodec.codec.sizeHint(value.name) +
        SequenceCodec(RuntimeApiMethodMetadataV15.codec).sizeHint(value.methods) +
        SequenceCodec(StrCodec.codec).sizeHint(value.docs);
  }
}

/// Metadata about a runtime API method (V15)
///
/// Describes a single method within a runtime API.
class RuntimeApiMethodMetadataV15 {
  /// Name of the method
  final String name;

  /// Input parameters for this method
  final List<RuntimeApiMethodParamMetadataV15> inputs;

  /// Type ID of the return value
  final int output;

  /// Documentation for this method
  final List<String> docs;

  const RuntimeApiMethodMetadataV15({
    required this.name,
    required this.inputs,
    required this.output,
    this.docs = const [],
  });

  /// Codec instance for RuntimeApiMethodMetadataV15
  static const $RuntimeApiMethodMetadataV15 codec = $RuntimeApiMethodMetadataV15._();

  Map<String, dynamic> toJson() => {
        'name': name,
        'inputs': inputs,
        'output': output,
        'docs': docs,
      };
}

/// Codec for RuntimeApiMethodMetadataV15
class $RuntimeApiMethodMetadataV15 with Codec<RuntimeApiMethodMetadataV15> {
  const $RuntimeApiMethodMetadataV15._();

  @override
  RuntimeApiMethodMetadataV15 decode(Input input) {
    final name = StrCodec.codec.decode(input);
    final inputs = SequenceCodec(RuntimeApiMethodParamMetadataV15.codec).decode(input);
    final output = CompactCodec.codec.decode(input);
    final docs = SequenceCodec(StrCodec.codec).decode(input);

    return RuntimeApiMethodMetadataV15(
      name: name,
      inputs: inputs,
      output: output,
      docs: docs,
    );
  }

  @override
  void encodeTo(RuntimeApiMethodMetadataV15 value, Output output) {
    StrCodec.codec.encodeTo(value.name, output);
    SequenceCodec(RuntimeApiMethodParamMetadataV15.codec).encodeTo(value.inputs, output);
    CompactCodec.codec.encodeTo(value.output, output);
    SequenceCodec(StrCodec.codec).encodeTo(value.docs, output);
  }

  @override
  int sizeHint(RuntimeApiMethodMetadataV15 value) {
    return StrCodec.codec.sizeHint(value.name) +
        SequenceCodec(RuntimeApiMethodParamMetadataV15.codec).sizeHint(value.inputs) +
        CompactCodec.codec.sizeHint(value.output) +
        SequenceCodec(StrCodec.codec).sizeHint(value.docs);
  }
}

/// Metadata about a runtime API method parameter (V15)
///
/// Describes a single parameter of a runtime API method.
///
/// New in MetadataV15
class RuntimeApiMethodParamMetadataV15 {
  /// Name of the parameter
  final String name;

  /// Type ID of the parameter
  final int typeId;

  const RuntimeApiMethodParamMetadataV15({
    required this.name,
    required this.typeId,
  });

  /// Codec instance for RuntimeApiMethodParamMetadataV15
  static const $RuntimeApiMethodParamMetadataV15 codec = $RuntimeApiMethodParamMetadataV15._();

  Map<String, dynamic> toJson() => {
        'name': name,
        'typeId': typeId,
      };
}

/// Codec for RuntimeApiMethodParamMetadataV15
class $RuntimeApiMethodParamMetadataV15 with Codec<RuntimeApiMethodParamMetadataV15> {
  const $RuntimeApiMethodParamMetadataV15._();

  @override
  RuntimeApiMethodParamMetadataV15 decode(Input input) {
    final name = StrCodec.codec.decode(input);
    final typeId = CompactCodec.codec.decode(input);

    return RuntimeApiMethodParamMetadataV15(
      name: name,
      typeId: typeId,
    );
  }

  @override
  void encodeTo(RuntimeApiMethodParamMetadataV15 value, Output output) {
    StrCodec.codec.encodeTo(value.name, output);
    CompactCodec.codec.encodeTo(value.typeId, output);
  }

  @override
  int sizeHint(RuntimeApiMethodParamMetadataV15 value) {
    return StrCodec.codec.sizeHint(value.name) + CompactCodec.codec.sizeHint(value.typeId);
  }
}
