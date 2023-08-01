import 'dart:typed_data';
import 'package:convert/convert.dart';
import 'package:polkadart/extrinsic/signed_extensions/substrate.dart';

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

  toMap() {
    return {
      'method': method,
      'specVersion': specVersion,
      'transactionVersion': transactionVersion,
      'genesisHash': genesisHash,
      'blockHash': blockHash,
      'era': era,
      'nonce': nonce,
      'tip': tip,
    };
  }

  static Uint8List createSigningPayload(SigningPayload signing, registry) {
    return signing.encode(registry);
  }

  Uint8List encode(dynamic registry) {
    final List extras = [];
    final List additionalExtras = [];

    registry.getSignedExtensionTypes().forEach((extension) {
      final payload =
          SubstrateSignedExtensions.signedExtensionPayload(extension, toMap());
      if (payload.isNotEmpty) {
        extras.add(payload);
      }
    });

    registry.getSignedExtensionExtra().forEach((extension) {
      final payload =
          SubstrateSignedExtensions.signedExtensionPayload(extension, toMap());
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