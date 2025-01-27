import 'dart:typed_data';
import 'package:polkadart/scale_codec.dart';

class ContractsBuilder {
  // args:
  // MultiSigMeta meta {meta contains -> specVersion, transactionVersion}
  // KeyPair ->    signer
  // Uint8List ->  method
  // tip
  // era
  // Provider
  //
  //
  //
  // variables:
  //
  //
  // genesisHash
  //
  // final nonce = await SystemApi(provider).accountNextIndex(signer.address);
}

class ContractsMethod {
  final String method;

  const ContractsMethod(this.method);

  static ContractsMethod instantiateWithCode =
      ContractsMethod('instantiate_with_code');

  Uint8List encode(final Registry registry, final Map<String, dynamic> args) {
    final contractArgument = MapEntry(
      'Contracts',
      MapEntry(method, args),
    );

    final Uint8List result = registry.codecs['Call']!.encode(contractArgument);
    return result;
  }
}
