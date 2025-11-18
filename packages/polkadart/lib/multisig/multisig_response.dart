part of multisig;

@JsonSerializable()
class MultisigResponse extends Equatable {
  final MultisigAccount multisigAccount;
  @Uint8ListConverter()
  final Uint8List callData;

  const MultisigResponse({required this.multisigAccount, required this.callData});

  Uint8List get callHash => Hasher.blake2b256.hash(callData);

  /// Create from JSON
  factory MultisigResponse.fromJson(final Map<String, dynamic> json) =>
      _$MultisigResponseFromJson(json);

  /// Convert to JSON
  Map<String, dynamic> toJson() => _$MultisigResponseToJson(this);

  Future<void> approveAsMulti({
    required final Provider provider,
    required final ChainInfo chainInfo,
    required final String approverAddress,
    required final SigningCallback approverSigningCallback,
    final int eraPeriod = 64,
    final BigInt? tip,
    final int? nonce,
    final Weight? maxWeight,
  }) async {
    return Multisig.approveAsMulti(
      provider: provider,
      chainInfo: chainInfo,
      multisigAccount: multisigAccount,
      approverAddress: approverAddress,
      approverSigningCallback: approverSigningCallback,
      callData: callData,
      eraPeriod: eraPeriod,
      nonce: nonce,
      maxWeight: maxWeight,
    );
  }

  @override
  List<Object> get props => [multisigAccount, callData];
}
