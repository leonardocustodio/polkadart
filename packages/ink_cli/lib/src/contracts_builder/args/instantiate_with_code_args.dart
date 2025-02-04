part of ink_cli;

class InstantiateWithCodeArgs implements ContractArgs {
  final BigInt value;
  final GasLimit gasLimit;
  final Option storageDepositLimit;
  final Uint8List code;
  final Uint8List data;
  final Uint8List salt;

  const InstantiateWithCodeArgs({
    required this.value,
    required this.gasLimit,
    required this.storageDepositLimit,
    required this.code,
    required this.data,
    required this.salt,
  });

  @override
  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'value': value,
      'gas_limit': gasLimit.toMap(),
      'storage_deposit_limit': storageDepositLimit,
      'code': code,
      'data': data,
      'salt': salt,
    };
  }
}
