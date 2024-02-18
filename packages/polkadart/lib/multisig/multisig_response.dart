part of multisig;

class MultisigResponse {
  final String callData;
  final String callHash;
  final int threshold;
  final List<String> allSignatories;

  MultisigResponse({
    required this.callData,
    required this.callHash,
    required this.threshold,
    required this.allSignatories,
  });

  Map<String, dynamic> toJson() {
    return {
      'callData': callData,
      'callHash': callHash,
      'threshold': threshold,
      'allSignatories': allSignatories,
    };
  }

  factory MultisigResponse.fromJson(Map<String, dynamic> json) {
    return MultisigResponse(
      callData: json['callData'],
      callHash: json['callHash'],
      threshold: json['threshold'],
      allSignatories: json['allSignatories'].cast<String>(),
    );
  }

  Uint8List get multisigBytes {
    return Signatories.fromAddresses(allSignatories, threshold).mutiSigBytes;
  }

  Future<bool> approveAsMulti(
    Provider provider,
    KeyPair keyPair, {
    Duration storageKeyDelay = const Duration(seconds: 25),
  }) async {
    return await Multisig.approveAsMulti(
      multisigResponse: this,
      provider: provider,
      signer: keyPair,
      storageKeyDelay: storageKeyDelay,
    );
  }

  Future<bool>? asMulti(
    Provider provider,
    KeyPair keyPair, {
    Duration storageKeyDelay = const Duration(seconds: 20),
  }) async {
    return await Multisig.asMulti(
      multisigResponse: this,
      provider: provider,
      signer: keyPair,
      storageKeyDelay: storageKeyDelay,
    );
  }

  Future<bool> cancelAsMulti(
    Provider provider,
    KeyPair keyPair, {
    Duration storageKeyDelay = const Duration(seconds: 20),
  }) async {
    return await Multisig.cancelAsMulti(
      multisigResponse: this,
      provider: provider,
      signer: keyPair,
      storageKeyDelay: storageKeyDelay,
    );
  }
}
