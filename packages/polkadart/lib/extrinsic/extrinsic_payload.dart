import 'dart:typed_data';
import 'package:convert/convert.dart';
import 'package:polkadart/extrinsic/signed_extensions/substrate.dart';
import 'package:polkadart_scale_codec/primitives/primitives.dart';

class Extrinsic {
  final String signer;
  final String method;
  final String signature;
  final String era;
  final String nonce;
  final String tip;

  const Extrinsic({
    required this.signer,
    required this.method,
    required this.signature,
    required this.era,
    required this.nonce,
    required this.tip,
  });

  toMap() {
    return {
      'signer': signer,
      'method': method,
      'signature': signature,
      'era': era,
      'nonce': nonce,
      'tip': tip,
    };
  }

  static Uint8List createSignedExtrinsic(Extrinsic extrinsic, registry) {
    return extrinsic.encode(registry);
  }

  Uint8List encode(dynamic registry) {
    final extrinsicVersion = registry.extrinsicVersion;
    print('Extrinsic version: $extrinsicVersion');
    // Unsigned transaction
    // final byte = extrinsicVersion & 0b0111_1111
    final preByte = extrinsicVersion & 127;
    final inHex = preByte.toRadixString(16);
    print('Byte: $preByte');
    print('In Hex: $inHex');
    // Signed transaction
    final extraByte = extrinsicVersion | 128;
    final hexByte = extraByte.toRadixString(16);

    // 00 = ed25519
    // 01 = sr25519
    final signatureType = '00'; // We only support ed25519 for now
    // 00 = MultiAddress?
    final signerType = '00';

    final List extras = [];

    registry.getSignedExtensionTypes().forEach((extension) {
      final payload =
          SubstrateSignedExtensions.signedExtensionPayload(extension, toMap());
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
