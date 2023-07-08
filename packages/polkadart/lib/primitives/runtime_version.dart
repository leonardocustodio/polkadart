part of primitives;

/// Runtime version.
/// This should not be thought of as classic Semver (major/minor/tiny).
/// This triplet have different semantics and mis-interpretation could cause problems.
/// In particular: bug fixes should result in an increment of `spec_version` and possibly
/// `authoring_version`, absolutely not `impl_version` since they change the semantics of the
/// runtime.
class RuntimeVersion {
  const RuntimeVersion({
    required this.specName,
    required this.implName,
    required this.authoringVersion,
    required this.specVersion,
    required this.implVersion,
    required this.apis,
    required this.transactionVersion,
    required this.stateVersion,
  });

  factory RuntimeVersion.decode(Input input) {
    return codec.decode(input);
  }

  factory RuntimeVersion.fromJson(Map<String, dynamic> json) {
    final apis = (json['apis'] as List)
        .map<ApiVersion>((json) => ApiVersion.fromJson(json))
        .toList();

    return RuntimeVersion(
      specName: json['specName'] as String,
      implName: json['implName'] as String,
      authoringVersion: json['authoringVersion'] as int,
      specVersion: json['specVersion'] as int,
      implVersion: json['implVersion'] as int,
      apis: apis,
      transactionVersion: json.containsKey('transactionVersion')
          ? json['transactionVersion']
          : 1,
      stateVersion: json.containsKey('stateVersion') ? json['stateVersion'] : 0,
    );
  }

  /// Identifies the different Substrate runtimes. There'll be at least polkadot and node.
  /// A different on-chain spec_name to that of the native runtime would normally result
  /// in node not attempting to sync or author blocks.
  final String specName;

  /// Name of the implementation of the spec. This is of little consequence for the node
  /// and serves only to differentiate code of different implementation teams. For this
  /// codebase, it will be parity-polkadot. If there were a non-Rust implementation of the
  /// Polkadot runtime (e.g. C++), then it would identify itself with an accordingly different
  /// `impl_name`.
  final String implName;

  /// `authoring_version` is the version of the authorship interface. An authoring node
  /// will not attempt to author blocks unless this is equal to its native runtime.
  final int authoringVersion;

  /// Version of the runtime specification. A full-node will not attempt to use its native
  /// runtime in substitute for the on-chain Wasm runtime unless all of `spec_name`,
  /// `spec_version` and `authoring_version` are the same between Wasm and native.
  final int specVersion;

  /// Version of the implementation of the specification. Nodes are free to ignore this; it
  /// serves only as an indication that the code is different; as long as the other two versions
  /// are the same then while the actual code may be different, it is nonetheless required to
  /// do the same thing.
  /// Non-consensus-breaking optimizations are about the only changes that could be made which
  /// would result in only the `impl_version` changing.
  final int implVersion;

  /// List of supported API "features" along with their versions.
  final List<ApiVersion> apis;

  /// All existing dispatches are fully compatible when this number doesn't change. If this
  /// number changes, then `spec_version` must change, also.
  ///
  /// This number must change when an existing dispatchable (module ID, dispatch ID) is changed,
  /// either through an alteration in its user-level semantics, a parameter
  /// added/removed/changed, a dispatchable being removed, a module being removed, or a
  /// dispatchable/module changing its index.
  ///
  /// It need *not* change when a new module is added or when a dispatchable is added.
  final int transactionVersion;

  /// Version of the state implementation used by this runtime.
  /// Use of an incorrect version is consensus breaking.
  final int stateVersion;

  // RuntimeVersion scale codec
  static const Codec<RuntimeVersion> codec = $RuntimeVersionCodec();

  Uint8List encode() {
    return codec.encode(this);
  }

  Map<String, dynamic> toJson() => {
        'specName': specName,
        'implName': implName,
        'authoringVersion': authoringVersion,
        'specVersion': specVersion,
        'implVersion': implVersion,
        'apis': apis.map((value) => value.toJson()).toList(),
        'transactionVersion': transactionVersion,
        'stateVersion': stateVersion,
      };

  @override
  bool operator ==(Object other) =>
      other is RuntimeVersion &&
      other.runtimeType == runtimeType &&
      other.specName == specName &&
      other.implName == implName &&
      other.authoringVersion == authoringVersion &&
      other.specVersion == specVersion &&
      other.implName == implName &&
      other.apis.length == apis.length &&
      other.apis == apis &&
      other.transactionVersion == transactionVersion &&
      other.stateVersion == stateVersion;

