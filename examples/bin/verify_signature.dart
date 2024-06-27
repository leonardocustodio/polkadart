// Copyright 2017-2024 @polkadot/util-crypto authors & contributors
// SPDX-License-Identifier: Apache-2.0

import 'dart:convert';
import 'dart:typed_data';

import 'package:ed25519_edwards/ed25519_edwards.dart' as ed;
import 'package:pointycastle/digests/blake2b.dart' show Blake2bDigest;
import 'package:secp256k1_ecdsa/secp256k1.dart' as secp256k1;
import 'package:secp256k1_ecdsa/secp256k1.dart';
import 'package:sr25519/sr25519.dart' as sr25519;
import 'package:ss58/ss58.dart';

// import 'package:polkadot_util/util.dart';
// import 'package:polkadot_util_crypto/address/decode.dart';
// import 'package:polkadot_util_crypto/ed25519/verify.dart';
// import 'package:polkadot_util_crypto/secp256k1/verify.dart';
// import 'package:polkadot_util_crypto/sr25519/verify.dart';

class VerifyInput {
  final Uint8List message;
  final Uint8List publicKey;
  final Uint8List signature;

  VerifyInput({
    required this.message,
    required this.publicKey,
    required this.signature,
  });
}

typedef Verifier = bool Function(
    Uint8List message, Uint8List signature, Uint8List publicKey);

enum KeypairType { ed25519, sr25519, ecdsa, ethereum, none }

class VerifyResult {
  KeypairType crypto = KeypairType.none;
  bool isValid = false;
  bool isWrapped = false;
  Uint8List publicKey;

  VerifyResult({
    required this.publicKey,
  });
}

Uint8List _blake2bDigest(Uint8List data) {
  final digest = Blake2bDigest(digestSize: 32);
  digest.update(data, 0, data.length);
  final output = Uint8List(32);
  digest.doFinal(output, 0);
  return output;
}

Uint8List _addressPrivate(secp256k1.PublicKey publicKey) {
  final Uint8List bytesValue = Uint8List.fromList(publicKey.toBytes(true));
  if (bytesValue.length > 32) {
    return _blake2bDigest(bytesValue);
  }
  return bytesValue;
}

bool secp256k1Verify(
    Uint8List message, Uint8List signature, Uint8List publicKey) {
  print('Message ECDSA: $message');
  print('Signature ECDSA: $signature');
  print('Public Key ECDSA: $publicKey');

  print('Test before public key');
  final pub = secp256k1.PublicKey(publicKey);
  print('Test before address....');
  final addr = Address(pubkey: _addressPrivate(pub), prefix: 42);
  final output = addr.encode();
  print('Address: $output');

  final blake = _blake2bDigest(message);
  print('Blake: $blake');
  final signatureObject = secp256k1.Signature.fromCompactBytes(signature);
  final verified = pub.verify(signatureObject, blake);
  print('Verified: $verified');

  return verified;
}

// bool secp256k1VerifyHasherKeccak(
//     Uint8List message, Uint8List signature, Uint8List publicKey) {
//   return secp256k1Verify(message, signature, publicKey, hashType);
// }

bool secp256k1VerifyHasherBlake2(
    Uint8List message, Uint8List signature, Uint8List publicKey) {
  return secp256k1Verify(message, signature, publicKey);
}

bool sr25519Verify(
    Uint8List message, Uint8List signature, Uint8List publicKey) {
  print('Message SR25519: $message');
  print('Signature SR25519: $signature');
  print('Public Key SR25519: $publicKey');

  final public = sr25519.PublicKey.newPublicKey(publicKey);
  final sign = sr25519.Signature.fromBytes(signature);
  final (verified, exception) = sr25519.Sr25519.verify(public, sign, message);
  print('Verified: $verified');
  print('Exception: $exception');

  return verified;
}

bool ed25519Verify(
    Uint8List message, Uint8List signature, Uint8List publicKey) {
  print('Message ED25519: $message');
  print('Signature ED25519: $signature');
  print('Public Key ED25519: $publicKey');

  final public = ed.PublicKey(publicKey);
  final verify = ed.verify(public, message, signature);
  print('Verify: $verify');

  return verify;
}

const List<MapEntry<KeypairType, Verifier>> VERIFIERS = [
  MapEntry(KeypairType.ed25519, ed25519Verify),
  MapEntry(KeypairType.sr25519, sr25519Verify),
  MapEntry(KeypairType.ecdsa, secp256k1VerifyHasherBlake2),
  // MapEntry(KeypairType.ecdsa, secp256k1VerifyHasherKeccak),
];

List<KeypairType> CRYPTO_TYPES = [
  KeypairType.ed25519,
  KeypairType.sr25519,
  KeypairType.ecdsa,
];

VerifyResult verifyDetect(VerifyResult result, VerifyInput input,
    [List<MapEntry<KeypairType, Verifier>> verifiers = VERIFIERS]) {
  result.isValid = verifiers.any((verifier) {
    try {
      if (verifier.value(input.message, input.signature, input.publicKey)) {
        result.crypto = verifier.key;
        return true;
      }
    } catch (_) {
      // do nothing, result.isValid still set to false
    }
    return false;
  });

  return result;
}

