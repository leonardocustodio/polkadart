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

  ///
  /// ApproveAsMulti
  ///
  /// It approves the multisig transaction and sends for further approval to other signatories.
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

  ///
  /// AsMulti
  ///
  /// It approves the multisig transaction and sends for further approval to other signatories.
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

  ///
  /// CancelAsMulti (Only the owner can cancel the multisig call.)
  ///
  /// It cancels the multisig transaction.
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
