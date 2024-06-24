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

  ///
  /// Create a new instance of [SigningPayload]
  ///
  /// For adding assetId or other custom signedExtensions to the payload, use [customSignedExtensions] with key 'assetId' with its mapped value.
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
    super.customSignedExtensions,
  });

  @override
  Map<String, dynamic> toEncodedMap(dynamic registry) {
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
      /* 'assetId': maybeAssetIdEncoded(registry), */
      'tip': tip is int
          ? encodeHex(CompactCodec.codec.encode(tip))
          : encodeHex(CompactBigIntCodec.codec.encode(tip)),
      // This is for the `CheckMetadataHash` signed extension.
      // signing the metadata hash is not supported now, so
      // the set the enabled byte false with `mode: '00'`.
      'mode': '00',
      // This is for the `CheckMetadataHash` additional signed extensions.
      // Signing the metadata hash is not supported now, so we
      // sign the `Option<MetadataHash>::None` by setting it to '00'.
      'metadataHash': '00',
    };
  }

  Uint8List encode(dynamic registry) {
    if (customSignedExtensions.isNotEmpty && registry is! Registry) {
      throw Exception(
          'Custom signed extensions are not supported on this registry. Please use registry from `runtimeMetadata.chainInfo.scaleCodec.registry`.');
    }
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

    late List<String> signedExtensionKeys;

    //
    //
    // Do the keys preparation of signedExtensions
    {
      if (registry.getSignedExtensionTypes() is Map) {
        // Usage here for the Registry from the polkadart_scale_codec
        signedExtensionKeys =
            (registry.getSignedExtensionTypes() as Map<String, Codec<dynamic>>)
                .keys
                .toList();
      } else {
        // Usage here for the generated lib from the polkadart_cli
        signedExtensionKeys =
            (registry.getSignedExtensionTypes() as List<dynamic>)
                .cast<String>();
      }
    }

    //
    // Traverse through the signedExtension keys and encode the payload
    for (final extension in signedExtensionKeys) {
      final (payload, found) =
          signedExtensions.signedExtension(extension, encodedMap);
      if (found) {
        if (payload.isNotEmpty) {
          tempOutput.write(hex.decode(payload));
        }
      } else {
        if (registry.getSignedExtensionTypes() is List) {
          // This method call is from polkadot cli and not from the Reigstry of the polkadart_scale_codec.
          continue;
        }
        // Most probably, it is a custom signed extension.
        // check if this signed extension is NullCodec or not!
        final signedExtensionMap = registry.getSignedExtensionTypes();
        if (signedExtensionMap[extension] != null &&
            signedExtensionMap[extension] is! NullCodec &&
            signedExtensionMap[extension].hashCode !=
                NullCodec.codec.hashCode) {
          if (customSignedExtensions.containsKey(extension) == false) {
            // throw exception as this is encodable key and we need this key to be present in customSignedExtensions
            throw Exception(
                'Key `$extension` is missing in customSignedExtensions.');
          }
          signedExtensionMap[extension]
              .encodeTo(customSignedExtensions[extension], tempOutput);
        }
      }
    }

    late List<String> additionalSignedExtensionKeys;
    {
      //
      // Do the keys preparation of signedExtensions
      if (registry.getSignedExtensionTypes() is Map) {
        // Usage here for the Registry from the polkadart_scale_codec
        additionalSignedExtensionKeys =
            (registry.getAdditionalSignedExtensionTypes()
                    as Map<String, Codec<dynamic>>)
                .keys
                .toList();
      } else {
        // Usage here for the generated lib from the polkadart_cli
        additionalSignedExtensionKeys =
            (registry.getSignedExtensionExtra() as List<dynamic>)
                .cast<String>();
      }
    }

    //
    // Traverse through the additionalSignedExtension keys and encode the payload
    for (final extension in additionalSignedExtensionKeys) {
      final (payload, found) =
          signedExtensions.additionalSignedExtension(extension, encodedMap);
      if (found) {
        if (payload.isNotEmpty) {
          tempOutput.write(hex.decode(payload));
        }
      } else {
        // Most probably, it is a custom signed extension.
        // check if this signed extension is NullCodec or not!
        if (registry.getSignedExtensionTypes() is List) {
          // This method call is from polkadot cli and not from the Reigstry of the polkadart_scale_codec.
          continue;
        }
        final additionalSignedExtensionMap =
            registry.getAdditionalSignedExtensionTypes();
        if (additionalSignedExtensionMap[extension] != null &&
            additionalSignedExtensionMap[extension] is! NullCodec &&
            additionalSignedExtensionMap[extension].hashCode !=
                NullCodec.codec.hashCode) {
          if (customSignedExtensions.containsKey(extension) == false) {
            // throw exception as this is encodable key and we need this key to be present in customSignedExtensions
            throw Exception(
                'Key `$extension` is missing in customSignedExtensions.');
          }
          additionalSignedExtensionMap[extension]
              .encodeTo(customSignedExtensions[extension], tempOutput);
        }
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
