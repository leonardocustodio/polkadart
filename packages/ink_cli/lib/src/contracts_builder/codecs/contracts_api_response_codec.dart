part of ink_cli;

/// Codec for decoding ContractsApi Runtime API responses.
///
/// This codec handles the decoding of responses from ContractsApi runtime methods:
/// - `ContractsApi_instantiate` - dry-run contract instantiation
/// - `ContractsApi_call` - dry-run contract call
///
/// **Important**: This is different from `RuntimeCallCodec` which is for pallet call
/// arguments. Runtime API responses have different structures than pallet calls.
///
/// The codec supports both V15 and V14 metadata:
/// - **V15**: Uses runtime API metadata to find the output type ID
/// - **V14**: Uses hardcoded known type structures (runtime APIs not in V14 metadata)
///
/// Example:
/// ```dart
/// final codec = ContractsApiResponseCodec(chainInfo.registry);
/// final result = codec.decodeInstantiateResult(ByteInput.fromBytes(responseBytes));
/// ```
class ContractsApiResponseCodec {
  final MetadataTypeRegistry registry;

  /// Create a codec with access to the metadata registry
  const ContractsApiResponseCodec(this.registry);

  /// The metadata version (14 or 15)
  int get metadataVersion => registry.version;

  // ============================================================================
  // PUBLIC DECODING METHODS
  // ============================================================================

  /// Decode ContractsApi_instantiate response
  ///
  /// Returns a [ContractExecResult] containing:
  /// - gasConsumed: Weight consumed during execution
  /// - gasRequired: Weight required for execution
  /// - storageDeposit: Storage deposit required
  /// - debugMessage: Debug output from the contract
  /// - result: InstantiateReturnValue with contract address on success
  ContractExecResult decodeInstantiateResult(final Input input) {
    if (metadataVersion >= 15) {
      return _decodeInstantiateResultV15(input);
    } else {
      return _decodeInstantiateResultV14(input);
    }
  }

  /// Decode ContractsApi_call response
  ///
  /// Returns a [ContractExecResult] containing:
  /// - gasConsumed: Weight consumed during execution
  /// - gasRequired: Weight required for execution
  /// - storageDeposit: Storage deposit required
  /// - debugMessage: Debug output from the contract
  /// - result: ExecReturnValue with return data on success
  ContractExecResult decodeCallResult(final Input input) {
    if (metadataVersion >= 15) {
      return _decodeCallResultV15(input);
    } else {
      return _decodeCallResultV14(input);
    }
  }

  // ============================================================================
  // V15 IMPLEMENTATION - Uses Runtime API Metadata
  // ============================================================================

  ContractExecResult _decodeInstantiateResultV15(final Input input) {
    final json = _decodeUsingRuntimeApiCodec(
      apiName: 'ContractsApi',
      methodName: 'instantiate',
      input: input,
    );
    return ContractExecResult.fromJson(json);
  }

  ContractExecResult _decodeCallResultV15(final Input input) {
    final json = _decodeUsingRuntimeApiCodec(
      apiName: 'ContractsApi',
      methodName: 'call',
      input: input,
    );
    return ContractExecResult.fromJson(json);
  }

  /// Decode using the registry's runtime API output codec (V15)
  ///
  /// Uses `MetadataTypeRegistry.getRuntimeApiOutputCodec()` to get the codec
  /// for the method's output type, then decodes and converts to JSON.
  Map<String, dynamic> _decodeUsingRuntimeApiCodec({
    required final String apiName,
    required final String methodName,
    required final Input input,
  }) {
    // Get codec for the runtime API method's output type
    final codec = registry.getRuntimeApiOutputCodec(apiName, methodName);
    if (codec == null) {
      throw ContractsApiException(
        'Runtime API "$apiName.$methodName" not found in metadata. '
        'This chain may not support the ContractsApi or is using V14 metadata.',
      );
    }

    // Decode the response and convert to JSON format
    final decoded = codec.decode(input);
    return ToJson(decoded).toJson() as Map<String, dynamic>;
  }

  // ============================================================================
  // V14 IMPLEMENTATION - Uses Known Type Structures
  // ============================================================================

  /// Decode instantiate result for V14 metadata
  ///
  /// Since V14 doesn't have runtime API metadata, we use known type structures
  /// from pallet-contracts-primitives.
  ContractExecResult _decodeInstantiateResultV14(final Input input) {
    final codec = _buildContractResultCodec(isInstantiate: true);
    final decoded = codec.decode(input);
    return ContractExecResult.fromJson(ToJson(decoded).toJson() as Map<String, dynamic>);
  }

