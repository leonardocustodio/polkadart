// ignore_for_file: non_constant_identifier_names

import 'dart:convert';

import 'package:polkadart/multisig/multisig_base.dart';
import 'package:secp256k1_ecdsa/secp256k1.dart';

BigInt getRandomBigInt() => Utilities.generateRandomBigInt(
    BigInt.one + BigInt.one, Curve.secp256k1.n - BigInt.one);

Future<void> main(List<String> arguments) async {
  final MSG = utf8.encode('teste');
  final PRIV_KEY = PrivateKey.fromHex(
      "81bd2487faa5e7e52ed238a0fddb3f4feb311f6651748c391ee46008ce391d59");

  final publicKey = PRIV_KEY.getPublicKey(false);
  print(Utilities.bytesToHex(publicKey.bytes));
  // 046f72fb985692883619f39c633abf8a16234eadebe874512da34e7af89b410f4f84154e250cdbb1f67580ffe0e54129395eaf4e03ffc37b1e4ddf037c358ae3b0
  // 046f72fb985692883619f39c633abf8a16234eadebe874512da34e7af89b410f4f84154e250cdbb1f67580ffe0e54129395eaf4e03ffc37b1e4ddf037c358ae3b0

  final hmacFnSync = hmacSha256(PRIV_KEY.bytes(), MSG);
  print(hmacFnSync.toHex());

  // final (seed, k2sig) = Utilities.prepSig(message, _privateKey,
  //     randomBytesFunc: randomBytesFunc,
  //     lowS: lowS,
  //     extraEntropy: extraEntropy); // Extract arguments for hmac-drbg
  // return Utilities.hmacDrbg(hmacFnSync)(
  //     seed, k2sig); // Re-run drbg until k2sig returns ok

  // final (r, s) = (getRandomBigInt(), getRandomBigInt());
  // final sig = Signature(r: r, s: s);
  // final signature = Signature.fromCompactHex(sig.toCompactHex());

  // 61477235559469980003873464121698965229542605902606114142942877525551315288384, s: 34622760604038070795400073602575496708347010731957031006934777879213829783808,
  // 3046022100982ce85b075a9b3d53052aa2258fa0014c33098b7d7013682c959b5b4bd1b9fe0221008132fed3884ef1c38c8b705b677f587fbc38aff3bbf3356291f426350da6665b

  // print(signature.toString());

  final signature = PRIV_KEY.sign(MSG);

  // print(publicKey.bytes.length);

  // 8ba6abe9dd4fa133f0aa08cbc1681f04f2eab94cd46c764e7f834bbfd82ef78d3ca89275c52a2d87de08a5c96dfbc58691775bf9363f4ac3763fa8e0249add3e
  // 3046022100982ce85b075a9b3d53052aa2258fa0014c33098b7d7013682c959b5b4bd1b9fe0221008132fed3884ef1c38c8b705b677f587fbc38aff3bbf3356291f426350da6665b
  //
  // print(signature.toCompactHex());
  // print(publicKey.verify(signature, MSG));

  // final licenseHex =
  //     Utilities.hexToBytes(hex.encode(jsonEncode(licenseRequest).codeUnits));
  // final signature = _privateKey.sign(licenseHex);
  //
  // final publicKey = _privateKey.getPublicKey();
  // final verified = publicKey.verify(signature, licenseHex);
}
