part of ink_cli;

class GasLimit {
  final BigInt refTime;
  final BigInt proofSize;

  const GasLimit({required this.refTime, required this.proofSize});

  static GasLimit from(final Map<String, dynamic> gasLimit) {
    if (gasLimit.containsKey('proof_size') && gasLimit.containsKey('ref_time')) {
      // We already have th result which we wanted.
      return GasLimit(
        proofSize: BigInt.parse(gasLimit['proof_size']),
        refTime: BigInt.parse(gasLimit['ref_time']),
      );
    }

    if (gasLimit.containsKey('proofSize') && gasLimit.containsKey('refTime')) {
      // Let's convert this converted result
      return GasLimit(
        proofSize: BigInt.parse(gasLimit['proofSize']),
        refTime: BigInt.parse(gasLimit['refTime']),
      );
    }
    throw Exception('Unable to create GasLimit from $gasLimit');
  }

  Map<String, BigInt> toMap() {
    return <String, BigInt>{
      'ref_time': refTime,
      'proof_size': proofSize,
    };
  }
}