  /// Decode call result for V14 metadata
  ContractExecResult _decodeCallResultV14(final Input input) {
    final codec = _buildContractResultCodec(isInstantiate: false);
    final decoded = codec.decode(input);
    return ContractExecResult.fromJson(ToJson(decoded).toJson() as Map<String, dynamic>);
  }

  /// Build codec for `ContractResult<T>`
  Codec _buildContractResultCodec({required final bool isInstantiate}) {
    return CompositeCodec({
      'gasConsumed': _weightV2Codec(),
      'gasRequired': _weightV2Codec(),
      'StorageDeposit': _storageDepositCodec(),
      'debugMessage': SequenceCodec(U8Codec.codec),
      'result': isInstantiate
          ? _instantiateReturnValueResultCodec()
          : _execReturnValueResultCodec(),
    });
  }

  /// Weight V2 codec: `{ refTime: Compact<u64>, proofSize: Compact<u64> }`
  Codec _weightV2Codec() {
    // Try to find Weight from metadata
    final weightType = registry.typeByPath('sp_weights::weight_v2::Weight');
    if (weightType != null) {
      return registry.codecFor(weightType.id);
    }

    // Fallback to known WeightV2 structure
    return CompositeCodec({
      'refTime': CompactBigIntCodec.codec,
      'proofSize': CompactBigIntCodec.codec,
    });
  }

  /// StorageDeposit enum codec
  Codec _storageDepositCodec() {
    // Try to find from metadata first
    final sdType = registry.typeByPath('pallet_contracts::primitives::StorageDeposit');
    if (sdType != null) {
      return registry.codecFor(sdType.id);
    }

    // Fallback to known structure
    return ComplexEnumCodec.sparse({
      0: MapEntry('Refund', U128Codec.codec),
      1: MapEntry('Charge', U128Codec.codec),
    });
  }

  /// `Result<InstantiateReturnValueOk, DispatchError>` codec
  Codec _instantiateReturnValueResultCodec() {
    return ResultCodec(_instantiateReturnValueOkCodec(), _dispatchErrorCodec());
  }

  /// `Result<ExecReturnValue, DispatchError>` codec
  Codec _execReturnValueResultCodec() {
    return ResultCodec(_execReturnValueCodec(), _dispatchErrorCodec());
  }

  /// InstantiateReturnValueOk codec
  Codec _instantiateReturnValueOkCodec() {
    return CompositeCodec({'result': _execReturnValueCodec(), 'accountId': _accountIdCodec()});
  }

  /// ExecReturnValue codec
  Codec _execReturnValueCodec() {
    return CompositeCodec({'flags': U32Codec.codec, 'data': SequenceCodec(U8Codec.codec)});
  }

  /// AccountId codec for ContractsApi responses
  ///
  /// **Important**: ContractsApi always returns raw AccountId32 (32 bytes),
  /// NOT MultiAddress. The `registry.accountIdType` returns the address type
  /// used in extrinsics (often MultiAddress enum), which is different.
  ///
  /// We always use a 32-byte fixed array here since pallet-contracts
  /// returns `AccountId32` directly in `InstantiateReturnValue`.
  Codec _accountIdCodec() {
    // ContractsApi always returns raw AccountId32 (32 bytes)
    // Do NOT use registry.accountIdType as that's for extrinsic addresses (MultiAddress)
    return ArrayCodec(U8Codec.codec, 32);
  }

  /// DispatchError codec
  Codec _dispatchErrorCodec() {
    // Try to find DispatchError from metadata
    final dispatchErrorType = registry.typeByPath('sp_runtime::DispatchError');
    if (dispatchErrorType != null) {
      return registry.codecFor(dispatchErrorType.id);
    }

    // Try alternative paths
    final altPath = registry.typeByPath('DispatchError');
    if (altPath != null) {
      return registry.codecFor(altPath.id);
    }

    // Fallback: decode as opaque bytes
    // This is a safe fallback that won't fail decoding
    return _opaqueBytesCodec();
  }

  /// Opaque bytes codec for unknown types
  Codec _opaqueBytesCodec() {
    return SequenceCodec(U8Codec.codec);
  }
}

/// Exception thrown by ContractsApiResponseCodec operations
class ContractsApiException implements Exception {
  final String message;
  const ContractsApiException(this.message);

  @override
  String toString() => 'ContractsApiException: $message';
}
