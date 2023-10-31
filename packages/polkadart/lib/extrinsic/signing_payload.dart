import 'dart:typed_data';

import 'package:convert/convert.dart';
import 'package:polkadart/extrinsic/signed_extensions/asset_hub.dart';
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
  final int? assetId; // ChargeAssetTxPayment

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
    this.assetId,
  });

  toEncodedMap() {
    return {
      'method': method,
      'specVersion': encodeHex(U32Codec.codec.encode(specVersion)),
      'transactionVersion':
          encodeHex(U32Codec.codec.encode(transactionVersion)),
      'genesisHash': genesisHash.replaceAll('0x', ''),
      'blockHash': blockHash.replaceAll('0x', ''),
      'era': Era.codec.encodeMortal(blockNumber, eraPeriod),
      'nonce': encodeHex(CompactCodec.codec.encode(nonce)),
      'assetId': assetId != null ? assetId!.toRadixString(16) : '',
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
      final payload = assetId != null
          ? AssetHubSignedExtensions.signedExtension(extension, toEncodedMap())
          : SubstrateSignedExtensions.signedExtension(
              extension, toEncodedMap());

      if (payload.isNotEmpty) {
        extras.add(payload);
      }
    });

    registry.getSignedExtensionExtra().forEach((extension) {
      final payload = assetId != null
          ? AssetHubSignedExtensions.additionalSignedExtension(
              extension, toEncodedMap())
          : SubstrateSignedExtensions.additionalSignedExtension(
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
