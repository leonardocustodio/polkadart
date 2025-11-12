part of multisig;

/// Weight parameters for a call
class Weight extends Equatable {
  /// Computational time
  final BigInt refTime;

  /// Proof size for PoV
  final BigInt proofSize;

  const Weight({required this.refTime, required this.proofSize});

  Map<String, dynamic> toJson() => {
        'ref_time': refTime.toString(),
        'proof_size': proofSize.toString(),
      };

  factory Weight.fromJson(final Map<String, dynamic> json) {
    return Weight(
      refTime: BigInt.parse(json['ref_time']),
      proofSize: BigInt.parse(json['proof_size']),
    );
  }

  @override
  List<Object> get props => [refTime, proofSize];
}
