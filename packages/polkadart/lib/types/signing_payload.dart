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

  static Uint8List createSigningPayload(SigningPayload signing, registry) {
    return signing.encode(registry);
  }

  String signedExtensionPayload(String extension) {
    switch (extension) {
      case 'CheckSpecVersion':
        return specVersion;
      case 'CheckTxVersion':
        return transactionVersion;
      case 'CheckGenesis':
        return genesisHash;
      case 'CheckMortality':
        return era;
      case 'CheckNonce':
        return nonce;
      case 'ChargeTransactionPayment':
        return tip;
      default:
        return '';
    }
  }

  Uint8List encode(dynamic registry) {
    final List extras = [];
    final List additionalExtras = [];

    registry.getSignedExtensionTypes().forEach((extension) {
      final payload = signedExtensionPayload(extension);
      if (payload.isNotEmpty) {
        extras.add(payload);
      }
    });

    registry.getSignedExtensionExtra().forEach((extension) {
      final payload = signedExtensionPayload(extension);
      if (payload.isNotEmpty) {
        extras.add(payload);
      }
    });

    final extra = extras.join();
    final addExtra = additionalExtras.join();
    final payload = method + extra + addExtra;

    return Uint8List.fromList(hex.decode(payload));
  }
}
