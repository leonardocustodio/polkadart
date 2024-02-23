import 'package:polkadart/multisig/multisig_base.dart';
import 'package:polkadart/polkadart.dart';
import 'package:polkadart_keyring/polkadart_keyring.dart' as keyring;

void main() async {
  //
  // Signatories: keypairS1, keypairS2, keypairS3
  final keypairS1 = await keyring.KeyPair.sr25519.fromUri('//keypairS1');
  keypairS1.ss58Format = 42;

  final keypairS2 = await keyring.KeyPair.sr25519.fromUri('//keypairS2');
  keypairS2.ss58Format = 42;

  final keypairS3 = await keyring.KeyPair.sr25519.fromUri('//keypairS3');
  keypairS3.ss58Format = 42;

  // Recipient: keypairR
  final keypairR = await keyring.KeyPair.sr25519.fromUri('//keypairR');
  keypairR.ss58Format = 42;

  final provider =
      Provider.fromUri(Uri.parse('wss://rpc-polkadot.luckyfriday.io'));

  ///
  /// Create and Fund Multisig
  final multiSigResponse = await Multisig.createAndFundMultisig(
    depositorKeyPair: keypairS1,
    otherSignatoriesAddressList: [keypairS2.address, keypairS3.address],
    threshold: 2,
    recipientAddress: keypairR.address,
    amount: BigInt.parse('711${'0' * 10}'), // 7.11 WND
    provider: provider,
  );

  // Json for forwarding to other signatories.
  final json = multiSigResponse.toJson();

  {
    // Assuming keypairS2 is the first signatory who is approving.
    final localResponse = MultisigResponse.fromJson(json);
    // Approve this call by keypairS2 and forward for further approval.
    await Future.delayed(Duration(seconds: 15));
    print('Calling ApproveAsMulti by keypairS2');
    await localResponse.approveAsMulti(provider, keypairS2);
  }

  /**
   * Although keypairS3 can call `approveAsMulti` to approve this call which will then
   * wait for `keypairS1` to approve via `asMulti` call.
   * 
   * In this case:
   * The last signatory (`keypairS1`) will not be able to call `approveAsMulti` as it will throw FinalApprovalException.
   * 
   * So, `keypairS1` will have to call `asMulti` to approve this call.
   */

  {
    // Assuming keypairS3 is the second signatory who is approving.
    final localResponse = MultisigResponse.fromJson(json);
    // Execute this call by keypairS3 approval.
    await Future.delayed(Duration(seconds: 15));
    print('Calling AsMulti by keypairS3');
    await localResponse.asMulti(provider, keypairS3);
  }

  // // Cancel this call by keypairS1
  //
  // final localResponse = MultisigResponse.fromJson(json);
  //
  // // Cancel this call by keypairS1
  // await Future.delayed(Duration(seconds: 15));
  print('Calling CancelAsMulti by keypairS1');
  // await multiSigResponse.cancelAsMulti(provider, keypairS1);
}
