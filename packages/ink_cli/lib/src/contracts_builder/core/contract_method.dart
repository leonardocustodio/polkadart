part of ink_cli;

class ContractsMethod {
  final String method;
  final ContractArgs args;

  const ContractsMethod._(
    this.method,
    this.args,
  );

  static ContractsMethod methodCall({
    required final ContractArgs args,
  }) {
    return ContractsMethod._(
      'call',
      args,
    );
  }

  static ContractsMethod instantiateWithCode({
    required final ContractArgs args,
  }) {
    return ContractsMethod._(
      'instantiate_with_code',
      args,
    );
  }

  Uint8List encode(final scale_codec.Registry registry) {
    final contractArgument = MapEntry(
      'Contracts',
      MapEntry(method, args.toMap()),
    );

    final Uint8List result = registry.codecs['Call']!.encode(contractArgument);
    return result;
  }
}
