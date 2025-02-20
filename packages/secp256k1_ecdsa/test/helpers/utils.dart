import 'dart:convert';
import 'dart:io';
import 'package:secp256k1_ecdsa/secp256k1.dart';
import 'models.dart';

String toBEHex(BigInt n) {
  return n.toRadixString(16).padLeft(64, '0');
}

BigInt hexToBigInt(String hex) {
  // Big Endian
  return BigInt.parse('0x$hex');
}

BigInt getRandomBigInt() =>
    Utilities.generateRandomBigInt(BigInt.one + BigInt.one, Curve.secp256k1.n - BigInt.one);

dynamic getJsonFor<T>(String filePath, type) {
  final file = File(filePath);
  // decode json data
  final jsonData = file.readAsStringSync();
  final decoded = json.decode(jsonData);
  return Models.fromJson(decoded, type);
}
