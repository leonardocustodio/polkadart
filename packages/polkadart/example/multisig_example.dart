import 'package:polkadart/multisig/multisig_base.dart';
import 'package:polkadart/polkadart.dart';
import 'package:polkadart_keyring/polkadart_keyring.dart' as keyring;

void main() async {
  //
  // Signatories: TeslaS1, TeslaS2, TeslaS3
  // These accounts are using `dev phrase`: 'bottom drive obey lake curtain smoke basket hold race lonely fit walk';
  final teslaS1 = await keyring.KeyPair.sr25519.fromUri('//TeslaS1');
  teslaS1.ss58Format = 42;

  final teslaS2 = await keyring.KeyPair.sr25519.fromUri('//TeslaS2');
  teslaS2.ss58Format = 42;

  final teslaS3 = await keyring.KeyPair.sr25519.fromUri('//TeslaS3');
  teslaS3.ss58Format = 42;

  // Recipient: TeslaR
  final teslaR = await keyring.KeyPair.sr25519.fromUri('//TeslaR');
  teslaR.ss58Format = 42;

  final provider =
      Provider.fromUri(Uri.parse('wss://rpc-polkadot.luckyfriday.io'));

  ///
  /// Create and Fund Multisig
  final multiSigResponse = await Multisig.createAndFundMultisig(
    depositorKeyPair: teslaS1,
    otherSignatoriesAddressList: [teslaS2.address, teslaS3.address],
    threshold: 2,
    recipientAddress: teslaR.address,
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
    print('Calling ApproveAsMulti by TeslaS2');
    await localResponse.approveAsMulti(provider, teslaS2);
  }

  /**
   * Although TeslaS3 can call `approveAsMulti` to approve this call which will then
   * wait for `TeslaS1` to approve via `asMulti` call.
   * 
   * The last signatory (`TeslaS1`) will not be able to call `approveAsMulti` as it will throw FinalApprovalException.
   * 
   * So, `TeslaS1` will have to call `asMulti` to approve this call.
   */

  {
    // Assuming TeslaS3 is the second signatory who is approving.
    final localResponse = MultisigResponse.fromJson(json);
    // Execute this call by TeslaS3 approval.
    await Future.delayed(Duration(seconds: 15));
    print('Calling AsMulti by TeslaS3');
    await localResponse.asMulti(provider, teslaS3);
  }

  // // Cancel this call by TeslaS1
  //
  // final localResponse = MultisigResponse.fromJson(json);
  //
  // // Cancel this call by TeslaS1
  // await Future.delayed(Duration(seconds: 15));
  print('Calling CancelAsMulti by TeslaS1');
  // await multiSigResponse.cancelAsMulti(provider, TeslaS1);
}
