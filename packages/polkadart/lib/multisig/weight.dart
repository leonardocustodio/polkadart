part of multisig;

/// Represents the computational weight parameters for executing a blockchain call.
///
/// Weight is Substrate's mechanism for measuring and limiting the computational resources
/// required to execute extrinsics. It has two components:
/// - Reference Time: The actual computational time required
/// - Proof Size: The size of the proof data (Proof of Validity) for parachains
///
/// When submitting multisig approvals, you must specify the maximum weight the final
/// call execution might consume. This prevents unbounded execution and ensures fair
/// resource allocation on the blockchain.
///
/// Example:
/// ```dart
/// // Default weight (1 second execution, 10KB proof)
/// final weight = Weight(
///   refTime: BigInt.from(1000000000), // 1 second in picoseconds
///   proofSize: BigInt.from(10000),     // 10KB
/// );
///
/// // For heavy operations, increase the weight
/// final heavyWeight = Weight(
///   refTime: BigInt.from(2000000000), // 2 seconds
///   proofSize: BigInt.from(50000),     // 50KB
/// );
/// ```
class Weight extends Equatable {
  /// Reference time: the computational time required for execution.
  ///
  /// Measured in picoseconds (10^-12 seconds).
  /// For example, 1 second = 1,000,000,000,000 picoseconds.
  final BigInt refTime;

  /// Proof size: the size of the proof data required.
  ///
  /// Measured in bytes. This is particularly important for parachains
  /// where proof of validity (PoV) data must be posted to the relay chain.
  final BigInt proofSize;

  /// Creates a new Weight instance.
  ///
  /// Parameters:
  /// - [refTime]: Computational time in picoseconds
  /// - [proofSize]: Proof data size in bytes
  const Weight({required this.refTime, required this.proofSize});

  /// Converts to an encodable object for SCALE encoding.
  ///
  /// Returns:
  /// A [Map<String, BigInt>] with ref_time and proof_size keys.
  Map<String, BigInt> toEncodableObject() => {'ref_time': refTime, 'proof_size': proofSize};

  /// Converts this Weight to a JSON representation.
  ///
  /// BigInt values are converted to strings for JSON compatibility.
  ///
  /// Returns:
  /// A [Map<String, dynamic>] containing the ref_time and proof_size as strings.
  Map<String, dynamic> toJson() => {
    'ref_time': refTime.toString(),
    'proof_size': proofSize.toString(),
  };

  /// Creates a Weight from a JSON representation.
  ///
  /// Parameters:
  /// - [json]: The JSON map containing ref_time and proof_size as strings
  ///
  /// Returns:
  /// A [Weight] instance reconstructed from the JSON data.
  ///
  /// Throws:
  /// - [FormatException] if ref_time or proof_size cannot be parsed as BigInt
  factory Weight.fromJson(final Map<String, dynamic> json) {
    return Weight(
      refTime: BigInt.parse(json['ref_time']),
      proofSize: BigInt.parse(json['proof_size']),
    );
  }

  @override
  List<Object> get props => [refTime, proofSize];
}
