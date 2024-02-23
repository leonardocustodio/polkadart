import 'dart:typed_data';

import 'package:convert/convert.dart';
import 'package:polkadart/extrinsic/signature_type.dart';
import 'package:polkadart/extrinsic/signed_extensions/signed_extensions_abstract.dart';
import 'package:polkadart/substrate/era.dart';
import 'package:polkadart_keyring/polkadart_keyring.dart' as keyring;
import 'package:polkadart_scale_codec/polkadart_scale_codec.dart';

import 'abstract_payload.dart';

class ExtrinsicPayload extends Payload {
  final Uint8List signer;
  final Uint8List signature;

  ///
  /// Create a new instance of [ExtrinsicPayload]
  ///
  /// For adding assetId or other custom signedExtensions to the payload, use [customSignedExtensions] with key 'assetId' with its mapped value.
  const ExtrinsicPayload({
    required this.signer,
    required super.method,
    required this.signature,
    required super.eraPeriod,
    required super.blockNumber,
    required super.nonce,
    required super.tip,
    super.customSignedExtensions,
  });

  @override
  Map<String, dynamic> toEncodedMap(dynamic registry) {
    return {
      'signer': signer,
      'method': method,
      'signature': signature,
      'era': eraPeriod == 0
          ? '00'
          : Era.codec.encodeMortal(blockNumber, eraPeriod),
      'nonce': encodeHex(CompactCodec.codec.encode(nonce)),
      /* 'assetId': maybeAssetIdEncoded(registry), */
      'tip': tip is int
          ? encodeHex(CompactCodec.codec.encode(tip))
          : encodeHex(CompactBigIntCodec.codec.encode(tip)),
    };
  }

  static ExtrinsicPayload fromPayload(
      Payload payload, Uint8List signer, Uint8List signature) {
    return ExtrinsicPayload(
      signer: signer,
      method: payload.method,
      signature: signature,
      eraPeriod: payload.eraPeriod,
      blockNumber: payload.blockNumber,
      nonce: payload.nonce,
      tip: payload.tip,
      customSignedExtensions: payload.customSignedExtensions,
    );
  }

  Uint8List encode(dynamic registry, SignatureType signatureType) {
    if (customSignedExtensions.isNotEmpty && registry is! Registry) {
      throw Exception(
          'Custom signed extensions are not supported on this registry. Please use registry from `runtimeMetadata.chainInfo.scaleCodec.registry`.');
    }
    final ByteOutput output = ByteOutput();

    final int extrinsicVersion = registry.extrinsicVersion;
    // Unsigned transaction
    final int preByte = extrinsicVersion & 127;
    // ignore: unused_local_variable
    final String inHex = preByte.toRadixString(16);

    // Signed transaction
    final int extraByte = extrinsicVersion | 128;

    output.pushByte(extraByte);

    if (signatureType != SignatureType.ecdsa) {
      // 00 = MultiAddress::Id
      output.pushByte(0);
    }

    // Push Signer Address
    output
      ..write(signer)
      // Push signature type byte
      ..pushByte(signatureType.type)
      // Push signature
      ..write(signature);

    late final SignedExtensions signedExtensions;

    final encodedMap = toEncodedMap(registry);

    if (usesChargeAssetTxPayment(registry)) {
      signedExtensions = SignedExtensions.assetHubSignedExtensions;
    } else {
      signedExtensions = SignedExtensions.substrateSignedExtensions;
    }

    late List<String> keys;
    {
      //
      //
      // Prepare keys for the encoding
      if (registry.getSignedExtensionTypes() is Map) {
        keys =
            (registry.getSignedExtensionTypes() as Map<String, Codec<dynamic>>)
                .keys
                .toList();
      } else {
        keys = (registry.getSignedExtensionTypes() as List<dynamic>)
            .cast<String>();
      }
    }

    for (final extension in keys) {
      final (payload, found) =
          signedExtensions.signedExtension(extension, encodedMap);
      if (found) {
        if (payload.isNotEmpty) {
          output.write(hex.decode(payload));
        }
      } else {
        if (registry.getSignedExtensionTypes() is List) {
          // This method call is from polkadot cli and not from the Reigstry of the polkadart_scale_codec.
          continue;
        }
        // Most probably, it is a custom signed extension.
        final signedExtensionMap = registry.getSignedExtensionTypes();

        // check if this signed extension is NullCodec or not!
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
              .encodeTo(customSignedExtensions[extension], output);
        }
      }
    }

    // Add the method call -> transfer.....
    output.write(method);

    return U8SequenceCodec.codec.encode(output.toBytes());
  }

  ///
  /// Encodes the payload and signs it with the supplied keypair
  /// [registry] The registry
  /// [signatureType] The signature type
  /// [keyPair] The keypair
  /// Returns [Uint8List] Signature
  ///
  Uint8List encodeAndSign(
      dynamic registry, SignatureType signatureType, keyring.KeyPair keyPair) {
    return keyPair.sign(encode(registry, signatureType));
  }
}
