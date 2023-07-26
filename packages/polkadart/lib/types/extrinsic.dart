import 'dart:typed_data';
import 'package:convert/convert.dart';
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

  Uint8List encode() {
    final extrinsicVersion = 4; // Come from extrinsic.version in metadata
    // Unsigned transaction
    // final byte = extrinsicVersion & 0b0111_1111
    // Signed transaction
    final extraByte = extrinsicVersion | 128;
    final hexByte = extraByte.toRadixString(16);

    // 00 = ed25519
    // 01 = sr25519
    final signatureType = '00';
    final extra = era + nonce + tip;
    // 00 = MultiAddress?
    final signerType = '00';

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
