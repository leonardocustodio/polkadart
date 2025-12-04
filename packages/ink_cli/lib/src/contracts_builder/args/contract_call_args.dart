part of ink_cli;

class ContractCallArgs implements ContractArgs {
  final Uint8List address;
  final BigInt value;
  final GasLimit gasLimit;
  final BigInt? storageDepositLimit;
  final Uint8List data;

  const ContractCallArgs({
    required this.address,
    required this.value,
    required this.gasLimit,
    required this.storageDepositLimit,
    required this.data,
  });

  @override
  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'dest': MapEntry('Id', address.toList()),
      'value': value,
      'gas_limit': gasLimit.toMap(),
      'storage_deposit_limit': storageDepositLimit,
      'data': data,
    };
  }
}
