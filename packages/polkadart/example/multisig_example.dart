// ignore_for_file: non_constant_identifier_names

import 'package:polkadart/multisig/multisig_base.dart';
import 'package:polkadart/polkadart.dart';
import 'package:polkadart_keyring/polkadart_keyring.dart' as keyring;

void main() async {
  //
  // Signatories: TeslaS1, TeslaS2, TeslaS3
  final TeslaS1 = await keyring.KeyPair.sr25519.fromUri('//TeslaS1');
  TeslaS1.ss58Format = 42;

  final TeslaS2 = await keyring.KeyPair.sr25519.fromUri('//TeslaS2');
  TeslaS2.ss58Format = 42;

  final TeslaS3 = await keyring.KeyPair.sr25519.fromUri('//TeslaS3');
  TeslaS3.ss58Format = 42;

  // Recipient: TeslaR
  final TeslaR = await keyring.KeyPair.sr25519.fromUri('//TeslaR');
  TeslaR.ss58Format = 42;

  final provider = Provider.fromUri(Uri.parse('wss://westend-rpc.polkadot.io'));

  ///
  /// Create and Fund Multisig
  final multiSigResponse = await Multisig.createAndFundMultisig(
    depositorKeyPair: TeslaS1,
    otherSignatoriesAddressList: [TeslaS2.address, TeslaS3.address],
    threshold: 2,
    recipientAddress: TeslaR.address,
    amount: BigInt.parse('71${'0' * 11}'), // 7 WND
    provider: provider,
  );
  // Approve this call by TeslaS1
  await Future.delayed(Duration(seconds: 15));
  await multiSigResponse.approveAsMulti(provider, TeslaS1);

  // Execute this call by TeslaS2
  await Future.delayed(Duration(seconds: 15));
  await multiSigResponse.approveAsMulti(provider, TeslaS2);

  /* 
  // Cancel this call by TeslaS1
  await Future.delayed(Duration(seconds: 15));
  await multiSigResponse.cancelAsMulti(provider, TeslaS1); 
  */
}
