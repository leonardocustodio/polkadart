import 'dart:typed_data';

import 'package:convert/convert.dart';
import 'package:polkadart/extrinsic/signed_extensions/asset_hub.dart';
import 'package:polkadart/extrinsic/signed_extensions/substrate.dart';
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

  toEncodedMap() {
    return {
      'signer': signer,
      'method': method,
      'signature': signature,
      'era': eraPeriod == 0
          ? '00'
          : Era.codec.encodeMortal(blockNumber, eraPeriod),
      'nonce': encodeHex(CompactCodec.codec.encode(nonce)),
      'assetId': assetId != null ? assetId!.toRadixString(16) : '',
      'tip': tip is int
          ? encodeHex(CompactCodec.codec.encode(tip))
          : encodeHex(CompactBigIntCodec.codec.encode(tip)),
    };
  }

  static Uint8List createSignedExtrinsic(Extrinsic extrinsic, registry) {
    return extrinsic.encode(registry);
  }

  Uint8List encode(dynamic registry) {
    final extrinsicVersion = registry.extrinsicVersion;
    // Unsigned transaction
    // final byte = extrinsicVersion & 0b0111_1111
    final preByte = extrinsicVersion & 127;
    // ignore: unused_local_variable
    final inHex = preByte.toRadixString(16);

    // Signed transaction
    final extraByte = extrinsicVersion | 128;
    final hexByte = extraByte.toRadixString(16);

    // 00 = MultiAddress::Id
    final signerType = '00';

    // 00 = ed25519
    // 01 = sr25519
    final signatureType = '00'; // We only support ed25519 for now

    final List extras = [];

    registry.getSignedExtensionTypes().forEach((extension) {
      final payload = assetId != null
          ? AssetHubSignedExtensions.signedExtension(extension, toEncodedMap())
          : SubstrateSignedExtensions.signedExtension(
              extension, toEncodedMap());

      if (payload.isNotEmpty) {
        extras.add(payload);
      }
    });

    final extra = extras.join();

    final extrinsic = hexByte +
        signerType +
        signer +
        signatureType +
        signature +
        extra +
        method;

    // Adds size in compact as prefix
    return U8SequenceCodec.codec.encode(hex.decode(extrinsic));
  }
}
