import 'dart:typed_data';

import 'package:convert/convert.dart';
import 'package:polkadart/extrinsic/signature_type.dart';
import 'package:polkadart/extrinsic/signed_extensions/signed_extensions_abstract.dart';
import 'package:polkadart_keyring/polkadart_keyring.dart' as keyring;
import 'package:polkadart_scale_codec/primitives/primitives.dart';
import 'package:polkadart_scale_codec/utils/utils.dart';

import '../substrate/era.dart';

class Extrinsic {
  final String signer;
  final String method;
  final String signature;
  final int eraPeriod;
  final int blockNumber;
  final int nonce;
  final dynamic tip;
  final int? assetId;

  const Extrinsic({
    required this.signer,
    required this.method,
    required this.signature,
    required this.eraPeriod,
    required this.blockNumber,
    required this.nonce,
    required this.tip,
    this.assetId,
  });

  toEncodedMap(dynamic registry) {
    return {
      'signer': signer,
      'method': method,
      'signature': signature,
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

  static Uint8List createSignedExtrinsic(
      Extrinsic extrinsic, registry, SignatureType signatureType) {
    return extrinsic.encode(registry, signatureType);
  }

  Uint8List encode(dynamic registry, SignatureType signatureType) {
    final int extrinsicVersion = registry.extrinsicVersion;
    // Unsigned transaction
    final int preByte = extrinsicVersion & 127;
    // ignore: unused_local_variable
    final String inHex = preByte.toRadixString(16);

    // Signed transaction
    final int extraByte = extrinsicVersion | 128;
    final String hexByte = extraByte.toRadixString(16);

    // 00 = MultiAddress::Id
    final String signerType = '00';

    final List<String> extras = <String>[];

    late final SignedExtensions signedExtensions;

    if (_usesChargeAssetTxPayment(registry)) {
      signedExtensions = SignedExtensions.assetHubSignedExtensions;
    } else {
      signedExtensions = SignedExtensions.substrateSignedExtensions;
    }

    for (final signedExtensiontype in registry.getSignedExtensionTypes()) {
      final payload = signedExtensions.signedExtension(
        signedExtensiontype,
        toEncodedMap(registry),
      );

      if (payload.isNotEmpty) {
        extras.add(payload);
      }
    }

    final String extra = extras.join();

    final String extrinsic = hexByte +
        signerType +
        signer +
        signatureType.type +
        signature +
        extra +
        method;

    // Adds size in compact as prefix
    return U8SequenceCodec.codec.encode(hex.decode(extrinsic));
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

  bool _usesChargeAssetTxPayment(dynamic registry) {
    return registry.getSignedExtensionTypes().contains('ChargeAssetTxPayment');
  }

  String maybeAssetIdEncoded(dynamic registry) {
    if (_usesChargeAssetTxPayment(registry)) {
      return assetId != null ?  '01${assetId!.toRadixString(16)}' : '00';
    } else {
      return '';
    }
  }
}
