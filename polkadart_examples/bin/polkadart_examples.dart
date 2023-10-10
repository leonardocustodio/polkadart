import 'dart:io';

import 'package:convert/convert.dart';
import 'package:polkadart/polkadart.dart';
import 'package:polkadart_examples/generated/polkadot/polkadot.dart';
import 'package:polkadart_keyring/polkadart_keyring.dart';

void main(List<String> arguments) async {
  final provider = Provider.fromUri(Uri.parse('wss://rpc.polkadot.io'));
  final api = Polkadot(provider);

  final keyring = await KeyPair.fromMnemonic(
      "toward disagree come neither clay priority bamboo chat tiny fabric damp aisle//0");
  final publicKey = hex.encode(keyring.publicKey.bytes);
  print('Public Key: $publicKey');
  // 4ea987928399dfe5b94bf7d37995850a21067bfa4549fa83b40250ee635fc064

  final call =
      '0a03008eaf04151687736326c9fea17e25fc5287613693c912909cb226aa4794f26a48a10f';
  final specVersion = 'c60b0000';
  final transactionVersion = '08000000';
  final genesisHash =
      '99ded175d436bee7d751fa3f2f8c7a257ddc063a541f8daa5e6152604f66b2a0';
  final blockHash =
      '99ded175d436bee7d751fa3f2f8c7a257ddc063a541f8daa5e6152604f66b2a0';
  final era = '00';
  final nonce = '28';
  final tip = '00';

  final payloadToSign = SigningPayload(
    method: call,
    specVersion: specVersion,
    transactionVersion: transactionVersion,
    genesisHash: genesisHash,
    blockHash: blockHash,
    era: era,
    nonce: nonce,
    tip: tip,
  );

  final payload = payloadToSign.encode(api.registry);
  print('Payload: ${hex.encode(payload)}');
  // 0x0a03008eaf04151687736326c9fea17e25fc5287613693c912909cb226aa4794f26a48a10f002800c60b00000800000099ded175d436bee7d751fa3f2f8c7a257ddc063a541f8daa5e6152604f66b2a099ded175d436bee7d751fa3f2f8c7a257ddc063a541f8daa5e6152604f66b2a0
  final anotherHexPayload = hex
      .encode(SigningPayload.createSigningPayload(payloadToSign, api.registry));
  print('Payload: $anotherHexPayload');

  final signature = keyring.sign(payload);
  final hexSignature = hex.encode(signature);
  print('Signature: $hexSignature');
  // d19e04fc1a4ec115ec55d29e53676ddaeae0467134f9513b29ed3cd6fd6cd551a96c35b92b867dfd08ba37417e5733620acc4ad17c1d7c65909d6edaaffd4d0e

  final extrinsic = Extrinsic(
          signer: publicKey,
          method: call,
          signature: hexSignature,
          era: era,
          nonce: nonce,
          tip: tip)
      .encode(api.registry);

  final hexExtrinsic = hex.encode(extrinsic);
  print('Extrinsic: $hexExtrinsic');
  // 2d0284006802f945419791d3138b4086aa0b2700abb679f950e2721fd7d65b5d1fdf8f0201d19e04fc1a4ec115ec55d29e53676ddaeae0467134f9513b29ed3cd6fd6cd551a96c35b92b867dfd08ba37417e5733620acc4ad17c1d7c65909d6edaaffd4d0e0028000a03008eaf04151687736326c9fea17e25fc5287613693c912909cb226aa4794f26a48a10f

  exit(1);
}
