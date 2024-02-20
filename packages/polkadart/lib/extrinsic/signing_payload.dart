import 'dart:typed_data';

import 'package:convert/convert.dart';
import 'package:polkadart/extrinsic/signed_extensions/signed_extensions_abstract.dart';
import 'package:polkadart/scale_codec.dart';
import 'package:polkadart/substrate/era.dart';

import '../polkadart.dart';
import 'abstract_payload.dart';

class SigningPayload extends Payload {
  final int specVersion; // CheckSpecVersion
  final int transactionVersion; // CheckTxVersion
  final String genesisHash; // CheckGenesis
  final String blockHash; // CheckMortality

  const SigningPayload({
    required super.method,
    required this.specVersion,
    required this.transactionVersion,
    required this.genesisHash,
    required this.blockHash,
    required super.blockNumber,
    required super.eraPeriod,
    required super.nonce,
    required super.tip,
    super.assetId,
  });

  @override
  toEncodedMap(dynamic registry) {
    return {
      'method': method,
      'specVersion': encodeHex(U32Codec.codec.encode(specVersion)),
      'transactionVersion':
          encodeHex(U32Codec.codec.encode(transactionVersion)),
      'genesisHash': genesisHash.replaceAll('0x', ''),
      'blockHash': blockHash.replaceAll('0x', ''),
      'era': eraPeriod == 0
          ? '00'
          : Era.codec.encodeMortal(blockNumber, eraPeriod),
      'nonce': encodeHex(CompactCodec.codec.encode(nonce)),
      'assetId': maybeAssetIdEncoded(registry),
      'tip': tip is int
          ? encodeHex(CompactCodec.codec.encode(tip))
          : encodeHex(CompactBigIntCodec.codec.encode(tip)),
    };
  }

  Uint8List encode(dynamic registry) {
    final ByteOutput tempOutput = ByteOutput();

    tempOutput.write(method);

    final ByteOutput output = ByteOutput();

    late final SignedExtensions signedExtensions;
    if (usesChargeAssetTxPayment(registry)) {
      signedExtensions = SignedExtensions.assetHubSignedExtensions;
    } else {
      signedExtensions = SignedExtensions.substrateSignedExtensions;
    }

    final encodedMap = toEncodedMap(registry);

    late List<String> typeKeys;
    if (registry.getSignedExtensionTypes() is Map) {
      // Usage here for the Registry from the polkadart_scale_codec
      typeKeys =
          (registry.getSignedExtensionTypes() as Map<String, Codec<dynamic>>)
              .keys
              .toList();
    } else {
      // Usage here for the generated lib from the polkadart_cli
      typeKeys =
          (registry.getSignedExtensionTypes() as List<dynamic>).cast<String>();
    }

    for (final extension in typeKeys) {
      final payload = signedExtensions.signedExtension(extension, encodedMap);

      if (payload.isNotEmpty) {
        tempOutput.write(hex.decode(payload));
      }
    }
    late List<String> extraKeys;
    if (registry.getSignedExtensionTypes() is Map) {
      // Usage here for the Registry from the polkadart_scale_codec
      extraKeys =
          (registry.getSignedExtensionTypes() as Map<String, Codec<dynamic>>)
              .keys
              .toList();
    } else {
      // Usage here for the generated lib from the polkadart_cli
      extraKeys =
          (registry.getSignedExtensionExtra() as List<dynamic>).cast<String>();
    }

    for (final extension in extraKeys) {
      final payload =
          signedExtensions.additionalSignedExtension(extension, encodedMap);

      if (payload.isNotEmpty) {
        tempOutput.write(hex.decode(payload));
      }
    }

    output.write(tempOutput.toBytes());
    final payloadEncoded = output.toBytes();

    // See rust code: https://github.com/paritytech/polkadot-sdk/blob/e349fc9ef8354eea1bafc1040c20d6fe3189e1ec/substrate/primitives/runtime/src/generic/unchecked_extrinsic.rs#L253
    return payloadEncoded.length > 256
        ? Blake2bHasher(32).hash(payloadEncoded)
        : payloadEncoded;
  }
}