  @override
  int get hashCode => Object.hash(specName, implName, authoringVersion,
      specVersion, implName, apis, transactionVersion, stateVersion);
}

class $RuntimeVersionCodec with Codec<RuntimeVersion> {
  const $RuntimeVersionCodec();

  static final BigInt coreId =
      U64Codec.codec.decode(ByteInput(Hasher.blake2b64.hashString('Core')));

  /// There exists multiple versions of [`RuntimeVersion`] and they are versioned using the `Core`
  /// runtime api:
  /// - `Core` version < 3 is a runtime version without a transaction version and state version.
  /// - `Core` version 3 is a runtime version without a state version.
  /// - `Core` version 4 is the latest runtime version.
  int? coreVersionFromApis(List<ApiVersion> apis) {
    apis = apis.where((api) => api.id == coreId).toList();
    return apis.isNotEmpty ? apis.first.version : null;
  }

  @override
  void encodeTo(
    RuntimeVersion value,
    Output output,
  ) {
    StrCodec.codec.encodeTo(
      value.specName,
      output,
    );
    StrCodec.codec.encodeTo(
      value.implName,
      output,
    );
    U32Codec.codec.encodeTo(
      value.authoringVersion,
      output,
    );
    U32Codec.codec.encodeTo(
      value.specVersion,
      output,
    );
    U32Codec.codec.encodeTo(
      value.implVersion,
      output,
    );
    const SequenceCodec<ApiVersion>(ApiVersion.codec).encodeTo(
      value.apis,
      output,
    );

    // - `Core` version < 3 is a runtime version without a transaction version and state version.
    // - `Core` version 3 is a runtime version without a state version.
    // - `Core` version 4 is the latest runtime version.
    final int? coreVersion = coreVersionFromApis(value.apis);

    if (coreVersion == null || coreVersion >= 3) {
      U32Codec.codec.encodeTo(
        value.transactionVersion,
        output,
      );
    }

    if (coreVersion == null || coreVersion >= 4) {
      U8Codec.codec.encodeTo(
        value.stateVersion,
        output,
      );
    }
  }

  @override
  RuntimeVersion decode(Input input) {
    final specName = StrCodec.codec.decode(input);
    final implName = StrCodec.codec.decode(input);
    final authoringVersion = U32Codec.codec.decode(input);
    final specVersion = U32Codec.codec.decode(input);
    final implVersion = U32Codec.codec.decode(input);
    final apis =
        const SequenceCodec<ApiVersion>(ApiVersion.codec).decode(input);

    // - `Core` version < 3 is a runtime version without a transaction version and state version.
    // - `Core` version 3 is a runtime version without a state version.
    // - `Core` version 4 is the latest runtime version.
    final int? coreVersion = coreVersionFromApis(apis);
    final int transactionVersion = coreVersion == null || coreVersion >= 3
        ? U32Codec.codec.decode(input)
        : 1;
    final int stateVersion = coreVersion == null || coreVersion >= 4
        ? U8Codec.codec.decode(input)
        : 0;

    return RuntimeVersion(
      specName: specName,
      implName: implName,
      authoringVersion: authoringVersion,
      specVersion: specVersion,
      implVersion: implVersion,
      apis: apis,
      transactionVersion: transactionVersion,
      stateVersion: stateVersion,
    );
  }

  @override
  int sizeHint(RuntimeVersion value) {
    int size = 0;
    size += StrCodec.codec.sizeHint(value.specName);
    size += StrCodec.codec.sizeHint(value.implName);
    size += U32Codec.codec.sizeHint(value.authoringVersion);
    size += U32Codec.codec.sizeHint(value.specVersion);
    size += U32Codec.codec.sizeHint(value.implVersion);
    size +=
        const SequenceCodec<ApiVersion>(ApiVersion.codec).sizeHint(value.apis);

    // - `Core` version < 3 is a runtime version without a transaction version and state version.
    // - `Core` version 3 is a runtime version without a state version.
    // - `Core` version 4 is the latest runtime version.
    final int? coreVersion = coreVersionFromApis(value.apis);
    if (coreVersion == null || coreVersion >= 3) {
      size += U32Codec.codec.sizeHint(value.transactionVersion);
    }
    if (coreVersion == null || coreVersion >= 4) {
      size += U8Codec.codec.sizeHint(value.stateVersion);
    }
    return size;
  }
}
