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
    amount: BigInt.parse('711${'0' * 10}'), // 7.11 WND
    provider: provider,
  );

  // Json for forwarding to other signatories.
  final json = multiSigResponse.toJson();

  {
    // Assuming TeslaS2 is the first signatory who is approving.
    final localResponse = MultisigResponse.fromJson(json);
    // Approve this call by TeslaS2 and forward for further approval.
    await Future.delayed(Duration(seconds: 15));
    await localResponse.approveAsMulti(provider, TeslaS2);
  }

  /**
   * Although TeslaS3 can call `approveAsMulti` to approve this call which will then
   * wait for `TeslaS1` to approve via `asMulti` call.
   * 
   * In this case:
   * The last signatory (`TeslaS1`) will not be able to call `approveAsMulti` as it will throw FinalApprovalException.
   * 
   * So, `TeslaS1` will have to call `asMulti` to approve this call.
   */

  {
    // Assuming TeslaS3 is the second signatory who is approving.
    final localResponse = MultisigResponse.fromJson(json);
    // Execute this call by TeslaS3 approval.
    await Future.delayed(Duration(seconds: 15));
    await localResponse.asMulti(provider, TeslaS3);
  }

  // // Cancel this call by TeslaS1
  //
  // final localResponse = MultisigResponse.fromJson(json);
  //
  // // Cancel this call by TeslaS1
  // await Future.delayed(Duration(seconds: 15));
  // await multiSigResponse.cancelAsMulti(provider, TeslaS1);
}
