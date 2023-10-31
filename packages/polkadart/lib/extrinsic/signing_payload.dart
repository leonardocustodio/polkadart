import 'dart:typed_data';

import 'package:convert/convert.dart';
import 'package:polkadart/extrinsic/signed_extensions/substrate.dart';
import 'package:polkadart/scale_codec.dart';
import 'package:polkadart/substrate/era.dart';

class SigningPayload {
  final String method; // Call
  final int specVersion; // CheckSpecVersion
  final int transactionVersion; // CheckTxVersion
  final String genesisHash; // CheckGenesis
  final String blockHash; // CheckMortality
  final int blockNumber;
  final int eraPeriod; // CheckMortality
  final int nonce; // CheckNonce
  final dynamic tip; // ChargeTransactionPayment

  const SigningPayload({
    required this.method,
    required this.specVersion,
    required this.transactionVersion,
    required this.genesisHash,
    required this.blockHash,
    required this.blockNumber,
    required this.eraPeriod,
    required this.nonce,
    required this.tip,
  });

  toEncodedMap() {
    return {
      'method': method,
      'specVersion': encodeHex(U32Codec.codec.encode(specVersion)),
      'transactionVersion':
          encodeHex(U32Codec.codec.encode(transactionVersion)),
      'genesisHash': genesisHash,
      'blockHash': blockHash,
      'era': Era.codec.encodeMortal(blockNumber, eraPeriod),
      'nonce': encodeHex(CompactCodec.codec.encode(nonce)),
      'tip': tip is int
          ? encodeHex(CompactCodec.codec.encode(tip))
          : encodeHex(CompactBigIntCodec.codec.encode(tip)),
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
          SubstrateSignedExtensions.signedExtension(extension, toEncodedMap());
      if (payload.isNotEmpty) {
        extras.add(payload);
      }
    });

    registry.getSignedExtensionExtra().forEach((extension) {
      final payload = SubstrateSignedExtensions.additionalSignedExtension(
          extension, toEncodedMap());
      if (payload.isNotEmpty) {
        additionalExtras.add(payload);
      }
    });

    final extra = extras.join();
    final addExtra = additionalExtras.join();
    final payload = method + extra + addExtra;

    return Uint8List.fromList(hex.decode(payload));
  }
}