VerifyResult verifyMultisig(VerifyResult result, VerifyInput input) {
  if (![0, 1, 2].contains(input.signature[0])) {
    throw ArgumentError(
        'Unknown crypto type, expected signature prefix [0..2], found ${input.signature[0]}');
  }

  KeypairType type = CRYPTO_TYPES[input.signature[0]] ?? KeypairType.none;
  result.crypto = type;

  // try {
  //   result.isValid = {
  //     KeypairType.ecdsa: () => verifyDetect(
  //             result,
  //             input.copyWith(signature: input.signature.sublist(1)),
  //             VERIFIERS_ECDSA)
  //         .isValid,
  //     KeypairType.ed25519: () => ed25519Verify(
  //         input.message, input.signature.sublist(1), input.publicKey),
  //     KeypairType.none: () =>
  //         throw ArgumentError('no verify for `none` crypto type'),
  //     KeypairType.sr25519: () => sr25519Verify(
  //         input.message, input.signature.sublist(1), input.publicKey),
  //   }[type]!();
  // } catch (_) {
  //   // ignore, result.isValid still set to false
  // }

  return result;
}

typedef VerifyFn = VerifyResult Function(
    VerifyResult result, VerifyInput input);

VerifyFn getVerifyFn(Uint8List signature) {
  return ([0, 1, 2].contains(signature[0]) &&
          [65, 66].contains(signature.length))
      ? verifyMultisig
      : verifyDetect;
}

VerifyResult? signatureVerify(
    dynamic message, dynamic signature, dynamic addressOrPublicKey) {
  Uint8List signatureU8a = Utilities.hexToBytes(signature);

  if (![64, 65, 66].contains(signatureU8a.length)) {
    throw ArgumentError(
        'Invalid signature length, expected [64..66] bytes, found ${signatureU8a.length}');
  }

  final publicKey = Address.decode(addressOrPublicKey);
  print(publicKey.encode());

  final msg = utf8.encode(message);

  VerifyInput input = VerifyInput(
      message: msg, publicKey: publicKey.pubkey, signature: signatureU8a);
  print(input.publicKey);
  print(input.signature);
  print(input.message);

  VerifyResult result = VerifyResult(publicKey: publicKey.pubkey);
  // ..isWrapped = u8aIsWrapped(input.message, true);
  // bool isWrappedBytes = u8aIsWrapped(input.message, false);
  VerifyFn verifyFn = getVerifyFn(signatureU8a);
  //
  verifyFn(result, input);

  print(result.isWrapped);
  print(result.crypto);
  print(result.isValid);
  //
  if (result.crypto != KeypairType.none) {
    // ||
    //(result.isWrapped && !isWrappedBytes)) {
    return result;
  }
  //
  // input = input.copyWith(
  //     message: isWrappedBytes
  //         ? u8aUnwrapBytes(input.message)
  //         : u8aWrapBytes(input.message));
  //
  // return verifyFn(result, input);
}

Future<void> main(List<String> arguments) async {
  const MESSAGE = 'hello world';

  const SIG_ED =
      '299d3bf4c8bb51af732f8067b3a3015c0862a5ff34721749d8ed6577ea2708365d1c5f76bd519009971e41156f12c70abc2533837ceb3bad9a05a99ab923de06';
  const ADDR_ED = 'DxN4uvzwPzJLtn17yew6jEffPhXQfdKHTp2brufb98vGbPN';
  final sig = signatureVerify(MESSAGE, SIG_ED, ADDR_ED);
  print(sig);

  const ADDR_SR = 'EK1bFgKm2FsghcttHT7TB7rNyXApFgs9fCbijMGQNyFGBQm';
  const SIG_SR =
      'ca01419b5a17219f7b78335658cab3b126db523a5df7be4bfc2bef76c2eb3b1dcf4ca86eb877d0a6cf6df12db5995c51d13b00e005d053b892bd09c594434288';
  final anotherSig = signatureVerify(MESSAGE, SIG_SR, ADDR_SR);
  print(anotherSig);

  const ADDR_SR_WRAP = 'J9nD3s7zssCX7bion1xctAF6xcVexcpy2uwy4jTm9JL8yuK';
  const SIG_SR_WRAP =
      '84b6afb1c8e54bbcb3f4872baf172580e21310e9387a53742627d6652d121447fa406b82805ed3184fb7bd519175cc9f99f283f97954d95cf966ee164df85489';

  const ADDR_EC = 'XyFVXiGaHxoBhXZkSh6NS2rjFyVaVNUo5UiZDqZbuSfUdji';
  const SIG_EC =
      '994638ee586d2c5dbd9bacacbc35d9b7e9018de8f7892f00c900db63bc57b1283e2ee7bc51a9b1c1dae121ac4f4b9e2a41cd1d6bf4bb3e24d7fed6faf6d85e0501';
  final anotherSig2 = signatureVerify(MESSAGE, SIG_EC, ADDR_EC);
  print(anotherSig2);

  // const ADDR_ET = '0x54Dab85EE2c7b9F7421100d7134eFb5DfA4239bF';
  // const SIG_ET =
  //     '4e35aad35793b71f08566615661c9b741d7c605bc8935ac08608dff685324d71b5704fbd14c9297d2f584ea0735f015dcf0def66b802b3f555e1db916eda4b7700';
  // final anotherSig3 = signatureVerify(MESSAGE, SIG_ET, ADDR_ET);
  // print(anotherSig3);
}
