import 'package:pointycastle/digests/blake2b.dart';
import 'package:polkadart_scale_codec/polkadart_scale_codec.dart'
    as scale_codec;
import 'package:substrate_metadata/chain_description/chain_description.model.dart';
import 'package:substrate_metadata/utils/utils.dart';

class Extrinsic {
  static Map<String, dynamic> decodeExtrinsic(
      dynamic rawExtrinsic, ChainDescription chainDescription,
      [scale_codec.Codec? codec]) {
    //
    // returning result map;
    final result = <String, dynamic>{};

    codec = codec ?? scale_codec.Codec(chainDescription.types);

    final source = scale_codec.Source(rawExtrinsic);

    result['extrinsic_length'] = source.decodeCompact();

    final meta = source.u8();

    //
    // 0b10000000 ~ 128 in BigInt
    final signed = meta & BigInt.from(128).toInt();

    //
    // 0b01111111 ~ 127 in BigInt
    final version = meta & BigInt.from(127).toInt();

    assertionCheck(version == 4, 'unsupported extrinsic version');

    //
    // assign version
    result['version'] = 4;

    //
    // decode the signature if the extrinsic is signed
    if (isNotEmpty(signed)) {
      result['signature'] =
          codec.decodeFromSource(chainDescription.signature, source);
    }

    //
    // decode the call
    result['call'] = codec.decodeFromSource(chainDescription.call, source);

    return result;
  }

  static String computeHash(String extrinsic) {
    final algorithm = Blake2bDigest(digestSize: 32);

    final bytes = algorithm.process(
        scale_codec.decodeHex(extrinsic.replaceAll(RegExp(r'0x'), '')));

    return scale_codec.encodeHex(bytes);
  }

  static String encodeExtrinsic(
      Map<String, dynamic> extrinsic, ChainDescription chainDescription,
      [scale_codec.Codec? codec]) {
    assertionCheck(extrinsic['version'] == 4, 'unsupported extrinsic version');

    // if the extrinsic contains 'hash' key, remove it
    extrinsic.remove('hash');
    // if the extrinsic contains 'extrinsic_length' key, remove it
    extrinsic.remove('extrinsic_length');

    // create codec instance
    codec ??= scale_codec.Codec(chainDescription.types);

    // create encoder instance
    var encoder = scale_codec.ByteEncoder();

    var meta = 4;

    // check if the extrinsic is signed
    if (extrinsic['signature'] != null) {
      //
      // 0b10000000 ~ 128 in BigInt
      meta |= BigInt.from(128).toInt();
    }

    // encode the meta
    encoder.u8(meta);

    if (extrinsic['signature'] != null) {
      codec.encodeWithEncoder(
          chainDescription.signature, extrinsic['signature'], encoder);
    }
    codec.encodeWithEncoder(chainDescription.call, extrinsic['call'], encoder);

    var bytes = encoder.toBytes();
    encoder = scale_codec.ByteEncoder();
    encoder.compact(bytes.length);
    encoder.bytes(bytes);
    return scale_codec.encodeHex(encoder.toBytes());
  }
}
