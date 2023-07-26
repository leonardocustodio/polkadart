import 'dart:typed_data';
import 'package:convert/convert.dart';

class SigningPayload {
  final String method; // Call
  final String specVersion; // CheckSpecVersion
  final String transactionVersion; // CheckTxVersion
  final String genesisHash; // CheckGenesis
  final String blockHash; // CheckMortality
  final String era; // CheckMortality
  final String nonce; // CheckNonce
  final String tip; // ChargeTransactionPayment

  const SigningPayload({
    required this.method,
    required this.specVersion,
    required this.transactionVersion,
    required this.genesisHash,
    required this.blockHash,
    required this.era,
    required this.nonce,
    required this.tip,
  });

  Uint8List encode(dynamic registry) {
    final List extras = [];
    final List additionalExtras = [];

    registry.getSignedExtensionTypes().forEach((extension) {
      if (extension == 'CheckSpecVersion') {
        extras.add(specVersion);
      }
      if (extension == 'CheckTxVersion') {
        extras.add(transactionVersion);
      }
      if (extension == 'CheckGenesis') {
        extras.add(genesisHash);
      }
      if (extension == 'CheckMortality') {
        extras.add(era);
      }
      if (extension == 'CheckNonce') {
        extras.add(nonce);
      }
      if (extension == 'ChargeTransactionPayment') {
        extras.add(tip);
      }
    });

    registry.getSignedExtensionExtra().forEach((extension) {
      if (extension == 'CheckSpecVersion') {
        additionalExtras.add(specVersion);
      }
      if (extension == 'CheckTxVersion') {
        additionalExtras.add(transactionVersion);
      }
      if (extension == 'CheckGenesis') {
        additionalExtras.add(genesisHash);
      }
      if (extension == 'CheckMortality') {
        additionalExtras.add(blockHash);
      }
      if (extension == 'CheckNonce') {
        additionalExtras.add(nonce);
      }
      if (extension == 'ChargeTransactionPayment') {
        additionalExtras.add(tip);
      }
    });

    print(extras);
    print(additionalExtras);

    final extra = extras.join();
    final addExtra = additionalExtras.join();
    final payload = method + extra + addExtra;

    return Uint8List.fromList(hex.decode(payload));
  }
}
