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

  const ExtrinsicPayload({
    required this.signer,
    required super.method,
    required this.signature,
    required super.eraPeriod,
    required super.blockNumber,
    required super.nonce,
    required super.tip,
    super.assetId,
  });

  @override
  toEncodedMap(Registry registry) {
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
      assetId: payload.assetId,
    );
  }

  Uint8List encode(Registry registry, SignatureType signatureType) {
    final ByteOutput output = ByteOutput();

    final int extrinsicVersion = registry.extrinsicVersion;
    // Unsigned transaction
    final int preByte = extrinsicVersion & 127;
    // ignore: unused_local_variable
    final String inHex = preByte.toRadixString(16);

    // Signed transaction
    final int extraByte = extrinsicVersion | 128;

    output
      ..pushByte(extraByte)
      // 00 = MultiAddress::Id
      ..pushByte(0)
      // Push Signer Address
      ..write(signer)
      // Push signature type byte
      ..pushByte(signatureType.type)
      // Push signature
      ..write(signature);

    late final SignedExtensions signedExtensions;

    final encodedMap = toEncodedMap(registry);

    if (_usesChargeAssetTxPayment(registry)) {
      signedExtensions = SignedExtensions.assetHubSignedExtensions;
    } else {
      signedExtensions = SignedExtensions.substrateSignedExtensions;
    }

    for (final signedExtensiontype in registry.signedExtensions.keys) {
      final payload =
          signedExtensions.signedExtension(signedExtensiontype, encodedMap);

      if (payload.isNotEmpty) {
        output.write(hex.decode(payload));
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
      Registry registry, SignatureType signatureType, keyring.KeyPair keyPair) {
    return keyPair.sign(encode(registry, signatureType));
  }

  bool _usesChargeAssetTxPayment(Registry registry) {
    return registry.signedExtensions.containsKey('ChargeAssetTxPayment');
  }

  @override
  String maybeAssetIdEncoded(Registry registry) {
    if (_usesChargeAssetTxPayment(registry)) {
      // '00' and '01' refer to rust's Option variants 'None' and 'Some'.
      return assetId != null ? '01${assetId!.toRadixString(16)}' : '00';
    } else {
      return '';
    }
  }
}
