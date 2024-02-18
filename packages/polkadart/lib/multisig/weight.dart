part of multisig;

class Weight {
  final BigInt refTime;
  final BigInt proofSize;

  const Weight({required this.refTime, required this.proofSize});

  Map<String, dynamic> toMap() {
    return {
      'ref_time': refTime,
      'proof_size': proofSize,
    };
  }
}
